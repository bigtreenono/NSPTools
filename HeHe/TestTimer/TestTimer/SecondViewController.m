//
//  SecondViewController.m
//  TestTimer
//
//  Created by FNNishipu on 7/23/15.
//  Copyright (c) 2015 FNNishipu. All rights reserved.
//

#import "SecondViewController.h"
#import "NSTimer+HelpMe.h"

@interface SecondViewController ()
{
    NSTimer *_timer;
}
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    _timer = [NSTimer timerWithTimeInterval:2 repeats:YES callBackBlock:^{
//        NSLog(@"222222222222");
//    }];
//    [_timer fire];

    
    // Do any additional setup after loading the view from its nib.
}

- (void)timerAction
{
    NSLog(@"22222222222");
}

- (void)dealloc
{
    [_timer invalidate];
    NSLog(@"dealloc dealloc dealloc dealloc dealloc");
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
