//
//  XLNavigator.m
//  Coinbon
//
//  Created by AlexSiu on 2018/6/21.
//  Copyright © 2018年 CoinSea. All rights reserved.
//

#import "XLNavigator.h"

@implementation XLNavigator

+ (instancetype)sharedInstance
{
    static XLNavigator * g_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        g_instance = [[[self class] alloc] init];
    });
    
    return g_instance;
}

+ (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [[[[self class] sharedInstance] rootNavigationController] pushViewController:viewController animated:animated];
}

+ (NSArray<UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated
{
    return [[[[self class] sharedInstance] rootNavigationController] popToRootViewControllerAnimated:animated];
}

+ (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    return [[[[self class] sharedInstance] rootNavigationController] popViewControllerAnimated:animated];
}

+ (NSArray<UIViewController *> *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    return [[[[self class] sharedInstance] rootNavigationController] popToViewController:viewController animated:animated];
}

+ (UIView *)mainView
{
    return [[[[self class] sharedInstance] rootNavigationController] view];
}

+ (UIWindow *)mainWindow
{
    return [UIApplication sharedApplication].keyWindow;
}

+ (UITabBarController *)rootTabBarController
{
    UITabBarController * tabBarController = nil;
    UINavigationController * rootNavigationController = [[[self class] sharedInstance] rootNavigationController];
    NSArray<UIViewController *> * viewControllers = [rootNavigationController viewControllers];
    for (UIViewController * viewController in viewControllers)
    {
        if ([viewController isKindOfClass:[UITabBarController class]])
        {
            tabBarController = (UITabBarController *)viewController;
            break;
        }
    }
    
    return tabBarController;
}

@end
