//
//  DeriveWebView.m
//  Demo
//
//  Created by Jeff on 12/7/15.
//  Copyright © 2015 FNNishipu. All rights reserved.
//

#import "DeriveWebView.h"

@interface DeriveWebView () <UIWebViewDelegate>

@end

@implementation DeriveWebView

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    if ([super respondsToSelector:@selector(webViewDidFinishLoad:)]) {
//        [super webViewDidFinishLoad:webView];
    }
}

@end
