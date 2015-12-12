//
//  ColorPickerViewController.h
//  MathMonsters
//
//  Created by FNNishipu on 8/17/15.
//  Copyright (c) 2015 FNNishipu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ColorPickerDelegate <NSObject>

@required

-(void)selectedColor:(UIColor *)newColor;

@end

@interface ColorPickerViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray *colorNames;
@property (nonatomic, weak) id<ColorPickerDelegate> delegate;

@end
