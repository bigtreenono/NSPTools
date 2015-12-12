//
//  NSTimer+HelpMe.h
//  TestTimer
//
//  Created by FNNishipu on 7/23/15.
//  Copyright (c) 2015 FNNishipu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (HelpMe)

+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)timeInterval repeats:(BOOL)repeats callBackBlock:(void (^)())callBackBlock;

+ (NSTimer *)timerWithTimeInterval:(NSTimeInterval)timeInterval repeats:(BOOL)repeats callBackBlock:(void (^)())callBackBlock;

@end