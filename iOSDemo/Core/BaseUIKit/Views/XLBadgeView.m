//
//  XLBadgeView.m
//  UnicornPay
//
//  Created by AlexSiu on 2018/6/13.
//  Copyright © 2018年 CoinSea. All rights reserved.
//

#import "XLBadgeView.h"

@implementation XLBadgeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setBackgroundColor:[UIColor colorWithRed:251/255.0 green:90/255.0 blue:61/255.0 alpha:1/1.0]];
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CAShapeLayer * maskLayer = [CAShapeLayer layer];
    CGRect bounds = CGRectMake(0, 0, CGRectGetWidth(rect), CGRectGetHeight(rect));
    maskLayer.frame = bounds;
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:bounds cornerRadius:CGRectGetHeight(bounds) / 2.0];
    maskLayer.path = path.CGPath;
    self.layer.mask = maskLayer;
}

@end
