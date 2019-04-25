//
//  UIColor+XLBase.m
//  Coinbon
//
//  Created by AlexSiu on 2018/6/13.
//  Copyright © 2018年 CoinSea. All rights reserved.
//

#import "UIColor+XLBase.h"

@implementation UIColor (XLBase)

+ (UIColor *)xl_defualtButtonColor
{
    return [UIColor colorWithRed:79.0 / 255.0 green:133.0 / 255.0 blue:250.0 / 255.0 alpha:1/1.0];
}

+ (UIColor*)xl_hexColor:(NSString*)hexColor
{
    unsigned int red, green, blue, alpha;
    NSRange range;
    range.length = 2;
    @try {
        if ([hexColor hasPrefix:@"#"])
        {
            hexColor = [hexColor stringByReplacingOccurrencesOfString:@"#" withString:@""];
        }
        range.location = 0;
        [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&red];
        range.location = 2;
        [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&green];
        range.location = 4;
        [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&blue];
        
        if ([hexColor length] > 6) {
            range.location = 6;
            [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&alpha];
        }
        else
        {
            alpha = 255;
        }
    }
    @catch (NSException * e) {
        //        [MAUIToolkit showMessage:[NSString stringWithFormat:@"颜色取值错误:%@,%@", [e name], [e reason]]];
        //        return [UIColor blackColor];
    }
    
    return [UIColor colorWithRed:(float)(red/255.0f) green:(float)(green/255.0f) blue:(float)(blue/255.0f) alpha:(float)(alpha/255.0f)];
}

+ (UIColor *)xl_mainFromColor
{
    return [self xl_hexColor:@"#F5596F"];
}

+ (UIColor *)xl_mainToColor
{
    return [self xl_hexColor:@"#F6AC67"];
}

/**
 *  背景颜色
 *  用于界面背景、水槽
 */
+ (UIColor *)xl_defaultBGColor
{
    return [self xl_hexColor:@"#F7F8FA"];
}

/**
 * 辅助颜色
 * 用于价格颜色、选中文字、提示文字、幽灵按钮
 */
+ (UIColor *)em_selectedColor
{
    return [self xl_hexColor:@"#E75A57"];
}

/**
 *  字体颜色
 *  用于标题、一级文字、内容文字
 */
+ (UIColor *)em_textNormalColor
{
    return [self xl_hexColor:@"#222222"];
}

/**
 *  字体颜色
 *  用于按钮上的文字、深色背景下的文字颜色
 */
+ (UIColor *)em_textWhiteColor
{
    return [self xl_hexColor:@"#FFFFFF"];
}

/**
 *  字体颜色
 *  用于部分一级文字
 */
+ (UIColor *)em_textLevel1Color
{
    return [self xl_hexColor:@"#585858"];
}

/**
 *  字体颜色
 *  用于部分二级文字
 */
+ (UIColor *)em_textLevel2Color
{
    return [self xl_hexColor:@"#E75A57"];
}

/**
 *  字体颜色
 *  引导输入文字
 */
+ (UIColor *)em_textGuideColor
{
    return [self xl_hexColor:@"#D0D0D0"];
}

/**
 *  g分割线颜色
 */
+ (UIColor *)em_lineColor
{
    return [self xl_hexColor:@"#F4F4F4"];
}



@end

