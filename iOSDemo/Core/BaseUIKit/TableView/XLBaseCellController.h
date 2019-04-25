//
//  XLBaseCellController.h
//  CSEasyMall
//
//  Created by AlexSiu on 2018/12/7.
//  Copyright © 2018 CoinSea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XLCellControllerProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@class XLBaseCellController;
@protocol XLBaseCellControllerDelegate <NSObject>
@optional
- (void)cellControllerDidLayoutToNeedReloadTableView:(XLBaseCellController *)cellController;
@end

@interface XLBaseCellController : NSObject<XLCellControllerProtocol>
@property (nonatomic, weak) id<XLBaseCellControllerDelegate> delegate;
+ (instancetype)cellController;
- (void)callDelegateToReloadTableView;


@end

NS_ASSUME_NONNULL_END
