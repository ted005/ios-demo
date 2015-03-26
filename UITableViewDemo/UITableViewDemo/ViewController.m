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


@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *leftBar;
@property (weak, nonatomic) IBOutlet UIImageView *add;
@property (weak, nonatomic) IBOutlet UIImageView *record;

//@property NSArray *sectionTitles;
@property NSMutableArray *textFieldsContent;
//@property NSDictionary *dict;


@end

@implementation ViewController

-(void)viewDidAppear:(BOOL)animated{
    UIScrollView *scrollView = (UIScrollView *)_tableView;
    [scrollView flashScrollIndicators];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _textFieldsContent = [self loadTextFieldsContent];

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
    
    /*UIApplication *app = [UIApplication sharedApplication];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActive:) name:UIApplicationWillResignActiveNotification object:app];
    
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc]
                               initWithEntityName:entityName];
    
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request error:&error];
    if (objects == nil) {
        NSLog(@"There was an error!");
    }
    
    for (NSManagedObject *oneObject in objects) {
        int index = [[oneObject valueForKey:contentIndex] intValue];
        NSString *content = [oneObject valueForKey:contentValue];
        
        [_textFieldsContent insertObject:content atIndex:index];
    }
     */

}
- (IBAction)addButtonPressed:(UIButton *)sender {
    [_textFieldsContent insertObject:@"" atIndex:0];
    [_tableView reloadData];
    TodoItem *cell = [_tableView cellForRowAtIndexPath:0];
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
    
    return cell;
}


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


 


//read data from Core Data
-(NSMutableArray *) loadTextFieldsContent{
    NSMutableArray *testData = [[NSMutableArray alloc] initWithObjects:@"A", @"B", @"C", @"D", nil];
    return testData;
}

-(void)applicationWillResignActive: (NSNotification *)notification{
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSError *error;
    
    for (int i = 0; i < _textFieldsContent.count; i++) {
        
        NSFetchRequest *request = [[NSFetchRequest alloc]
                                   initWithEntityName:entityName];
        NSPredicate *pred = [NSPredicate
                             predicateWithFormat:@"(%K = %d)", contentIndex, i];
        [request setPredicate:pred];
        
        NSArray *objects = [context executeFetchRequest:request error:&error];
        if (objects == nil) {
            NSLog(@"There was an error!");
            // Do whatever error handling is appropriate
        }
        
        NSManagedObject *theLine = nil;
        if ([objects count] > 0) {
            theLine = [objects objectAtIndex:0];
        } else {
            theLine = [NSEntityDescription
                       insertNewObjectForEntityForName:entityName
                       inManagedObjectContext:context];
        }
        
        [theLine setValue:[NSNumber numberWithInt:i] forKey:contentIndex];
        [theLine setValue:[_textFieldsContent objectAtIndex:i] forKey:contentValue];
        
    }
//    [appDelegate saveContext];
    
}



@end
