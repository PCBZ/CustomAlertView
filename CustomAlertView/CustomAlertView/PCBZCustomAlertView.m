//
//  PCBZCustomAlertView.m
//  CustomAlertView
//
//  Created by Wenshuang Zhou on 15/11/9.
//  Copyright © 2015 PCBZ. All rights reserved.
//

#import "PCBZCustomAlertView.h"
#import "UIView+Extension.h"
#import "UIColor+Hex.h"

@interface PCBZCustomAlertView ()

@end

@implementation PCBZCustomAlertView

- (instancetype)initWithSize:(CGSize)size
{
    self = [super init];
    if (self) {
        self.containerView.size = size;
        [self addTapGesture];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addTapGesture];
    }
    return self;
}

/**
 *  A default tapgesture, when touch the background, the alert view dismiss.
 */
- (void)addTapGesture
{
    self.backgroundTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss:)];
    [self.backgroundView addGestureRecognizer:self.backgroundTapGesture];
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        [self.containerView addSubview:_titleLabel];
        [_titleLabel convertPoint:_titleLabel.center fromView:_titleLabel.superview];
    }
    [_titleLabel sizeToFit];
    return _titleLabel;
}

- (UILabel *)messageLabel
{
    if (!_messageLabel) {
        _messageLabel = [[UILabel alloc] init];
        [self.containerView addSubview:_messageLabel];
         [_messageLabel convertPoint:_messageLabel.center fromView:_messageLabel.superview];
    }
    [_messageLabel sizeToFit];
    return _messageLabel;
}

- (void)setButtonEnabled:(BOOL)enabled
{
    for (UIView *subview in self.dialogView.subviews ) {
        if ([subview isKindOfClass:[UIButton class]]) {
            [(UIButton *)subview setEnabled:enabled];
            NSLog(@"button found");
            break;
        }
    }
}

- (void)dismiss:(id)sender
{
    [self close];
}


@end
