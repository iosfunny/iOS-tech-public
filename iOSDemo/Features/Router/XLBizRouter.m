//
//  XLBizRouter.m
//  UnicornPay
//
//  Created by AlexSiu on 2018/6/22.
//  Copyright © 2018年 CoinSea. All rights reserved.
//

#import "XLBizRouter.h"
#import "NSString+XLURLCode.h"

@implementation XLBizRouter

+ (instancetype)router
{
    return [[[self class] alloc] init];
}

- (BOOL)openBiz:(NSURL *)bizUrl userInfo:(NSDictionary *)userInfo
{
    // sub class hook ...
    BOOL result = NO;
    do
    {
        NSString * scheme = [bizUrl scheme];    if (scheme.length == 0) break;
        NSString * host = [bizUrl host];        if (host.length == 0) break;
        NSString * path = [bizUrl path];
        NSString * query = [bizUrl query];
        
        NSMutableDictionary * queryDict = [NSMutableDictionary dictionary];
        NSArray<NSString *> * queryArray =  [query componentsSeparatedByString:@"&"];
        for (NSString * queryItem in queryArray)
        {
            NSArray<NSString *> * queryItemArray = [queryItem componentsSeparatedByString:@"="];
            if (queryItemArray.count == 2)
            {
                NSString * key = [queryItemArray firstObject];
                NSString * value = [queryItemArray lastObject];
                
                if (key.length > 0 && value.length > 0)
                {
                    [queryDict setObject:[value xl_urlDecodeString] forKey:key];
                }
            }
        }
        
        result = [self tryOpenUrl:bizUrl scheme:scheme host:host path:path queryInfo:queryDict userInfo:userInfo];
    }
    while (false);
    
    return result;
}

- (BOOL)tryOpenUrl:(NSURL *)url scheme:(NSString *)scheme host:(NSString *)host path:(NSString *)path queryInfo:(NSDictionary *)queryInfo userInfo:(NSDictionary *)userInfo
{
    NSLog(@"Subclass <%@ %p> hook .. ", NSStringFromClass([self class]), self);
    assert(false);
    return NO;
}

@end
