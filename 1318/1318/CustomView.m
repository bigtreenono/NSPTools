//
//  CustomView.m
//  1318
//
//  Created by Jeff on 8/10/16.
//  Copyright © 2016 Jeff. All rights reserved.
//

#import "CustomView.h"

@implementation CustomView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch preciseLocationInView:self];
    NSLog(@"point %@", NSStringFromCGPoint(point));
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch preciseLocationInView:self];
    NSLog(@"point2 %@", NSStringFromCGPoint(point));
}

@end