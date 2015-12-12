//
//  NSTimer+HelpMe.m
//  TestTimer
//
//  Created by FNNishipu on 7/23/15.
//  Copyright (c) 2015 FNNishipu. All rights reserved.
//

#import "NSTimer+HelpMe.h"

@implementation NSTimer (HelpMe)

+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)timeInterval repeats:(BOOL)repeats callBackBlock:(void (^)())callBackBlock;
{
    return [self scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(timerAction:) userInfo:[callBackBlock copy] repeats:repeats];
}

+ (NSTimer *)timerWithTimeInterval:(NSTimeInterval)timeInterval repeats:(BOOL)repeats callBackBlock:(void (^)())callBackBlock;
{
    return [self timerWithTimeInterval:timeInterval target:self selector:@selector(timerAction:) userInfo:[callBackBlock copy] repeats:repeats];
}

+ (void)timerAction:(NSTimer *)inTimer;
{
    if ([inTimer userInfo])
    {
        void (^block)() = (void (^)())[inTimer userInfo];
        block();
    }
}

@end
