//
//  XLChannelScrollView.h
//  CSEasyMall
//
//  Created by AlexSiu on 2018/12/3.
//  Copyright © 2018 CoinSea. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLChannel.h"

NS_ASSUME_NONNULL_BEGIN

@class XLChannelScrollView;
@protocol XLChannelScrollViewDelegate <NSObject>
@optional
- (void)channelScrollView:(XLChannelScrollView *)channelScrollView didClickIndex:(NSInteger)index channel:(XLChannel *)channel;
- (void)channelScrollViewDidClickMore:(XLChannelScrollView *)channelScrollView;

@end

@interface XLChannelScrollView : UIView
@property (nonatomic, strong) NSArray<XLChannel *> * channels;
@property (nonatomic, weak) id<XLChannelScrollViewDelegate> delegate;
@property (nonatomic, strong) UIScrollView * scrollView;

- (void)scrollIndexViewPostionFrom:(NSInteger)from to:(NSInteger)to progress:(CGFloat)progress;
- (void)updateIndex:(NSInteger)index anmation:(BOOL)animation;
- (void)repostionSelectedItemViewPostionAnimation:(BOOL)animation;

@end

NS_ASSUME_NONNULL_END
