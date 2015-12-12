//
//  TLAttributedLabel.h
//  TLAttributedLabel-Demo
//
//  Created by andezhou on 15/7/7.
//  Copyright (c) 2015年 andezhou. All rights reserved.
//
//  持有TLAttributedLabel类的实例，负责将CTFrameRef绘制到界面上。

#import <UIKit/UIKit.h>
#import "TLAttributeConfig.h"
#import "TLFrameParser.h"
#import "TLAttributedLabelImage.h"
#import "TLAttributedLabelLink.h"
#import "TLCoreTextData.h"

@class TLAttributedLabel;

@protocol TLAttributedLabelDelegate <NSObject>

- (void)attributedLabel:(TLAttributedLabel *)label imageData:(TLAttributedLabelImage *)imageData imageList:(NSArray *)imageList;
- (void)attributedLabel:(TLAttributedLabel *)label linkData:(TLAttributedLabelLink *)linkData;

@end

@interface TLAttributedLabel : UIView

@property (weak, nonatomic) id<TLAttributedLabelDelegate> delegate;
@property (strong, nonatomic) TLCoreTextData *data;

@end

