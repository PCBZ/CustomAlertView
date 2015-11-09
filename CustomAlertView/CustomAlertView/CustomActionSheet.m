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
//#import "JWBlurView.h"

//#import "FunctionAPI.h"


static NSInteger const DEFAULT_CONTENTVIEWHEIGHT = 350;
static NSInteger const DEFAULT_TITLELABELVIEWHEIGHT = 200;
static NSInteger const DEFAULT_BUTTONHEIGHT = 50;
static NSInteger const DEFAULT_CANCALBUTTONGAP = 5;


@interface CustomActionSheet ()

@property (nonatomic, strong) NSMutableArray *buttonArray;
@property (nonatomic, strong) UIButton *cancelButton;

@property (nonatomic, strong) NSMutableArray *buttonTitleArray;

@property (nonatomic, strong) UITapGestureRecognizer *tapGestureRecognizer;

@end



@implementation CustomActionSheet

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark - init

- (id)initWithTitle:(NSString *)title delegate:(id)delegate titleViewHeight:(CGFloat)titleViewHeight cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {

        self.delegate = delegate;
        self.titleViewHeight = titleViewHeight;
        self.cancelButtonTitle = cancelButtonTitle;
//        self.buttonArray = [NSMutableArray array];
//        self.buttonTitleArray = [NSMutableArray array];
        
        va_list args;
        va_start(args, otherButtonTitles);
        if (otherButtonTitles) {
            [self.buttonTitleArray addObject:otherButtonTitles];
            while (1) {
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
        _backgroundView = [[UIView alloc] initWithFrame:self.frame];
//        _backgroundView.alpha = 1.0;
        _backgroundView.backgroundColor = [UIColor blackColor];
        [_backgroundView addGestureRecognizer:self.tapGestureRecognizer];
        [self addSubview:_backgroundView];
    }
    return _backgroundView;
}

- (UIView *)contentView
{
    if (!_contentView) {
        _contentView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
        _contentView.backgroundColor = [UIColor whiteColorWithAlpha:0.8];
        
        _contentView.width = [UIScreen mainScreen].bounds.size.width;
        _contentView.height = DEFAULT_CONTENTVIEWHEIGHT;
        _contentView.x = 0;
        _contentView.y = [UIScreen mainScreen].bounds.size.height - DEFAULT_CONTENTVIEWHEIGHT;
        
        [self addSubview:_contentView];
        
    }
    return _contentView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        CGFloat titleHeight = self.titleViewHeight > 0 ? self.titleViewHeight : DEFAULT_TITLELABELVIEWHEIGHT;
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.contentView.width, titleHeight)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.backgroundColor = [UIColor clearColor];
//        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UIView *)buttonView
{
    if (!_buttonView) {
        _buttonView = [[UIView alloc] initWithFrame:CGRectMake(0, self.titleLabel.height, self.contentView.width, 0)];
        _buttonView.backgroundColor = [UIColor clearColor];
        
        if (self.buttonTitleArray.count > 0) {
            for (int i = 0; i < self.buttonTitleArray.count; i++) {
                UIView *seperatorline = [[UIView alloc] initWithFrame:CGRectMake(0, i * DEFAULT_BUTTONHEIGHT, self.contentView.width, 1)];
                seperatorline.backgroundColor = [UIColor colorWithHex:0xcccccc];
//                seperatorline.alpha = 0.5;
                [_buttonView addSubview:seperatorline];
                
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                button.frame = CGRectMake(0, i * DEFAULT_BUTTONHEIGHT + 1, self.contentView.width, DEFAULT_BUTTONHEIGHT);
//                UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, i * DEFAULT_BUTTONHEIGHT + 1, self.contentView.width, DEFAULT_BUTTONHEIGHT)];
                button.backgroundColor = [UIColor clearColor];
                button.titleLabel.font = [UIFont systemFontOfSize:18];
                [button setTitle:self.buttonTitleArray[i] forState:UIControlStateNormal];
                [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//                [button setBackgroundImage:[FunctionAPI getImageWithRGBColor:[UIColor colorWithHex:0xe5e5e5]] forState:UIControlStateHighlighted];
                
                [button addTarget:self action:@selector(ButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                [self.buttonArray addObject:button];
                [_buttonView addSubview:button];
                
                _buttonView.height += seperatorline.height + button.height;
                self.contentView.height = _buttonView.height + self.titleLabel.height;
                self.contentView.y = self.height - self.contentView.height;
            }
            _buttonView.layer.cornerRadius = 0;
            _buttonView.layer.masksToBounds = YES;
            [self.contentView addSubview:_buttonView];
        }
//        NSLog(@"button View %@", NSStringFromCGRect(_buttonView.frame));
        UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
        blurView.frame = _buttonView.frame;
        blurView.backgroundColor = [UIColor whiteColorWithAlpha:0.8];
        [_buttonView addSubview:blurView];
    }
//    NSLog(@"buttonview %@", NSStringFromCGRect(_buttonView.frame));
    return _buttonView;
}

- (UIButton *)cancelButton
{
    if (!_cancelButton) {
        _cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.contentView.width, DEFAULT_BUTTONHEIGHT)];
        _cancelButton.backgroundColor = [UIColor whiteColor];
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:18];
        _cancelButton.layer.cornerRadius = 5.0;
        _cancelButton.layer.masksToBounds = YES;
        [_cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(cancelButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        self.contentView.height += _cancelButton.height + DEFAULT_CANCALBUTTONGAP;
        self.contentView.y = self.height - self.contentView.height;
        

        self.buttonView.height += _cancelButton.height + DEFAULT_CANCALBUTTONGAP;
        
        _cancelButton.y = self.buttonView.height - DEFAULT_BUTTONHEIGHT;
        
        [self.buttonView addSubview:_cancelButton];
    }
    return _cancelButton;
}

#pragma mark - some setter to public

- (void)setTitle:(NSString *)title
{
    _title = title;
}

- (void)setCancelButtonTitle:(NSString *)cancelButtonTitle
{
    _cancelButtonTitle = cancelButtonTitle;
//    [self.cancelButton setTitle:cancelButtonTitle forState:UIControlStateNormal];
}

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

- (void)setTitleViewHeight:(CGFloat)titleViewHeight
{
    _titleViewHeight = titleViewHeight;
    _titleLabel.height = titleViewHeight;
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
