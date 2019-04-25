//
//  NSDictionary+XLSafe.m
//  Coinbon
//
//  Created by AlexSiu on 2018/6/23.
//  Copyright © 2018年 CoinSea. All rights reserved.
//

#import "NSDictionary+XLSafe.h"

@implementation NSDictionary (XLSafe)

- (id)dataForKey:(NSString *)key
{
    return key ? [self objectForKey:key] : nil;
}

- (id)dataForKey:(NSString *)key dataClass:(Class)dataClass
{
    id data = [self dataForKey:key];
    assert((data == nil || [data isKindOfClass:dataClass] || [data isKindOfClass:[NSNull class]]));
    return [data isKindOfClass:dataClass] ? data : nil;
}

- (NSString *)xlsafe_stringValueForKey:(NSString *)key
{
    return [self dataForKey:key dataClass:[NSString class]];
}

- (NSArray *)xlsafe_arrayValueForKey:(NSString *)key
{
    return [self dataForKey:key dataClass:[NSArray class]];
}

- (NSDictionary *)xlsafe_dictionaryValueForKey:(NSString *)key
{
    return [self dataForKey:key dataClass:[NSDictionary class]];
}

- (NSNumber *)xlsafe_numberValueForKey:(NSString*)key
{
    return [self dataForKey:key dataClass:[NSNumber class]];
}

- (int)xlsafe_intValueForKey:(NSString *)key
{
    id data = [self dataForKey:key];
    assert(data == nil || [data respondsToSelector:@selector(intValue)] || [data isKindOfClass:[NSNull class]]);
    if ([data respondsToSelector:@selector(intValue)])
    {
        return [data intValue];
    }
    
    return 0;
}

- (NSInteger)xlsafe_integerValueForKey:(NSString *)key
{
    id data = [self dataForKey:key];
    assert(data == nil || [data respondsToSelector:@selector(integerValue)] || [data isKindOfClass:[NSNull class]]);
    if ([data respondsToSelector:@selector(integerValue)])
    {
        return [data integerValue];
    }
    
    return 0;
}

- (NSDecimalNumber *)xlsafe_decimalNumberForKey:(NSString *)key
{
    id data = [self dataForKey:key];
    assert(data == nil || [data isKindOfClass:[NSString class]] || [data isKindOfClass:[NSNumber class]] || [data isKindOfClass:[NSNull class]]);
    if ([data isKindOfClass:[NSString class]] || [data isKindOfClass:[NSNumber class]])
    {
        return [NSDecimalNumber decimalNumberWithString:[data description]];
    }
    
    return nil;
}

- (long long)xlsafe_longlongValueForKey:(NSString *)key
{
    id data = [self dataForKey:key];
    assert(data == nil || [data respondsToSelector:@selector(longLongValue)] || [data isKindOfClass:[NSNull class]]);
    if ([data respondsToSelector:@selector(longLongValue)])
    {
        return [data longLongValue];
    }
    
    return 0;
}

- (double)xlsafe_doubleValueForKey:(NSString *)key
{
    id data = [self dataForKey:key];
    assert(data == nil || [data respondsToSelector:@selector(doubleValue)] || [data isKindOfClass:[NSNull class]]);
    if ([data respondsToSelector:@selector(doubleValue)])
    {
        return [data doubleValue];
    }
    
    return 0.f;
}

- (BOOL)xlsafe_boolValueForKey:(NSString *)key
{
    id data = [self dataForKey:key];
    assert(data == nil || [data respondsToSelector:@selector(boolValue)] || [data isKindOfClass:[NSNull class]]);
    if ([data respondsToSelector:@selector(boolValue)])
    {
        return [data boolValue];
    }
    
    return NO;
}

@end


@implementation NSMutableDictionary (XLSafe)

- (void)xlsafe_setObject:(id)anObject forKey:(id<NSCopying>)aKey
{
    if (anObject)
    {
        [self setObject:anObject forKey:aKey];
    }
}

@end
