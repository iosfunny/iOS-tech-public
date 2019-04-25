//
//  XLRouterInit.m
//  UnicornPay
//
//  Created by AlexSiu on 2018/6/22.
//  Copyright © 2018年 CoinSea. All rights reserved.
//

#import "XLRouterInit.h"
#import "XLRouterManager.h"

#pragma mark - sub routers
#import "XLToolsRouter.h"

#pragma mark - sub router

@implementation XLRouterInit

+ (void)pluginSubRouter
{
    [[XLRouterManager sharedRouter] registerSubBizRouter:[XLToolsRouter router]];
}

@end
