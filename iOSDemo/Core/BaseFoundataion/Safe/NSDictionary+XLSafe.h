//
//  NSDictionary+XLSafe.h
//  Coinbon
//
//  Created by AlexSiu on 2018/6/23.
//  Copyright © 2018年 CoinSea. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (XLSafe)
- (NSString *)xlsafe_stringValueForKey:(NSString *)key;
- (NSArray *)xlsafe_arrayValueForKey:(NSString *)key;
- (NSDictionary *)xlsafe_dictionaryValueForKey:(NSString *)key;
- (NSNumber *)xlsafe_numberValueForKey:(NSString*)key;

- (BOOL)xlsafe_boolValueForKey:(NSString *)key;
- (double)xlsafe_doubleValueForKey:(NSString *)key;
- (NSInteger)xlsafe_integerValueForKey:(NSString *)key;
- (long long)xlsafe_longlongValueForKey:(NSString *)key;
- (int)xlsafe_intValueForKey:(NSString *)key;
- (NSDecimalNumber *)xlsafe_decimalNumberForKey:(NSString *)key;

@end

@interface NSMutableDictionary (XLSafe)
- (void)xlsafe_setObject:(id)anObject forKey:(id<NSCopying>)aKey;
@end
