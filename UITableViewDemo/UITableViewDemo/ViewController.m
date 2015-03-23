//
//  ViewController.m
//  UITableViewDemo
//
//  Created by Robbie on 3/17/15.
//  Copyright (c) 2015 Mattie. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property UITableView *tableView;
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
    
    _tableView = (UITableView *)[self.view viewWithTag:1];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    _tableView.sectionIndexColor = [UIColor blackColor];
//    _tableView.sectionIndexBackgroundColor = [UIColor grayColor];
//    _tableView.sectionIndexTrackingBackgroundColor = [UIColor blackColor];
    
    //cell
    //_tableView.rowHeight = 90;
    UINib *nib = [UINib nibWithNibName:@"cell" bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [_tableView setSeparatorColor:[UIColor clearColor]];


    //header issue
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
    [self.view addSubview:header];
    
    
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
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:identifier];
    
    if(cell == nil){
        cell = [[[UITableViewCell alloc] init] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }

//    [cell.contentView setFrame:CGRectMake(cell.frame.origin.x, cell.frame.origin.y - 50, cell.frame.size.width, cell.frame.size.height - 50)];
    
    [cell.contentView setBackgroundColor:[UIColor clearColor]];
//    [cell setBackgroundColor:[UIColor greenColor]];
//    [cell setAccessoryType:UITableViewCellAccessoryDetailDisclosureButton];
    
    NSString *title = [_sectionTitles objectAtIndex:indexPath.section];
    NSArray *sectionItems = [_dict objectForKey:title];
    
    
    //add subview
    UIView *card = [[UIView alloc] initWithFrame:CGRectMake(cell.frame.origin.x + 40, cell.frame.origin.y + 10, 300, 80)];
    [card setBackgroundColor:[self getRandomColor]];
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, 0, 300, 80);
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor blackColor];
    label.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    label.text = [sectionItems objectAtIndex:indexPath.row];
    [card addSubview:label];
    
    [cell.contentView addSubview:card];
    
//    cell.textLabel.text = [sectionItems objectAtIndex:indexPath.row];
//    cell.textLabel.backgroundColor = [UIColor redColor];
    
    
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

-(UIColor *) getRandomColor{
    CGFloat hue = (arc4random()%256/256.0);
    CGFloat saturation = (arc4random()%128/256.0)+0.5;
    CGFloat brightness = saturation;
    
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}



@end
