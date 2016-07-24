//
//  ViewController.m
//  test
//
//  Created by Jeff on 5/14/16.
//  Copyright © 2016 Jeff. All rights reserved.
//

#import "ViewController.h"
#import "UIView+FDCollapsibleConstraints.h"
#import <FBKVOController.h>
#import "TestView.h"
#import <YYKit/YYCache.h>
#import "TestViewController.h"
#import "SarkViewController.h"
#import "UIView+ExtendTouchRect.h"
#import "MyButton.h"
#import "SubClass.h"

@interface ViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet MyButton *leftButton;
@property (weak, nonatomic) IBOutlet UIView *testView;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicatorView;
@property (nonatomic, strong) FBKVOController *kvoController;
@property (nonatomic, copy) NSString *str;
@property (nonatomic, strong) NSMutableArray *arr;
@property (nonatomic, strong) dispatch_queue_t dynaSerialQueue;
@property (nonatomic, strong) TestView *viewa;
@property (nonatomic, strong) NSDictionary<NSNumber *, NSString *> *technicalIndicatorInfo;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _leftButton.touchExtendInset = UIEdgeInsetsMake(-20, -20, -20, -20);
    
    CGRect rect2 = CGRectMake(10, -10, 100, 200);
    CGRect rect3 = CGRectMake(-30, 30, 100, 200);
//    CGRect rect1 = CGRectMake(0, 0, 100, 200);
//    CGRect rect1 = CGRectMake(0, 0, 100, 200);
    NSLog(@"%f, %f", CGRectGetMaxX(rect3), CGRectGetMaxY(rect2));
}

//- (BOOL)shouldAutorotate {
//    NSLog(@"2222");
//
//    return YES;
//}

- (IBAction)test:(id)sender {
    [[SubClass new] test];
}

//- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
//    return UIInterfaceOrientationMaskAllButUpsideDown;
//}

- (IBAction)action:(id)sender
{
    NSLog(@"22222222222222222222222222222222222222222222222222222222222222");
    
    [[UIDevice currentDevice] setValue:UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation) ? @(UIInterfaceOrientationPortrait) : @(UIInterfaceOrientationLandscapeRight) forKey:@"orientation"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end











































