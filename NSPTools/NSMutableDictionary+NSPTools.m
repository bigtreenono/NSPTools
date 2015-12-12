//
//  NSMutableDictionary+NSPTools.m
//  Demo
//
//  Created by Jeff on 12/12/15.
//  Copyright © 2015 FNNishipu. All rights reserved.
//

#import "NSMutableDictionary+NSPTools.h"

@implementation NSMutableDictionary (NSPTools)

- (void)setObjectSafe:(id)anObject forKey:(id<NSCopying>)aKey
{
    if (!aKey || !anObject)
    {
        return;
    }
    return [self setObject:anObject forKey:aKey];
}

@end
