//
//  TLFrameParser.h
//  TLAttributedLabel-Demo
//
//  Created by andezhou on 15/7/7.
//  Copyright (c) 2015年 andezhou. All rights reserved.
//
//  用于生成最后绘制界面需要的CTFrameRef实例。

#import <Foundation/Foundation.h>
#import "TLCoreTextData.h"
#import "TLAttributedLabelLink.h"
#import "TLAttributedLabelImage.h"
#import "TLAttributeConfig.h"

@interface TLFrameParser : NSObject

/**
 *   生成带属性的字符串的attributes
 *
 *  @param config 用于配置绘制的参数，例如：文字颜色，大小，行间距等。
 *
 *  @return 带属性的字符串的attribute
 */
+ (NSMutableDictionary *)attributesWithConfig:(TLAttributeConfig *)config;

/**
 *  通过传入需要展示的文字，来获取CTFrameRef实例以及CTFrameRef实际绘制需要的高度
 *
 *  @param content 需要展示的文字
 *  @param config  配置绘制的参数，例如：文字颜色，大小，行间距等。
 *  @param links   自定义link数组
 *
 *  @return CTFrameRef实例以及CTFrameRef实际绘制需要的高度
 */
+ (TLCoreTextData *)parseContent:(NSString *)content config:(TLAttributeConfig *)config;
+ (TLCoreTextData *)parseContent:(NSString *)content;
+ (TLCoreTextData *)parseContent:(NSString *)content config:(TLAttributeConfig *)config link:(NSArray *)links;
+ (TLCoreTextData *)parseContent:(NSString *)content link:(NSArray *)links;

/**
 *  通过已配置好的带属性字符串， 来获取CTFrameRef实例以及CTFrameRef实际绘制需要的高度
 *
 *  @param attributedString 带属性的字符串
 *  @param config           配置绘制的参数，例如：文字颜色，大小，行间距等。
 *
 *  @return CTFrameRef实例以及CTFrameRef实际绘制需要的高度
 */
+ (TLCoreTextData *)parseAttributedContent:(NSMutableAttributedString *)attributedString config:(TLAttributeConfig *)config;
+ (TLCoreTextData *)parseAttributedContent:(NSMutableAttributedString *)attributedString;

/**
 *  通过沙盒地址， 来获取CTFrameRef实例以及CTFrameRef实际绘制需要的高度
 *
 *  @param path   JSON文件路径
 *  @param config 配置绘制的参数，例如：文字颜色，大小，行间距等。
 *
 *  @return CTFrameRef实例以及CTFrameRef实际绘制需要的高度
 */
+ (TLCoreTextData *)parseTemplateFile:(NSString *)path config:(TLAttributeConfig *)config;
+ (TLCoreTextData *)parseTemplateFile:(NSString *)path;

/**
 *  通过网络获取下来的数组（NSArray），来获取CTFrameRef实例以及CTFrameRef实际绘制需要的高度
 *
 *  @param data   从网络获取下来的数组，遍历数组后的字典（NSDictionary）包含颜色（color）、内容（content）和类型（type）
 *  @param config 配置绘制的参数，例如：文字颜色，大小，行间距等。
 *
 *  @return CTFrameRef实例以及CTFrameRef实际绘制需要的高度
 */
+ (TLCoreTextData *)parseTemplateArray:(NSArray *)dataList config:(TLAttributeConfig *)config;
+ (TLCoreTextData *)parseTemplateArray:(NSArray *)dataList;

@end

