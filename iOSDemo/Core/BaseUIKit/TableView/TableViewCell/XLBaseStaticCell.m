//
//  XLBaseStaticCell.m
//  Coinbon
//
//  Created by AlexSiu on 2018/6/14.
//  Copyright © 2018年 CoinSea. All rights reserved.
//

#import "XLBaseStaticCell.h"

@interface XLBaseStaticCell ()
@property (nonatomic, assign) BOOL detailLabelLoaded;
@property (nonatomic, assign) BOOL titleLabelLoaded;
@property (nonatomic, strong) UIView * lineView;
@end

@implementation XLBaseStaticCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self.contentView addSubview:self.detailSuffixLabel];
    }
    
    return self;
}

- (void)setShowLine:(BOOL)showLine
{
    if (_showLine != showLine)
    {
        _showLine = showLine;
        self.lineView.hidden = !showLine;
    }
}

- (UILabel *)detailLabel
{
    UILabel * label = [super detailLabel];
    if (!_detailLabelLoaded && label)
    {
        label.textColor = [UIColor xl_hexColor:@"#9E9B9B"];
        label.font = [UIFont fontWithName:@"PingFangSC-Regular" size: 15];
        _detailLabelLoaded = YES;
    }

    return label;
}

- (UILabel *)titleLabel
{
    UILabel * label = [super titleLabel];
    if (!_titleLabelLoaded && label)
    {
        label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
        _titleLabelLoaded = YES;
    }
    
    return label;
}

- (UILabel *)detailSuffixLabel
{
    if (!_detailSuffixLabel)
    {
        _detailSuffixLabel = [[UILabel alloc] init];
        _detailSuffixLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:18];
        _detailSuffixLabel.textColor = [UIColor colorWithRed:158/255.0 green:155/255.0 blue:155/255.0 alpha:1];
    }
    
    return _detailSuffixLabel;
}

- (UIView *)lineView
{
    if (!_lineView)
    {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor xl_defaultBGColor];
        [self.contentView addSubview:self.lineView];
        [self setNeedsLayout];
    }
    
    return _lineView;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (!_noImg)
    {
        self.iconImageView.frame = CGRectMake(15, 0, 20, 20);
        self.iconImageView.centerY = CGRectGetMidY(self.bounds);
        
        [self.titleLabel sizeToFit];
        self.titleLabel.left = self.iconImageView.right + 12;
        self.titleLabel.height = self.height;
    }
    
    CGFloat right = self.width - 15;
    
    if (self.showMoreIcon)
    {
        right -= 15;
    }
    
    [self.detailSuffixLabel sizeToFit];
    if (self.detailSuffixLabel.width > 0)
    {
        self.detailSuffixLabel.height = self.height;
        self.detailSuffixLabel.left = right - self.detailSuffixLabel.width;
        right = self.detailSuffixLabel.left - 5;
    }
    
    [self.detailLabel sizeToFit];
    self.detailLabel.left = right - self.detailLabel.width;
    self.detailLabel.height = self.height;
    
    if (_lineView)
    {
        _lineView.frame = CGRectMake(0, self.height - 1, self.width, 1);
    }
}


@end
