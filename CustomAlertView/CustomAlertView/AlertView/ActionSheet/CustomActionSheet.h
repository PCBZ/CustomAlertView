//
//  CustomActionSheet.h
//  Congratulations
//
//  Created by Wenshuang Zhou on 15/9/15.
//  Copyright (c) 2015年 Zhenai. All rights reserved.
//

#import <UIKit/UIKit.h>

//#import "YLDeviceStatics.h"

//#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
//#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
//#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
//#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
//#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

@protocol CustomActionSheetDelegate;

@interface CustomActionSheet : UIView

@property (nonatomic, weak) id<CustomActionSheetDelegate> delegate;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *cancelButtonTitle;

@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *buttonView;

@property (nonatomic, assign) CGFloat titleViewHeight;



- (id)initWithTitle:(NSString *)title delegate:(id)delegate titleViewHeight:(CGFloat)titleViewHeight cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;
/**
 *  显示和隐藏
 */
- (void)show;
- (void)hide;

- (void)setTitle:(NSString *)title;
- (void)setCancelButtonTitle:(NSString *)cancelButtonTitle;

- (void)setButtonTitleColor:(UIColor *)color BackgroundColor:(UIColor *)backgroundColor fontSize:(CGFloat)font atIndex:(NSInteger)index Alpha:(CGFloat)alpha;

- (void)setCancelButtonTitleColor:(UIColor *)color BackgroundColor:(UIColor *)backgroundColor fontSize:(CGFloat)font Alpha:(CGFloat)alpha;

- (void)setTitleLabelHeight:(CGFloat)height;

@end


@protocol CustomActionSheetDelegate <NSObject>

@optional

- (void)customActionSheetCancelClick:(CustomActionSheet *)actionSheet;
- (void)customActionSheet:(CustomActionSheet *)sheet clickedButtonAtIndex:(NSInteger)buttonIndex;

@end