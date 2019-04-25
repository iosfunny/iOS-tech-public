//
//  XLCommonCell.m
//  Coinbon
//
//  Created by AlexSiu on 2018/6/12.
//  Copyright © 2018年 CoinSea. All rights reserved.
//

#import "XLCommonCell.h"
#import "XLImageView.h"
#import "XLBadgeView.h"

@interface XLCommonCell ()
@property (nonatomic, copy) void (^ActionBlock)(void);
@property (nonatomic, assign) BOOL layouted;

@property (nonatomic, strong) XLBadgeView * badgeView;
@end

@implementation XLCommonCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}

- (XLBadgeView *)badgeView
{
    if (!_badgeView)
    {
        _badgeView = [[XLBadgeView alloc] init];
    }
    
    return _badgeView;
}

- (UIImageView *)moreIconView
{
    if (!_moreIconView)
    {
        _moreIconView = [XLImageView imageViewWithImageKeyPath:@"common/箭头.png"];
    }
    
    return _moreIconView;
}

- (UIImageView *)iconImageView
{
    if (!_iconImageView)
    {
        _iconImageView = [[UIImageView alloc] init];

        [self addSubview:_iconImageView];
        _layouted = NO;
        [self setNeedsLayout];
    }
    
    return _iconImageView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
        _titleLabel.textColor = [UIColor colorWithRed:16/255.0 green:16/255.0 blue:16/255.0 alpha:1/1.0];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        
        [self addSubview:_titleLabel];
        _layouted = NO;
        [self setNeedsLayout];
    }
    
    return _titleLabel;
}

- (UILabel *)detailLabel
{
    if (!_detailLabel)
    {
        _detailLabel = [[UILabel alloc] init];
        _detailLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
        _detailLabel.textColor = [UIColor colorWithRed:158/255.0 green:155/255.0 blue:155/255.0 alpha:1/1.0];
        _detailLabel.textAlignment = NSTextAlignmentRight;
        
        [self addSubview:_detailLabel];
        _layouted = NO;
        [self setNeedsLayout];
    }
    
    return _detailLabel;
}

- (void)setShowMoreIcon:(BOOL)showMoreIcon
{
    _showMoreIcon = showMoreIcon;
    if (_showMoreIcon && ![self.moreIconView superview])
    {
        [self addSubview:self.moreIconView];
        _layouted = NO;
        [self setNeedsLayout];
    }
}

- (void)setShowBadge:(BOOL)showBadge
{
    _showBadge = showBadge;
    if (_showBadge && ![_badgeView superview])
    {
        [self addSubview:self.badgeView];
        _layouted = NO;
        [self setNeedsLayout];
    }
    
    if (!_showBadge)
    {
        _badgeView.hidden = YES;
    }
    else
    {
        _badgeView.hidden = NO;
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (_layouted) return;
    _layouted = YES;
    
    CGFloat left = 15;
    CGFloat right = 10;
    _iconImageView.frame = CGRectMake(left, 15, 30, 30);
    
    left += _iconImageView.width;
    _titleLabel.left = left + (_iconImageView ? 12 : 0);
    _titleLabel.width = self.width - _titleLabel.left - 120;
    _titleLabel.height = self.height;
    
    left = self.width - 25;
    _moreIconView.size = CGSizeMake(11, 11);
    _moreIconView.left = left;
    _moreIconView.centerY = CGRectGetMidY(self.bounds);
    right += _moreIconView.width;
    
    if (_moreIconView)
    {
        left = _moreIconView.left - 11;
    }
    
    _badgeView.size = CGSizeMake(8, 8);
    _badgeView.left = left;
    _badgeView.centerY = _titleLabel.centerY;
    
    
    _detailLabel.width = 90;
    _detailLabel.height = self.height;
    _detailLabel.right = self.width - right;
}

@end
