//
//  ViewController.m
//  1318
//
//  Created by Jeff on 8/7/16.
//  Copyright © 2016 Jeff. All rights reserved.
//

#import "ViewController.h"
#import "Sark.h"

@interface ViewController ()

@property (nonatomic, strong) NSArray *array;
@property (nonatomic, strong) Sark *sark;

@end

@implementation ViewController

- (void)dealloc {
    NSLog(@"%@ dealloc dealloc dealloc dealloc dealloc", self.class);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _array = @[ @1, @2, @3, @4 ];
    _sark = [Sark new];
    _sark.block = ^(){
//        [self test];
    };
    [_sark.array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self test];
    }];
}

- (void)test {
    NSLog(@"111111111111111111111111111111111111");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
