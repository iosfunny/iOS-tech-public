//
//  XLQRCodeView.m
//  UnicornPay
//
//  Created by AlexSiu on 2018/6/22.
//  Copyright © 2018年 CoinSea. All rights reserved.
//

#import "XLQRCodeView.h"


@interface XLQRCodeView ()
@property (nonatomic, strong) XLImageView * qrCodeBorderView;
@end

@implementation XLQRCodeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.tintColor = [UIColor colorWithRed:216.0 / 255.0 green:226.0 / 255.0 blue:231.0 / 255.0 alpha:1.0];
        self.contentInset = UIEdgeInsetsMake(16, 16, 16, 16);
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.qrCodeBorderView];
        [self addSubview:self.imageView];
    }
    
    return self;
}

- (void)setContentInset:(UIEdgeInsets)contentInset
{
    _contentInset = contentInset;
    
    [self setNeedsDisplay];
    [self setNeedsLayout];
}

- (XLImageView *)imageView
{
    if (!_imageView)
    {
        _imageView = [[XLImageView alloc] init];
        _imageView.backgroundColor = [UIColor xl_defaultBGColor];
    }
    
    return _imageView;
}

- (XLImageView *)qrCodeBorderView
{
    if (!_qrCodeBorderView)
    {
        _qrCodeBorderView = [[XLImageView alloc] init];
        _qrCodeBorderView.size = CGSizeMake(168, 168);
    }
    
    return _qrCodeBorderView;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.qrCodeBorderView.frame = self.bounds;
    
    CGFloat x = self.contentInset.left;
    CGFloat y = self.contentInset.top;
    CGFloat w = self.width - self.contentInset.left - self.contentInset.right;
    CGFloat h = self.height - self.contentInset.top - self.contentInset.bottom;
    
    self.imageView.frame = CGRectMake(x, y, w, h);
}

@end
