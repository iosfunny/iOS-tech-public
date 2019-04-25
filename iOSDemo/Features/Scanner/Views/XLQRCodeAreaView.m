//
//  XLQRCodeAreaView.m
//  iOSDemo
//
//  Created by AlexSiu on 2019/4/25.
//  Copyright © 2019 AlexSiu. All rights reserved.
//

#import "XLQRCodeAreaView.h"


@interface XLQRCodeAreaView ()
@property (nonatomic, strong) UIView * scanLiner;
@end

@implementation XLQRCodeAreaView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.tintColor = [UIColor greenColor];
        self.backgroundColor = [UIColor clearColor];
        [self.imageView removeFromSuperview];
        self.layer.borderColor = [UIColor colorWithWhite:0.6 alpha:1.0].CGColor;
        self.layer.borderWidth = 0.5;
        
        [self addSubview:self.scanLiner];
        [self startAnimation];
    }
    
    return self;
}

- (void)startAnimation
{
    self.scanLiner.top = 0;
    [UIView animateWithDuration:2.0 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.scanLiner.top = self.height;
    } completion:^(BOOL finished) {
        if (finished)
        {
            [self startAnimation];
        }
    }];
}

- (UIView *)scanLiner
{
    if (!_scanLiner)
    {
        _scanLiner = [[UIView alloc] initWithFrame:self.bounds];
        _scanLiner.alpha = 0.5;
        _scanLiner.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _scanLiner.height = 1;
        _scanLiner.backgroundColor = [UIColor greenColor];
        _scanLiner.layer.shadowColor = [UIColor greenColor].CGColor;
        _scanLiner.layer.shadowOpacity = 1.0;
        _scanLiner.layer.shadowOffset = CGSizeMake(0, 1);
    }
    
    return _scanLiner;
}

@end
