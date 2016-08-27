//
//  ViewController3.m
//  1318
//
//  Created by Jeff on 8/11/16.
//  Copyright © 2016 Jeff. All rights reserved.
//

#import "ViewController3.h"

@interface ViewController3 ()

@end

@implementation ViewController3

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"3333333333333333333333333333333333333333333333333333333333333333333333333333333333 viewWillAppear");
    });
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NSLog(@"3333333333333333333333333333333333333333333333333333333333333333333333333333333333 viewWillDisappear");
    for (int i = 0; i < 9999999; ++i)
    {
        [NSArray array];
    }
    NSLog(@"3333333333333333333333333333333333333333333333333333333333333333333333333333333333 viewWillDisappear");
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
