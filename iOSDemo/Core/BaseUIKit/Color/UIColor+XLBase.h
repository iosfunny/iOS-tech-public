//
//  UIColor+XLBase.h
//  Coinbon
//
//  Created by AlexSiu on 2018/6/13.
//  Copyright © 2018年 CoinSea. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (XLBase)

+ (UIColor *)xl_defualtButtonColor;
+ (UIColor*)xl_hexColor:(NSString*)hexColor;

/**
 *  主色调 渐变
 */
+ (UIColor *)xl_mainFromColor;
+ (UIColor *)xl_mainToColor;

/**
 *  背景颜色
 *  用于界面背景、水槽
 */
+ (UIColor *)xl_defaultBGColor;

/**
 * 辅助颜色
 * 用于价格颜色、选中文字、提示文字、幽灵按钮
 */
+ (UIColor *)em_selectedColor;

/**
 *  字体颜色
 *  用于标题、一级文字、内容文字
 */
+ (UIColor *)em_textNormalColor;

/**
 *  字体颜色
 *  用于按钮上的文字、深色背景下的文字颜色
 */
+ (UIColor *)em_textWhiteColor;

/**
 *  字体颜色
 *  用于部分一级文字
 */
+ (UIColor *)em_textLevel1Color;

/**
 *  字体颜色
 *  用于部分二级文字
 */
+ (UIColor *)em_textLevel2Color;

/**
 *  字体颜色
 *  引导输入文字
 */
+ (UIColor *)em_textGuideColor;

/**
 *  g分割线颜色
 */
+ (UIColor *)em_lineColor;

@end
