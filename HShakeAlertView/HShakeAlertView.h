//
//  HShakeAlertView.h
//  HShakeAlertView
//
//  Created by dj-xxzx-10065 on 16/3/17.
//  Copyright © 2016年 Dong jing Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^Complection)();

@interface HShakeAlertView : UIAlertView

+ (instancetype)showSecureInputWithTitle:(NSString *)title
                          verifyPassword:(NSString *)password
                              completion:(Complection)completion;

@end
