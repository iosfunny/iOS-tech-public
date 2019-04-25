//
//  XLNavigator.h
//  Coinbon
//
//  Created by AlexSiu on 2018/6/21.
//  Copyright © 2018年 CoinSea. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XLNavigator : NSObject
@property (nonatomic, weak) UINavigationController * rootNavigationController;

+ (instancetype)sharedInstance;
+ (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated;
+ (NSArray<UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated;
+ (UIViewController *)popViewControllerAnimated:(BOOL)animated;
+ (NSArray<UIViewController *> *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated;
+ (UIWindow *)mainWindow;
+ (UIView *)mainView;
+ (UITabBarController *)rootTabBarController;

@end
