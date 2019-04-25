//
//  XLBaseStaticTableController.h
//  CSEasyMall
//
//  Created by AlexSiu on 2018/12/12.
//  Copyright © 2018 CoinSea. All rights reserved.
//

#import "XLBaseController.h"
#import "XLTableCellProvider.h"

NS_ASSUME_NONNULL_BEGIN

@interface XLBaseStaticTableController : XLBaseController<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) XLTableCellProvider * cellProvider;
- (void)featurePluginCells;

@end

NS_ASSUME_NONNULL_END
