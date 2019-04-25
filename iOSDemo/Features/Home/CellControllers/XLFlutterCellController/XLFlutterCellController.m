//
//  XLFlutterCellController.m
//  iOSDemo
//
//  Created by AlexSiu on 2019/4/25.
//  Copyright © 2019 AlexSiu. All rights reserved.
//

#import "XLFlutterCellController.h"
#import "XLBaseController.h"

@implementation XLFlutterCellController

- (NSString *)featureTitleForCell
{
    return @"Flutter";
}

- (UIImage *)featureIconImage
{
    return resGetImage(@"common/设置-icon.png");
}

- (void)cellDidTriggerEvent:(XLCellTriggerEvent)event userInfo:(NSDictionary *)userInfo
{
    XLBaseController * controller = [[XLBaseController alloc] init];
    controller.title = [self featureTitleForCell];
    
    [XLNavigator pushViewController:controller animated:YES];
}

@end
