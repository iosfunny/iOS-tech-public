//
//  XLDrawHelper.m
//  Coinbon
//
//  Created by AlexSiu on 2018/6/20.
//  Copyright © 2018年 CoinSea. All rights reserved.
//

#import "XLDrawHelper.h"

@implementation XLDrawHelper


+ (void)drawLinearGradient:(CGContextRef)context
                      path:(CGPathRef)path
                startColor:(CGColorRef)startColor
                  endColor:(CGColorRef)endColor
                startPoint:(CGPoint)startPoint
                  endPoint:(CGPoint)endPoint
{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = { 0.0, 1.0 };
    
    NSArray *colors = @[(__bridge id) startColor, (__bridge id) endColor];
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) colors, locations);
    
    CGContextSaveGState(context);
    CGContextAddPath(context, path);
    CGContextClip(context);
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    CGContextRestoreGState(context);
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
}

+ (void)drawLinearGradient:(CGContextRef)context
                      path:(CGPathRef)path
                startColor:(CGColorRef)startColor
                  endColor:(CGColorRef)endColor
{
    CGRect pathRect = CGPathGetBoundingBox(path);
    CGPoint startPoint = CGPointMake(CGRectGetMinX(pathRect), CGRectGetMidY(pathRect));
    CGPoint endPoint = CGPointMake(CGRectGetMaxX(pathRect), CGRectGetMidY(pathRect));
    [self drawLinearGradient:context path:path startColor:startColor endColor:endColor startPoint:startPoint endPoint:endPoint];
}


+ (void)drawRadialGradient:(CGContextRef)context
                      path:(CGPathRef)path
                startColor:(CGColorRef)startColor
                  endColor:(CGColorRef)endColor
{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = { 0.0, 1.0 };
    
    NSArray *colors = @[(__bridge id) startColor, (__bridge id) endColor];
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) colors, locations);
    
    
    CGRect pathRect = CGPathGetBoundingBox(path);
    CGPoint center = CGPointMake(CGRectGetMidX(pathRect), CGRectGetMidY(pathRect));
    CGFloat radius = MAX(pathRect.size.width / 2.0, pathRect.size.height / 2.0) * sqrt(2);
    
    CGContextSaveGState(context);
    CGContextAddPath(context, path);
    CGContextEOClip(context);
    
    CGContextDrawRadialGradient(context, gradient, center, 0, center, radius, 0);
    
    CGContextRestoreGState(context);
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
}

+ (CGPoint)getCatmullRomPoint:(CGFloat)t p0:(CGPoint)p0 p1:(CGPoint)p1 p2:(CGPoint)p2 p3:(CGPoint)p3
{
    CGFloat t2 = t*t;
    CGFloat t3 = t2*t;
    
    CGFloat f0 = -0.5*t3 + t2 - 0.5*t;
    CGFloat f1 = 1.5*t3 - 2.5*t2 + 1.0;
    CGFloat f2 = -1.5*t3 + 2.0*t2 + 0.5*t;
    CGFloat f3 = 0.5*t3 - 0.5*t2;
    
    CGFloat x = p0.x*f0 + p1.x*f1 + p2.x*f2 +p3.x*f3;
    CGFloat y = p0.y*f0 + p1.y*f1 + p2.y*f2 +p3.y*f3;
    
    return CGPointMake(x, y);
}

+ (UIBezierPath *)curvePathWithPoints:(NSArray<NSValue *> *)points beginPoint:(CGPoint)beginPoint endPoint:(CGPoint)endPoint precision:(NSInteger)precision
{
    UIBezierPath * bezierPath = nil;
    do
    {
        if (![points isKindOfClass:[NSArray class]] || points.count == 0)
        {
            break;
        }
        
        NSMutableArray * mutablePoints = [NSMutableArray arrayWithArray:points];
        NSValue * pFirst = [points firstObject];
        NSValue * pLast = [points lastObject];
        
        [mutablePoints insertObject:pFirst atIndex:0];
        [mutablePoints insertObject:pLast atIndex:points.count];
        
        CGPoint firstPoint = [pFirst CGPointValue];
        bezierPath = [UIBezierPath bezierPath];
        [bezierPath moveToPoint:beginPoint];
        [bezierPath addLineToPoint:firstPoint];
        
        for (int i = 0; i < points.count - 3; i ++)
        {
            CGPoint t0 = [points[i+0] CGPointValue];
            CGPoint t1 = [points[i+1] CGPointValue];
            CGPoint t2 = [points[i+2] CGPointValue];
            CGPoint t3 = [points[i+3] CGPointValue];
            
            for (int i = 0; i < precision; i++)
            {
                CGFloat t = i / precision;
                CGPoint point = [self getCatmullRomPoint:t p0:t0 p1:t1 p2:t2 p3:t3];
                [bezierPath addLineToPoint:point];
            }
        }
        
        CGPoint lastPoint = [pLast CGPointValue];
        [bezierPath addLineToPoint:lastPoint];
        [bezierPath addLineToPoint:endPoint];
    }
    while (false);
    
    return bezierPath;
}

@end
