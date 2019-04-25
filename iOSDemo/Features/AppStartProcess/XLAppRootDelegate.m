//
//  XLAppRootDelegate.m
//  Coinbon
//
//  Created by AlexSiu on 2018/6/14.
//  Copyright © 2018年 CoinSea. All rights reserved.
//

#import "XLAppRootDelegate.h"
#import "UIViewController+XLFinder.h"

#pragma mark -

@interface XLAppRootDelegate ()
@end

@implementation XLAppRootDelegate

#pragma mark - UITabBarControllerDelegate

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    [viewController updateNavigationItem:tabBarController.navigationItem];
}

#pragma mark - UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    viewController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
}

@end
