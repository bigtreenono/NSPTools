//
//  ClassB.m
//  Demo
//
//  Created by FNNishipu on 11/4/15.
//  Copyright © 2015 FNNishipu. All rights reserved.
//

#import "ClassB.h"

@implementation ClassB

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.name = @"name";
    }
    return self;
}

- (id)methodX
{
    return self;
}

@end
