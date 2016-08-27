//
//  Sark.m
//  1318
//
//  Created by Jeff on 8/14/16.
//  Copyright © 2016 Jeff. All rights reserved.
//

#import "Sark.h"
#import <YYKit/NSObject+YYModel.h>

@implementation Sark

- (NSString *)description {
    return [self modelDescription];
}

- (void)test {
    [_mutableArray addObject:@2];
    NSLog(@"_mutableArray %@, %p", _mutableArray, _mutableArray);
}

- (void)set:(NSMutableArray *)arr {
    _mutableArray = arr;
}

@end
