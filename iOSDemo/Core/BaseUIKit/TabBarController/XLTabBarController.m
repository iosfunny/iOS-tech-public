//
//  XLTabBarController.m
//  Coinbon
//
//  Created by AlexSiu on 2018/6/11.
//  Copyright © 2018年 CoinSea. All rights reserved.
//

#import "XLTabBarController.h"

@interface XLTabBarController ()

@end

@implementation XLTabBarController

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.automaticallyAdjustsScrollViewInsets = NO;
        [self.tabBar setTranslucent:NO];
    }
    
    return self;
}

@end
