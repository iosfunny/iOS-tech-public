//
//  XLAppInitProcess.m
//  Coinbon
//
//  Created by AlexSiu on 2018/6/11.
//  Copyright © 2018年 CoinSea. All rights reserved.
//

#import "XLAppInitProcess.h"
#import "XLTabBarController.h"
#import "XLTransparentNavigationBar.h"
#import "XLAppRootController.h"
#import "XLAppRootDelegate.h"
#import "UIViewController+XLFinder.h"
#import "XLVersionWelcomeController.h"

@interface XLAppInitProcess ()
@property (nonatomic, strong) XLAppRootDelegate * appRootDelegate;
@end

@implementation XLAppInitProcess

static XLAppInitProcess * g_instance;

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        g_instance = [[[self class] alloc] init];
    });
    
    return g_instance;
}

- (XLAppRootDelegate *)appRootDelegate
{
    if (!_appRootDelegate)
    {
        _appRootDelegate = [[XLAppRootDelegate alloc] init];
    }
    
    return _appRootDelegate;
}

- (UIViewController *)makeRootViewControllerWithLaunchOptions:(NSDictionary *)launchOptions
{
    XLAppRootController * appRootContoller = [[XLAppRootController alloc] init];
    appRootContoller.delegate = self.appRootDelegate;
    XLNavigationController * rootNavigationController = [XLNavigationController navigtionControllerWithRootVC:appRootContoller];
    rootNavigationController.delegate = self.appRootDelegate;
    [XLNavigator sharedInstance].rootNavigationController = rootNavigationController;
    
    return rootNavigationController;
}

- (void)application:(UIApplication *)application beforeFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    /**
     *  ...
     */
}

- (void)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    /**
     *  欢迎页面
     */
    [XLVersionWelcomeController showIfNeed];
}

@end
