//
//  XLTableCellProvider.h
//  Coinbon
//
//  Created by AlexSiu on 2018/6/14.
//  Copyright © 2018年 CoinSea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XLCellControllerProtocol.h"

@interface XLTableCellProvider : NSObject
- (void)pluginCellController:(id<XLCellControllerProtocol>)cellController atSection:(NSInteger)section;
- (void)unPluginCellController:(id<XLCellControllerProtocol>)cellController acSection:(NSInteger)section;
- (void)removeAllCellControllers;

- (id<XLCellControllerProtocol>)cellControllerAtIndexPath:(NSIndexPath *)indexPath;
- (NSInteger)numberOfSection;
- (NSInteger)numberOfRowAtSection:(NSInteger)section;

@end
