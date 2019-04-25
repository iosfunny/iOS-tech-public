//
//  XLChannelSelectBoardView.m
//  CSEasyMall
//
//  Created by AlexSiu on 2018/12/7.
//  Copyright © 2018 CoinSea. All rights reserved.
//

#import "XLChannelSelectBoardView.h"
#import "XLImageView.h"
#import "UIView+XLLayout.h"
#import "UIColor+XLBase.h"

@class XLChannelsBoardItemView;
@protocol XLChannelsBoardItemViewDelegate <NSObject>
@optional
- (void)channelsBoardItemViewDidClickContent:(XLChannelsBoardItemView *)channelsBoardItemView;

@end

@interface XLChannelsBoardItemView : UIView
@property (nonatomic, weak) id<XLChannelsBoardItemViewDelegate> delegate;
@property (nonatomic, strong) XLChannel * channel;
@property (nonatomic, strong) XLImageView * iconView;
@property (nonatomic, strong) UILabel * titleLabel;
@end

@implementation XLChannelsBoardItemView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self addSubview:self.iconView];
        [self addSubview:self.titleLabel];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(contentDidClick)];
        [self addGestureRecognizer:tap];
    }
    
    return self;
}

- (void)contentDidClick
{
    if ([self.delegate respondsToSelector:@selector(channelsBoardItemViewDidClickContent:)])
    {
        [self.delegate channelsBoardItemViewDidClickContent:self];
    }
}

- (XLImageView *)iconView
{
    if (!_iconView)
    {
        _iconView = [XLImageView imageViewWithImageKeyPath:@""];
        _iconView.size = CGSizeMake(44, 44);
    }
    
    return _iconView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size: 14];
        _titleLabel.textColor = [UIColor em_textLevel1Color];
    }
    
    return _titleLabel;
}

- (void)setChannel:(XLChannel *)channel
{
    if (_channel != channel)
    {
        _channel = channel;
    }
    
    self.titleLabel.text = channel.categoryName;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.titleLabel sizeToFit];
    self.titleLabel.height = 14;
    self.titleLabel.bottom = self.height;
    self.titleLabel.centerX = CGRectGetMidX(self.bounds);
    
    self.iconView.centerX = CGRectGetMidX(self.bounds);
}

@end

#pragma mark - XLChannelsBoardView

@class XLChannelsBoardView;
@protocol XLChannelsBoardViewDelegate <NSObject>
@optional
- (void)channelsBoardView:(XLChannelsBoardView *)channelsBoardView didClickChannel:(XLChannel *)channel index:(NSInteger)index;

@end

@interface XLChannelsBoardView : UIView<XLChannelsBoardItemViewDelegate>
@property (nonatomic, weak) id<XLChannelsBoardViewDelegate> delegate;
@property (nonatomic, strong) NSArray<XLChannel *> * channels;
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) NSMutableArray<XLChannelsBoardItemView *> * channelItemViews;
@property (nonatomic, strong) UIScrollView * scrollView;
@property (nonatomic, assign) CGFloat contentHeight;

@property (nonatomic, assign) CGFloat maxContentHeight;

@end

@implementation XLChannelsBoardView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.scrollView];
        [self.scrollView addSubview:self.titleLabel];
        
        self.clipsToBounds = YES;
    }
    
    return self;
}

- (NSMutableArray<XLChannelsBoardItemView *> *)channelItemViews
{
    if (!_channelItemViews)
    {
        _channelItemViews = [NSMutableArray array];
    }
    
    return _channelItemViews;
}

- (UIScrollView *)scrollView
{
    if (!_scrollView)
    {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    
    return _scrollView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size: 15];
        _titleLabel.textColor = [UIColor em_textNormalColor];
        _titleLabel.text = @"全部频道";
        [_titleLabel sizeToFit];
        _titleLabel.height = 15;
        _titleLabel.top = 25;
        _titleLabel.left = 15;
    }
    
    return _titleLabel;
}

- (void)setChannels:(NSArray<XLChannel *> *)channels
{
    if (_channels != channels)
    {
        _channels = channels;
    }
    
    for (UIView * view in self.channelItemViews)
    {
        [view removeFromSuperview];
    }
    
    [self.channelItemViews removeAllObjects];
    
    for (XLChannel * channel in _channels)
    {
        XLChannelsBoardItemView * itemView = [[XLChannelsBoardItemView alloc] init];
        itemView.channel = channel;
        itemView.delegate = self;
        
        [self.scrollView addSubview:itemView];
        [self.channelItemViews addObject:itemView];
    }
    
    [self layoutItemViews];
    [self setNeedsLayout];
}

#pragma mark - XLChannelsBoardItemViewDelegate
- (void)channelsBoardItemViewDidClickContent:(XLChannelsBoardItemView *)channelsBoardItemView
{
    if ([self.delegate respondsToSelector:@selector(channelsBoardView:didClickChannel:index:)])
    {
        NSInteger index = [self.channelItemViews indexOfObject:channelsBoardItemView];
        [self.delegate channelsBoardView:self didClickChannel:channelsBoardItemView.channel index:index];
    }
}

#pragma mark - layout
- (CGFloat)heightForContent
{
    return MIN(self.contentHeight, _maxContentHeight);
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.scrollView.frame = self.bounds;
    [self layoutItemViews];
}

- (void)layoutItemViews
{
    CGFloat itemViewW = [UIScreen mainScreen].bounds.size.width / 4.0;
    CGFloat itemViewH = 66;
    UIView * bottomView = self.titleLabel;
    for (int i = 0; i < self.channelItemViews.count; i ++)
    {
        XLChannelsBoardItemView * itemView = [self.channelItemViews objectAtIndex:i];
        itemView.frame = CGRectMake((i % 4) * itemViewW, self.titleLabel.bottom + 25 + (i / 4) * (itemViewH + 25), itemViewW, itemViewH);
        bottomView = itemView;
    }
    
    self.scrollView.contentSize = CGSizeMake(self.width, bottomView.bottom + 25);
    self.contentHeight = self.scrollView.contentSize.height;
}


@end

#pragma mark - XLChannelsBoardView

@interface XLChannelSelectBoardView ()<XLChannelsBoardViewDelegate>
@property (nonatomic, strong) UIView * bgView;
@property (nonatomic, strong) XLChannelsBoardView * channelsBoardView;
@end

@implementation XLChannelSelectBoardView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self addSubview:self.bgView];
        [self addSubview:self.channelsBoardView];
    }
    
    return self;
}

- (void)setChannels:(NSArray<XLChannel *> *)channels
{
    if (_channels != channels)
    {
        _channels = channels;
    }
    
    self.channelsBoardView.channels = channels;
}

- (XLChannelsBoardView *)channelsBoardView
{
    if (!_channelsBoardView)
    {
        _channelsBoardView = [[XLChannelsBoardView alloc] init];
        _channelsBoardView.delegate = self;
    }
    
    return _channelsBoardView;
}

- (UIView *)bgView
{
    if (!_bgView)
    {
        _bgView = [[UIView alloc] init];
        _bgView.alpha = 0;
        _bgView.backgroundColor = [UIColor colorWithRed:16/255.0 green:16/255.0 blue:16/255.0 alpha:0.5];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bgViewDidClick)];
        [_bgView addGestureRecognizer:tap];
    }
    
    return _bgView;
}

#pragma mark - XLChannelsBoardViewDelegate

- (void)channelsBoardView:(XLChannelsBoardView *)channelsBoardView didClickChannel:(XLChannel *)channel index:(NSInteger)index
{
    if ([self.delegate respondsToSelector:@selector(channelSelectBoardView:didClickChannel:index:)])
    {
        [self.delegate channelSelectBoardView:self didClickChannel:channel index:index];
    }
}

#pragma mark - layout

- (void)setTopLayoutGuide:(CGFloat)topLayoutGuide
{
    if (_topLayoutGuide != topLayoutGuide)
    {
        _topLayoutGuide = topLayoutGuide;
    }
    
    self.channelsBoardView.maxContentHeight = [UIScreen mainScreen].bounds.size.height - _topLayoutGuide;
    
    [self setNeedsLayout];
}

- (BOOL)showing
{
    return self.superview ? YES : NO;
}

- (void)show
{
//    [[XLNavigator mainWindow] addSubview:self];
//    self.channelsBoardView.frame = CGRectMake(0, _topLayoutGuide, self.width, 1);
//    [UIView animateWithDuration:0.25 animations:^{
//        self.channelsBoardView.height = [self.channelsBoardView heightForContent];
//        self.bgView.alpha = 1.0;
//    }];
}

- (void)close
{
    [UIView animateWithDuration:0.25 animations:^{
        self.channelsBoardView.height = 0;
        self.bgView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)bgViewDidClick
{
    [self close];
}

#pragma mark - layout

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.bgView.frame = CGRectMake(0, _topLayoutGuide, self.width, self.height - _topLayoutGuide);
}

@end
