//
//  ViewController.m
//  GenericType
//
//  Created by Jeff on 1/3/16.
//  Copyright © 2016 FNNishipu. All rights reserved.
//

#import "ViewController.h"
#import "MyObject.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MyObject<NSNumber *> *obj1 = [MyObject new];
    obj1.obj = @100;
    [obj1 release];
    
    MyObject<NSString *> *obj2 = [MyObject new];
    obj2.obj = @"200";
    [obj2 release];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
























