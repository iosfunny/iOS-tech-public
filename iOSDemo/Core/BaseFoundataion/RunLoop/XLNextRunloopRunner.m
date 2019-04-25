//
//  XLNextRunloopRunner.m
//  Coinbon
//
//  Created by AlexSiu on 2018/6/15.
//  Copyright © 2018年 CoinSea. All rights reserved.
//

#import "XLNextRunloopRunner.h"

@interface XLNextRunloopRunner ()
@property (nonatomic, copy) void (^block)(void);

@end

@implementation XLNextRunloopRunner

- (void)dealloc
{
    if (_block) { _block(); }
    [_block release]; _block = nil;
    
    [super dealloc];
}

- (XLNextRunloopRunner *)initRunnerWithBlock:(void (^)(void))block
{
    self = [super init];
    if (self)
    {
        self.block = block;
    }
    
    return self;
}

+ (XLNextRunloopRunner *)runnerWithBlock:(void (^)(void))block
{
    return [[[self alloc] initRunnerWithBlock:block] autorelease];
}

+ (void)run:(void (^)(void))block
{
    XLNextRunloopRunner * runner = [self runnerWithBlock:block];
    [runner class];
}

@end
