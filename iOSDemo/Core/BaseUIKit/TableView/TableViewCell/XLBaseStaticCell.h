//
//  XLBaseStaticCell.h
//  Coinbon
//
//  Created by AlexSiu on 2018/6/14.
//  Copyright © 2018年 CoinSea. All rights reserved.
//

#import "XLCommonCell.h"

@interface XLBaseStaticCell : XLCommonCell
@property (nonatomic, strong) UILabel * detailSuffixLabel;
@property (nonatomic, assign) BOOL showLine;
@property (nonatomic, assign) BOOL noImg;

@end
