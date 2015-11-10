//
//  ViewController.m
//  CustomAlertView
//
//  Created by Wenshuang Zhou on 15/11/9.
//  Copyright © 2015年 PCBZ. All rights reserved.
//

#import "ViewController.h"
#import "CustomActionSheet.h"
#import "ShareActionSheet.h"
#import "PCBZCustomAlertView.h"
#import "UIView+Extension.h"
#import "UIColor+Hex.h"

#define tintColor ([[[UIApplication sharedApplication] delegate] window].tintColor)

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)ClickAlertView:(id)sender
{

    PCBZCustomAlertView *alertView = [[PCBZCustomAlertView alloc] init];
    alertView.containerView.size   = CGSizeMake(300, 120);
    alertView.buttonTitles         = @[@"OK",@"Twenkle",@"Cancel"];
    alertView.titleLabel.text      = @"Title";
    alertView.titleLabel.center    = alertView.containerView.center;
    alertView.titleLabel.y         = 30;
    alertView.messageLabel.text    = @"Message";
    alertView.messageLabel.center  = alertView.containerView.center;
    alertView.messageLabel.y       = CGRectGetMaxY(alertView.titleLabel.frame) + 20;
    alertView.containerView.backgroundColor = [UIColor whiteColor];
    
    NSDictionary *dic1 = [NSDictionary dictionaryWithObjectsAndKeys:
                          [UIColor whiteColor],         @"backgroundColor",
                          [UIFont systemFontOfSize:14], @"buttonFont",
                          tintColor,                    @"buttonColor",
                          nil];
    NSDictionary *dic2 = [NSDictionary dictionaryWithObjectsAndKeys:
                          [UIColor whiteColor],         @"backgroundColor",
                          [UIFont systemFontOfSize:14], @"buttonFont",
                          tintColor,                    @"buttonColor",
                          nil];
    NSDictionary *dic3 = [NSDictionary dictionaryWithObjectsAndKeys:
                          [UIColor whiteColor],             @"backgroundColor",
                          [UIFont systemFontOfSize:14],     @"buttonFont",
                          [UIColor colorWithHex:0x666666],  @"buttonColor",
                          nil];

    alertView.buttonStyles = [[NSArray alloc] initWithObjects:dic1, dic2, dic3, nil];
    
    [alertView show];
}


- (IBAction)ClickActionSheet:(id)sender
{
    ShareActionSheet *actionSheet = [[ShareActionSheet alloc] initWithdelegate:self];
    [actionSheet show];
}


@end
