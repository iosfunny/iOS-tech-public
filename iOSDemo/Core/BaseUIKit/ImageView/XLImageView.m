//
//  XLImageView.m
//  Coinbon
//
//  Created by AlexSiu on 2018/6/12.
//  Copyright © 2018年 CoinSea. All rights reserved.
//

#import "XLImageView.h"
#import "XLDrawHelper.h"
#import "XLResourceManager.h"


@implementation XLImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
    }
    
    return self;
}

+ (instancetype)imageViewWithImageKeyPath:(NSString *)keyPath
{
    XLImageView * imageView = [[[self class] alloc] init];
    [imageView setImage:resGetImage(keyPath)];
    
    return imageView;
}

+ (instancetype)linearGradientImageViewWithSize:(CGSize)size startColor:(UIColor *)startColor endColor:(UIColor *)endColor startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint
{
    XLImageView * imageView = [[[self class] alloc] init];
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, size.width, 0);
    CGPathAddLineToPoint(path, NULL, size.width, size.height);
    CGPathAddLineToPoint(path, NULL, 0, size.height);
    CGPathCloseSubpath(path);
    [XLDrawHelper drawLinearGradient:context path:path startColor:[startColor CGColor] endColor:[endColor CGColor] startPoint:startPoint endPoint:endPoint];
    
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    imageView.image = image;
    CGPathRelease(path);
    
    return imageView;
}

+ (instancetype)linearGradientImageViewWithSize:(CGSize)size startColor:(UIColor *)startColor endColor:(UIColor *)endColor
{
    XLImageView * imageView = [[[self class] alloc] init];
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, size.width, 0);
    CGPathAddLineToPoint(path, NULL, size.width, size.height);
    CGPathAddLineToPoint(path, NULL, 0, size.height);
    CGPathCloseSubpath(path);
    [XLDrawHelper drawLinearGradient:context path:path startColor:[startColor CGColor] endColor:[endColor CGColor]];
    
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    imageView.image = image;
    CGPathRelease(path);
    
    return imageView;
}

@end
