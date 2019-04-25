//
//  UIAlertController+XLQuick.m
//  iOSDemo
//
//  Created by AlexSiu on 2019/4/25.
//  Copyright © 2019 AlexSiu. All rights reserved.
//

#import "UIAlertController+XLQuick.h"

@implementation UIAlertController (XLQuick)

+ (UIAlertController *)alertTitle:(NSString *)title message:(NSString *)message completion:(void (^)(void))completion
{
    UIAlertController * alertControlelr = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if (completion)
        {
            completion();
        }
    }];
    
    [alertControlelr addAction:cancelAction];
    
    return alertControlelr;
}

@end
