//
//  UIImage+XLQuick.m
//  Coinbon
//
//  Created by AlexSiu on 2018/6/11.
//  Copyright © 2018年 CoinSea. All rights reserved.
//

#import "UIImage+XLQuick.h"
#import "UIColor+XLBase.h"

@implementation UIImage (XLQuick)

+ (UIImage *)sharedPlaceholderImage
{
    static UIImage * g_placeholderImage = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        g_placeholderImage = [UIImage colorImageWithColor:[UIColor xl_defaultBGColor]];
    });
    
    return g_placeholderImage;
}

+ (UIImage *)sharedEmptyImage
{
    return [[UIImage alloc] init];
}

+ (UIImage *)colorImageWithColor:(UIColor *)color
{
    UIGraphicsBeginImageContext(CGSizeMake(1, 1));
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, CGRectMake(0, 0, 1, 1));
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)colorRoundImageWithColor:(UIColor *)color size:(CGFloat)size
{
    CGFloat relSize = [UIScreen mainScreen].scale * size;
    UIGraphicsBeginImageContext(CGSizeMake(relSize, relSize));
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddArc(context, relSize / 2, relSize / 2, relSize / 2, 0, M_PI * 2, 1);
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillPath(context);
    
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)qrCodeImageWithText:(NSString *)text size:(CGFloat)size
{
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setDefaults];
    NSData * data = [text dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    [filter setValue:data forKeyPath:@"inputMessage"];
    CIImage * coreImage = [filter outputImage];
    UIImage * image = [self createNonInterpolatedUIImageFormCIImage:coreImage withSize:size];
    
    return image;
}

/**
 *  根据CIImage生成指定大小的UIImage
 *
 *  @param image CIImage
 *  @param size  图片宽度
 */
+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat)size
{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CGColorSpaceRelease(cs);
    
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    UIImage * resultImage = [UIImage imageWithCGImage:scaledImage];
    CGImageRelease(scaledImage);
    
    return resultImage;
}

@end
