//
//  XLAppInitProcess.h
//  Coinbon
//
//  Created by AlexSiu on 2018/6/11.
//  Copyright © 2018年 CoinSea. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLNavigationController.h"

@interface XLAppInitProcess : NSObject
+ (instancetype)sharedInstance;

- (UIViewController *)makeRootViewControllerWithLaunchOptions:(NSDictionary *)launchOptions;

- (void)application:(UIApplication *)application beforeFinishLaunchingWithOptions:(NSDictionary *)launchOptions;
- (void)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;

@end
