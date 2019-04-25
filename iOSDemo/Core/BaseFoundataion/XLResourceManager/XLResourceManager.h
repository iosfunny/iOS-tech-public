//
//  XLResourceManager.h
//  Coinbon
//
//  Created by AlexSiu on 2018/6/11.
//  Copyright © 2018年 CoinSea. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XLResourceManager : NSObject
+ (instancetype)sharedInstance;
- (NSString *)sandboxDirPath:(NSSearchPathDirectory)pathDirectory;
- (UIImage *)imageWithKeyPath:(NSString *)keyPath;
- (NSString *)resourcePath;

UIImage * resGetImage(NSString * keyPath);

@end
