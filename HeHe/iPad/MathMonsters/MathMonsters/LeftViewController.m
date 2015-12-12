//
//  LeftViewController.m
//  MathMonsters
//
//  Created by FNNishipu on 8/17/15.
//  Copyright (c) 2015 FNNishipu. All rights reserved.
//

#import "LeftViewController.h"
#import "Monster.h"
#import "Weapon.h"

@interface LeftViewController ()


@end

@implementation LeftViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        //Initialize the array of monsters for display.
        _monsters = [NSMutableArray array];
        
        //Create monster objects then add them to the array.
        [_monsters addObject:[Monster newMonsterWithName:@"Cat-Bot" description:@"MEE-OW"
                                                iconName:@"meetcatbot.png" weapon:[Weapon newWeaponOfType:Sword]]];
        [_monsters addObject:[Monster newMonsterWithName:@"Dog-Bot" description:@"BOW-WOW"
                                                iconName:@"meetdogbot.png" weapon:[Weapon newWeaponOfType:Blowgun]]];
        [_monsters addObject:[Monster newMonsterWithName:@"Explode-Bot" description:@"Tick, tick, BOOM!"
                                                iconName:@"meetexplodebot.png" weapon:[Weapon newWeaponOfType:Smoke]]];
        [_monsters addObject:[Monster newMonsterWithName:@"Fire-Bot" description:@"Will Make You Steamed"
                                                iconName:@"meetfirebot.png" weapon:[Weapon newWeaponOfType:NinjaStar]]];
        [_monsters addObject:[Monster newMonsterWithName:@"Ice-Bot" description:@"Has A Chilling Effect"
                                                iconName:@"meeticebot.png" weapon:[Weapon newWeaponOfType:Fire]]];
        [_monsters addObject:[Monster newMonsterWithName:@"Mini-Tomato-Bot" description:@"Extremely Handsome" 
                                                iconName:@"meetminitomatobot.png" weapon:[Weapon newWeaponOfType:NinjaStar]]];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_monsters count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    Monster *monster = _monsters[indexPath.row];
    cell.textLabel.text = monster.name;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Monster *selectedMonster = [_monsters objectAtIndex:indexPath.row];
    if (_delegate) {
        [_delegate selectedMonster:selectedMonster];
    }
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
