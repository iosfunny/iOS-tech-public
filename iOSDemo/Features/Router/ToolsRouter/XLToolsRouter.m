//
//  XLToolsRouter.m
//  iOSDemo
//
//  Created by AlexSiu on 2019/4/25.
//  Copyright © 2019 AlexSiu. All rights reserved.
//

#import "XLToolsRouter.h"
#import "XLScannerController.h"

NSString * const XLToolsScheme = @"tools";
NSString * const XLToolsScannerHost = @"scanner";
NSString * const XLToolsScannerParamsCallbackKey = @"callback";

@implementation XLToolsRouter

- (BOOL)tryOpenUrl:(NSURL *)url scheme:(NSString *)scheme host:(NSString *)host path:(NSString *)path queryInfo:(NSDictionary *)queryInfo userInfo:(NSDictionary *)userInfo
{
    BOOL result = YES;
    do
    {
        // 优先判断 scheme
        if (![scheme isEqualToString:XLToolsScheme]) { result = NO; break; }
        
        if ([host isEqualToString:XLToolsScannerHost])
        {
            // 扫码
            XLScannerCallback scannerCallback = [userInfo objectForKey:XLToolsScannerParamsCallbackKey];
            XLScannerController * scanner = [[XLScannerController alloc] init];
            scanner.scannerCallback = ^(BOOL success, NSString *result, UIViewController *scannerController) {
                if (scannerCallback)
                {
                    scannerCallback(success, result, scannerController);
                }
            };
            
            [XLNavigator pushViewController:scanner animated:YES];
            
            break;
        }
        
        result = NO;
    }
    while (false);
    
    return result;
}

@end
