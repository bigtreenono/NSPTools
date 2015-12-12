//
//  SecondViewController.m
//  Demo
//
//  Created by FNNishipu on 11/8/15.
//  Copyright © 2015 FNNishipu. All rights reserved.
//

#import "SecondViewController.h"
#import "NSPStickyHeaderView.h"
#import "NSPStickyFooterView.h"

@interface SecondViewController () <UIWebViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SecondViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.navigationController.navigationBarHidden = YES;
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]]];

    NSPStickyFooterView *footerView = [[NSPStickyFooterView alloc] initWithFrame:CGRectMake(0, 0, 0, 44)];
//    footerView.layer.zPosition = 1;
    
    UILabel *label = [[UILabel alloc] initWithFrame:footerView.bounds];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"This is a footer";
    label.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [footerView addSubview:label];
    
    [self.tableView addSubview:footerView];

//    NSPStickyHeaderView *headerView = [[NSPStickyHeaderView alloc] initWithMinimunHeight:150];
//    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"preview"]];
//    imageView.frame = headerView.bounds;
//    imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//    [headerView addSubview:imageView];
//    [_tableView addSubview:headerView];
}

#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuse = @"reuse";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"section %zd, row %zd", indexPath.section, indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSString *js = @"document.getElementsByTagName('footer')[0].remove();";
    [webView stringByEvaluatingJavaScriptFromString:js];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
