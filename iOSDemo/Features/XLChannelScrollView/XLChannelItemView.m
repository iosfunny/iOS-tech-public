//
//  XLChannelItemView.m
//  CSEasyMall
//
//  Created by AlexSiu on 2018/12/4.
//  Copyright © 2018 CoinSea. All rights reserved.
//

#import "XLChannelItemView.h"
#import "UIColor+XLBase.h"
#import "UIView+XLLayout.h"

@implementation XLChannelItemView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self addSubview:self.titleLabel];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(channelItemViewDidClick)];
        [self addGestureRecognizer:tap];
    }
    
    return self;
}

- (void)setScale:(CGFloat)scale
{
    if (_scale != scale)
    {
        _scale = scale;
    }
    
    self.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size: 15 + 10 * scale];
    [self setNeedsLayout];
}

- (void)channelItemViewDidClick
{
    self.channel.selected = YES;
    if ([self.delegate respondsToSelector:@selector(channelItemViewDidClick:)])
    {
        [self.delegate channelItemViewDidClick:self];
    }
}

- (void)setChannel:(XLChannel *)channel
{
    if (_channel != channel)
    {
        _channel = channel;
    }
    
    self.titleLabel.text = channel.categoryName;
    self.titleLabel.textColor = channel.selected ? [UIColor em_selectedColor] : [UIColor em_textNormalColor];
}

- (UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size: 15];
        _titleLabel.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
    }
    
    return _titleLabel;
}

- (CGSize)sizeThatFits:(CGSize)size
{
    [self.titleLabel sizeToFit];
    
    CGSize resultSize = self.titleLabel.size;
    resultSize.width += 30;
    resultSize.height = 40;
    
    return resultSize;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.titleLabel sizeToFit];
    self.titleLabel.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
}

@end

