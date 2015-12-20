//
//  SecondViewController.m
//  Demo
//
//  Created by FNNishipu on 11/8/15.
//  Copyright © 2015 FNNishipu. All rights reserved.
//

#import "SecondViewController.h"
#import "extobjc.h"

@interface SecondViewController () <UIWebViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, copy) NSString *testString;
@property (nonatomic, copy) void (^TextBlock)(void);

@end

@implementation SecondViewController

- (void)dealloc
{
    NSLog(@"%@ dealloc dealloc dealloc dealloc dealloc", self.class);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    __weak typeof(self) weakSelf = self;
    __strong typeof(weakSelf) strongSelf = weakSelf;
    _TextBlock = ^{
        strongSelf.testString = @"hehe";
    };
    
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
