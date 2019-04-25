//
//  NSString+XLURLCode.m
//  UnicornPay
//
//  Created by AlexSiu on 2018/9/5.
//  Copyright © 2018年 CoinSea. All rights reserved.
//

#import "NSString+XLURLCode.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

@implementation NSString (XLURLCode)

- (NSString *)xl_urlEncodeString
{
    NSString *encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (__bridge CFStringRef)self,
                                                              NULL,
                                                              (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                              kCFStringEncodingUTF8));
    return encodedString;
}

- (NSString *)xl_urlDecodeString
{
    NSString *decodedString  = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
                                                                                                                     (__bridge CFStringRef)self,
                                                                                                                     CFSTR(""),
                                                                                                                     CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    return decodedString;
}

@end

#pragma clang diagnostic pop
