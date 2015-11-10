//
//  CustomActionSheet.m
//  Congratulations
//
//  Created by Wenshuang Zhou on 15/9/15.
//  Copyright (c) 2015年 Zhenai. All rights reserved.
//

#import "CustomActionSheet.h"
#import "UIColor+Hex.h"
#import "UIView+Extension.h"


static NSInteger const DEFAULT_CONTENTVIEWHEIGHT = 350;
static NSInteger const DEFAULT_TITLELABELVIEWHEIGHT = 200;
static NSInteger const DEFAULT_BUTTONHEIHGT = 50;
static NSInteger const DEFAULT_CANCALBUTTONGAP = 5;


@interface CustomActionSheet ()

@property (nonatomic, strong) NSMutableArray *buttonArray;
@property (nonatomic, strong) UIButton *cancelButton;

@property (nonatomic, strong) NSMutableArray *buttonTitleArray;

@property (nonatomic, strong) UITapGestureRecognizer *tapGestureRecognizer;

@property (nonatomic, assign) CGFloat buttonHeight;
@property (nonatomic, assign) CGFloat cancelButtonGap;

@end



@implementation CustomActionSheet

#pragma mark - init

- (instancetype)initWithTitle:(NSString *)title TitleViewHeight:(CGFloat)titleViewHeight CancelButtonTitle:(NSString *)cancelButtonTitle OtherButtonTitles:(NSString *)otherButtonTitles, ...
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        self.titleViewHeight = titleViewHeight;
        self.cancelButtonTitle = cancelButtonTitle;
        
        va_list args;
        va_start(args, otherButtonTitles);
        if (otherButtonTitles) {
            [self.buttonTitleArray addObject:otherButtonTitles];
            while (TRUE) {
                NSString *otherButtonTitle = va_arg(args, NSString *);
                if (otherButtonTitle == nil) {
                    break;
                } else {
                    [self.buttonTitleArray addObject:otherButtonTitle];
                }
            }
        }
        va_end(args);
        self.backgroundColor = [UIColor clearColor];
        self.backgroundView.alpha = 0;
        
        self.titleLabel.text = title;
        self.buttonView.backgroundColor = [UIColor clearColor];
        
        if (self.cancelButtonTitle) {
            [self.cancelButton setTitle:self.cancelButtonTitle forState:UIControlStateNormal];
        }
        
        self.contentView.frame = CGRectMake(0, self.height, self.contentView.width, self.contentView.height);

    }
    return self;
}

- (id)initWithTitle:(NSString *)title Delegate:(id)delegate TitleViewHeight:(CGFloat)titleViewHeight ButtonHeight:(CGFloat)buttonHeight CancelButtonTitle:(NSString *)cancelButtonTitle CancelButtonGap:(CGFloat)gap OtherButtonTitles:(NSString *)otherButtonTitles, ...
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {

        self.delegate = delegate;
        self.titleViewHeight = titleViewHeight;
        self.buttonHeight = buttonHeight;
        self.cancelButtonTitle = cancelButtonTitle;
        self.cancelButtonGap = gap;
        
        va_list args;
        va_start(args, otherButtonTitles);
        if (otherButtonTitles) {
            [self.buttonTitleArray addObject:otherButtonTitles];
            while (TRUE) {
                NSString *otherButtonTitle = va_arg(args, NSString *);
                if (otherButtonTitle == nil) {
                    break;
                } else {
                    [self.buttonTitleArray addObject:otherButtonTitle];
                }
            }
        }
        va_end(args);
        self.backgroundColor = [UIColor clearColor];
        self.backgroundView.alpha = 0;
        
        self.titleLabel.text = title;
        self.buttonView.backgroundColor = [UIColor clearColor];
        
        if (self.cancelButtonTitle) {
            [self.cancelButton setTitle:self.cancelButtonTitle forState:UIControlStateNormal];
        }
        
        self.contentView.frame = CGRectMake(0, self.height, self.contentView.width, self.contentView.height);

    }
    return self;
}

- (NSMutableArray *)buttonArray
{
    if (!_buttonArray) {
        _buttonArray = [[NSMutableArray alloc] initWithArray:_buttonArray];
    }
    return _buttonArray;
}

- (NSMutableArray *)buttonTitleArray
{
    if (!_buttonTitleArray) {
        _buttonTitleArray = [[NSMutableArray alloc] init];
    }
    return _buttonTitleArray;
}

- (UITapGestureRecognizer *)tapGestureRecognizer
{
    if (!_tapGestureRecognizer) {
        _tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
    }
    return _tapGestureRecognizer;
}

- (UIView *)backgroundView
{
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc] initWithFrame:self.bounds];
        _backgroundView.backgroundColor = [UIColor blackColor];
        [_backgroundView addGestureRecognizer:self.tapGestureRecognizer];
        [self addSubview:_backgroundView];
    }
    return _backgroundView;
}

- (UIView *)contentView
{
    if (!_contentView) {
        _contentView        = [[UIView alloc] init];
        _contentView.width  = [UIScreen mainScreen].bounds.size.width;
        _contentView.height = DEFAULT_CONTENTVIEWHEIGHT;
        _contentView.x      = 0;
        _contentView.y      = [UIScreen mainScreen].bounds.size.height - DEFAULT_CONTENTVIEWHEIGHT;
        [self addSubview:_contentView];
    }
    return _contentView;
}

- (UIView *)coverView
{
    if (!_coverView) {
        _coverView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
        _coverView.backgroundColor = [UIColor whiteColorWithAlpha:0.5];
        [self.contentView addSubview:_coverView];
    }
    return _coverView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        CGFloat titleHeight = self.titleViewHeight > 0 ? self.titleViewHeight : DEFAULT_TITLELABELVIEWHEIGHT;
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.contentView.width, titleHeight)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.backgroundColor = [UIColor clearColor];
        [self.coverView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UIView *)buttonView
{
    if (!_buttonView) {
        _buttonView = [[UIView alloc] initWithFrame:CGRectMake(0, self.titleLabel.height, self.contentView.width, 0)];
        _buttonView.backgroundColor = [UIColor clearColor];
        
        CGFloat tempButtonHeight = self.buttonHeight == 0 ? DEFAULT_BUTTONHEIHGT : self.buttonHeight;
        
        if (self.buttonTitleArray.count > 0) {
            for (int i = 0; i < self.buttonTitleArray.count; i++) {
                UIView *seperatorline = [[UIView alloc] initWithFrame:CGRectMake(0, i * tempButtonHeight, self.contentView.width, 1)];
                seperatorline.backgroundColor = [UIColor colorWithHex:0x666666];
                [_buttonView addSubview:seperatorline];
                
                UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
                button.frame = CGRectMake(0, i * tempButtonHeight + 1, self.contentView.width, tempButtonHeight);
                button.backgroundColor = [UIColor clearColor];
                button.titleLabel.font = [UIFont systemFontOfSize:18];
                [button setTitle:self.buttonTitleArray[i] forState:UIControlStateNormal];
                [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                
                [button addTarget:self action:@selector(ButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                [self.buttonArray addObject:button];
                [_buttonView addSubview:button];
                
                _buttonView.height += seperatorline.height + button.height;
                self.contentView.height = _buttonView.height + self.titleLabel.height;
                self.contentView.y = self.height - self.contentView.height;
                self.coverView.frame = self.contentView.bounds;
            }
            _buttonView.layer.cornerRadius = 0;
            _buttonView.layer.masksToBounds = YES;
            [self.contentView addSubview:_buttonView];
        }

        self.coverView.layer.cornerRadius = 16.0;
        self.coverView.layer.masksToBounds = YES;
    }
    return _buttonView;
}

- (UIButton *)cancelButton
{
    if (!_cancelButton) {
        CGFloat tempButtonHeight = self.buttonHeight == 0 ? DEFAULT_BUTTONHEIHGT : self.buttonHeight;
        
        _cancelButton                 = [UIButton buttonWithType:UIButtonTypeSystem];
        _cancelButton.frame           = CGRectMake(0, 0, self.contentView.width, tempButtonHeight);
        _cancelButton.backgroundColor = UIColor.clearColor;
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:18];
        [_cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(cancelButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        CGFloat cancelButtonGap = self.cancelButtonGap == 0 ? DEFAULT_CANCALBUTTONGAP : self.cancelButtonGap;
        
        self.contentView.height += _cancelButton.height + cancelButtonGap;
        self.contentView.y      = self.height - self.contentView.height;
        self.buttonView.height  += _cancelButton.height + cancelButtonGap;
        _cancelButton.y         = self.buttonView.height - tempButtonHeight;

        [self.buttonView addSubview:self.cancelButtonCoverView];
        [self.buttonView addSubview:_cancelButton];
    }
    return _cancelButton;
}

- (UIView *)cancelButtonCoverView
{
    if (!_cancelButtonCoverView) {
        _cancelButtonCoverView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
        _cancelButtonCoverView.backgroundColor = [UIColor whiteColorWithAlpha:0.5];
        _cancelButtonCoverView.frame = self.cancelButton.frame;
        _cancelButtonCoverView.layer.cornerRadius = 16.0;
        _cancelButtonCoverView.layer.masksToBounds = YES;
    }
    return _cancelButtonCoverView;
}

#pragma mark - some setter to public


- (void)setButtonTitleColor:(UIColor *)color BackgroundColor:(UIColor *)backgroundColor fontSize:(CGFloat)font atIndex:(NSInteger)index Alpha:(CGFloat)alpha
{
    UIButton *button = self.buttonArray[index];
    if (color) {
        [button setTitleColor:color forState:UIControlStateNormal];
    }
    if (backgroundColor) {
        [button setBackgroundColor:backgroundColor];
    }
    if (font) {
        button.titleLabel.font = [UIFont systemFontOfSize:font];
    }
    if (alpha) {
        [button setBackgroundColor:[backgroundColor colorWithAlphaComponent:alpha]];
    }
}

- (void)setCancelButtonTitleColor:(UIColor *)color BackgroundColor:(UIColor *)backgroundColor fontSize:(CGFloat)font Alpha:(CGFloat)alpha
{
    if (color) {
        [self.cancelButton setTitleColor:color forState:UIControlStateNormal];
    }
    if (backgroundColor) {
        self.cancelButton.backgroundColor = backgroundColor;
    }
    if (font) {
        self.cancelButton.titleLabel.font = [UIFont systemFontOfSize:font];
    }
    if (alpha) {
        self.cancelButton.alpha = alpha;
    }
}

- (void)show
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    [self addAnimation];
}

- (void)hide
{
    [self removeAnimation];
}

#pragma mark - animation

- (void)addAnimation
{
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.contentView.frame = CGRectMake(self.contentView.x, self.height - self.contentView.height , self.contentView.width, self.contentView.height);
        self.backgroundView.alpha = 0.5;
    }completion:^(BOOL finished) { }];
}

- (void)removeAnimation
{
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.backgroundView.alpha = 0;
        self.contentView.frame = CGRectMake(self.contentView.x, self.height, self.contentView.width, self.contentView.height);
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - selector

- (void)ButtonPressed:(UIButton *)button
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(customActionSheet:clickedButtonAtIndex:)]) {
        for (int i = 0 ; i < self.buttonArray.count; i++) {
            if (button == self.buttonArray[i]) {
                [self.delegate customActionSheet:self clickedButtonAtIndex:i];
                break;
            }
        }
    }
    [self hide];
}

- (void)cancelButtonPressed:(UIButton *)button
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(actionSheetCancel:)]) {
        [self.delegate customActionSheetCancelClick:self];
    }
    [self hide];
}


@end
