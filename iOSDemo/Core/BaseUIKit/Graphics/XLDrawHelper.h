//
//  XLDrawHelper.h
//  Coinbon
//
//  Created by AlexSiu on 2018/6/20.
//  Copyright © 2018年 CoinSea. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XLDrawHelper : NSObject
/**
 *  绘制线性渐变
 **/
+ (void)drawLinearGradient:(CGContextRef)context
                      path:(CGPathRef)path
                startColor:(CGColorRef)startColor
                  endColor:(CGColorRef)endColor;


+ (void)drawLinearGradient:(CGContextRef)context
                      path:(CGPathRef)path
                startColor:(CGColorRef)startColor
                  endColor:(CGColorRef)endColor
                startPoint:(CGPoint)startPoint
                  endPoint:(CGPoint)endPoint;

/**
 *  绘制圆半径方向渐变
 **/
+ (void)drawRadialGradient:(CGContextRef)context
                      path:(CGPathRef)path
                startColor:(CGColorRef)startColor
                  endColor:(CGColorRef)endColor;

/**
 *   使用 Catmull-Rom算法获取阶段点；用来画曲线用
 *   https://en.wikipedia.org/wiki/Centripetal_Catmull–Rom_spline
 */
+ (CGPoint)getCatmullRomPoint:(CGFloat)t p0:(CGPoint)p0 p1:(CGPoint)p1 p2:(CGPoint)p2 p3:(CGPoint)p3;

+ (UIBezierPath *)curvePathWithPoints:(NSArray<NSValue *> *)points beginPoint:(CGPoint)beginPoint endPoint:(CGPoint)endPoint precision:(NSInteger)precision;

@end
