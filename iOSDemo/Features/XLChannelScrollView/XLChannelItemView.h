//
//  XLChannelItemView.h
//  CSEasyMall
//
//  Created by AlexSiu on 2018/12/4.
//  Copyright © 2018 CoinSea. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLChannel.h"

NS_ASSUME_NONNULL_BEGIN

@class XLChannelItemView;
@protocol XLChannelItemViewDelegate <NSObject>
@optional
- (void)channelItemViewDidClick:(XLChannelItemView *)channelItemView;

@end

@interface XLChannelItemView : UIView
@property (nonatomic, weak) id<XLChannelItemViewDelegate> delegate;
@property (nonatomic, strong) XLChannel * channel;
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, assign) CGFloat scale;

@end

NS_ASSUME_NONNULL_END
