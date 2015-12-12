//
//  ViewController.m
//  VVeboTableViewPractise
//
//  Created by FNNishipu on 7/16/15.
//  Copyright (c) 2015 FNNishipu. All rights reserved.
//

#import "ViewController.h"
#import "VVeboTableView.h"

@interface ViewController ()
{
    VVeboTableView *tableView;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    tableView = [[VVeboTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    tableView.scrollIndicatorInsets = tableView.contentInset;
    tableView.contentOffset = CGPointMake(0, -20);
    [self.view addSubview:tableView];
    
    UIToolbar *statusBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
    [self.view addSubview:statusBar];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
