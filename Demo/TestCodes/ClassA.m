//
//  ClassA.m
//  Demo
//
//  Created by FNNishipu on 11/4/15.
//  Copyright © 2015 FNNishipu. All rights reserved.
//

#import "ClassA.h"

@interface ClassA ()
@property (nonatomic, copy) NSString *test2;

@end

@implementation ClassA
{
    NSString *_test2;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _test2 = @"test2";
//        self.delegateString = @"delegateString";
    }
    return self;
}

- (NSString *)test2
{
    return _test2;
}

- (void)setTest2:(NSString *)test2
{
    _test2 = [test2 copy];
}

- (id)methodA
{
    NSLog(@"111");

    return self;
}

- (instancetype)methodB
{
    return self;
}

- (id)copyWithZone:(NSZone *)zone
{
    return nil;
}

@end
