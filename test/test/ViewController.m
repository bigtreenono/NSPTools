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
    
    uint32_t a = 0x12345678;
    NSLog(@"%@", [NSData dataWithBytes:&a length:sizeof(uint32_t)]);

    
    typedef struct {
        uint64_t a;
        uint8_t  b;
        uint32_t c;
        uint8_t  d;
        uint16_t e;
    } TestStruct;
    
    TestStruct test = {1, 2, 3, 4, 5};
    NSUInteger length = sizeof(TestStruct);
    NSLog(@"%ld %@", length, [NSData dataWithBytes:&test length:length]);

}

- (void)performSelectorOnceAfterDelay:(NSTimeInterval)delay block:(void (^)())block {
    NSLog(@"self %p", self);
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
    [self performSelectorOnceAfterDelay:2 block:^{
        NSLog(@"22222222222222222222222222222222222222222222222222222222222222 weakSelf %p", weakSelf);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end











































