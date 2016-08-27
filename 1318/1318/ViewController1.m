//
//  ViewController1.m
//  1318
//
//  Created by Jeff on 8/11/16.
//  Copyright © 2016 Jeff. All rights reserved.
//

#import "ViewController1.h"
#import "Sark.h"
#import "JCExtendableButton.h"
#import "ViewController.h"
#import <YYKit/YYKit.h>
#import <Masonry.h>
#import <UIView+FDCollapsibleConstraints.h>

@interface ViewController1 ()

@property (weak, nonatomic) IBOutlet JCExtendableButton *extendableButton;
@property (nonatomic, strong) Sark *sark;
@property (nonatomic, strong) NSMutableArray *array;
@property (nonatomic, strong) dispatch_queue_t dynamicSerialQueue;
@property (nonatomic, assign) BOOL boolValue;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@end

@implementation ViewController1

- (void)viewDidLoad {
    [super viewDidLoad];

//    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"searchIcon"]];
//    imageView.backgroundColor = [UIColor redColor];
//    
//    UIView *rightBarCustomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 70, 44)];
//    rightBarCustomView.backgroundColor = [UIColor lightGrayColor];
//    [rightBarCustomView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
//        NSLog(@"111111111111111111111111111111111111");
//    }]];
//    [rightBarCustomView addSubview:imageView];
//    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.offset(0);
//        make.right.offset(-10);
//    }];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBarCustomView];
    
//    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBarButton];
//    UIBarButtonItem *rightFixSpaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
//    rightFixSpaceItem.width = -15;
//    self.navigationItem.rightBarButtonItems = @[ rightItem, rightFixSpaceItem ];

}

- (void)rightBarButtonTapped {
    NSLog(@"111111111111111111111111111111111111");
}

- (IBAction)buttonClicked:(id)sender {

}

- (IBAction)button2Click:(UIButton *)sender {

}

- (IBAction)button3Click:(UIButton *)sender {
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end





































