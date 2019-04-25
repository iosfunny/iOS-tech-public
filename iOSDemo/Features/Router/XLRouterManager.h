//
//  XLRouterManager.h
//  UnicornPay
//
//  Created by AlexSiu on 2018/6/22.
//  Copyright © 2018年 CoinSea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XLRouterProtocol.h"

extern NSString * const CBRouterCommonParamsFromKey;

@interface XLRouterManager : NSObject
+ (instancetype)sharedRouter;
- (void)registerSubBizRouter:(id<XLRouterProtocol>)subBizRouter;
- (void)unregisterSubBizRouter:(id<XLRouterProtocol>)subBizRouter;
- (void)openBiz:(NSString *)bizStr userInfo:(NSDictionary *)userInfo;
- (void)externOpenBizWhihPath:(NSString *)path userInfo:(NSDictionary *)userInfo;

- (NSDictionary *)commonParamsWithFrom:(NSString *)from;

@end
