//
//  SubClass.m
//  test
//
//  Created by Jeff on 7/21/16.
//  Copyright © 2016 Jeff. All rights reserved.
//

#import "SubClass.h"

@implementation SubClass

- (void)test {
    NSLog(@"in SubClass %@", self);
    [super test];
}

@end
