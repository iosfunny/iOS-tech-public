//
//  NSString+XLJSON.m
//  UnicornPay
//
//  Created by AlexSiu on 2018/10/22.
//  Copyright © 2018年 CoinSea. All rights reserved.
//

#import "NSString+XLJSON.h"

@implementation NSString (XLJSON)

+ (NSString *)jsonStringWithObject:(NSDictionary *)object
{
    if (![object isKindOfClass:[NSDictionary class]]) return nil;
    
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:object options:0 error:nil];
    NSString * jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    return jsonString;
}

@end
