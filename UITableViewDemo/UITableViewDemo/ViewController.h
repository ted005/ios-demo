//
//  ViewController.h
//  UITableViewDemo
//
//  Created by Robbie on 3/17/15.
//  Copyright (c) 2015 Mattie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate, UITextFieldDelegate>

@property NSMutableArray *array;


@end

