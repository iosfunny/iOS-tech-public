//
//  NSArray+XLSafe.h
//  Coinbon
//
//  Created by AlexSiu on 2018/6/19.
//  Copyright © 2018年 CoinSea. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray<ObjectType> (XLSafe)
/**
 *  return Obj or nil!
 */
- (ObjectType)xlsafe_objectAtIndex:(NSUInteger)index;

@end


@interface NSMutableArray<ObjectType> (XLSafe)
- (void)xlsafe_addObject:(ObjectType)object;

@end
