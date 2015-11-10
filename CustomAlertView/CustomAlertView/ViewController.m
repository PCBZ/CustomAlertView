//
//  ViewController.m
//  CustomAlertView
//
//  Created by Wenshuang Zhou on 15/11/9.
//  Copyright © 2015年 PCBZ. All rights reserved.
//

#import "ViewController.h"
#import "CustomActionSheet.h"
#import "PCBZCustomAlertView.h"
#import "UIView+Extension.h"
#import "UIColor+Hex.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *alertView;
@property (weak, nonatomic) IBOutlet UIButton *actionSheet;

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
                          self.view.tintColor,          @"buttonColor",
                          nil];
    NSDictionary *dic2 = [NSDictionary dictionaryWithObjectsAndKeys:
                          [UIColor whiteColor],         @"backgroundColor",
                          [UIFont systemFontOfSize:14], @"buttonFont",
                          UIColor.blackColor,           @"buttonColor",
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
    CustomActionSheet *actionSheet = [[CustomActionSheet alloc] initWithTitle:@"Title" Delegate:self TitleViewHeight:120 ButtonHeight:50 CancelButtonTitle:@"Cancel" CancelButtonGap:8 OtherButtonTitles:@"OK1", @"OK2", nil];
    [actionSheet setButtonTitleColor:self.view.tintColor BackgroundColor:nil fontSize:18 atIndex:0 Alpha:1];
    [actionSheet show];
}


@end

































