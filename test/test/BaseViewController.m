//
//  BaseViewController.m
//  test
//
//  Created by Jeff on 7/24/16.
//  Copyright © 2016 Jeff. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()
@property (nonatomic, assign) BOOL shouldAutorotate;
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

//- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
//    NSLog(@"BaseViewController supportedInterfaceOrientations");
//    return UIInterfaceOrientationMaskPortrait;
//}

- (void)rotateScreen {
    _shouldAutorotate = YES;
    NSLog(@"before 1111111111111111111111111111111111111111111111111111111111111111");
    [[UIDevice currentDevice] setValue:UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation) ? @(UIInterfaceOrientationPortrait) : @(UIInterfaceOrientationLandscapeRight) forKey:@"orientation"];
    
    NSLog(@"after 1111111111111111111111111111111111111111111111111111111111111111");

    _shouldAutorotate = NO;
}

- (BOOL)shouldAutorotate {
    NSLog(@"BaseViewController shouldAutorotate");
    return _shouldAutorotate;
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
