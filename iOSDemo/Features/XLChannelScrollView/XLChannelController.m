//
//  XLChannelController.m
//  Demo
//
//  Created by AlexSiu on 2019/4/18.
//  Copyright © 2019 AlexSiu. All rights reserved.
//

#import "XLChannelController.h"
#import "UIView+XLLayout.h"

@interface XLChannelController ()
@property (nonatomic, strong) UILabel * nameLabel;
@end

@implementation XLChannelController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGFloat red = (arc4random() % 255 / 255.0);
    CGFloat green = (arc4random() % 255 / 255.0);
    CGFloat blue = (arc4random() % 255 / 255.0);
    
    self.view.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    self.nameLabel.textColor = [UIColor colorWithRed:(1 - red) green:(1 - green) blue:(1 - blue) alpha:1.0];
    
    [self.view addSubview:self.nameLabel];
}

- (void)setChannel:(XLChannel *)channel
{
    if (_channel != channel)
    {
        _channel = channel;
    }
    
    self.nameLabel.text = channel.categoryName.length > 0 ? channel.categoryName : @"Default Name";
    [self.view setNeedsLayout];
}

- (UILabel *)nameLabel
{
    if (!_nameLabel)
    {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont boldSystemFontOfSize:50];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.numberOfLines = 0;
    }
    
    return _nameLabel;
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.nameLabel.width = self.view.width - 40;
    [self.nameLabel sizeToFit];
    self.nameLabel.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds));
}

@end
