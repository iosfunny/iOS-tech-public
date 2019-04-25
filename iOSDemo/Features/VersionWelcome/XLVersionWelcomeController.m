//
//  XLVersionWelcomeController.m
//  UnicornPay
//
//  Created by AlexSiu on 2018/9/13.
//  Copyright © 2018年 CoinSea. All rights reserved.
//

#import "XLVersionWelcomeController.h"
#import "XLVersionWelcomeItemView.h"
#import "UIView+XLLayout.h"

int const XLVersionWelcomeVersion = 1;
NSString * const CBVersionWelcomeImagesDirName = @"VersionWelcomeImages";
NSString * const CBVersionWelcomeImageNamePrefix = @"引导页-";
NSString * const XLVersionWelcomeCloseNotificationName = @"XLVersionWelcomeCloseNotificationName";

#pragma mark - XLVersionWelcomeController

@interface XLVersionWelcomeController ()<UIScrollViewDelegate, CAAnimationDelegate, XLVersionWelcomeItemViewDelegate>
@property (nonatomic, strong) UIScrollView * scrollView;
@property (nonatomic, strong) NSMutableArray<UIImage *> * images;
@property (nonatomic, strong) NSMutableArray<XLVersionWelcomeItemView *> * itemViews;
@property (nonatomic, strong) UIButton * closeButton;
@property (nonatomic, strong) UIPageControl * pageControl;

@end

@implementation XLVersionWelcomeController

#pragma mark - class method

static XLVersionWelcomeController * g_versionWelcomeController = nil;
+ (BOOL)showIfNeed
{
    BOOL result = NO;
    do
    {
        BOOL showed = [[NSUserDefaults standardUserDefaults] boolForKey:[self welcomeVersionKey]];
        if (showed) break;
        
        g_versionWelcomeController = [[XLVersionWelcomeController alloc] init];
        UIView * superView = [UIApplication sharedApplication].keyWindow;
        g_versionWelcomeController.view.frame = superView.bounds;
        [superView addSubview:g_versionWelcomeController.view];
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:[self welcomeVersionKey]];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        result = YES;
    }
    while (false);
    
    return result;
}

+ (BOOL)isShowing
{
    return (BOOL)g_versionWelcomeController.view.superview;
}

+ (NSString *)welcomeVersionKey
{
    return [NSString stringWithFormat:@"XLVersionWelcomeVersion_%d", [self welcomeVersion]];
}

+ (int)welcomeVersion
{
    return XLVersionWelcomeVersion;
}

#pragma mark -

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.pageControl];
    [self.view addSubview:self.closeButton];
    
    [self loadItemViews];
}

- (void)loadItemViews
{
    for (UIImage * image in self.images)
    {
        XLVersionWelcomeItemView * itemView = [[XLVersionWelcomeItemView alloc] init];
        itemView.delegate = self;
        itemView.imageView.image = image;
        
        [self.scrollView addSubview:itemView];
        [self.itemViews addObject:itemView];
    }
    
    self.pageControl.hidden = self.itemViews.count <= 1;
    self.pageControl.numberOfPages = self.itemViews.count;
    
    [self.view setNeedsLayout];
}

#pragma mark -

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetX = scrollView.contentOffset.x;
    NSInteger index = (offsetX + scrollView.bounds.size.width / 2.0) / scrollView.bounds.size.width;
    self.pageControl.currentPage = index;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    /*
     禁止惯性滚动
     */
    CGFloat offsetX = scrollView.contentOffset.x;
    if (decelerate && scrollView.contentSize.width - (offsetX + self.view.bounds.size.width) < -85)
    {
        [XLNextRunloopRunner run:^{
            [scrollView setContentOffset:scrollView.contentOffset animated:NO];
            [self close];
        }];
    }

}

#pragma mark - getter

- (UIButton *)closeButton
{
    if (!_closeButton)
    {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeButton setTitle:@"关闭" forState:UIControlStateNormal];
        [_closeButton setTitleColor:[UIColor colorWithRed:158/255.0 green:155/255.0 blue:155/255.0 alpha:1] forState:UIControlStateNormal];
        [_closeButton.titleLabel setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:15]];
        [_closeButton addTarget:self action:@selector(closeButtonDidClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _closeButton;
}

- (NSMutableArray<XLVersionWelcomeItemView *> *)itemViews
{
    if (!_itemViews)
    {
        _itemViews = [NSMutableArray array];
    }
    
    return _itemViews;
}

- (NSMutableArray<UIImage *> *)images
{
    if (!_images)
    {
        _images = [NSMutableArray array];
        
#pragma mark - TEST
        UIImage * image1 = [[UIImage alloc] init];  if (image1) [_images addObject:image1];
        UIImage * image2 = [[UIImage alloc] init];  if (image2) [_images addObject:image1];
        UIImage * image3 = [[UIImage alloc] init];  if (image3) [_images addObject:image1];
    }
    
    return _images;
}

- (UIPageControl *)pageControl
{
    if (!_pageControl)
    {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.pageIndicatorTintColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
        _pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:216/255.0 green:216/255.0 blue:216/255.0 alpha:1];
        _pageControl.hidden = YES;
    }
    
    return _pageControl;
}

- (UIScrollView *)scrollView
{
    if (!_scrollView)
    {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    
    return _scrollView;
}

- (void)close
{
    CGFloat kAnimationDuration = 0.5;
    CAGradientLayer *contentLayer = (CAGradientLayer *)self.view.layer;
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    scaleAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 1)];
    scaleAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(2, 2, 1)];
    scaleAnimation.duration = kAnimationDuration;
    scaleAnimation.cumulative = NO;
    scaleAnimation.repeatCount = 1;
    [scaleAnimation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    [contentLayer addAnimation: scaleAnimation forKey:@"myScale"];
    
    CABasicAnimation *showViewAnn = [CABasicAnimation animationWithKeyPath:@"opacity"];
    showViewAnn.fromValue = [NSNumber numberWithFloat:1.0];
    showViewAnn.toValue = [NSNumber numberWithFloat:0.0];
    showViewAnn.duration = kAnimationDuration;
    showViewAnn.fillMode = kCAFillModeForwards;
    showViewAnn.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    showViewAnn.removedOnCompletion = NO;
    showViewAnn.delegate = self;
    [contentLayer addAnimation:showViewAnn forKey:@"myShow"];
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.duration = kAnimationDuration;
    group.removedOnCompletion = NO;
    group.repeatCount = 1;
    group.fillMode = kCAFillModeForwards;
    [group setAnimations:@[scaleAnimation,showViewAnn]];
    
    [contentLayer addAnimation:group forKey:@"animationOpacity"];
}

#pragma mark - action
- (void)closeButtonDidClick
{
    [self close];
}

#pragma mark - XLVersionWelcomeItemViewDelegate
- (void)versionWelcomeItemViewDidClick:(XLVersionWelcomeItemView *)versionWelcomeItemView
{
    if (versionWelcomeItemView == [self.itemViews lastObject])
    {
        [self close];
    }
}

#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [self.view removeFromSuperview];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        g_versionWelcomeController = nil;
    });
    
    [[NSNotificationCenter defaultCenter] postNotificationName:XLVersionWelcomeCloseNotificationName object:nil userInfo:nil];
}

#pragma mark - layout

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.scrollView.frame = self.view.bounds;
    
    CGFloat itemViewWidth = self.view.bounds.size.width;
    CGFloat itemViewHeight = self.view.bounds.size.height;
    for (int i = 0; i < self.itemViews.count; i ++)
    {
        UIView * view = [self.itemViews objectAtIndex:i];
        view.frame = CGRectMake(i * itemViewWidth, 0, itemViewWidth, itemViewHeight);
    }
    
    self.scrollView.contentSize = CGSizeMake(itemViewWidth * self.itemViews.count, itemViewHeight);
    self.pageControl.frame = CGRectMake(0, itemViewHeight - 40, itemViewWidth, 20);
    [self.closeButton sizeToFit];
    self.closeButton.top = 28;
    self.closeButton.right = itemViewWidth - 15;
}

@end
