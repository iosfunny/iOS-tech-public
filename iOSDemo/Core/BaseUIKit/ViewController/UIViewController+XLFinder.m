//
//  UIViewController+XLFinder.m
//  Coinbon
//
//  Created by AlexSiu on 2018/6/14.
//  Copyright © 2018年 CoinSea. All rights reserved.
//

#import "UIViewController+XLFinder.h"

@implementation UIViewController (XLFinder)

- (UIViewController *)xl_findCustomTopViewController
{
    if ([self isKindOfClass:[UINavigationController class]])
    {
        UINavigationController * navigationController = (UINavigationController *)self;
        if (navigationController.visibleViewController)
        {
            return [navigationController.visibleViewController xl_findCustomTopViewController];
        }
        
        return navigationController;
    }
    else if ([self isKindOfClass:[UITabBarController class]])
    {
        UITabBarController * tabBarController = (UITabBarController *)self;
        if (tabBarController.selectedViewController)
        {
            return [tabBarController.selectedViewController xl_findCustomTopViewController];
        }
        
        return tabBarController;
    }
    
    return self;
}

- (void)updateNavigationItem:(UINavigationItem *)navigationItem
{
    navigationItem.title = self.title;
    navigationItem.rightBarButtonItem = self.navigationItem.rightBarButtonItem;
    navigationItem.leftBarButtonItem = self.navigationItem.leftBarButtonItem;
    navigationItem.titleView = self.navigationItem.titleView;
}

@end
