//
//  XLChannelSelectBoardView.h
//  CSEasyMall
//
//  Created by AlexSiu on 2018/12/7.
//  Copyright © 2018 CoinSea. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLChannel.h"

NS_ASSUME_NONNULL_BEGIN


@class XLChannelSelectBoardView;
@protocol XLChannelSelectBoardViewDelegate <NSObject>
@optional
- (void)channelSelectBoardView:(XLChannelSelectBoardView *)channelSelectBoardView didClickChannel:(XLChannel *)channel index:(NSInteger)index;

@end

@interface XLChannelSelectBoardView : UIView
@property (nonatomic, weak) id<XLChannelSelectBoardViewDelegate> delegate;
@property (nonatomic, strong) NSArray<XLChannel *> * channels;
@property (nonatomic, assign) CGFloat topLayoutGuide;


- (BOOL)showing;
- (void)show;
- (void)close;

@end

NS_ASSUME_NONNULL_END
