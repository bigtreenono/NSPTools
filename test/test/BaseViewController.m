//
//  BaseViewController.m
//  test
//
//  Created by Jeff on 7/24/16.
//  Copyright © 2016 Jeff. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (BOOL)shouldAutorotate {
//    NSLog(@"111");
//    return NO;
//}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    NSLog(@"BaseViewController supportedInterfaceOrientations");
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotate
{
    NSLog(@"BaseViewController shouldAutorotate");

    return NO;
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
