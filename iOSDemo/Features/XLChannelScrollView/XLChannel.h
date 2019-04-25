//
//  XLChannel.h
//  CSEasyMall
//
//  Created by AlexSiu on 2018/12/3.
//  Copyright © 2018 CoinSea. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XLChannel : NSObject
@property (nonatomic, copy) NSString * categoryId;
@property (nonatomic, copy) NSString * categoryName;
@property (nonatomic, assign) NSInteger categoryLevel;
@property (nonatomic, copy) NSString * parentId;
@property (nonatomic, copy) NSString * picUrl;
@property (nonatomic, copy) NSArray<XLChannel *> * childCategorys;

@property (nonatomic, assign) BOOL selected;

+ (NSArray<XLChannel *> *)channelsWithParams:(NSArray *)params;
+ (XLChannel *)channelWithParams:(NSDictionary *)params;
+ (XLChannel *)channelWithId:(NSString *)channelId name:(NSString *)name;

+ (XLChannel *)shareHomepageChannel;
+ (NSString *)homepageChannelId;
+ (NSArray *)testChannels;

@end

NS_ASSUME_NONNULL_END
