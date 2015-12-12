//
//  Monster.h
//  MathMonsters
//
//  Created by FNNishipu on 8/17/15.
//  Copyright (c) 2015 FNNishipu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Weapon;
@interface Monster : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *adescription;
@property (nonatomic, strong) NSString *iconName;
@property (nonatomic, strong) Weapon *weapon;

//Factory class method to create new monsters
+(Monster *)newMonsterWithName:(NSString *)name description:(NSString *)description
                      iconName:(NSString *)iconName weapon:(Weapon *)weapon;


@end
