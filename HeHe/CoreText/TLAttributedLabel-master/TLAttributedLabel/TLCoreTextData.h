//
//  TLCoreTextData.h
//  TLAttributedLabel-Demo
//
//  Created by andezhou on 15/7/7.
//  Copyright (c) 2015年 andezhou. All rights reserved.
//
//  用于保存由CTFrameParser类生成的CTFrameRef实例以及CTFrameRef实际绘制需要的高度。

#import <Foundation/Foundation.h>
#import <CoreText/CoreText.h>
#import "TLAttributedLabelImage.h"
#import "TLAttributedLabelLink.h"
#import "TLAttributeConfig.h"

@interface TLCoreTextData : NSObject

/**
 *  配置属性
 */
@property (strong, nonatomic) TLAttributeConfig *config;

/**
 *  TLAttributedLabel 的CTFrameRef
 */
@property (assign, nonatomic) CTFrameRef ctFrame;

/**
 *  TLAttributedLabel的高度
 */
@property (assign, nonatomic) CGFloat height;

/**
 *  图片数组
 */
@property (strong, nonatomic) NSArray *imageArray;

/**
 *  链接数组
 */
@property (strong, nonatomic) NSArray *linkArray;

/**
 *  带属性的可变字符串
 */
@property (strong, nonatomic) NSAttributedString *attributedString;

@end
