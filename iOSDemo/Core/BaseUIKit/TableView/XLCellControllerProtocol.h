//
//  XLCellControllerProtocol.h
//  Coinbon
//
//  Created by AlexSiu on 2018/6/14.
//  Copyright © 2018年 CoinSea. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, XLCellTriggerEvent)
{
    XLCellTriggerEventTouchUpInside
};

@protocol XLCellControllerProtocol <NSObject>
@required
- (UITableViewCell *)cell;
- (void)cellDidTriggerEvent:(XLCellTriggerEvent)event userInfo:(NSDictionary *)userInfo;
- (CGFloat)cellHeight;

@end
