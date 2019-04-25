//
//  XLTableCellProvider.m
//  Coinbon
//
//  Created by AlexSiu on 2018/6/14.
//  Copyright © 2018年 CoinSea. All rights reserved.
//

#import "XLTableCellProvider.h"

@interface XLTableCellProvider ()
@property (nonatomic, strong) NSMutableArray<NSMutableArray<id<XLCellControllerProtocol>> *> * sections;
@end

@implementation XLTableCellProvider 

- (NSMutableArray<NSMutableArray<id<XLCellControllerProtocol>> *> *)sections
{
    if (!_sections)
    {
        _sections = [NSMutableArray array];
    }
    
    return _sections;
}

- (NSInteger)numberOfSection
{
    return self.sections.count;
}

- (NSInteger)numberOfRowAtSection:(NSInteger)section
{
    NSInteger count = 0;
    if (self.sections.count > section)
    {
        NSArray * itemArray = [self.sections objectAtIndex:section];
        count = itemArray.count;
    }
    
    return count;
}

- (id<XLCellControllerProtocol>)cellControllerAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    NSMutableArray<id<XLCellControllerProtocol>> * cellControllers = nil;
    id<XLCellControllerProtocol> cellController = nil;
    if (self.sections.count > section)
    {
        cellControllers = [self.sections objectAtIndex:section];
    }
    
    if (cellControllers.count > row)
    {
        cellController = [cellControllers objectAtIndex:row];
    }
    
    assert(cellController);
    return cellController;
}

- (void)pluginCellController:(id<XLCellControllerProtocol>)cellController atSection:(NSInteger)section
{
    NSInteger sectionCount = self.sections.count;
    NSMutableArray<id<XLCellControllerProtocol>> * cellControllers = nil;
    if (section < sectionCount)
    {
        cellControllers = [self.sections objectAtIndex:section];
    }
    else
    {
        cellControllers = [NSMutableArray array];
        [self.sections addObject:cellControllers];
    }
    
    if (![cellControllers containsObject:cellController])
    {
        [cellControllers addObject:cellController];
    }
}

- (void)unPluginCellController:(id<XLCellControllerProtocol>)cellController acSection:(NSInteger)section
{
    NSInteger sectionCount = self.sections.count;
    NSMutableArray<id<XLCellControllerProtocol>> * cellControllers = nil;
    if (section < sectionCount)
    {
        cellControllers = [self.sections objectAtIndex:section];
    }
    
    if ([cellControllers containsObject:cellController])
    {
        [cellControllers removeObject:cellController];
    }
}

- (void)removeAllCellControllers
{
    [self.sections removeAllObjects];
}

@end
