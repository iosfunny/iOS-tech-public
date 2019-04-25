//
//  XLQRCodeView.h
//  UnicornPay
//
//  Created by AlexSiu on 2018/6/22.
//  Copyright © 2018年 CoinSea. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLImageView.h"

@interface XLQRCodeView : UIView
@property (nonatomic, assign) UIEdgeInsets contentInset;
@property (nonatomic, strong) XLImageView * imageView;
@end
