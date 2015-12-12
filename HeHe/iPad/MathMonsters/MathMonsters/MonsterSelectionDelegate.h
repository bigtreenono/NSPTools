//
//  MonsterSelectionDelegate.h
//  MathMonsters
//
//  Created by FNNishipu on 8/17/15.
//  Copyright (c) 2015 FNNishipu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Monster;

@protocol MonsterSelectionDelegate <NSObject>

@required
- (void)selectedMonster:(Monster *)newMonster;

@end
