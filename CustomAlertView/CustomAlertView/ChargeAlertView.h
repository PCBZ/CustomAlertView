//
//  ChargeAlertView.h
//  Congratulations
//
//  Created by Wenshuang Zhou on 15/9/11.
//  Copyright (c) 2015年 Zhenai. All rights reserved.
//

#import "CustomIOSAlertView.h"

typedef NS_ENUM(NSInteger, ChargeType)
{
    // 足够的咖啡豆
    AdequateBeans,
    // 不够咖啡豆却可以填详细资料去赚
    EarnBeans,
    // 咖啡豆不足
    InAdequateBeans
};


@interface ChargeAlertView : CustomIOSAlertView

@property (nonatomic, assign) ChargeType chargeAlertType;

- (instancetype)initWithBeansNumber:(NSInteger)beans ChargeType:(ChargeType)chargeAlertType;

- (void)setButtonEnabled:(BOOL)enabled;

@end
