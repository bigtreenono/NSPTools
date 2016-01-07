//
//  MyObject.m
//  GenericType
//
//  Created by Jeff on 1/3/16.
//  Copyright © 2016 FNNishipu. All rights reserved.
//

#import "MyObject.h"

@implementation MyObject

- (void)dealloc
{
    NSLog(@"%@ dealloc dealloc dealloc dealloc dealloc", self.class);
    if (_obj != nil)
    {
        NSLog(@"_obj %@ %@", _obj, [_obj class]);
        [_obj release];
    }
    [super dealloc];
}

@end
