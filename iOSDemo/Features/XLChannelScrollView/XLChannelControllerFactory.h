//
//  XLChannelControllerFactory.h
//  Demo
//
//  Created by AlexSiu on 2019/4/18.
//  Copyright © 2019 AlexSiu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XLChannelController.h"

@interface XLChannelControllerFactory : NSObject

+ (XLChannelController *)channelControllerWithChannel:(XLChannel *)channel;

@end

