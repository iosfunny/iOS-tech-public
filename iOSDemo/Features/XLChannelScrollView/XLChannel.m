//
//  XLChannel.m
//  CSEasyMall
//
//  Created by AlexSiu on 2018/12/3.
//  Copyright © 2018 CoinSea. All rights reserved.
//

#import "XLChannel.h"
#import "NSDictionary+XLSafe.h"

@implementation XLChannel

+ (XLChannel *)channelWithParams:(NSDictionary *)params
{
    if (![params isKindOfClass:[NSDictionary class]]) return nil;    
    XLChannel * channel = [[XLChannel alloc] init];
    channel.categoryId = [NSString stringWithFormat:@"%ld", (long)[params xlsafe_integerValueForKey:@"categoryId"]];
    channel.categoryName = [params xlsafe_stringValueForKey:@"categoryName"];
    channel.categoryLevel = [params xlsafe_integerValueForKey:@"categoryLevel"];
    channel.parentId = [NSString stringWithFormat:@"%ld", (long)[params xlsafe_integerValueForKey:@"parentId"]];
    channel.picUrl = [params xlsafe_stringValueForKey:@"picUrl"];
    
    NSArray * childCategorys = [params xlsafe_arrayValueForKey:@"childCategory"];
    if ([childCategorys isKindOfClass:[NSArray class]] && childCategorys.count > 0)
    {
        channel.childCategorys = [XLChannel channelsWithParams:childCategorys];
    }
    
    return channel;
}

+ (NSArray<XLChannel *> *)channelsWithParams:(NSArray *)params
{
    if (![params isKindOfClass:[NSArray class]]) return nil;
    NSMutableArray * array = [NSMutableArray array];
    
    for (NSDictionary * item in params)
    {
        if (![item isKindOfClass:[NSDictionary class]]) continue;
        XLChannel * channel = [XLChannel channelWithParams:item];
        if (channel)
        {
            [array addObject:channel];
        }
    }
    
    return [array copy];
}


+ (NSString *)homepageChannelId
{
    return @"888";
}

+ (XLChannel *)shareHomepageChannel
{
    static XLChannel * g_homePageChannel = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        g_homePageChannel = [[XLChannel alloc] init];
        g_homePageChannel.categoryName = @"TEST";
        g_homePageChannel.categoryId = [self homepageChannelId];
    });
    
    return g_homePageChannel;
}

+ (XLChannel *)channelWithId:(NSString *)channelId name:(NSString *)name
{
    XLChannel * channel = [[XLChannel alloc] init];
    channel.categoryId = channelId;
    channel.categoryName = name;
    
    return channel;
}

+ (NSArray *)testChannels
{
    XLChannel * channel1 = [self channelWithId:@"1001" name:@"C"];
    XLChannel * channel2 = [self channelWithId:@"1002" name:@"C++"];
    XLChannel * channel3 = [self channelWithId:@"1003" name:@"C#"];
    XLChannel * channel4 = [self channelWithId:@"1004" name:@"Java"];
    XLChannel * channel5 = [self channelWithId:@"1005" name:@"Swift"];
    XLChannel * channel6 = [self channelWithId:@"1006" name:@"HTML"];
    XLChannel * channel7 = [self channelWithId:@"1007" name:@"Fuck"];
    
    return @[channel1, channel2, channel3, channel4, channel5, channel6, channel7];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%p %@  ID:%@>", self, _categoryName, _categoryId];
}

@end
