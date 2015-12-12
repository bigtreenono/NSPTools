//
//  ViewController.m
//  CoreTextMagazine
//
//  Created by FNNishipu on 7/20/15.
//  Copyright (c) 2015 FNNishipu. All rights reserved.
//

#import "ViewController.h"
#import "CTView.h"
#import "MarkupParser.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSString *path = [[NSBundle mainBundle] pathForResource:@"zombies" ofType:@"txt"];
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"txt"];
    NSString* text = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
    MarkupParser* p = [[MarkupParser alloc] init];
    NSAttributedString* attString = [p attrStringFromMarkup: text];
    [(CTView *)[self view] setAttString:attString withImages: p.images];
    [(CTView *)[self view] buildFrames];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
