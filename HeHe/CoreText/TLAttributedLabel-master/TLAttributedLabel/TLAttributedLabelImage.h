//
//  TLCoreTextImage.h
//  TLAttributedLabel-Demo
//
//  Created by andezhou on 15/7/7.
//  Copyright (c) 2015年 andezhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TLAttributeConfig.h"
@interface TLAttributedLabelImage : NSObject

/**
 *  用来保存图片名字
 */
@property (strong, nonatomic) NSString *imageName;

/**
 *  用来保存图片的size大小
 */
@property (assign, nonatomic) CGSize imageSize;

/**
 *  图片是否允许点击
 */
@property (assign, nonatomic) BOOL allowClick;

/**
 *  用来保存图片相对于文字的排版样式
 */
@property (assign, nonatomic, readonly) CTImageAlignment imageAlignment;

/**
 * 用来保存图片相对于父视图的展示模式
 */
@property (assign, nonatomic, readonly) CTImageShowMode imageMode;

/**
 *  用来保存图片的frame，此坐标是 CoreText 的坐标系，而不是UIKit的坐标系
 */
@property (assign, nonatomic) CGRect imagePosition;

#pragma mark 从字符串中找出所有的图片，并把图片和文字分开
+ (NSArray *)detectImagesFromContent:(NSString *)content;

#pragma mark 生成图片空白的占位符
- (NSAttributedString *)parseImageDataFromConfig:(TLAttributeConfig *)config
                                            attributes:(NSDictionary *)attributes;

@end
