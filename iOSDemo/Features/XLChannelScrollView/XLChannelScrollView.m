//
//  XLChannelScrollView.m
//  CSEasyMall
//
//  Created by AlexSiu on 2018/12/3.
//  Copyright © 2018 CoinSea. All rights reserved.
//

#import "XLChannelScrollView.h"
#import "XLChannelItemView.h"
#import "UIColor+XLBase.h"
#import "UIView+XLLayout.h"
#import "XLResourceManager.h"

@interface XLChannelScrollView ()<XLChannelItemViewDelegate>

@property (nonatomic, strong) UIButton * moreButton;
@property (nonatomic, strong) NSMutableArray<XLChannelItemView *> * channelItemViews;
@property (nonatomic, strong) UIView * selectedLineView;

@property (nonatomic, strong) XLChannelItemView * selectedChannelItemView;

@property (nonatomic, assign) CGFloat firstChannelCenterX;
@property (nonatomic, assign) CGFloat lastChannelCenterX;

@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, strong) UIView * lineView;

@end

@implementation XLChannelScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self addSubview:self.lineView];
        [self addSubview:self.scrollView];
        [self addSubview:self.moreButton];
        [self.scrollView addSubview:self.selectedLineView];
    }
    
    return self;
}

- (UIView *)lineView
{
    if (!_lineView)
    {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor em_lineColor];
    }
    
    return _lineView;
}

- (UIView *)selectedLineView
{
    if (!_selectedLineView)
    {
        _selectedLineView = [[UIView alloc] init];
        _selectedLineView.backgroundColor = [UIColor em_selectedColor];
        _selectedLineView.size = CGSizeMake(25, 2);
        _selectedLineView.layer.cornerRadius = 2;
        _selectedLineView.layer.masksToBounds = YES;
    }
    
    return _selectedLineView;
}

- (UIButton *)moreButton
{
    if (!_moreButton)
    {
        _moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_moreButton setImage:resGetImage(@"common/箭头.png") forState:UIControlStateNormal];
        _moreButton.backgroundColor = [UIColor whiteColor];
        _moreButton.layer.shadowColor = [UIColor whiteColor].CGColor;
        _moreButton.layer.shadowOffset = CGSizeMake(-10, 0);
        _moreButton.layer.shadowOpacity = 1;
        [_moreButton addTarget:self action:@selector(moreButtonDidClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _moreButton;
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

- (NSMutableArray<XLChannelItemView *> *)channelItemViews
{
    if (!_channelItemViews)
    {
        _channelItemViews = [NSMutableArray array];
    }
    
    return _channelItemViews;
}

- (void)setChannels:(NSArray<XLChannel *> *)channels
{
    if (_channels != channels)
    {
        _channels = channels;
    }
    
    [self reloadChannels];
}

- (void)reloadChannels
{
    for (XLChannelItemView * itemView in self.channelItemViews)
    {
        [itemView removeFromSuperview];
    }
    
    [self.channelItemViews removeAllObjects];
    
    self.selectedLineView.hidden = (_channels.count == 0);
    
    for (XLChannel * channel in _channels)
    {
        XLChannelItemView * itemView = [[XLChannelItemView alloc] init];
        itemView.channel = channel;
        itemView.delegate = self;
        [itemView sizeToFit];
        
        // 更新选择视图
        if (channel.selected)
        {
            self.selectedChannelItemView = itemView;
        }
        
        [self.scrollView addSubview:itemView];
        [self.channelItemViews addObject:itemView];
    }
    
    [self setNeedsLayout];
}


- (void)setSelectedChannelItemView:(XLChannelItemView *)selectedChannelItemView
{
    if (_selectedChannelItemView != selectedChannelItemView)
    {
        // 重置旧视图中的数据
        XLChannel * oldSelectedChannel = _selectedChannelItemView.channel;
        oldSelectedChannel.selected = NO;
        _selectedChannelItemView.channel = oldSelectedChannel;
        _selectedChannelItemView.scale = 0;
        
        // 新的视图赋值
        _selectedChannelItemView = selectedChannelItemView;
        XLChannel * selectedChannel = _selectedChannelItemView.channel;
        selectedChannel.selected = YES;
        _selectedChannelItemView.channel = selectedChannel;
        _selectedChannelItemView.scale = 1;
    }
}

- (void)updateIndex:(NSInteger)index anmation:(BOOL)animation
{
    if (index == _selectedIndex) return;
    if (index >= self.channelItemViews.count) return;
    
    _selectedIndex = index;
    
    XLChannelItemView * channelItemView = [self.channelItemViews objectAtIndex:index];
    self.selectedChannelItemView = channelItemView;
    CGFloat centerX = channelItemView.centerX;
    if (animation)
    {
        [UIView animateWithDuration:0.25 animations:^{
            self.selectedLineView.centerX = centerX;
        }];
    }
    else
    {
        self.selectedLineView.centerX = centerX;
    }
    
    [self repostionSelectedItemViewPostionAnimation:YES];
}

- (void)repostionSelectedItemViewPostionAnimation:(BOOL)animation
{
    if (self.selectedChannelItemView.right > self.scrollView.contentOffset.x + self.scrollView.width)
    {
        [self.scrollView setContentOffset:CGPointMake(self.selectedChannelItemView.right - self.scrollView.width, 0) animated:animation];
    }
    else if (self.selectedChannelItemView.left < self.scrollView.contentOffset.x)
    {
        [self.scrollView setContentOffset:CGPointMake(self.selectedChannelItemView.left, 0) animated:animation];
    }
}

- (void)scrollIndexViewPostionFrom:(NSInteger)from to:(NSInteger)to progress:(CGFloat)progress
{
    if (!(from < self.channelItemViews.count && to < self.channelItemViews.count)) return;
    
    XLChannelItemView * fromItemView = [self.channelItemViews objectAtIndex:from];
    XLChannelItemView * toItemView = [self.channelItemViews objectAtIndex:to];
    
    fromItemView.scale = 1 - progress;
    toItemView.scale = progress;
    
    CGFloat distance = toItemView.centerX - fromItemView.centerX;
    self.selectedLineView.centerX = fromItemView.centerX + distance * progress;
}

- (void)recenterSelectedLineViewAnimation:(BOOL)animation
{
    if (!_selectedChannelItemView) return;
    if (!animation)
    {
        self.selectedLineView.centerX = _selectedChannelItemView.centerX;
        return;
    }
    
    [UIView animateWithDuration:0.2 animations:^{
        self.selectedLineView.centerX = self.selectedChannelItemView.centerX;
    }];
}

#pragma mark - XLChannelItemViewDelegate
- (void)channelItemViewDidClick:(XLChannelItemView *)channelItemView
{
    self.selectedIndex = [self.channelItemViews indexOfObject:channelItemView];
    self.selectedChannelItemView = channelItemView;
    [self recenterSelectedLineViewAnimation:YES];
    [self repostionSelectedItemViewPostionAnimation:YES];
    
    if ([self.delegate respondsToSelector:@selector(channelScrollView:didClickIndex:channel:)])
    {
        NSInteger index = [self.channelItemViews indexOfObject:channelItemView];
        [self.delegate channelScrollView:self didClickIndex:index channel:channelItemView.channel];
    }
}

- (void)moreButtonDidClick
{
    if ([self.delegate respondsToSelector:@selector(channelScrollViewDidClickMore:)])
    {
        [self.delegate channelScrollViewDidClickMore:self];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.lineView.frame = CGRectMake(0, self.height - 1, self.width, 1);
    self.moreButton.frame = CGRectMake(self.width - 42, 0, 42, self.height);
    self.scrollView.frame = CGRectMake(0, 0, self.width - 42, self.height);
    self.selectedLineView.bottom = self.height;
    
    CGFloat left = 0;
    
    for (int i = 0; i < self.channelItemViews.count; i ++)
    {
        XLChannelItemView * itemView = [self.channelItemViews objectAtIndex:i];
        itemView.left = left;
        left = itemView.right;
        
        if (itemView.channel.selected)
        {
            self.selectedLineView.centerX = itemView.centerX;
        }
        
        if (i == 0)
        {
            _firstChannelCenterX = itemView.centerX;
        }
        else if (i == self.channelItemViews.count - 1)
        {
            _lastChannelCenterX = itemView.centerX;
        }
    }
    
    self.scrollView.contentSize = CGSizeMake(left, self.height);
}

@end
