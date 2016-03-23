//
//  HShakeAlertView.m
//  HShakeAlertView
//
//  Created by dj-xxzx-10065 on 16/3/17.
//  Copyright © 2016年 Dong jing Ltd. All rights reserved.
//

#import "HShakeAlertView.h"
#import <objc/runtime.h>

@interface HShakeAlertView ()

@property (nonatomic, copy) NSString *vPassword;
@property (nonatomic, copy) Complection completion;

@end

@implementation HShakeAlertView

#pragma mark - 初始化
+ (instancetype)showSecureInputWithTitle:(NSString *)title
                          verifyPassword:(NSString *)password
                              completion:(Complection)completion
{
    HShakeAlertView *textInput = [[self alloc] initWithTitle:title verifyPassword:password completion:completion];
    [textInput show];
    
    return textInput;
}

- (instancetype)initWithTitle:(NSString *)title verifyPassword:(NSString *)password completion:(Complection)completion
{
    self = [super initWithTitle:title
                        message:nil
                       delegate:nil
              cancelButtonTitle:@"取消"
              otherButtonTitles:@"确定", nil];
    
    self.alertViewStyle = UIAlertViewStyleSecureTextInput;
    UITextField *textField = [self textFieldAtIndex:0];
    textField.textAlignment = NSTextAlignmentCenter;
    
    self.vPassword = [password copy];
    self.completion = [completion copy];
    
    return self;
}

#pragma mark - 逻辑处理，点“确定”的时候判断密码是否正确
#pragma iOS > 7调用
- (void)dismissWithClickedButtonIndex:(NSInteger)buttonIndex animated:(BOOL)animated
{
    if (buttonIndex == 1) {
        if (![self isCorrectPassword]) return;//密码不正确
    }
    [[self textFieldAtIndex:0] resignFirstResponder];
    [super dismissWithClickedButtonIndex:buttonIndex animated:animated];
}

#pragma iOS <= 7调用:runtime的内部方法
- (BOOL)modalItem:(id)arg1 shouldDismissForButtonAtIndex:(int)arg2
{
    if (arg2 == 1) {
        return [self isCorrectPassword];
    }
    return YES;
}

- (BOOL)isCorrectPassword
{
    NSString *text = [self textFieldAtIndex:0].text;
    BOOL isCorrect = [text isEqualToString:self.vPassword];
    
    if (isCorrect) {
        !self.completion? :self.completion();
    }else {
        [self errorShake];
    }
    return isCorrect;
}

#pragma mark - 错误提示2个动画: 文本框左右摇, 边框闪烁
- (void)errorShake
{
    UITextField *inputField = [self textFieldAtIndex:0];
    [inputField.layer removeAllAnimations];
    [inputField.layer addAnimation:[self shakeAnimation] forKey:nil];
    
    UIView *view = [inputField superview];
    view.layer.borderColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0391346153846154].CGColor;
    view.layer.borderWidth = 1.f;
//    [view.layer removeAllAnimations];
    [view.layer addAnimation:[self blinkAnimation] forKey:nil];
}


- (CABasicAnimation *)shakeAnimation
{
    CABasicAnimation *animation   = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    animation.toValue             = @10;
    animation.duration            = 0.1f;
    animation.repeatCount         = 2;
    animation.removedOnCompletion = YES;
    animation.autoreverses        = YES;
    animation.fillMode            = kCAFillModeForwards;
    return animation;
}

- (CABasicAnimation *)blinkAnimation
{
    CABasicAnimation *animation   = [CABasicAnimation animationWithKeyPath:@"borderColor"];
    animation.fromValue           = (id)[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0391346153846154].CGColor;
    animation.toValue             = (id)[UIColor redColor].CGColor;
    animation.duration            = 0.6f;
    animation.repeatCount         = 2;
    animation.removedOnCompletion = YES;
    animation.autoreverses        = YES;
    return animation;
}

@end
