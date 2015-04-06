//
//  ViewController.m
//  UITableViewDemo
//
//  Created by Robbie on 3/17/15.
//  Copyright (c) 2015 Mattie. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import <CoreData/CoreData.h>
#import "TodoItem.h"


static NSString * const entityName = @"TodoEntry";
static NSString * const contentIndex = @"index";
static NSString * const contentValue = @"content";
static NSString * const contentState = @"state";


@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *leftBar;
@property (weak, nonatomic) IBOutlet UIImageView *add;
@property (weak, nonatomic) IBOutlet UIImageView *record;

@property NSMutableArray *textFieldsContent;

@property NSMutableArray *states;//NSNumber *

@end

@implementation ViewController

-(void)viewDidAppear:(BOOL)animated{
//    UIScrollView *scrollView = (UIScrollView *)_tableView;
//    [scrollView flashScrollIndicators];
}
- (IBAction)handle:(UIPanGestureRecognizer *)sender {
    CGPoint movePoint = [sender translationInView:self.view];
    
    
    if ([sender state] == UIGestureRecognizerStateEnded) {
        NSLog(@"ended...");
        if (movePoint.y >= 300) {
            [self insertTodoItem];
        }
    }
    
    if ([sender state] == UIGestureRecognizerStateBegan) {
        NSLog(@"pulling...");
    }


}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //black status bar
    
    UIApplication *app = [UIApplication sharedApplication];
    CGSize size = app.statusBarFrame.size;
    
    UIView *statusBarView =  [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    statusBarView.backgroundColor  =  [UIColor blackColor];
    [self.view addSubview:statusBarView];

//    get names from .plist
//    NSURL *url = [[NSBundle mainBundle] URLForResource:@"sortednames" withExtension:@"plist"];
//    _dict = [NSDictionary dictionaryWithContentsOfURL:url];
//    _sectionTitles = _dict.allKeys;
//    _sectionTitles = [_sectionTitles sortedArrayUsingSelector:@selector(compare:)];
    
//     index
//    _tableView.sectionIndexColor = [UIColor blackColor];
//    _tableView.sectionIndexBackgroundColor = [UIColor grayColor];
//    _tableView.sectionIndexTrackingBackgroundColor = [UIColor blackColor];

//        header issue
//        UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
//        header.backgroundColor = [UIColor lightGrayColor];
//        [self.view addSubview:header];
    
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [_tableView setSeparatorColor:[UIColor clearColor]];
    _tableView.backgroundColor = [UIColor blackColor];
    
    
    //init textFieldsContent
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActive:) name:UIApplicationWillResignActiveNotification object:app];
    
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc]
                               initWithEntityName:entityName];
    
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request error:&error];
    if (objects == nil) {
        NSLog(@"There was an error when trying to retrieving from persistence!");
    }
    
    if(_textFieldsContent == nil){
        _textFieldsContent = [self loadArray];
    }
    
    if(_states == nil){
        _states = [self loadArray];
    }
    
    for (NSManagedObject *oneObject in objects) {
        NSInteger index = [[oneObject valueForKey:contentIndex] integerValue];
        NSString *content = [oneObject valueForKey:contentValue];
        NSInteger state = [[oneObject valueForKey:contentState] integerValue];
        
        [_textFieldsContent insertObject:content atIndex:index];
        [_states insertObject:[NSNumber numberWithInteger:state] atIndex:index];

    }

}

//foreground color of status bar
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}


- (IBAction)addButtonPressed:(UIBarButtonItem *)sender {
    [self insertTodoItem];
}


-(void)insertTodoItem{
    [_textFieldsContent insertObject:@"" atIndex:0];
    [_states insertObject:[NSNumber numberWithInteger:1] atIndex:0];
    
    NSArray *insertIndexPaths = [NSArray arrayWithObjects:[NSIndexPath indexPathForRow:0 inSection:0], nil];
    [_tableView beginUpdates];
    
    [_tableView insertRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationTop];
    
    [_tableView endUpdates];
    
    TodoItem *cell = (TodoItem *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [cell.textField becomeFirstResponder];

}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_textFieldsContent count];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"cell";

    [tableView registerClass:[TodoItem class] forCellReuseIdentifier:identifier];
    TodoItem *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.itemText = [_textFieldsContent objectAtIndex:indexPath.row];
    cell.index = indexPath.row;
    cell.state = [(NSNumber *)[_states objectAtIndex:indexPath.row] integerValue];

    return cell;
}


//-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSUInteger itemCount = 5 - 1;
//    float val = ((float)indexPath.row / (float)itemCount) * 0.6;
//    cell.backgroundColor = [UIColor colorWithRed: 1.0 green:val blue: 0.0 alpha:1.0];
//}


//index on the right
//-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
//    return _sectionTitles;
//}

//-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
//    NSInteger i = [_sectionTitles indexOfObject:title];
//    return i;
//}

/**
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [_sectionTitles objectAtIndex:section];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSString *sectionTitle = [self tableView:tableView titleForHeaderInSection:section];
    if (sectionTitle == nil) {
        return nil;
    }
    
    // Create label with section title
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(12, 0, 300, 22);
    label.backgroundColor = [UIColor darkGrayColor];
    label.textColor = [UIColor blackColor];
    label.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    label.text = [sectionTitle stringByAppendingString:@": "];
    
    // Create header view and add label as a subview
    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 22)];
    [sectionView setBackgroundColor:[UIColor blackColor]];
    [sectionView addSubview:label];
    
    return sectionView;
}
*/


-(NSMutableArray *) loadArray{
    NSMutableArray *testData = [[NSMutableArray alloc] initWithObjects:nil];
    return testData;
}


-(void)applicationWillResignActive: (NSNotification *)notification{
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSError *error;
    
    //retrieve cells
    NSArray *cells = [_tableView visibleCells];
    
    for (int i = 0; i < _textFieldsContent.count; i++) {
        
        TodoItem *cell = (TodoItem *)[cells objectAtIndex:i];
        
        NSFetchRequest *request = [[NSFetchRequest alloc]
                                   initWithEntityName:entityName];
        NSPredicate *pred = [NSPredicate
                             predicateWithFormat:@"(%K = %d)", contentIndex, i];
        [request setPredicate:pred];
        
        NSArray *objects = [context executeFetchRequest:request error:&error];
        if (objects == nil) {
            NSLog(@"There was an error when trying to saving to persistence!");
            // Do whatever error handling is appropriate
        }
        
        NSManagedObject *entry = nil;
        if ([objects count] > 0) {
            entry = [objects objectAtIndex:0];
        } else {
            entry = [NSEntityDescription
                       insertNewObjectForEntityForName:entityName
                       inManagedObjectContext:context];
        }
        
        
        [entry setValue:[NSNumber numberWithInt:i] forKey:contentIndex];
        [entry setValue:cell.textField.text forKey:contentValue];
//        [entry setValue:[_states objectAtIndex:i] forKey:contentState];
        [entry setValue:[NSNumber numberWithInteger:cell.state] forKey:contentState];
        
    }
    [appDelegate saveContext];
    
    //icon badge
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = _textFieldsContent.count;
    
}



@end
