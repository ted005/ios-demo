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

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize
{
    _state = YES;
    
    //swipe to right
    UISwipeGestureRecognizer *swipeRightGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    swipeRightGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [swipeRightGestureRecognizer setDelegate:self];
    [self addGestureRecognizer:swipeRightGestureRecognizer];
    
    //swipe to left
    UISwipeGestureRecognizer *swipeLeftGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    swipeLeftGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    [swipeLeftGestureRecognizer setDelegate:self];
    [self addGestureRecognizer:swipeLeftGestureRecognizer];
    
}

-(void)handlePanGesture:(UISwipeGestureRecognizer *)panGestureRecognizer {
    
    if (panGestureRecognizer.direction == UISwipeGestureRecognizerDirectionRight) {
        NSLog(@"swipe to right......");
        
        if (!_state) {
            return;
        }
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:_itemText];
        [attributedString addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, _itemText.length)];
        
        _textField.attributedText = attributedString;
        UIView *subView = [self.contentView.subviews objectAtIndex:0];//card
        UITextField *subView2 = [self.contentView.subviews objectAtIndex:1];//textField
        
        if(subView2.enabled){
            subView2.enabled = NO;
        }
        
        if(subView.backgroundColor != [UIColor blackColor]){
            subView.backgroundColor = [UIColor blackColor];
        }
        
        _state = NO;
        
    } else {
        NSLog(@"swipe to left......");
        
        if (_state) {
            return;
        }
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:_itemText];
//        [attributedString addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, _itemText.length)];
        
        _textField.attributedText = attributedString;
        UIView *subView = [self.contentView.subviews objectAtIndex:0];//card
        UITextField *subView2 = [self.contentView.subviews objectAtIndex:1];//textField
        
        if(!subView2.enabled){
            subView2.enabled = YES;
        }
        
        if(subView.backgroundColor == [UIColor blackColor]){
            subView.backgroundColor = [self colorForIndex:_index];
        }
        
        _state = YES;

    }
    
}

-(void)layoutSubviews{
    [self.contentView setBackgroundColor:[UIColor blackColor]];
    
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenSize.width, 100)];
    backgroundView.backgroundColor = [UIColor clearColor];
    self.backgroundView = backgroundView;
    
    UIView *card = [[UIView alloc] initWithFrame:CGRectMake(0, 15, screenSize.width, 70)];
    [card setBackgroundColor:[self colorForIndex:_index]];
    card.layer.masksToBounds = NO;
//    card.layer.cornerRadius = 5.0;
    card.clipsToBounds = YES;
    
    _textField = [[UITextField alloc] init];
    _textField.text = _itemText;
    [_textField setFrame:CGRectMake(8, 15, screenSize.width, 70)];
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
    return [UIColor colorWithRed: val green:0.9 blue: 0 alpha:0.9];
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
