//
//  NSArray+XLSafe.m
//  Coinbon
//
//  Created by AlexSiu on 2018/6/19.
//  Copyright © 2018年 CoinSea. All rights reserved.
//

#import "NSArray+XLSafe.h"

@implementation NSArray (XLSafe)

- (id)xlsafe_objectAtIndex:(NSUInteger)index
{
    id obj = nil;
    if (self.count > index)
    {
        obj = [self objectAtIndex:index];
    }

    return obj;
}

@end

@implementation NSMutableArray (XLSafe)

- (void)xlsafe_addObject:(id)object
{
    assert(object);
    if (object)
    {
        [self addObject:object];
    }
}

@end
