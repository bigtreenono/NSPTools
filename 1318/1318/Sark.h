//
//  Sark.h
//  1318
//
//  Created by Jeff on 8/14/16.
//  Copyright © 2016 Jeff. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Sark : NSObject

@property (nonatomic, copy) NSString *marketId;
@property (nonatomic, assign) BOOL yesOrNo;
@property (nonatomic, strong) NSArray *array;
@property (nonatomic, copy) dispatch_block_t block;
@property (nonatomic, strong) NSMutableArray *mutableArray;

- (void)test;

- (void)set:(NSMutableArray *)arr;

@end
