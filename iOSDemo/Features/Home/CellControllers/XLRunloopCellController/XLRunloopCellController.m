//
//  XLRunloopCellController.m
//  iOSDemo
//
//  Created by AlexSiu on 2019/4/25.
//  Copyright © 2019 AlexSiu. All rights reserved.
//

#import "XLRunloopCellController.h"
#import "XLBaseController.h"

@implementation XLRunloopCellController

- (NSString *)featureTitleForCell
{
    return @"Runloop";
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
