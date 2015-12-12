//
//  TLJSONViewController.m
//  TLAttributedLabel
//
//  Created by andezhou on 15/7/12.
//  Copyright (c) 2015年 周安德. All rights reserved.
//

#import "TLJSONViewController.h"
#import "TLWebViewController.h"
#import "TLAttributedLabel.h"
#import "UIView+frameAdjust.h"

@interface TLJSONViewController () <TLAttributedLabelDelegate>

@end

@implementation TLJSONViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64)];
    [self.view addSubview:scrollView];
    
    TLAttributedLabel *displayText = [[TLAttributedLabel alloc] initWithFrame:self.view.bounds];
    displayText.delegate = self;
    [scrollView addSubview:displayText];
    displayText.backgroundColor = [UIColor whiteColor];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"content" ofType:@"json"];
    
    TLCoreTextData *data = [TLFrameParser parseTemplateFile:path];
    displayText.data = data;
    displayText.height = data.height;
    
    scrollView.contentSize = CGSizeMake(0, data.height + 20);
    // Do any additional setup after loading the view.
}

#pragma mark -
#pragma mark CTDisplayViewDelegate
- (void)attributedLabel:(TLAttributedLabel *)label imageData:(TLAttributedLabelImage *)imageData imageList:(NSArray *)imageList {
    NSString *message = [NSString stringWithFormat:@"您点中第%zi张图片%@", [imageList indexOfObject:imageData] ,imageData.imageName];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alertView show];
}

- (void)attributedLabel:(TLAttributedLabel *)label linkData:(TLAttributedLabelLink *)linkData {
    
    if (linkData.type == kCoreTextLnkDataUrl) {
        TLWebViewController *webVC = [[TLWebViewController alloc] init];
        webVC.url = linkData.url;
        [self.navigationController pushViewController:webVC animated:YES];
    }else{
        NSString *message = [NSString stringWithFormat:@"您点中: %@", linkData.title];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
    }
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
