//
//  XLNavigationBar.m
//  Coinbon
//
//  Created by AlexSiu on 2018/6/11.
//  Copyright © 2018年 CoinSea. All rights reserved.
//

#import "XLNavigationBar.h"

@interface XLNavigationBar ()
@end

@implementation XLNavigationBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        UIColor * color = [UIColor blackColor];
        UIFont * titleFont = [UIFont fontWithName:@"PingFangSC-Medium" size:18];
        NSDictionary * dict = @{NSForegroundColorAttributeName: color, NSFontAttributeName: titleFont};
        self.titleTextAttributes = dict;
        self.tintColor = color;
//        self.backIndicatorImage = resGetImage(@"Common/back_icon.png");
//        self.backIndicatorTransitionMaskImage = resGetImage(@"Common/back_icon.png");
    }
    
    return self;
}

@end
