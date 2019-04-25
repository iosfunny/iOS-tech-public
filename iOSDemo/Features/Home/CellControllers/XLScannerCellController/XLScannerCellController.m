//
//  XLScannerCellController.m
//  iOSDemo
//
//  Created by AlexSiu on 2019/4/25.
//  Copyright © 2019 AlexSiu. All rights reserved.
//

#import "XLScannerCellController.h"
#import "UIAlertController+XLQuick.h"

@implementation XLScannerCellController
- (NSString *)featureTitleForCell
{
    return @"Scanner";
}

- (UIImage *)featureIconImage
{
    return resGetImage(@"common/扫描icon.png");
}

- (void)cellDidTriggerEvent:(XLCellTriggerEvent)event userInfo:(NSDictionary *)userInfo
{
    XLScannerCallback scannerCallback =  ^(BOOL success, NSString * result, UIViewController *scannerController){
        
        [XLNavigator popViewControllerAnimated:YES];
        
        if (success)
        {
            UIAlertController * alertController = [UIAlertController alertTitle:@"扫描结果" message:result ?: @"啥都没扫到" completion:nil];
            [[[XLNavigator sharedInstance] rootNavigationController] presentViewController:alertController animated:YES completion:nil];
        }
    };
    
    NSMutableDictionary * parameters = [NSMutableDictionary dictionary];
    [parameters xlsafe_setObject:scannerCallback forKey:XLToolsScannerParamsCallbackKey];
    
    [[XLRouterManager sharedRouter] openBiz:@"tools://scanner" userInfo:parameters];
}

@end
