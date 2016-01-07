//
//  MyObject.h
//  GenericType
//
//  Created by Jeff on 1/3/16.
//  Copyright © 2016 FNNishipu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyObject <__covariant T> : NSObject

@property (nonatomic, strong) T obj;

@end
