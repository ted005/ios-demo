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
    
    //init textFieldsContent
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
    
    UIApplication *app = [UIApplication sharedApplication];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActive:) name:UIApplicationWillResignActiveNotification object:app];
    
    
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
    
    NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if(cell == nil){
        cell = [[[UITableViewCell alloc] init] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    [cell.contentView setBackgroundColor:[UIColor clearColor]];
    
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 280, 100)];
    backgroundView.backgroundColor = [UIColor blackColor];
    cell.backgroundView = backgroundView;
    
    tableView.backgroundColor = [UIColor blackColor];
    
    //add subview
    UIView *card = [[UIView alloc] initWithFrame:CGRectMake(0, 10, 310, 60)];
    [card setBackgroundColor:[self colorForIndex:indexPath.row]];
    card.layer.masksToBounds = YES;
    card.layer.cornerRadius = 5.0;
//    card.layer.shadowOffset = CGSizeMake(-1, 1);
//    card.layer.shadowOpacity = 0.2;
    
//    UILabel *label = [[UILabel alloc] init];
//    label.frame = CGRectMake(5, 10, 310, 60);
//    label.backgroundColor = [UIColor clearColor];
//    label.textColor = [UIColor blackColor];
//    label.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
//    label.text = [sectionItems objectAtIndex:indexPath.row];
    
    UITextField *textField = [[UITextField alloc] init];
    textField.text = [_textFieldsContent objectAtIndex:indexPath.row];
    [textField setFrame:CGRectMake(5, 10, 310, 60)];
    [textField setBorderStyle:UITextBorderStyleLine];
    textField.placeholder = @"Hello";
    textField.textColor = [UIColor blackColor];
    textField.backgroundColor = [UIColor clearColor];
    textField.adjustsFontSizeToFitWidth = YES;
    textField.keyboardType = UIKeyboardTypeAlphabet;
    textField.keyboardAppearance = UIKeyboardAppearanceDark;
    textField.returnKeyType = UIReturnKeyDone;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.delegate = self;
    
    
//    [card addSubview:textField];
    
    [cell.contentView addSubview:card];
//    [cell.contentView sendSubviewToBack:card];
    [cell.contentView addSubview:textField];
    
    //gesture
//    UIGestureRecognizer* recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:cell action:@selector(handlePan:withCell:)];
//    recognizer.delegate = self;
//    [cell addGestureRecognizer:recognizer];
    
    return cell;
    
}

-(void)handlePan:(UIPanGestureRecognizer *)recognizer withCell: (UITableViewCell *)cell{
    
    CGPoint originalCenter;
    int deleteOnDragRelease = 0;
    
    // 1
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        // if the gesture has just started, record the current centre location
        originalCenter = cell.center;
    }
    
//    // 2
//    if (recognizer.state == UIGestureRecognizerStateChanged) {
//        // translate the center
//        CGPoint translation = [recognizer translationInView:cell];
//        cell.center = CGPointMake(originalCenter.x + translation.x, originalCenter.y);
//        // determine whether the item has been dragged far enough to initiate a delete / complete
//        deleteOnDragRelease = cell.frame.origin.x < -cell.frame.size.width / 2;
//        
//    }
//    
//    // 3
//    if (recognizer.state == UIGestureRecognizerStateEnded) {
//        // the frame this cell would have had before being dragged
//        CGRect originalFrame = CGRectMake(0, cell.frame.origin.y,
//                                          cell.bounds.size.width, cell.bounds.size.height);
//        if (!deleteOnDragRelease) {
//            // if the item is not being deleted, snap back to the original location
//            [UIView animateWithDuration:0.2
//                             animations:^{
//                                 cell.frame = originalFrame;
//                             }
//             ];
//        }
//    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
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

-(UIColor*)colorForIndex:(NSInteger) index {
    NSUInteger itemCount = _textFieldsContent.count - 1;
    float val = ((float)index / (float)itemCount) * 0.6;
    return [UIColor colorWithRed: 1.0 green:val blue: 0.0 alpha:1.0];
}
 
-(UIColor *) getRandomColor{
    CGFloat hue = (arc4random()%256/256.0);
    CGFloat saturation = (arc4random()%128/256.0)+0.5;
    CGFloat brightness = saturation;
    
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

//read data from Core Data
-(NSMutableArray *) loadTextFieldsContent{
    NSMutableArray *testData = [[NSMutableArray alloc] initWithObjects:@"A", @"B", @"C", @"D", nil];
    return testData;
}

-(void)applicationWillResignActive: (NSNotification *)notification{
    UIApplication *app = [UIApplication sharedApplication];
    AppDelegate *delegate = app.delegate;
//    [delegate ]
    
}



@end
