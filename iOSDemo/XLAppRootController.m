//
//  XLAppRootController.m
//  Coinbon
//
//  Created by AlexSiu on 2018/6/14.
//  Copyright © 2018年 CoinSea. All rights reserved.
//

#import "XLAppRootController.h"
#import "UIViewController+XLFinder.h"

#pragma mark - Controllers
#import "XLHomeController.h"
#import "XLChannelsController.h"
#import "XLMRCViewController.h"

@interface XLAppRootController ()

@end

@implementation XLAppRootController

- (UITabBarItem *)tabBarItemWithTitle:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage
{
    UIColor * normalColor = [UIColor colorWithRed:192/255.0 green:192/255.0 blue:195/255.0 alpha:1];;
    UIColor * selectedColor = [UIColor colorWithRed:46.0 / 255.0 green:47.0 / 255.0 blue:70.0 / 255.0 alpha:1.0];
    
    NSDictionary * textAttributesNormal = @{NSForegroundColorAttributeName: normalColor};
    NSDictionary * textAttributesSelected = @{NSForegroundColorAttributeName: selectedColor};
    UITabBarItem * item = [[UITabBarItem alloc] initWithTitle:title image:image selectedImage:selectedImage];
    [item setTitleTextAttributes:textAttributesNormal forState:UIControlStateNormal];
    [item setTitleTextAttributes:textAttributesSelected forState:UIControlStateSelected];
    
    return item;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        // 首页
        XLHomeController * homeController = [[XLHomeController alloc] init];
        UITabBarItem * homeItem = [self tabBarItemWithTitle:@"首页" image:nil selectedImage:nil];
        homeController.tabBarItem = homeItem;
        
        // 频道页
        XLChannelsController * channelsController = [[XLChannelsController alloc] init];
        UITabBarItem * channelsItem = [self tabBarItemWithTitle:@"频道" image:nil selectedImage:nil];
        channelsController.tabBarItem = channelsItem;
        
        // MRC
        XLMRCViewController * mrcController = [[XLMRCViewController alloc] init];
        UITabBarItem * mrcItem = [self tabBarItemWithTitle:@"MRC" image:nil selectedImage:nil];
        mrcController.tabBarItem = mrcItem;
        
        
        NSArray<UIViewController *> * viewControllers = @[homeController, channelsController, mrcController];
        self.viewControllers = viewControllers;
        
        UIViewController * firstViewController = [viewControllers firstObject];
        [firstViewController updateNavigationItem:self.navigationItem];
    }
    
    return self;
}

- (UIViewController *)childViewControllerForStatusBarStyle
{
    return self.selectedViewController;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return [self.selectedViewController preferredStatusBarStyle];
}

- (NSString *)title
{
    NSString * title = [self xl_findCustomTopViewController].title;
    return title ?: @"";
}

- (void)setSelectedViewController:(__kindof UIViewController *)selectedViewController
{
    [super setSelectedViewController:selectedViewController];
    [self updateNavigationBarWithController:selectedViewController];
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    [super setSelectedIndex:selectedIndex];
    UIViewController * selectedViewController = [self selectedViewController];
    [self updateNavigationBarWithController:selectedViewController];
}

- (void)updateNavigationBarWithController:(UIViewController *)controller
{
    self.title = self.title;
    [controller updateNavigationItem:self.navigationItem];
}

@end
