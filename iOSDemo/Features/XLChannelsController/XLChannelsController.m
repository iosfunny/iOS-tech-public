//
//  ViewController.m
//  Demo
//
//  Created by AlexSiu on 2018/6/9.
//  Copyright © 2018年 AlexSiu. All rights reserved.
//

#import "XLChannelsController.h"
#import "XLChannelScrollView.h"
#import "XLChannelController.h"
#import "UIView+XLLayout.h"
#import "XLNextRunloopRunner.h"
#import "XLChannelControllerFactory.h"

@interface XLChannelsController ()<XLChannelScrollViewDelegate, UIScrollViewDelegate>
@property (nonatomic, strong) XLChannelScrollView * channelScrollView;
@property (nonatomic, copy) NSArray<XLChannel *> * channels;

@property (nonatomic, strong) NSMutableArray<XLChannelController *> * channelControllers;
@property (nonatomic, strong) UIScrollView * controllerScrollView;

@property (nonatomic, assign) BOOL scrollFromClick;
@property (nonatomic, assign) NSInteger nextRunloopTryScrollToIndex;

@property (nonatomic, assign) BOOL mainPageIsAppear;

@property (nonatomic, strong) NSString * aa;

@end

@implementation XLChannelsController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"频道";
    self.automaticallyAdjustsScrollViewInsets = NO;

    [self.view addSubview:self.channelScrollView];
    [self.view addSubview:self.controllerScrollView];

    self.channels = [XLChannel testChannels];
}

#pragma mark - getter

- (XLChannelScrollView *)channelScrollView
{
    if (!_channelScrollView)
    {
        _channelScrollView = [[XLChannelScrollView alloc] init];
        _channelScrollView.delegate = self;
    }
    
    return _channelScrollView;
}


- (UIScrollView *)controllerScrollView
{
    if (!_controllerScrollView)
    {
        _controllerScrollView = [[UIScrollView alloc] init];
        _controllerScrollView.delegate = self;
        _controllerScrollView.showsVerticalScrollIndicator = NO;
        _controllerScrollView.showsHorizontalScrollIndicator = NO;
        _controllerScrollView.pagingEnabled = YES;
        
        if (@available(iOS 11.0, *))
        { [_controllerScrollView setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever]; }
    }
    
    return _controllerScrollView;
}

- (NSMutableArray<XLChannelController *> *)channelControllers
{
    if (!_channelControllers)
    {
        _channelControllers = [NSMutableArray array];
    }
    
    return _channelControllers;
}

- (void)syncScrollIndex:(NSInteger)index
{
    if (self.channelControllers.count <= index) return;
//    XLChannelController * channelController = [self.channelControllers objectAtIndex:index];
}


- (void)scrollToIndex:(NSInteger)index channel:(XLChannel *)channel animation:(BOOL)animation
{
    if (self.controllerScrollView.contentSize.width == 0)
    {
        _nextRunloopTryScrollToIndex = index;
        return;
    }
    
    _nextRunloopTryScrollToIndex = -1;
    
    CGFloat width = self.controllerScrollView.width;
    CGFloat height = self.controllerScrollView.height;
    [self.controllerScrollView scrollRectToVisible:CGRectMake(width * index, 0, width, height) animated:animation];
    [self.channelScrollView repostionSelectedItemViewPostionAnimation:NO];
}


#pragma mark - setter

- (void)setChannels:(NSArray<XLChannel *> *)channels
{
    XLChannel * homePageChannel = [XLChannel shareHomepageChannel];
    if (_channels != channels)
    {
        if (![channels containsObject:homePageChannel])
        {
            NSMutableArray<XLChannel *> * copyChannels = [channels mutableCopy];
            
            for (XLChannel * channel in copyChannels)
            {
                channel.selected = NO;
            }
            
            homePageChannel.selected = YES;
            [copyChannels insertObject:homePageChannel atIndex:0];
            
            channels = copyChannels;
        }
        
        _channels = [channels copy];
    }
    
    NSInteger homePageIndex = [_channels indexOfObject:homePageChannel];
    [self scrollToIndex:homePageIndex channel:homePageChannel animation:NO];
    
    self.channelScrollView.channels = channels;
    
    for (XLChannelController * controller in self.channelControllers)
    {
        [controller.view removeFromSuperview];
    }
    
    [self.channelControllers removeAllObjects];
    
    for (XLChannel * channel in _channels)
    {
        XLChannelController * controller = [XLChannelControllerFactory channelControllerWithChannel:channel];
        
        [self.controllerScrollView addSubview:controller.view];
        [self.channelControllers addObject:controller];
    }
    
    [self.view setNeedsLayout];
}



#pragma mark - XLChannelScrollViewDelegate
- (void)channelScrollView:(XLChannelScrollView *)channelScrollView didClickIndex:(NSInteger)index channel:(XLChannel *)channel
{
    _scrollFromClick = YES;
    [self scrollToIndex:index channel:channel animation:YES];
    [self syncScrollIndex:index];
}

- (void)channelScrollViewDidClickMore:(XLChannelScrollView *)channelScrollView
{
    CGFloat width = channelScrollView.width;
    CGFloat height = channelScrollView.height;
    CGFloat contentOffsetX = channelScrollView.scrollView.contentOffset.x;
    
    [channelScrollView.scrollView scrollRectToVisible:CGRectMake(contentOffsetX + width, 0, width, height) animated:YES];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (_scrollFromClick) return;
    CGFloat contentOffsetX = scrollView.contentOffset.x;
    NSInteger from = (int)contentOffsetX / scrollView.width;
    NSInteger to = from + 1;
    CGFloat progress = (contentOffsetX - from * scrollView.width) / scrollView.width;
    
    [self.channelScrollView scrollIndexViewPostionFrom:from to:to progress:progress];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate)
    {
        CGFloat contentOffsetX = scrollView.contentOffset.x;
        NSInteger index = contentOffsetX / scrollView.width;
        [self.channelScrollView updateIndex:index anmation:NO];
        [self syncScrollIndex:index];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat contentOffsetX = scrollView.contentOffset.x;
    NSInteger index = contentOffsetX / scrollView.width;
    [self.channelScrollView updateIndex:index anmation:NO];
    [self syncScrollIndex:index];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    _scrollFromClick = NO;
}


#pragma mark - layout
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    CGFloat top = self.topLayoutGuide.length;
    self.channelScrollView.frame = CGRectMake(0, top, self.view.width, 40);
    
    CGFloat controllerScrollViewTop = self.channelScrollView.bottom;
    CGFloat controllerScrollViewHeight = self.view.height - controllerScrollViewTop - self.bottomLayoutGuide.length;
    self.controllerScrollView.frame = CGRectMake(0, controllerScrollViewTop, self.view.width, controllerScrollViewHeight);
    
    CGFloat controllerLeft = 0;
    for (XLChannelController * controller in self.channelControllers)
    {
        controller.view.frame = CGRectMake(controllerLeft, 0, self.controllerScrollView.width, self.controllerScrollView.height);
        controllerLeft = controller.view.right;
    }
    
    self.controllerScrollView.contentSize = CGSizeMake(controllerLeft, controllerScrollViewHeight);
    if (_nextRunloopTryScrollToIndex != -1)
    {
        [XLNextRunloopRunner run:^{
            [self scrollToIndex:self.nextRunloopTryScrollToIndex channel:nil animation:NO];
        }];
    }
}

@end





