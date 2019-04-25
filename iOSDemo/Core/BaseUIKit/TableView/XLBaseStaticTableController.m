//
//  XLBaseStaticTableController.m
//  CSEasyMall
//
//  Created by AlexSiu on 2018/12/12.
//  Copyright © 2018 CoinSea. All rights reserved.
//

#import "XLBaseStaticTableController.h"

@interface XLBaseStaticTableController ()

@end

@implementation XLBaseStaticTableController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self featurePluginCells];
}

- (void)featurePluginCells
{
    
}

- (XLTableCellProvider *)cellProvider
{
    if (!_cellProvider)
    {
        _cellProvider = [[XLTableCellProvider alloc] init];
    }
    
    return _cellProvider;
}

- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delaysContentTouches = NO;
        _tableView.backgroundColor = [UIColor xl_defaultBGColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.sectionFooterHeight = 0;
        if (@available(iOS 11.0, *))
        { [_tableView setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever]; }
        
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.1)];
        view.backgroundColor = [UIColor clearColor];
        _tableView.tableHeaderView = view;
    }
    
    return _tableView;
}

#pragma mark - UITableViewDelegate && UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    CGFloat height = 0;
    do
    {
        if (section == 0) break;
        height = 10;
    }
    while (false);
    
    return height;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id<XLCellControllerProtocol> cellController = [self.cellProvider cellControllerAtIndexPath:indexPath];
    return [cellController cellHeight];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.cellProvider numberOfSection];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.cellProvider numberOfRowAtSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id<XLCellControllerProtocol> cellController = [self.cellProvider cellControllerAtIndexPath:indexPath];
    UITableViewCell * cell = [cellController cell];
    if (!cell)
    {
        assert(false);
        // 异常处理
        cell = [[UITableViewCell alloc] init];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    id<XLCellControllerProtocol> cellController = [self.cellProvider cellControllerAtIndexPath:indexPath];
    [cellController cellDidTriggerEvent:XLCellTriggerEventTouchUpInside userInfo:nil];
}

#pragma mark - layout
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    CGFloat top = self.topLayoutGuide.length;
    self.tableView.frame = CGRectMake(0, top, self.view.width, self.view.height - top);
}

@end
