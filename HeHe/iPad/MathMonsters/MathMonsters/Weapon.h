//
//  Weapon.h
//  MathMonsters
//
//  Created by FNNishipu on 8/17/15.
//  Copyright (c) 2015 FNNishipu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum {
    Blowgun = 0,
    NinjaStar,
    Fire,
    Sword,
    Smoke,
} WeaponType;

@interface Weapon : NSObject

@property (nonatomic, assign) WeaponType weaponType;

//Factory method to make a new weapon object with a particular type.
+(Weapon *)newWeaponOfType:(WeaponType)weaponType;

//Convenience instance method to get the UIImage representing the weapon.
-(UIImage *)weaponImage;

@end
