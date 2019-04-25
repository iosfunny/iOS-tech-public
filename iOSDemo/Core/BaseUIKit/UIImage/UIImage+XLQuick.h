//
//  UIImage+XLQuick.h
//  Coinbon
//
//  Created by AlexSiu on 2018/6/11.
//  Copyright © 2018年 CoinSea. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (XLQuick)
+ (UIImage *)sharedEmptyImage;
+ (UIImage *)colorImageWithColor:(UIColor *)color;
+ (UIImage *)colorRoundImageWithColor:(UIColor *)color size:(CGFloat)size;
+ (UIImage *)qrCodeImageWithText:(NSString *)text size:(CGFloat)size;
+ (UIImage *)sharedPlaceholderImage;

@end
