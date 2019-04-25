//
//  XLNavigationController.m
//  Coinbon
//
//  Created by AlexSiu on 2018/6/11.
//  Copyright © 2018年 CoinSea. All rights reserved.
//

#import "XLNavigationController.h"
#import "XLNavigationBar.h"

@interface XLNavigationController ()<UINavigationBarDelegate>

@end

@implementation XLNavigationController

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (UIViewController *)childViewControllerForStatusBarStyle
{
    return self.visibleViewController;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return [self.visibleViewController preferredStatusBarStyle];
}

+ (XLNavigationController *)navigtionControllerWithRootVC:(UIViewController *)rootVC
{
    XLNavigationController * navigationController = [[XLNavigationController alloc] initWithNavigationBarClass:[XLNavigationBar class]
                                                                                                  toolbarClass:[UIToolbar class]];
    if ([rootVC isKindOfClass:[UIViewController class]])
    {
        [navigationController pushViewController:rootVC animated:NO];
    }
    
    return navigationController;
}

- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item
{
    if([self.viewControllers count] < [navigationBar.items count])
    {
        return YES;
    };
    
    BOOL shouldPop = YES;
    UIViewController* vc = [self topViewController];
    shouldPop = [vc navigationShouldPopOnBackButton];
    if(!shouldPop)
    {
        return NO;
    }
    
    [XLNextRunloopRunner run:^{
        [self popViewControllerAnimated:YES];
    }];
    
    return YES;
}

@end

@implementation UIViewController (XLNavigationController)
- (BOOL)navigationShouldPopOnBackButton
{
    return YES;
}

@end
