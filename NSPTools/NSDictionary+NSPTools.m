//
//  NSDictionary+NSPTools.m
//  Demo
//
//  Created by Jeff on 12/12/15.
//  Copyright © 2015 FNNishipu. All rights reserved.
//

#import "NSDictionary+NSPTools.h"

@implementation NSDictionary (NSPTools)

+ (instancetype)safeDictionaryWithObject:(id)object forKey:(id<NSCopying>)key
{
    if (!key || !object)
    {
        return nil;
    }
    return [self dictionaryWithObject:object forKey:key];
}

- (NSString *)safeStringForKey:(id)aKey
{
    NSString *value = [self objectForKey:aKey];
    if (value && ![value isKindOfClass:[NSNull class]])
    {
        if ([value isKindOfClass:[NSString class]])
        {
            return value;
        }
        else if ([value isKindOfClass:[NSNumber class]])
        {
            return [NSString stringWithFormat:@"%@",value];
        }
        return nil;
    }
    return nil;
}

- (NSNumber *)safeNumberForKey:(id)aKey
{
    NSNumber *value = [self objectForKey:aKey];
    if (value && ![value isKindOfClass:[NSNull class]])
    {
        if ([value isKindOfClass:[NSNumber class]])
        {
            return value;
        }
        else if ([value respondsToSelector:@selector(doubleValue)])
        {
            return [NSNumber numberWithDouble:[value doubleValue]];
        }
        return nil;
    }
    return nil;
}

- (NSInteger)safeIntegerForKey:(id)aKey
{
    NSString *value = [self objectForKey:aKey];
    if (value && [value respondsToSelector:@selector(integerValue)])
    {
        return [value integerValue];
    }
    return 0;
}

- (BOOL)safeBoolForKey:(id)aKey
{
    NSString *value = [self objectForKey:aKey];
    if (value && [value respondsToSelector:@selector(boolValue)])
    {
        return [value boolValue];
    }
    return NO;
}

@end





























