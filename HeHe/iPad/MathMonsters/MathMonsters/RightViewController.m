//
//  RightViewController.m
//  MathMonsters
//
//  Created by FNNishipu on 8/17/15.
//  Copyright (c) 2015 FNNishipu. All rights reserved.
//

#import "RightViewController.h"
#import "Monster.h"
#import "Weapon.h"

@interface RightViewController ()

@end

@implementation RightViewController

- (void)viewDidLoad
{
    [self refreshUI];
    [super viewDidLoad];
}

-(void)setMonster:(Monster *)monster
{
    //Make sure you're not setting up the same monster.
    if (_monster != monster) {
        _monster = monster;
        
        //Update the UI to reflect the new monster on the iPad.
        [self refreshUI];
    }
}

-(void)selectedMonster:(Monster *)newMonster
{
    [self setMonster:newMonster];
    if (_popover != nil) {
        [_popover dismissPopoverAnimated:YES];
    }
}

- (void)selectedWeapon:(Weapon *)weapon
{
    //Check to make sure the weapon is changing.
    if (_monster.weapon != weapon) {
        //Update the weapon
        _monster.weapon = weapon;
    }
}

-(void)refreshUI
{
    _nameLabel.text = _monster.name;
    _iconImageView.image = [UIImage imageNamed:_monster.iconName];
    _descriptionLabel.text = _monster.description;
    
    //Setting the weapon on your custom imageview will automatically set
    //the image.
    _weaponImageView.weapon = _monster.weapon;
}

#pragma mark - UISplitViewDelegate methods
- (void)splitViewController:(UISplitViewController *)svc
    willHideViewController:(UIViewController *)aViewController
         withBarButtonItem:(UIBarButtonItem *)barButtonItem
      forPopoverController:(UIPopoverController *)pc
{
    //Grab a reference to the popover
    self.popover = pc;
    
    //Set the title of the bar button item
    barButtonItem.title = @"Monsters";
    
    //Set the bar button item as the Nav Bar's leftBarButtonItem
//    [_navBarItem setLeftBarButtonItem:barButtonItem animated:YES];
    
    UINavigationItem *navItem = [self navigationItem];
    [navItem setLeftBarButtonItem:barButtonItem animated:YES];
}

- (void)splitViewController:(UISplitViewController *)svc
    willShowViewController:(UIViewController *)aViewController
 invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    //Remove the barButtonItem.
    UINavigationItem *navItem = [self navigationItem];
    [navItem setLeftBarButtonItem:barButtonItem animated:YES];
    
    //Nil out the pointer to the popover.
    _popover = nil;
}

#pragma mark - IBActions
-(IBAction)chooseColorButtonTapped:(id)sender
{
    if (_colorPicker == nil)
    {
        //Create the ColorPickerViewController.
        _colorPicker = [[ColorPickerViewController alloc] initWithStyle:UITableViewStylePlain];
        
        //Set this VC as the delegate.
        _colorPicker.delegate = self;
    }
    
    if (_colorPickerPopover == nil)
    {
        //The color picker popover is not showing. Show it.
        _colorPickerPopover = [[UIPopoverController alloc] initWithContentViewController:_colorPicker];
        [_colorPickerPopover presentPopoverFromBarButtonItem:(UIBarButtonItem *)sender
                                    permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    }
    else
    {
        // The color picker popover is showing. Hide it.
        [_colorPickerPopover dismissPopoverAnimated:YES];
        _colorPickerPopover = nil;
    }
}

#pragma mark - ColorPickerDelegate method
-(void)selectedColor:(UIColor *)newColor
{
    _nameLabel.textColor = newColor;
    
    //Dismiss the popover if it's showing.
    if (_colorPickerPopover)
    {
        [_colorPickerPopover dismissPopoverAnimated:YES];
        _colorPickerPopover = nil;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end




























