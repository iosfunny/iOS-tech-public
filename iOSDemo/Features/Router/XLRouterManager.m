//
//  CBRouterManager.m
//  UnicornPay
//
//  Created by AlexSiu on 2018/6/22.
//  Copyright © 2018年 CoinSea. All rights reserved.
//

#import "XLRouterManager.h"

NSString * const CBMainPageDidFinishLoadAndFirstAppearNotification = @"CBMainPageDidFinishLoadAndFirstAppearNotification";

NSString * const CBRouterCommonParamsKey = @"commonParams";
NSString * const CBRouterCommonParamsFromKey = @"from";
NSString * const CBRouterCommonParamsTitleKey = @"title";
NSString * const CBRouterNavigationControllerKey = @"CBRouterNavigationControllerKey";

NSString * const CBAccountNeedToReRequestUserInfoNotification = @"CBAccountNeedToReRequestUserInfoNotification";

NSString * const CBRouterShareParamsTypeKey = @"shareType";

@interface CBRouterTaskInfo : NSObject
@property (nonatomic, copy) NSString * bizUrlStr;
@property (nonatomic, strong) NSDictionary * userInfo;
@end

@implementation CBRouterTaskInfo
+ (instancetype)taskInfoWithBizUrlStr:(NSString *)bizUrlStr userInfo:(NSDictionary *)userInfo
{
    CBRouterTaskInfo * task = [[self alloc] init];
    task.bizUrlStr = bizUrlStr;
    task.userInfo = userInfo;
    
    return task;
}
@end


@interface XLRouterManager ()
@property (nonatomic, strong) NSMutableArray<id<XLRouterProtocol>> * bizRouters;
@property (nonatomic, strong) CBRouterTaskInfo * delayExternTaskInfo;
@property (nonatomic, assign) BOOL isFinishStartProcess;
@end

@implementation XLRouterManager

+ (instancetype)sharedRouter
{
    static XLRouterManager * g_router;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        g_router = [[[self class] alloc] init];
    });
    
    return g_router;
}

- (NSMutableArray<id<XLRouterProtocol>> *)bizRouters
{
    if (!_bizRouters)
    {
        _bizRouters = [NSMutableArray array];
    }
    
    return _bizRouters;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidFinishLaunchingAndMainPageFirstAppear:) name:CBMainPageDidFinishLoadAndFirstAppearNotification object:nil];
    }
    
    return self;
}

#pragma mark - Notification

- (void)appDidFinishLaunchingAndMainPageFirstAppear:(NSNotification *)notification
{
    // 这里只处理正常情况，异常情况不处理
    assert(!_isFinishStartProcess);
    if (!_isFinishStartProcess)
    {
        _isFinishStartProcess = YES;
        
        
        if (_delayExternTaskInfo)
        {
            NSString * host = _delayExternTaskInfo.bizUrlStr;
            NSDictionary * userInfo = _delayExternTaskInfo.userInfo;
            _delayExternTaskInfo = nil;
            [self externOpenBizWhihPath:host userInfo:userInfo];
        }
    }
}

#pragma mark - register sub router

- (void)registerSubBizRouter:(id<XLRouterProtocol>)subBizRouter
{
    if (!subBizRouter || [self.bizRouters containsObject:subBizRouter]) return;
    [self.bizRouters addObject:subBizRouter];
}

- (void)unregisterSubBizRouter:(id<XLRouterProtocol>)subBizRouter
{
    if (!subBizRouter) return;
    [self.bizRouters removeObject:subBizRouter];
}

#pragma mark - public method

- (void)externOpenBizWhihPath:(NSString *)path userInfo:(NSDictionary *)userInfo
{
    if (path.length == 0) return;
    
    // 需要基础服务启动完成之后才能支持，首屏展示完毕之后再做跳转
    if (!_isFinishStartProcess)
    {
        _delayExternTaskInfo = [CBRouterTaskInfo taskInfoWithBizUrlStr:path userInfo:userInfo];
        return;
    }
    
    [self.bizRouters enumerateObjectsUsingBlock:^(id<XLRouterProtocol>  _Nonnull router, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([router respondsToSelector:@selector(hanldeExternOpenPath:userInfo:)])
        {
            BOOL handleResult = [router hanldeExternOpenPath:path userInfo:userInfo];
            if (handleResult) *stop = YES;
        }
    }];
}

- (void)openBiz:(NSString *)bizStr userInfo:(NSDictionary *)userInfo
{
    if (bizStr.length == 0) return;
    NSURL * bizUrl = [NSURL URLWithString:bizStr];
    if (!bizUrl) return;
    
    [self.bizRouters enumerateObjectsUsingBlock:^(id<XLRouterProtocol>  _Nonnull router, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([router openBiz:bizUrl userInfo:userInfo]) *stop = YES;
    }];
}

- (NSDictionary *)commonParamsWithFrom:(NSString *)from
{
    NSMutableDictionary * commonParams = [NSMutableDictionary dictionary];
    [commonParams xlsafe_setObject:from forKey:CBRouterCommonParamsFromKey];
    
    return [NSDictionary dictionaryWithDictionary:commonParams];
}

@end
