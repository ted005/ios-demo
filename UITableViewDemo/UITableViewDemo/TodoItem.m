//
//  TodoItem.m
//  UITableViewDemo
//
//  Created by Robbie on 15/3/26.
//  Copyright (c) 2015年 Mattie. All rights reserved.
//

#import "TodoItem.h"

@implementation TodoItem

- (void)awakeFromNib {
    // Initialization code

}

-(void)layoutSubviews{
    [self.contentView setBackgroundColor:[UIColor blackColor]];
    
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
    backgroundView.backgroundColor = [UIColor blackColor];
    self.backgroundView = backgroundView;
    
    UIView *card = [[UIView alloc] initWithFrame:CGRectMake(0, 15, 320, 70)];
    [card setBackgroundColor:[self colorForIndex:_index]];
    card.layer.masksToBounds = NO;
    card.layer.cornerRadius = 5.0;
    card.clipsToBounds = YES;
    
    _textField = [[UITextField alloc] init];
    _textField.text = _itemText;
    [_textField setFrame:CGRectMake(8, 15, 320, 70)];
    [_textField setBorderStyle:UITextBorderStyleNone];
    _textField.textColor = [UIColor whiteColor];
    _textField.backgroundColor = [UIColor clearColor];
    _textField.adjustsFontSizeToFitWidth = YES;
    _textField.keyboardType = UIKeyboardTypeAlphabet;
    _textField.keyboardAppearance = UIKeyboardAppearanceDark;
    _textField.returnKeyType = UIReturnKeyDone;
    _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _textField.delegate = self;
    
    [self.contentView addSubview:card];
    [self.contentView addSubview:_textField];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(UIColor*)colorForIndex:(NSInteger) index {
    NSUInteger itemCount = 5 - 1;
    float val = ((float)index / (float)itemCount) * 0.6;
    return [UIColor colorWithRed: 1.0 green:val blue: 0.0 alpha:1.0];
}

-(UIColor *) getRandomColor{
    CGFloat hue = (arc4random()%256/256.0);
    CGFloat saturation = (arc4random()%128/256.0)+0.5;
    CGFloat brightness = saturation;
    
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    _itemText = textField.text;
    [textField resignFirstResponder];
    return YES;
}

@end
