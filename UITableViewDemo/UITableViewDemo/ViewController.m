//
//  ViewController.m
//  UITableViewDemo
//
//  Created by Robbie on 3/17/15.
//  Copyright (c) 2015 Mattie. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _array = [NSMutableArray arrayWithObjects:@"A", @"B", @"C", nil];
    
    _tableView = (UITableView *)[self.view viewWithTag:1];
    _tableView.sectionIndexColor = [UIColor blackColor];
    _tableView.sectionIndexBackgroundColor = [UIColor grayColor];
    _tableView.sectionIndexTrackingBackgroundColor = [UIColor blackColor];
    
    
    //header issue
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
    [self.view addSubview:header];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_array count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identifier = @"UITableViewDemoCell";
    UITableViewCell *cell = [[[UITableViewCell alloc] init] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    
    cell.textLabel.text = [_array objectAtIndex:indexPath.row];
    cell.textLabel.backgroundColor = [UIColor blackColor];
    
    return cell;
    
}

//index on the right
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return _array;
}




@end
