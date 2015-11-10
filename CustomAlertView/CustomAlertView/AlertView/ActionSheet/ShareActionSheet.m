//
//  ShareActionSheet.m
//  Congratulations
//
//  Created by Wenshuang Zhou on 15/9/15.
//  Copyright (c) 2015年 Zhenai. All rights reserved.
//

#import "ShareActionSheet.h"
#import "UIView+Extension.h"
#import "UIColor+Hex.h"
//#import "YLNormal.h"
//#import "JWBlurView.h"
#import <QuartzCore/QuartzCore.h>


//#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
//#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
//#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
//#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
//#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)


@interface ShareActionSheet ()

// 标题图片
@property (nonatomic, strong) UIImageView *titleImageView;
//
@property (nonatomic, strong) UILabel *headLabel;

@property (nonatomic, strong) UILabel *firstLabel;
@property (nonatomic, strong) UILabel *secondLabel;
@property (nonatomic, strong) UIView *separatorLine;
@property (nonatomic, strong) UILabel *thirdLabel;
@property (nonatomic, strong) UILabel *fourthLabel;

// 分享给微信好友
@property (nonatomic, strong) UIButton *wechatShareButton;
// 分享给qq好友
@property (nonatomic, strong) UIButton *QQShareButton;

@end



@implementation ShareActionSheet


#pragma mark - init

- (instancetype)initWithdelegate:(id)delegate
{
    self = [super initWithTitle:nil delegate:delegate titleViewHeight:[self getTitleHeight] cancelButtonTitle:nil otherButtonTitles:@"取消", nil];
    if (self) {
        
        self.delegate = delegate;
         NSLog(@"button View %@", NSStringFromCGRect(self.buttonView.frame));
        UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
        blurView.frame = self.buttonView.frame;
        blurView.backgroundColor = [UIColor whiteColorWithAlpha:0.8];
        [self.buttonView addSubview:blurView];
//        self.buttonView.backgroundColor = [UIColor whiteColorWithAlpha:0.8];
//        self.contentView.backgroundColor = [UIColor blueColor];
        
        [self setButtonTitleColor:[UIColor colorWithHex:0x6b0cad] BackgroundColor:nil fontSize:16 atIndex:0 Alpha:0.0];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        
        // set blur effect
//        if ( SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0") ) {
////            UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
////            blurView.frame = self.contentView.bounds;
////            blurView.backgroundColor = [UIColor whiteColorWithAlpha:0.8];
////            [self.contentView addSubview:blurView];
//        } else {
//            JWBlurView *blurView = [[JWBlurView alloc] initWithFrame:self.titleLabel.frame];
//            [blurView setBlurAlpha:0.5];
//            [self.contentView addSubview:blurView];
//        }
//        
    
        
        // init title image
        self.titleImageView.image = [UIImage imageNamed:@"coffee_icon_share"];
        self.titleImageView.y = 12;
        self.titleImageView.center = CGPointMake(self.contentView.center.x, self.titleImageView.center.y);
        
        // init head Label
        self.headLabel.text = @"推荐给朋友";
        self.headLabel.font = [UIFont systemFontOfSize:15];
        self.headLabel.center = self.center;
        self.headLabel.y = CGRectGetMaxY(self.titleImageView.frame) + 10;
        
        // init beans label
//        NSTextAttachment *attach = [[NSTextAttachment alloc] init];
//        attach.image = [UIImage imageNamed:@"coffee_icon_me_bean_middle_white"];
//        attach.bounds = (CGRect){ CGPointZero, attach.image.size };
//        NSAttributedString *beansIcon = [NSAttributedString attributedStringWithAttachment:attach];
//        NSMutableAttributedString *string = [[NSMutableAttributedString alloc]
//                                             initWithString:[NSString stringWithFormat:@" %d",35]
//                                             attributes:@{
//                                                          NSForegroundColorAttributeName:[UIColor whiteColor],
//                                                          NSFontAttributeName:[UIFont systemFontOfSize:10 weight:100]
//                                                          }];
//        
//        [string addAttribute:NSBaselineOffsetAttributeName value:@(4.5) range:NSMakeRange(0, string.length)];
//        [string insertAttributedString: beansIcon atIndex:0];
//        [self.addBeansLabel setAttributedTitle:string forState:UIControlStateNormal];
        
        // init firstLabelcu
        self.firstLabel.text = @"每天前3次推荐，均可获得";
        self.firstLabel.font = [UIFont systemFontOfSize:12];
        self.firstLabel.textColor = [UIColor colorWithHex:0x999999];
        CGSize size1 = [self BoundingWithSize:self.size Text:@"每天前3次推荐，均可获得" HexFont:12];

        self.firstLabel.size = CGSizeMake(size1.width + 4 + 46, 20);
        self.firstLabel.center = self.center;
        self.firstLabel.y = CGRectGetMaxY(self.headLabel.frame) + 16;
        
        UIView *beansView1 = [self addBeansViewWithCoffeeCount:@"20"];
        beansView1.x = size1.width + 4;
        
        [self.firstLabel addSubview:beansView1];
        
        // init secondLabel
        self.secondLabel.text = @"朋友成功注册后，你还将获得";
        self.secondLabel.font = [UIFont systemFontOfSize:12];
        self.secondLabel.textColor = [UIColor colorWithHex:0x999999];
        CGSize size2 = [self BoundingWithSize:self.size Text:@"朋友成功注册后，你还将获得" HexFont:12];
        
        self.secondLabel.size = CGSizeMake(size2.width + 4 + 46, 20);
        self.secondLabel.center = self.center;
        self.secondLabel.y = CGRectGetMaxY(self.firstLabel.frame) + 13;
        
        UIView *beansView2 = [self addBeansViewWithCoffeeCount:@"300"];
        beansView2.x = size2.width + 4;
    
        [self.secondLabel addSubview:beansView2];

        // init separator
        self.separatorLine.width = self.width - 2 * 15;
        self.separatorLine.center = self.center;
        self.separatorLine.y = CGRectGetMaxY(self.secondLabel.frame) + 24;
        
        // init thirdLabel
        self.thirdLabel.text = @"觉得Ta很适合我身边的某个小伙伴";
        self.thirdLabel.font = [UIFont systemFontOfSize:12];
        self.thirdLabel.textColor = [UIColor colorWithHex:0xbfbfbf];
        self.thirdLabel.center = self.center;
        self.thirdLabel.y = CGRectGetMaxY(self.separatorLine.frame) + 20;
        
        // init fourthLabel
        self.fourthLabel.text = @"通过以下方式介绍他们认识";
        self.fourthLabel.font = [UIFont systemFontOfSize:12];
        self.fourthLabel.textColor = [UIColor colorWithHex:0xbfbfbf];
        self.fourthLabel.center = self.center;
        self.fourthLabel.y = CGRectGetMaxY(self.thirdLabel.frame) + 6;
        
        
        // init share buttons
        UIImage *wechatImage = [UIImage imageNamed:@"coffee_icon_home_share_wx"];
        [self.wechatShareButton setImage:wechatImage forState:UIControlStateNormal];
        [self.wechatShareButton setTitle:@"微信" forState:UIControlStateNormal];
        [self.wechatShareButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.wechatShareButton.titleLabel.font = [UIFont systemFontOfSize:14];
        
        self.wechatShareButton.x = 88;
        
        self.wechatShareButton.y = CGRectGetMaxY(self.fourthLabel.frame) + 14;
        [self makeButton:self.wechatShareButton Image:wechatImage Title:@"微信" VerticallyWithInset:10];
        
        [self.wechatShareButton addTarget:self action:@selector(clickWechatShare:) forControlEvents:UIControlEventTouchUpInside];

        
        UIImage *qqImage = [UIImage imageNamed:@"coffee_icon_home_share_qq"];
        [self.QQShareButton setImage:qqImage forState:UIControlStateNormal];
        [self.QQShareButton setTitle:@"QQ" forState:UIControlStateNormal];
        [self.QQShareButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.QQShareButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [self makeButton:self.QQShareButton Image:wechatImage Title:@"QQ" VerticallyWithInset:10];
        self.QQShareButton.y = CGRectGetMaxY(self.fourthLabel.frame) + 14;
//        if (!IPHONE_6plus) {
//            self.QQShareButton.x = self.width - 88 * 1.5 - self.QQShareButton.width;
//        } else {
        self.QQShareButton.x = self.width - 88 - self.QQShareButton.width;
//        }
        [self.QQShareButton addTarget:self action:@selector(clickQQShare:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}

- (UIImageView *)titleImageView
{
    if (!_titleImageView) {
        _titleImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_titleImageView];
    }
    [_titleImageView sizeToFit];
    return _titleImageView;
}

- (UILabel *)headLabel
{
    if (!_headLabel) {
        _headLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_headLabel];
    }
    [_headLabel sizeToFit];
    return _headLabel;
}

- (UILabel *)firstLabel
{
    if (!_firstLabel) {
        _firstLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_firstLabel];
    }
    return _firstLabel;
}

- (UILabel *)secondLabel
{
    if (!_secondLabel) {
        _secondLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_secondLabel];
    }
    return _secondLabel;
}

- (UIView *)separatorLine
{
    if (!_separatorLine) {
        _separatorLine = [[UIView alloc] init];
        _separatorLine.height = 0.5;
        _separatorLine.backgroundColor = [UIColor colorWithHex:0xcccccc];
        [self.contentView addSubview:_separatorLine];
    }
    return _separatorLine;
}

- (UILabel *)thirdLabel
{
    if (!_thirdLabel) {
        _thirdLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_thirdLabel];
    }
    [_thirdLabel sizeToFit];
    return _thirdLabel;
}

- (UILabel *)fourthLabel
{
    if (!_fourthLabel) {
        _fourthLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_fourthLabel];
    }
    [_fourthLabel sizeToFit];
    return _fourthLabel;
}


- (UIButton *)wechatShareButton
{
    if (!_wechatShareButton) {
        _wechatShareButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:_wechatShareButton];
    }
//    [_wechatShareButton sizeToFit];
    return _wechatShareButton;
}

- (UIButton *)QQShareButton
{
    if (!_QQShareButton) {
        _QQShareButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:_QQShareButton];
    }
//    [_QQShareButton sizeToFit];
    return _QQShareButton;
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

- (CGFloat)getTitleHeight
{
    CGFloat height_15 = [self BoundingWithSize:self.size Text:@"推荐给朋友" HexFont:15].height;
    CGFloat height_12 = [self BoundingWithSize:self.size Text:@"推荐给朋友" HexFont:12].height;
    CGFloat height_14 = [self BoundingWithSize:self.size Text:@"推荐给朋友" HexFont:14].height;
    
    return 12 + [UIImage imageNamed:@"coffee_icon_share"].size.height + 10 + height_15 + 16 + 20 + 13 + 20 + 24 + 0.5 + 20 + height_12 + 6 + height_12 + 14 + [UIImage imageNamed:@"coffee_icon_home_share_wx"].size.height + 10 + height_14 + 20;
    
}

/**
 *  set button image & title vertically
 *
 *  @param button
 *  @param image  image
 *  @param text   text
 *  @param insets insets between image & title
 */
- (void)makeButton:(UIButton *)button Image:(UIImage *)image Title:(NSString *)text VerticallyWithInset:(CGFloat)insets
{
    CGSize textSize = [self BoundingWithSize:self.contentView.size Text:text HexFont:14];
    button.size = CGSizeMake(MAX(textSize.width, image.size.width), image.size.height + insets + textSize.height);
    
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, 0, insets + textSize.height, 0)];
    
    [button setTitleEdgeInsets:UIEdgeInsetsMake(image.size.height + insets,
                                               - button.size.width + (button.size.width - textSize.width) / 2,
                                               0,
                                               (button.size.width - textSize.width) / 2)];
}

#pragma mark - beansView

- (UIView *)addBeansViewWithCoffeeCount:(NSString *)coffeeCount
{
    UIView *beansView = [[UIView alloc] init];
    
    beansView = [[UIButton alloc] init];
    beansView.size = CGSizeMake(46, 20);
    beansView.backgroundColor = [UIColor colorWithHex:0xff6000];
    UIImageView *beansImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_share_beans"]];
    [beansImageView sizeToFit];
    beansImageView.origin = CGPointMake(5, 2.5);
    UILabel *beanslabel = [[UILabel alloc] init];
    beanslabel.text = coffeeCount;
    
    beanslabel.font = [UIFont boldSystemFontOfSize:10];
    
    beanslabel.textColor = [UIColor whiteColor];
    [beanslabel sizeToFit];
    beanslabel.origin = CGPointMake( 5 + beansImageView.width + 4, 4);
    
    beansView.width = 5 + beansImageView.width + 4 + beanslabel.width + 9;
    
    [beansView addSubview:beansImageView];
    [beansView addSubview:beanslabel];
    
    beansView.layer.cornerRadius = 10;
    beansView.layer.masksToBounds = YES;
    
    return beansView;
}


#pragma mark - delegate

- (void)clickWechatShare:(UIButton *)button
{
    if (self.shareDelegate && [self.shareDelegate respondsToSelector:@selector(ShareToWechat:)]) {
        [self.shareDelegate ShareToWechat:self];
    }
    [self hide];
}

- (void)clickQQShare:(UIButton *)button
{
    if (self.shareDelegate && [self.shareDelegate respondsToSelector:@selector(ShareToQQ:)]) {
        [self.shareDelegate ShareToQQ:self];
    }
    [self hide];
}

@end













































