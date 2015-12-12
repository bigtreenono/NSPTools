//
//  CustomView.m
//  Demo
//
//  Created by Jeff on 11/29/15.
//  Copyright © 2015 FNNishipu. All rights reserved.
//

#import "CustomView.h"

@implementation CustomView

- (void)awakeFromNib
{
    NSLog(@"1111111111111111111111111111111111111111111111111111111111111111");
}

- (void)setTestString:(NSString *)testString
{
    _testString = testString;
    NSLog(@"testString %@", testString);
}

- (CGSize)intrinsicContentSize
{
    NSLog(@"22222222222222222222222222222222222222222222222222222222222222");
    return CGSizeMake(100, 100);
}

@end
