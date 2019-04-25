//
//  NSString+XLUUID.m
//  UnicornPay
//
//  Created by AlexSiu on 2018/9/20.
//  Copyright © 2018年 CoinSea. All rights reserved.
//

#import "NSString+XLUUID.h"

@implementation NSString (XLUUID)

+ (NSString *)xl_uuidString
{
    CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
    CFStringRef uuid_string_ref= CFUUIDCreateString(NULL, uuid_ref);
    NSString * uuid = [NSString stringWithString:(__bridge NSString *)uuid_string_ref];
    CFRelease(uuid_ref);
    CFRelease(uuid_string_ref);
    
    return [uuid lowercaseString];
}

@end
