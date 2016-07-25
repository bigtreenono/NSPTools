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
}

//- (BOOL)shouldAutorotate {
//    NSLog(@"ViewController shouldAutorotate");
//    return NO;
//}

- (IBAction)test:(id)sender {
    
}

//- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
//    return UIInterfaceOrientationMaskAllButUpsideDown;
//}

- (IBAction)action:(id)sender
{
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end











































