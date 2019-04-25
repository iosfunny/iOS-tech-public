//
//  XLVersionWelcomeController.h
//  UnicornPay
//
//  Created by AlexSiu on 2018/9/13.
//  Copyright © 2018年 CoinSea. All rights reserved.
//

#import "XLBaseController.h"

extern NSString * const XLVersionWelcomeCloseNotificationName;

@interface XLVersionWelcomeController : XLBaseController
+ (BOOL)showIfNeed;
+ (BOOL)isShowing;

@end
