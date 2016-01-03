//
//  ClassA.h
//  Demo
//
//  Created by FNNishipu on 11/4/15.
//  Copyright © 2015 FNNishipu. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ClassADelegate <NSObject>

@property (nonatomic, copy) NSString *delegateString;

@end

@interface ClassA : NSObject <NSCopying>//, ClassADelegate>

@property (nonatomic, copy) NSString *age;
@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSString *money;

@property (nonatomic, retain) NSString *test;


- (id)methodA;
- (instancetype)methodB;

@end
