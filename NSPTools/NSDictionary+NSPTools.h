//
//  NSDictionary+NSPTools.h
//  Demo
//
//  Created by Jeff on 12/12/15.
//  Copyright © 2015 FNNishipu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (NSPTools)

+ (instancetype)safeDictionaryWithObject:(id)object forKey:(id<NSCopying>)key;

- (NSString *)safeStringForKey:(id)akey;

- (NSNumber *)safeNumberForKey:(id)aKey;

- (NSInteger)safeIntegerForKey:(id)aKey;

- (BOOL)safeBoolForKey:(id)aKey;

@end
