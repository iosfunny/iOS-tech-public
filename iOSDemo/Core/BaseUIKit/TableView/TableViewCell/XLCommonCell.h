//
//  XLCommonCell.h
//  Coinbon
//
//  Created by AlexSiu on 2018/6/12.
//  Copyright © 2018年 CoinSea. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLImageView.h"

@interface XLCommonCell : UITableViewCell
@property (nonatomic, strong) XLImageView * moreIconView;
@property (nonatomic, strong) UIImageView * iconImageView;
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UILabel * detailLabel;
@property (nonatomic, assign) BOOL showBadge;
@property (nonatomic, assign) BOOL showMoreIcon;    // Default is YES;

@end
