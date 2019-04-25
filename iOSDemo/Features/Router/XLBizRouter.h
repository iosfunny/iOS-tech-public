//
//  XLBizRouter.h
//  UnicornPay
//
//  Created by AlexSiu on 2018/6/22.
//  Copyright © 2018年 CoinSea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XLRouterProtocol.h"

@interface XLBizRouter : NSObject<XLRouterProtocol>
+ (instancetype)router;

/**
 * subclass hook ..
 */
- (BOOL)tryOpenUrl:(NSURL *)url scheme:(NSString *)scheme host:(NSString *)host path:(NSString *)path queryInfo:(NSDictionary *)queryInfo userInfo:(NSDictionary *)userInfo;
@end
