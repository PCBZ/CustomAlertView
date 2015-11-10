//
//  ShareActionSheet.h
//  Congratulations
//
//  Created by Wenshuang Zhou on 15/9/15.
//  Copyright (c) 2015年 Zhenai. All rights reserved.
//

#import "CustomActionSheet.h"

@protocol ShareDelegate;

/**
 *  毛玻璃弹框
 */
@interface ShareActionSheet : CustomActionSheet

@property (nonatomic, weak) id<ShareDelegate> shareDelegate;

- (instancetype)initWithdelegate:(id)delegate;

@end

@protocol ShareDelegate <NSObject>

@optional

- (void)ShareToWechat:(ShareActionSheet *)actionSheet;
- (void)ShareToQQ:(ShareActionSheet *)actionSheet;

@end
