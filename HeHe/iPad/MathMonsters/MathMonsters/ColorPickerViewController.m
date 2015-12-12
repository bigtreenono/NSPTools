//
//  ColorPickerViewController.m
//  MathMonsters
//
//  Created by FNNishipu on 8/17/15.
//  Copyright (c) 2015 FNNishipu. All rights reserved.
//

#import "ColorPickerViewController.h"

@interface ColorPickerViewController ()

@end

@implementation ColorPickerViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    if ([super initWithStyle:style] != nil)
    {
        // Initialize the array
        _colorNames = [NSMutableArray array];
        
        //Set up the array of colors.
        [_colorNames addObject:@"Red"];
        [_colorNames addObject:@"Green"];
        [_colorNames addObject:@"Blue Delightful Sky Blue"];
        
        //Make row selections persist.
        self.clearsSelectionOnViewWillAppear = NO;
        
        //Calculate how tall the view should be by multiplying
        //the individual row height by the total number of rows.
        NSInteger rowsCount = [_colorNames count];
        CGFloat totalRowsHeight = rowsCount * 44;

        //Calculate how wide the view should be by finding how
        //wide each string is expected to be
        CGFloat largestLabelWidth = 0;
        for (NSString *colorName in _colorNames)
        {
            // Checks size of text using the default font for UITableViewCell's textLabel.
            CGSize labelSize = [colorName sizeWithFont:[UIFont boldSystemFontOfSize:20.0f]];
            if (labelSize.width > largestLabelWidth)
            {
                largestLabelWidth = labelSize.width;
            }
        }
        
        //Set the property to tell the popover container how big this view will be.
        self.preferredContentSize = CGSizeMake(largestLabelWidth, totalRowsHeight);
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_colorNames count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    cell.textLabel.text = [_colorNames objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *selectedColorName = [_colorNames objectAtIndex:indexPath.row];
    
    //Create a variable to hold the color, making its default
    //color something annoying and obvious so you can see if
    //you've missed a case here.
    UIColor *color = [UIColor orangeColor];
    
    //Set the color object based on the selected color name.
    if ([selectedColorName isEqualToString:@"Red"]) {
        color = [UIColor redColor];
    } else if ([selectedColorName isEqualToString:@"Green"]){
        color = [UIColor greenColor];
    } else if ([selectedColorName isEqualToString:@"Blue"]) {
        color = [UIColor blueColor];
    }
    
    //Notify the delegate if it exists.
    if (_delegate)
    {
        [_delegate selectedColor:color];
    }
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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
