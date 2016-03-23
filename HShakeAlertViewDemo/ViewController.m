//
//  ViewController.m
//  HShakeAlertViewDemo
//
//  Created by dj-xxzx-10065 on 16/3/22.
//  Copyright © 2016年 Dong jing Ltd. All rights reserved.
//

#import "ViewController.h"
#import "HShakeAlertView.h"

@interface ViewController ()

@end

@implementation ViewController

- (IBAction)showAlert:(id)sender
{
    [HShakeAlertView showSecureInputWithTitle:@"请输入密码" verifyPassword:@"123" completion:^{
        NSLog(@"correct");
    }];
}

@end
