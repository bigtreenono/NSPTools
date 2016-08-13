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
#import "UIAlertView+Blocks.h"
#import "UIActionSheet+Blocks.h"

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
@property (nonatomic, strong) UIWindow *customWindow;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    _leftButton.touchExtendInset = UIEdgeInsetsMake(-20, -20, -20, -20);
    
    

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notification:) name:@"test" object:nil];
}

- (void)notification:(NSNotification *)notify {
    NSLog(@"44444444444444444444444444444444444444444444444444444444444444444444444444444");
}

- (void)performSelectorOnceAfterDelay:(NSTimeInterval)delay block:(void (^)())block {
    NSLog(@"xixi %@", block);
//    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(jc_performBlock:) object:block];
    [self performSelector:@selector(jc_performBlock:) withObject:block afterDelay:delay];
}

- (void)jc_performBlock:(void (^)())block {
    block();
}

- (IBAction)test:(id)sender {
    
}

//- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
//    return UIInterfaceOrientationMaskAllButUpsideDown;
//}

- (IBAction)action:(id)sender
{
    __weak typeof(self) weakSelf = self;
    
//    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(test2) object:nil];
//    [self performSelector:@selector(test2) withObject:nil afterDelay:2];
    
    void (^xixi)() = ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"test" object:weakSelf];
    };
    
    NSLog(@"xixi %@", xixi);

    [self performSelectorOnceAfterDelay:2 block:xixi];
}

- (void)test2 {
    NSLog(@"3333333333333333333333333333333333333333333333333333333333333333333333333333333333 self %@", self);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end











































