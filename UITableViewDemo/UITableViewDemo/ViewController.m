//
//  ViewController.m
//  UITableViewDemo
//
//  Created by Robbie on 3/17/15.
//  Copyright (c) 2015 Mattie. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *leftBar;
@property (weak, nonatomic) IBOutlet UIImageView *add;
@property (weak, nonatomic) IBOutlet UIImageView *record;

@property NSArray *sectionTitles;
@property NSDictionary *dict;

@end

@implementation ViewController

-(void)viewDidAppear:(BOOL)animated{
    UIScrollView *scrollView = (UIScrollView *)_tableView;
    [scrollView flashScrollIndicators];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //get names from .plist
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"sortednames" withExtension:@"plist"];
    _dict = [NSDictionary dictionaryWithContentsOfURL:url];
    
    _sectionTitles = _dict.allKeys;
    _sectionTitles = [_sectionTitles sortedArrayUsingSelector:@selector(compare:)];
    
//    _tableView.sectionIndexColor = [UIColor blackColor];
//    _tableView.sectionIndexBackgroundColor = [UIColor grayColor];
//    _tableView.sectionIndexTrackingBackgroundColor = [UIColor blackColor];
    
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [_tableView setSeparatorColor:[UIColor clearColor]];


    //header issue
//    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
//    header.backgroundColor = [UIColor lightGrayColor];
//    [self.view addSubview:header];
    
    
    
//    _leftBar.backgroundColor = [UIColor lightGrayColor];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return [_sectionTitles count];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *title = [_sectionTitles objectAtIndex:section];
    NSArray *sectionItems = [_dict objectForKey:title];
    return [sectionItems count];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if(cell == nil){
        cell = [[[UITableViewCell alloc] init] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    [cell.contentView setBackgroundColor:[UIColor clearColor]];
    
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 280, 100)];
    backgroundView.backgroundColor = [UIColor colorWithRed:0.52 green:0.32 blue:0.21 alpha:1];
    cell.backgroundView = backgroundView;
    
    tableView.backgroundColor = [UIColor colorWithRed:0.52 green:0.32 blue:0.21 alpha:1];
    
//    [cell setAccessoryType:UITableViewCellAccessoryDetailDisclosureButton];
    
    NSString *title = [_sectionTitles objectAtIndex:indexPath.section];
    NSArray *sectionItems = [_dict objectForKey:title];
    
    
    //add subview
    UIView *card = [[UIView alloc] initWithFrame:CGRectMake(0, 10, 310, 60)];
    [card setBackgroundColor:[self getRandomColor]];
    card.layer.masksToBounds = NO;
    card.layer.cornerRadius = 5.0;
//    card.layer.shadowOffset = CGSizeMake(-1, 1);
//    card.layer.shadowOpacity = 0.2;
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(5, 10, 310, 60);
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor blackColor];
    label.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    label.text = [sectionItems objectAtIndex:indexPath.row];
    [card addSubview:label];
    
    [cell.contentView addSubview:card];
    [cell.contentView sendSubviewToBack:card];

    return cell;
    
}

//index on the right
//-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
//    return _sectionTitles;
//}

-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    NSInteger i = [_sectionTitles indexOfObject:title];
    return i;
}

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
 
 
-(UIColor *) getRandomColor{
    CGFloat hue = (arc4random()%256/256.0);
    CGFloat saturation = (arc4random()%128/256.0)+0.5;
    CGFloat brightness = saturation;
    
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}



@end
