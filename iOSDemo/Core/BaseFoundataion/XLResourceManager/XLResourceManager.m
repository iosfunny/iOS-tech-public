//
//  XLResourceManager.m
//  Coinbon
//
//  Created by AlexSiu on 2018/6/11.
//  Copyright © 2018年 CoinSea. All rights reserved.
//

#import "XLResourceManager.h"
#import "UIColor+XLBase.h"

@interface XLResourceManager ()
@property (nonatomic, strong) NSCache<NSString *, UIImage *> * localImageCache;         //  图片资源缓存
@property (nonatomic, copy) NSString * resourcePath;                                  //  资源母路径
@property (nonatomic, copy) NSString * imagesMainPath;                                //  图片资源主路径
@property (nonatomic, copy) NSString * imageLastPathComponent;                        //  图片资源优先搜索叶子文件夹   @2x @3x
@property (nonatomic, copy) NSString * imageDefaultPathComponent;                     //  图片资源的默认叶子文件夹     @2x

@end

@implementation XLResourceManager

static XLResourceManager * g_instance = nil;
+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        g_instance = [[self alloc] init];
    });
    
    return g_instance;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _imagesMainPath = [self staticImageResourcePath];
        _imageLastPathComponent = [UIScreen mainScreen].scale > 2.0 ? @"@3x" : @"@2x";
        _imageDefaultPathComponent = @"@2x";
    }
    
    return self;
}

#pragma mark - getter

- (NSCache<NSString *,UIImage *> *)localImageCache
{
    if (!_localImageCache)
    {
        _localImageCache = [[NSCache alloc] init];
        _localImageCache.totalCostLimit = 100;
        _localImageCache.countLimit = 100;
    }
    
    return _localImageCache;
}

- (NSString *)resourcePath
{
    if (!_resourcePath)
    {
        NSString * bundlePath = [[NSBundle mainBundle] bundlePath];
        NSString * resourcesPath = [bundlePath stringByAppendingPathComponent:@"xl_resources"];
        _resourcePath = resourcesPath;
    }
    
    return _resourcePath;
}

- (NSString *)staticImageResourcePath
{
    NSString * filePath = [[self resourcePath] stringByAppendingPathComponent:@"images"];
    return filePath;
}


#pragma mark - public

- (UIImage *)imageWithKeyPath:(NSString *)keyPath
{
    return [self imageWithKeyPath:keyPath systemCache:YES];
}

- (UIImage *)imageWithKeyPath:(NSString *)keyPath systemCache:(BOOL)systemCache
{
    UIImage * image = nil;
    do
    {
        image = [self.localImageCache objectForKey:keyPath]; if (image) break;

        NSString * string = [self.imagesMainPath stringByAppendingPathComponent:keyPath];
        NSString * dirPath = [string stringByDeletingLastPathComponent];
        NSString * imageDirPath = [dirPath stringByAppendingPathComponent:_imageLastPathComponent];
        NSString * filePath = [imageDirPath stringByAppendingPathComponent:[string lastPathComponent]];
        image = [UIImage imageWithContentsOfFile:filePath];
        if (image) { [self.localImageCache setObject:image forKey:keyPath]; break; }
        
        imageDirPath = [dirPath stringByAppendingPathComponent:_imageDefaultPathComponent];
        filePath = [imageDirPath stringByAppendingPathComponent:[string lastPathComponent]];
        image = [UIImage imageWithContentsOfFile:filePath];
        if (image) { [self.localImageCache setObject:image forKey:keyPath]; break; }
        image = [UIImage colorImageWithColor:[UIColor xl_defaultBGColor]];
        
    } while (false);
    
    return image;
}

- (NSString *)sandboxDirPath:(NSSearchPathDirectory)pathDirectory
{
    NSArray<NSString *>* pathes = NSSearchPathForDirectoriesInDomains(pathDirectory, NSUserDomainMask, YES);
    return [pathes firstObject];
}

#pragma mark - C Function

UIImage * resGetImage(NSString * keyPath)
{
    return [[XLResourceManager sharedInstance] imageWithKeyPath:keyPath];
}

@end
