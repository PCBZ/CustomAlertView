//
//  PCBZCustomAlertView.h
//  CustomAlertView
//
//  Created by Wenshuang Zhou on 15/11/9.
//  Copyright © 2015年 PCBZ. All rights reserved.
//

#import "CustomIOSAlertView.h"

@interface PCBZCustomAlertView : CustomIOSAlertView

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *messageLabel;

@property (nonatomic, strong) UITapGestureRecognizer *backgroundTapGesture;

- (instancetype)initWithSize:(CGSize)size;
- (void)setButtonEnabled:(BOOL)enabled;

@end
