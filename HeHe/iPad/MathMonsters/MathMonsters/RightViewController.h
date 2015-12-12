//
//  RightViewController.h
//  MathMonsters
//
//  Created by FNNishipu on 8/17/15.
//  Copyright (c) 2015 FNNishipu. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "MonsterSelectionDelegate.h"
#import "ColorPickerViewController.h"
#import "WeaponSelectorImageView.h" //Also has WeaponSelectorDelegate protocol

@class Monster;

@interface RightViewController : UIViewController <MonsterSelectionDelegate, UISplitViewControllerDelegate, ColorPickerDelegate, WeaponSelectorDelegate>

@property (nonatomic, strong) Monster *monster;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *descriptionLabel;
@property (nonatomic, weak) IBOutlet UIImageView *iconImageView;
@property (nonatomic, weak) IBOutlet WeaponSelectorImageView *weaponImageView;
@property (nonatomic, weak) IBOutlet UINavigationItem *navBarItem;
@property (nonatomic, strong) UIPopoverController *popover;
@property (nonatomic, strong) ColorPickerViewController *colorPicker;
@property (nonatomic, strong) UIPopoverController *colorPickerPopover;

-(IBAction)chooseColorButtonTapped:(id)sender;

@end






























