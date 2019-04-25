//
//  XLImageView.h
//  Coinbon
//
//  Created by AlexSiu on 2018/6/12.
//  Copyright © 2018年 CoinSea. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XLImageView : UIImageView

+ (instancetype)imageViewWithImageKeyPath:(NSString *)keyPath;
+ (instancetype)linearGradientImageViewWithSize:(CGSize)size startColor:(UIColor *)startColor endColor:(UIColor *)endColor;
+ (instancetype)linearGradientImageViewWithSize:(CGSize)size startColor:(UIColor *)startColor endColor:(UIColor *)endColor startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint;

@end
