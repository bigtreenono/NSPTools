//
//  TLTableViewController.m
//  TLAttributedLabel
//
//  Created by andezhou on 15/7/12.
//  Copyright (c) 2015年 周安德. All rights reserved.
//

#import "TLTableViewController.h"

@interface TableObject : NSObject

@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *subTitle;
@property (nonatomic,strong) NSString *vcName;

@end

@implementation TableObject

+ (TableObject *)objectWithTitle:(NSString *)title
                        subTitle:(NSString *)subTitle
                          vcName:(NSString *)vcName
{
    TableObject *object = [[TableObject alloc]init];
    object.title      = title;
    object.subTitle   = subTitle;
    object.vcName     = vcName;
    return object;
}

@end

@interface TLTableViewController ()

@property (strong, nonatomic) NSArray *dataList;

@end

@implementation TLTableViewController

#pragma mark -
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    TableObject *object = [self.dataList objectAtIndex:[indexPath row]];
    cell.textLabel.text = object.title;
    cell.detailTextLabel.text = object.subTitle;
    
    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    TableObject *object = [self.dataList objectAtIndex:[indexPath row]];
    UIViewController *controller = [[NSClassFromString(object.vcName) alloc] init];
    controller.title = object.title;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark -
#pragma mark lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"CoreText";
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.rowHeight = 60;
    
    self.dataList = @[
                      [TableObject objectWithTitle:@"基本使用" subTitle:@"创建一个简单的AttributedString" vcName:@"TLAttributedViewController"],
                      [TableObject objectWithTitle:@"JSON使用" subTitle:@"根据网络获取的数据进行布局" vcName:@"TLJSONViewController"]
                      ];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
