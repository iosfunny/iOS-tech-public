//
//  XLRouterProtocol.h
//  UnicornPay
//
//  Created by AlexSiu on 2018/6/22.
//  Copyright © 2018年 CoinSea. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol XLRouterProtocol <NSObject>
@required
- (BOOL)openBiz:(NSURL *)bizUrl userInfo:(NSDictionary *)userInfo;

@optional
- (BOOL)hanldeExternOpenPath:(NSString *)path userInfo:(NSDictionary *)userInfo;

@end
