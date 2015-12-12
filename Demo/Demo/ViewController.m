//
//  ViewController.m
//  Demo
//
//  Created by FNNishipu on 11/1/15.
//  Copyright © 2015 FNNishipu. All rights reserved.
//

#import "ViewController.h"
#import "ClassA.h"
#import "ClassB.h"
#import "CustomView.h"
#import <objc/runtime.h>

@interface ViewController () <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, copy) void(^Callback)(void);
@property (nonatomic, copy) NSMutableArray *array;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]]];
//    CustomView *view = [[NSBundle mainBundle] loadNibNamed:@"CustomView" owner:nil options:nil][0];
//    view.backgroundColor = [UIColor redColor];
//    view.testString = @"123";
//    [self.view addSubview:view];
}

- (IBAction)buttonTapped:(id)sender
{
    ClassA *a4 = [[ClassA alloc] init];
    a4.age = @"1234";
    
    [_array containsObject:a4];
//    _Callback();
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"aaaaaaa %d, %d, %@", [super respondsToSelector:@selector(webViewDidFinishLoad:)], (class_respondsToSelector(class_getSuperclass([self class]), @selector(webViewDidFinishLoad:))), super.class);
}

- (void)test
{
    NSMutableArray *arr1 = [NSMutableArray array];
    NSMutableArray *arr2 = [NSMutableArray array];
    NSMutableArray *arr3 = [NSMutableArray array];
    NSMutableArray *arr4 = [NSMutableArray array];
    
    [arr1 addObject:arr2];
    [arr1 addObject:arr3];
    [arr1 addObject:arr4];
    
    NSUInteger index = [arr1 indexOfObject:arr3];
    NSLog(@"%zd", index);

    _array = [NSMutableArray arrayWithArray:@[ @"1", @"2"]];
    
    __weak typeof(self) weakSelf = self;
    void (^add)() = ^{
        //        weakSelf.array = [NSMutableArray arrayWithArray:@[ @"1", @"2"]];
        [weakSelf.array addObject:@"3"];
    };
    
    add();

    
    [[[[ClassA alloc] init] methodA] methodX]; //This will NOT generate a compiler warning or error because the return type for methodA is id. Eventually this will generate exception at runtime
    
//    [[[[ClassA alloc] init] methodB] methodX]; //This will generate a compiler error saying "No visible @interface ClassA declares selector methodX" because the methodB returns instanceType i.e. the type of the receiver
    
    ClassA *a = [[ClassA alloc] init];
    __block ClassA *weakA = a;
    _Callback = ^{
        [weakA methodA];
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
