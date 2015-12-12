//
//  LeftViewController.h
//  MathMonsters
//
//  Created by FNNishipu on 8/17/15.
//  Copyright (c) 2015 FNNishipu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MonsterSelectionDelegate.h"

@interface LeftViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray *monsters;
@property (nonatomic, assign) id<MonsterSelectionDelegate> delegate;

@end
