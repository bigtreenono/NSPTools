//
//  TLAttributedViewController.m
//  TLAttributedLabel
//
//  Created by andezhou on 15/7/12.
//  Copyright (c) 2015年 周安德. All rights reserved.
//

#import "TLAttributedViewController.h"
#import "TLWebViewController.h"
#import "TLAttributedLabel.h"
#import "UIView+frameAdjust.h"

NSString *const content = @"[/bg3.jpg] 小明明:\n教育部[/haha]严禁中小学组织、(http://www.sina.com/)要求学生参加有偿补课@张三 教育部日[/haha]前印发了《严禁中小学校和在职中小www.baidu.com学教师有偿补课的规定》,@李四 严禁中小学校[/haha]组织Www.baidu.com要求学生参加有 #开心时刻# Https://www.baidu.com/s?cl=3&tn=baidutop10&fr=top1000&wd=%E5%AD%A6%E7%94%9F%E5%90%88%E5%94%B1%E8%87%B4%E8%88%9E%E5%8F%B0%E5%9D%8D%E5%A1%8C&rsv_idx=2 我的电话：15611450210";
@interface TLAttributedViewController () <TLAttributedLabelDelegate>

@end

@implementation TLAttributedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    TLAttributedLabel *displayText = [[TLAttributedLabel alloc] initWithFrame:self.view.bounds];
    displayText.backgroundColor = [UIColor whiteColor];
    displayText.delegate = self;
    [self.view addSubview:displayText];
    
    // 直接赋值
    TLAttributeConfig *config = [[TLAttributeConfig alloc] init];
    config.textColor = [UIColor blackColor];
    config.width = displayText.width;
    
    TLCoreTextData *data = [TLFrameParser parseContent:content config:config link:@[@"小明明"]];
    displayText.data = data;
    displayText.height = data.height;
    
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
}/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
