//
//  XLHomeController.m
//  Demo
//
//  Created by AlexSiu on 2019/4/19.
//  Copyright © 2019 AlexSiu. All rights reserved.
//

#import "XLHomeController.h"

#pragma mark - cellControllers
#import "XLScannerCellController.h"
#import "XLAlgorithmCellController.h"
#import "XLReactNativeCellController.h"
#import "XLFlutterCellController.h"

@interface XLHomeController ()
@end

@implementation XLHomeController

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.title = @"XL Deom Home";
    }
    
    return self;
}

- (void)featurePluginCells
{
    NSInteger section = 0;
    [self.cellProvider pluginCellController:[XLScannerCellController cellController] atSection:section];
    [self.cellProvider pluginCellController:[XLAlgorithmCellController cellController] atSection:section];
    [self.cellProvider pluginCellController:[XLFlutterCellController cellController] atSection:section];
    [self.cellProvider pluginCellController:[XLReactNativeCellController cellController] atSection:section];
}



@end
