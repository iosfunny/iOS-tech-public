//
//  XLNormalCellController.m
//  Demo
//
//  Created by AlexSiu on 2019/4/19.
//  Copyright © 2019 AlexSiu. All rights reserved.
//

#import "XLNormalCellController.h"
#import "XLBaseStaticCell.h"

@interface XLNormalCellController ()
@property (nonatomic, strong) XLBaseStaticCell * normalCell;
@end

@implementation XLNormalCellController

- (XLBaseStaticCell *)normalCell
{
    if (!_normalCell)
    {
        _normalCell = [[XLBaseStaticCell alloc] init];
        _normalCell.noImg = ![self featureIconImage];
        _normalCell.iconImageView.image = [self featureIconImage];
        _normalCell.titleLabel.text = [self featureTitleForCell];
        _normalCell.showLine = YES;
        _normalCell.showMoreIcon = [self featureNeedShowMore];
    }
    
    return _normalCell;
}

- (NSString *)featureTitleForCell
{
    return @"Normal";
}

- (BOOL)featureNeedShowMore
{
    return YES;
}

- (UIImage *)featureIconImage
{
    return nil;
}

- (UITableViewCell *)cell
{
    return self.normalCell;
}

- (void)cellDidTriggerEvent:(XLCellTriggerEvent)event userInfo:(NSDictionary *)userInfo
{
    
}

@end
