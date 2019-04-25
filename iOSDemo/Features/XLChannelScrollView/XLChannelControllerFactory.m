//
//  XLChannelControllerFactory.m
//  Demo
//
//  Created by AlexSiu on 2019/4/18.
//  Copyright © 2019 AlexSiu. All rights reserved.
//

#import "XLChannelControllerFactory.h"
#import "TestViewController.h"

@implementation XLChannelControllerFactory

+ (XLChannelController *)channelControllerWithChannel:(XLChannel *)channel
{
    XLChannelController * controlelr = nil;
    if ([channel.categoryId isEqualToString:[XLChannel homepageChannelId]])
    {
        controlelr = [[TestViewController alloc] init];
    }
    else
    {
        controlelr = [[XLChannelController alloc] init];
    }
    
    controlelr.channel = channel;
    
    return controlelr;
}

@end
