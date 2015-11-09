//
//  UIColor+Hex.h
//  CTDestingy
//
//  Created by CT.Master on 13-10-31.
//  Copyright (c) 2013年 YLW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Hex)

+(UIColor*)colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alphaValue;

+(UIColor*)colorWithHex:(NSInteger)hexValue;

+(UIColor*)whiteColorWithAlpha:(CGFloat)alphaValue;

+(UIColor*)blackColorWithAlpha:(CGFloat)alphaValue;

@property (nonatomic, readonly) CGFloat r;
@property (nonatomic, readonly) CGFloat g;
@property (nonatomic, readonly) CGFloat b;
@property (nonatomic, readonly) CGFloat a;

@end
