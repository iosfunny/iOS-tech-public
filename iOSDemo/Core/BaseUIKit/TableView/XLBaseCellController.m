//
//  XLBaseCellController.m
//  CSEasyMall
//
//  Created by AlexSiu on 2018/12/7.
//  Copyright © 2018 CoinSea. All rights reserved.
//

#import "XLBaseCellController.h"

@implementation XLBaseCellController
+ (instancetype)cellController
{
    XLBaseCellController * cellContoller = [[self alloc] init];
    return cellContoller;
}

- (UITableViewCell *)cell
{
    assert(false);
    // subclass hook ..
    return [[UITableViewCell alloc] init];
}

- (void)cellDidTriggerEvent:(XLCellTriggerEvent)event userInfo:(NSDictionary *)userInfo
{
    NSLog(@"Subclass hook ..");
}

- (CGFloat)cellHeight
{
    return 60.0;
}

- (void)callDelegateToReloadTableView
{
    if ([self.delegate respondsToSelector:@selector(cellControllerDidLayoutToNeedReloadTableView:)])
    {
        [self.delegate cellControllerDidLayoutToNeedReloadTableView:self];
    }
}

@end
