//
//  TodoItem.h
//  UITableViewDemo
//
//  Created by Robbie on 15/3/26.
//  Copyright (c) 2015年 Mattie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TodoItem : UITableViewCell <UITextFieldDelegate>

@property UITextField *textField;
@property NSString *itemText;
@property NSInteger *index;
@end
