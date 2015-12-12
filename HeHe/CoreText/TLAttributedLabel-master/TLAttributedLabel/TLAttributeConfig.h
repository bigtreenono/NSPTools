//
//  TLAttributeConfig.h
//  TLAttributedLabel-Demo
//
//  Created by andezhou on 15/7/7.
//  Copyright (c) 2015年 andezhou. All rights reserved.
//
//  用于配置绘制的参数，例如：文字颜色，大小，行间距等。

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 同一行文图混搭时，图片相对于同一行的文字的对齐模式，包含（上、中、下对齐）
 */
typedef NS_ENUM(NSInteger, CTImageAlignment){
    kCTImageAlignmentTop = 0,
    kCTImageAlignmentCenter,
    kCTImageAlignmentBottom,
};

/**
 图片单独展示时，图片的展示模式{注：如图片展示模式为left、right和center，则该行只显示这一张图片}
 kCTShowImageModeNone   不做处理
 kCTShowImageModeFull   宽度跟展示视图同宽
 kCTShowImageModeLeft   向左对齐
 kCTShowImageModeCenter 居中对齐
 kCTShowImageModeRight  向右对齐
 */
typedef NS_ENUM(NSInteger, CTImageShowMode) {
    kCTShowImageModeNone = 0,
    kCTShowImageModeLeft,
    kCTShowImageModeCenter,
    kCTShowImageModeRight,
};

@interface TLAttributeConfig : NSObject

/**
 *  text的宽度，默认屏幕宽度
 */
@property (assign, nonatomic) CGFloat width;

/**
 *  文字的字体大小，默认16
 */
@property (assign, nonatomic) CGFloat fontSize;

/**
 *  字体名字， 默认“ArialMT”
 */
@property (strong, nonatomic) NSString *fontName;

/**
 *  行间距，默认7.0
 */
@property (assign, nonatomic) CGFloat lineSpace;

/**
 *  段间距, 默认10
 */
@property (assign, nonatomic) CGFloat paragraphSpacing;

/**
 *  文字排版样式, 默认kCTTextAlignmentLeft
 */
@property (assign, nonatomic) CTTextAlignment textAlignment;

/**
 *  图片相对于文字的排版样式, 默认kCTImageAlignmentCenter
 */
@property (assign, nonatomic) CTImageAlignment imageAlignment;

/**
 *  断行模式，默认kCTLineBreakByWordWrapping ｜ kCTLineBreakByCharWrapping
 */
@property (assign, nonatomic) CTLineBreakMode lineBreakMode;

/**
 *  图片相对于父视图的展示模式， 默认kCTShowImageModeNone
 */
@property (assign, nonatomic) CTImageShowMode imageMode;

/**
 *  文字颜色，默认RGB(108, 108, 108)
 */
@property (strong, nonatomic) UIColor *textColor;

/**
 *  连接文字颜色， 默认为蓝色
 */
@property (strong, nonatomic) UIColor *highlightedLinkColor;

/**
 *  链接点击时背景高亮色, 默认RGB(204, 221, 236)
 */
@property (strong, nonatomic) UIColor *backgroundColor;

/**
 *  是否显示连接地址，默认不显示
 */
@property (assign, nonatomic) BOOL showUrl;

/**
 *  针对绘画层的偏移
 */
@property (assign, nonatomic) CGPoint offset;

/**
 *  更新属性
 *
 *  @param dict 新的属性
 *
 *  @return 更新后的属性
 */
- (instancetype)refreshAttributeConfigWithDict:(NSDictionary *)dict;

@end
