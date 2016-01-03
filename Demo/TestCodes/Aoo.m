//
//  Aoo.m
//  Demo
//
//  Created by Jeff on 12/31/15.
//  Copyright © 2015 FNNishipu. All rights reserved.
//

#import "Aoo.h"

@implementation Aoo

@synthesize name = _name;

- (instancetype)init
{
    self = [super init];
    if (self) {
        _name = @"test";
    }
    return self;
}

//- (NSString *)name
//{
//    return self.name;
//}

- (void)setName:(NSString *)name
{
    NSLog(@"name %@", name);
}

@end
