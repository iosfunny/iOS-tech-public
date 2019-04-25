//
//  UIAlertController+XLQuick.h
//  iOSDemo
//
//  Created by AlexSiu on 2019/4/25.
//  Copyright © 2019 AlexSiu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIAlertController (XLQuick)
+ (UIAlertController *)alertTitle:(NSString *)title message:(NSString *)message completion:(void (^ _Nullable )(void))completion;

@end

NS_ASSUME_NONNULL_END
