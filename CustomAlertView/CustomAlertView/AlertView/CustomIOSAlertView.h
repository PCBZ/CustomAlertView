//
//  CustomIOSAlertView.h
//  CustomIOSAlertView
//
//  Created by Richard on 20/09/2013.
//  Copyright (c) 2013-2015 Wimagguc.
//
//  Lincesed under The MIT License (MIT)
//  http://opensource.org/licenses/MIT
//

#import <UIKit/UIKit.h>

@protocol CustomIOSAlertViewDelegate;

struct buttonParams
{
    NSInteger backgroundColor;
    NSInteger font;
    NSInteger textColor;
};


@interface CustomIOSAlertView : UIView


@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, retain) UIView *parentView;    // The parent view this 'dialog' is attached to
@property (nonatomic, retain) UIView *dialogView;    // Dialog's container view
@property (nonatomic, retain) UIView *containerView; // Container within the dialog (place your ui elements here)

@property (nonatomic, assign) id <CustomIOSAlertViewDelegate> delegate;
@property (nonatomic, retain) NSArray *buttonTitles;
@property (nonatomic, assign) BOOL useMotionEffects;

@property (nonatomic, assign) NSArray *buttonCache;

@property (nonatomic, strong) NSArray *buttonStyles;

@property (copy) void (^onButtonTouchUpInside)(CustomIOSAlertView *alertView, int buttonIndex) ;

- (id)init;

/*!
 DEPRECATED: Use the [CustomIOSAlertView init] method without passing a parent view.
 */
- (id)initWithParentView: (UIView *)_parentView __attribute__ ((deprecated));

- (void)addButtonsToView:(UIView *)container WithButton:(NSArray *)buttonStyles;

/**
 *  显示和隐藏
 */
- (void)show;
- (void)close;

- (IBAction)customIOS7dialogButtonTouchUpInside:(id)sender;
- (void)setOnButtonTouchUpInside:(void (^)(CustomIOSAlertView *alertView, int buttonIndex))onButtonTouchUpInside;

- (void)deviceOrientationDidChange: (NSNotification *)notification;
- (void)dealloc;

@end

@protocol CustomIOSAlertViewDelegate <NSObject>

@optional

- (void)customIOS7dialogButtonTouchUpInside:(CustomIOSAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;

@end


