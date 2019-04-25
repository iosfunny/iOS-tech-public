//
//  XLScannerController.h
//  iOSDemo
//
//  Created by AlexSiu on 2019/4/25.
//  Copyright © 2019 AlexSiu. All rights reserved.
//

#import "XLBaseController.h"

NS_ASSUME_NONNULL_BEGIN

@interface XLScannerController : XLBaseController
@property (nonatomic, copy) void (^scannerCallback)(BOOL success, NSString * result, UIViewController * scannerController);
@end

NS_ASSUME_NONNULL_END
