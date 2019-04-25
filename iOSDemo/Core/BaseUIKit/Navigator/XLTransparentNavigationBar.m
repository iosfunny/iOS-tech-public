//
//  XLTransparentNavigationBar.m
//  Coinbon
//
//  Created by AlexSiu on 2018/6/11.
//  Copyright © 2018年 CoinSea. All rights reserved.
//

#import "XLTransparentNavigationBar.h"

@implementation XLTransparentNavigationBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        UIImage * image = [UIImage sharedEmptyImage];
        [self setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
        [self setShadowImage:image];

        [self setTintColor:[UIColor blackColor]];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSArray<UIView *> * subviews = [self subviews];
    for (UIView * subview in subviews)
    {
        subview.backgroundColor = [UIColor clearColor];
    }
}

@end
