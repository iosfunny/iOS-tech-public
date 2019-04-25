//
//  XLVersionWelcomeItemView.m
//  UnicornPay
//
//  Created by AlexSiu on 2018/9/13.
//  Copyright © 2018年 CoinSea. All rights reserved.
//

#import "XLVersionWelcomeItemView.h"
#import "UIView+XLLayout.h"

@implementation XLVersionWelcomeItemView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self addSubview:self.imageView];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(contentDidClick)];
        [self addGestureRecognizer:tap];
        
        self.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}

- (UIImageView *)imageView
{
    if (!_imageView)
    {
        _imageView = [[UIImageView alloc] init];

        _imageView.backgroundColor = [UIColor colorWithRed:(arc4random() % 255 / 255.0) green:(arc4random() % 255 / 255.0) blue:(arc4random() % 255 / 255.0) alpha:1.0];
    }
    
    return _imageView;
}

- (void)contentDidClick
{
    if ([self.delegate respondsToSelector:@selector(versionWelcomeItemViewDidClick:)])
    {
        [self.delegate versionWelcomeItemViewDidClick:self];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGSize imageSize = self.imageView.image.size;
    
    if (imageSize.width == 0 || imageSize.height == 0)
    {
        self.imageView.frame = self.bounds;
        return;
    }
    
    CGFloat height = self.bounds.size.height;
    CGFloat width = self.bounds.size.width;
    CGFloat left = 0;
    CGFloat top = 0;
    if ((imageSize.height / imageSize.width) > (height / width))
    {
        // 图高了，以高为准
        width = imageSize.width / imageSize.height * height;
        left = (self.bounds.size.height - width) / 2.0;
    }
    else
    {
        height = imageSize.height / imageSize.width * width;
        top = (self.bounds.size.height - height) / 2.0;
    }
    
    self.imageView.frame = CGRectMake(left, top, width, height);
}


@end
