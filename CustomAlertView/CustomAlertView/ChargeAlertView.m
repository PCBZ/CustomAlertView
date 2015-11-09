
//
//  ChargeAlertView.m
//  Congratulations
//
//  Created by Wenshuang Zhou on 15/9/11.
//  Copyright (c) 2015年 Zhenai. All rights reserved.
//

#import "ChargeAlertView.h"
#import "UIView+Extension.h"
#import "UIColor+Hex.h"
//#import "YLDeviceStatics.h"

static CGFloat const chargeInset = 23;
static CGFloat const titleLabelTopInset = 10;
static CGFloat const titleLabelLeftInset = 20;
static CGFloat const messageLabelInset = 14;

static CGFloat const buttonHeight = 44;

static CGFloat const alertViewHeight = 198;

static NSInteger const chargeFont = 14;
static NSInteger const chargeColor = 0x6b0cad;
static NSInteger const titleFont = 14;
static NSInteger const titleColor = 0x666666;
static NSInteger const messageFont = 14;
static NSInteger const messageColor = 0x939393;

static NSInteger const buttonFont = 14;
static NSInteger const buttonColor = 0x6b0cad;
static NSInteger const cancelButtonFont = 14;
static NSInteger const cancelButtonColor = 0x666666;

static NSInteger const backgroundColor = 0xf2f2f2;

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface ChargeAlertView ()

@property (nonatomic, strong) UILabel *chargeLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *messageLabel;

@end

@implementation ChargeAlertView

- (instancetype)initWithBeansNumber:(NSInteger)beans ChargeType:(ChargeType)chargeAlertType
{
    self = [super init];
    if (self) {
        
        // 是否拥有足够的coffee beans
        self.chargeAlertType = chargeAlertType;
        
        CGFloat alertViewWidth;
//        if ( IPHONE_6plus ) {
//            alertViewWidth = SCREEN_WIDTH - 45 / 2 * 2;
//        } else {
            alertViewWidth = SCREEN_WIDTH - 30 / 2 * 2;
//        }
        
        self.containerView.size = CGSizeMake(alertViewWidth, alertViewHeight - 2 * buttonHeight);
        
        self.containerView.backgroundColor = [UIColor colorWithHex:backgroundColor];
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:5];
        [paragraphStyle setLineBreakMode:NSLineBreakByWordWrapping];
        paragraphStyle.paragraphSpacingBefore = 0;
        NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:paragraphStyle forKey:NSParagraphStyleAttributeName];
        
        self.chargeLabel.text = @"把Ta推荐给我";
        self.chargeLabel.font = [UIFont systemFontOfSize:chargeFont];
        self.chargeLabel.textColor = [UIColor colorWithHex:chargeColor];
        
        self.titleLabel.text = @"把ta推荐给你后，你可以看到Ta的完整资料，并可以like ta。";
        NSAttributedString *titleAttributedString = [[NSAttributedString alloc] initWithString:@"把ta推荐给你后，你可以看到Ta的完整资料，并可以like ta。" attributes:attrsDictionary];
        [self.titleLabel setAttributedText:titleAttributedString];
        self.titleLabel.font = [UIFont systemFontOfSize:titleFont];
        self.titleLabel.textColor = [UIColor colorWithHex:titleColor];
//        CGFloat titleLabelHeight = [self BoundingWithSize:self.size Text:@"把ta推荐给你后，你可以看到Ta的完整资料，并可以like ta。" HexFont:titleFont].height * 2;
        CGFloat titleLabelHeight = [self.titleLabel.text boundingRectWithSize:self.size
                                                                      options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                                   attributes:attrsDictionary
                                                                      context:nil].size.height * 2;
        self.titleLabel.size = CGSizeMake(alertViewWidth - 2 * 20, titleLabelHeight + 8);
//        self.titleLabel.height = self.titleLabel.height / 2;
//        self.titleLabel.backgroundColor = [UIColor lightGrayColor];
//        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.titleLabel.numberOfLines = 0;
        
        self.messageLabel.text = @"如果你like ta，我们将在1-3天内也把你推荐到Ta的首页";
         NSAttributedString *messageAttributedString = [[NSAttributedString alloc] initWithString:@"如果你like ta，我们将在1-3天内也把你推荐到Ta的首页。" attributes:attrsDictionary];
        self.messageLabel.attributedText = messageAttributedString;
        self.messageLabel.font = [UIFont systemFontOfSize:messageFont];
        self.messageLabel.textColor = [UIColor colorWithHex:messageColor];
//        CGFloat messageLabelHeight = [self BoundingWithSize:self.size Text:@"如果你like ta，我们将在1-3天内也把你推荐到Ta的首页" HexFont:messageFont].height * 2;
        CGFloat messageLabelHeight = [self.messageLabel.text boundingRectWithSize:self.size
                                                                          options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                                       attributes:attrsDictionary
                                                                          context:nil].size.height * 2;
        self.messageLabel.size = CGSizeMake(alertViewWidth - 2 * 20, messageLabelHeight + 8);
//        self.messageLabel.textAlignment = NSTextAlignmentCenter;
//        self.messageLabel.backgroundColor = [UIColor lightGrayColor];
        self.messageLabel.lineBreakMode = NSLineBreakByCharWrapping;
        self.messageLabel.numberOfLines = 0;
        
        self.containerView.height = CGRectGetMaxY(self.messageLabel.frame) + 24;
        
        [self.containerView addSubview:self.chargeLabel];
        [self.containerView addSubview:self.titleLabel];
        [self.containerView addSubview:self.messageLabel];
        
        
        struct buttonParams buttonStyle;
        buttonStyle.backgroundColor = backgroundColor;
        buttonStyle.font = buttonFont;
        buttonStyle.textColor = buttonColor;
        
        struct buttonParams cancelButtonStyle;
        cancelButtonStyle.backgroundColor = backgroundColor;
        cancelButtonStyle.font = cancelButtonFont;
        cancelButtonStyle.textColor = cancelButtonColor;
        
        NSTextAttachment *attach = [[NSTextAttachment alloc] init];
        attach.image = [UIImage imageNamed:@"coffee_icon_introduction_bean_purple"];
        attach.bounds = (CGRect){ CGPointZero, attach.image.size };
        NSAttributedString *beansIcon = [NSAttributedString attributedStringWithAttachment:attach];
 
        NSMutableAttributedString *string;
        
        switch (self.chargeAlertType) {
            case AdequateBeans:
                string = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"-  %ld",(long)beans]];
                [string addAttribute:NSBaselineOffsetAttributeName value:@(6) range:NSMakeRange(0, string.length)];
                [string insertAttributedString: beansIcon atIndex:2];
                break;
            case EarnBeans:
                string = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"还差  %ld，现在去赚",(long)beans]];
                [string addAttribute:NSBaselineOffsetAttributeName value:@(6) range:NSMakeRange(0, string.length)];
                [string insertAttributedString: beansIcon atIndex:3];
                break;
            case InAdequateBeans:
                string = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"-  %ld",(long)beans]];
                [string addAttribute:NSBaselineOffsetAttributeName value:@(6) range:NSMakeRange(0, string.length)];
                [string insertAttributedString: beansIcon atIndex:2];
                attach.image = [UIImage imageNamed:@"coffee_icon_me_bean_middle_gray"];
                buttonStyle.textColor = 0xcccccc;
                break;
            default:
                break;
        }

        [self setButtonTitles:@[string,@"稍后再去"]];
        
        self.buttonStyles = (struct buttonParams *)malloc(sizeof(struct buttonParams) * 2);
        self.buttonStyles[0] = buttonStyle;
        self.buttonStyles[1] = cancelButtonStyle;
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss:)];
        [self.backgroundView addGestureRecognizer:tapGesture];
        
    }
    return self;
}


- (UILabel *)chargeLabel
{
    if (!_chargeLabel) {
        _chargeLabel = [[UILabel alloc] init];
    }
    [_chargeLabel sizeToFit];
    _chargeLabel.y = chargeInset;
    _chargeLabel.center = CGPointMake(self.containerView.center.x, _chargeLabel.center.y);
    return _chargeLabel;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
    }
//    [_titleLabel sizeToFit];
    _titleLabel.y = self.chargeLabel.y + self.chargeLabel.height + titleLabelTopInset;
    _titleLabel.x = titleLabelLeftInset;
    return _titleLabel;
}

- (UILabel *)messageLabel
{
    if (!_messageLabel) {
        _messageLabel = [[UILabel alloc] init];
    }
//    [_messageLabel sizeToFit];
    
    _messageLabel.x = titleLabelLeftInset;
    _messageLabel.y = self.titleLabel.y + self.titleLabel.height + messageLabelInset;
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

#pragma mark - some tools;
/**
 *  get size accordingto text & font
 *
 *  @param size    MAXSIZE
 *  @param text    text
 *  @param hexFont textFont
 *
 *  @return text size
 */
- (CGSize)BoundingWithSize:(CGSize)size Text:(NSString *)text HexFont:(NSUInteger)hexFont
{
    CGRect titleRect = [text boundingRectWithSize:size
                                          options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                       attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:hexFont]}
                                          context:nil];
    return titleRect.size;
}


@end










