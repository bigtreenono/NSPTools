//
//  NSMutableDictionary+NSPTools.h
//  Demo
//
//  Created by Jeff on 12/12/15.
//  Copyright © 2015 FNNishipu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (NSPTools)

- (void)setObjectSafe:(id)anObject forKey:(id<NSCopying>)aKey;

@end
