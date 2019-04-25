//
//  XLRouterDefined.h
//  UnicornPay
//
//  Created by AlexSiu on 2018/6/23.
//  Copyright © 2018年 CoinSea. All rights reserved.
//

#ifndef XLRouterDefined_h
#define XLRouterDefined_h

#import "XLRouterManager.h"

typedef void (^XLScannerCallback)(BOOL success, NSString * result, UIViewController *scannerController);
extern NSString * const XLToolsScannerParamsCallbackKey;

#endif /* XLRouterDefined_h */
