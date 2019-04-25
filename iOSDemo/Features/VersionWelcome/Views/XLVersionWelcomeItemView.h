//
//  XLVersionWelcomeItemView.h
//  UnicornPay
//
//  Created by AlexSiu on 2018/9/13.
//  Copyright © 2018年 CoinSea. All rights reserved.
//

#import <UIKit/UIKit.h>


@class XLVersionWelcomeItemView;
@protocol XLVersionWelcomeItemViewDelegate <NSObject>
@optional
- (void)versionWelcomeItemViewDidClick:(XLVersionWelcomeItemView *)versionWelcomeItemView;

@end

@interface XLVersionWelcomeItemView : UIView
@property (nonatomic, weak) id<XLVersionWelcomeItemViewDelegate> delegate;
@property (nonatomic, strong) UIImageView * imageView;
@end
