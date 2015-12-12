//
//  WeaponSelectorImageView.h
//  MathMonsters
//
//  Created by FNNishipu on 8/17/15.
//  Copyright (c) 2015 FNNishipu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeaponInputViewController.h" //Has Input delegate as well.

@class Weapon;

@protocol WeaponSelectorDelegate <NSObject>
-(void)selectedWeapon:(Weapon *)weapon;
@end

@interface WeaponSelectorImageView : UIImageView <WeaponInputDelegate>

@property (nonatomic, strong) Weapon *weapon;
@property (nonatomic, strong) WeaponInputViewController *weaponInputController;
@property (nonatomic, strong) IBOutlet id<WeaponSelectorDelegate> delegate;

@end
