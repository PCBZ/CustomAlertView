//
//  ViewController.m
//  CustomAlertView
//
//  Created by Wenshuang Zhou on 15/11/9.
//  Copyright © 2015年 PCBZ. All rights reserved.
//

#import "ViewController.h"
#import "ChargeAlertView.h"
#import "CustomActionSheet.h"
#import "ShareActionSheet.h"

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
    ChargeAlertView *alertView = [[ChargeAlertView alloc] initWithBeansNumber:30 ChargeType:AdequateBeans];
    [alertView show];
}

- (IBAction)ClickActionSheet:(id)sender
{
    ShareActionSheet *actionSheet = [[ShareActionSheet alloc] initWithdelegate:self];
    [actionSheet show];
}


@end
