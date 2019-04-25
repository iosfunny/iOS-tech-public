//
//  XLAlgorithmCellController.m
//  Demo
//
//  Created by AlexSiu on 2019/4/19.
//  Copyright © 2019 AlexSiu. All rights reserved.
//

#import "XLAlgorithmCellController.h"
#import "XLBaseController.h"

@implementation XLAlgorithmCellController

- (NSString *)featureTitleForCell
{
    return @"Algorithm";
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
