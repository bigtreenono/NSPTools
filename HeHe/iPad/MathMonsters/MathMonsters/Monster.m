//
//  Monster.m
//  MathMonsters
//
//  Created by FNNishipu on 8/17/15.
//  Copyright (c) 2015 FNNishipu. All rights reserved.
//

#import "Monster.h"
#import "Weapon.h"

@implementation Monster

+(Monster *)newMonsterWithName:(NSString *)name description:(NSString *)description
                      iconName:(NSString *)iconName weapon:(Weapon *)weapon
{
    Monster *monster = [[Monster alloc] init];
    monster.name = name;
    monster.adescription = description;
    monster.iconName = iconName;
    monster.weapon = weapon;
    
    return monster;
}

@end




























