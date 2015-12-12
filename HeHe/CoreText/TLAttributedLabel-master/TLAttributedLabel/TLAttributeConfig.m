//
//  TLAttributeConfig.m
//  TLAttributedLabel-Demo
//
//  Created by andezhou on 15/7/7.
//  Copyright (c) 2015年 andezhou. All rights reserved.
//
//  用于配置绘制的参数，例如：文字颜色，大小，行间距等。

#import "TLAttributeConfig.h"

#define RGB(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]

static CGFloat kDefaultFontSize = 16.0f;
static CGFloat kDefaultLineSpace = 7.0f;
static CGFloat kDefaultParagraphSpacing = 10.0f;
static NSString *kDefaultFontName = @"ArialMT";

@implementation TLAttributeConfig

- (id)init {
    self = [super init];
    if (self) {
        _width = [UIScreen mainScreen].bounds.size.width;
        _fontSize = kDefaultFontSize;
        _lineSpace = kDefaultLineSpace;
        _fontName = kDefaultFontName;
        _paragraphSpacing = kDefaultParagraphSpacing;
        _textColor = RGB(108, 108, 108);
        _highlightedLinkColor = [UIColor blueColor];
        _showUrl = NO;
        _offset = CGPointMake(10, 10);
        _backgroundColor = RGB(204, 221, 236);
        _imageAlignment = kCTImageAlignmentCenter;
        _textAlignment = kCTTextAlignmentLeft;
        _imageMode = kCTShowImageModeNone;
        _lineBreakMode = kCTLineBreakByWordWrapping | kCTLineBreakByCharWrapping;
    }
    return self;
}

#pragma mark -
#pragma mark 网络获取数据，刷新新的属性
- (instancetype)refreshAttributeConfigWithDict:(NSDictionary *)dict {
    // 设置文字颜色
    UIColor *color = TLColorFromString(dict[@"color"]);
    if (color) {
        self.textColor = color;
    }else{
        self.textColor = RGB(108, 108, 108);
    }
    
    // 设置字体大小
    CGFloat fontSize = [dict[@"size"] floatValue];
    if (fontSize > 0) {
        self.fontSize = fontSize;
    }else {
        self.fontSize = kDefaultFontSize;
    }
    
    // 设置字体类型
    NSString *fontName = dict[@"fontName"];
    if (fontName) {
        self.fontName = fontName;
    }else{
        self.fontName = kDefaultFontName;
    }
    
    // 设置行间距
    CGFloat lineSpace = [dict[@"lineSpace"] floatValue];
    if (lineSpace > 0) {
        self.lineSpace = lineSpace;
    }else{
        self.lineSpace = kDefaultLineSpace;
    }
    
    // 设置段间距
    CGFloat paragraphSpacing = [dict[@"paragraphSpacing"] floatValue];
    if (paragraphSpacing > 0) {
        self.paragraphSpacing = paragraphSpacing;
    }else{
        self.paragraphSpacing = kDefaultParagraphSpacing;
    }
    
    // 设置文字对齐属性
    NSString *alignment = dict[@"alignment"];
    if (alignment) {
        self.textAlignment = TLTextAlignmentFromString(alignment);
    }else{
        self.textAlignment = kCTTextAlignmentLeft;
    }
    
    // 设置图片展示模式
    NSString *mode = dict[@"mode"];
    if (mode) {
        self.imageMode = TLImageModeFromString(mode);
    }else{
        self.imageMode = kCTShowImageModeNone;
    }
    
    return self;
}

#pragma mark 根据JSON中的mode转化为对应的图片展示模式
CTImageShowMode TLImageModeFromString(NSString *imageMode) {
    if ([imageMode isEqualToString:@"left"]) {
        return kCTShowImageModeLeft;
    } else if ([imageMode isEqualToString:@"center"]) {
        return kCTShowImageModeCenter;
    } else if ([imageMode isEqualToString:@"right"]) {
        return kCTShowImageModeRight;
    } else {
        return kCTShowImageModeNone;
    }
}

#pragma mark 根据JSON中的alignment转化为对应的文本对齐方式
CTTextAlignment TLTextAlignmentFromString(NSString *textAligment) {
    if ([textAligment isEqualToString:@"right"]) {
        return kCTTextAlignmentRight;
    } else if ([textAligment isEqualToString:@"center"]) {
        return kCTTextAlignmentCenter;
    } else if ([textAligment isEqualToString:@"justified"]) {
        return kCTTextAlignmentJustified;
    } else if ([textAligment isEqualToString:@"natural"]) {
        return kCTTextAlignmentNatural;
    } else {
        return kCTTextAlignmentLeft;
    }
}

#pragma mark 根据JSON中的color转化为UIColor
UIColor * TLColorFromString(NSString *colorString) {
    if ([colorString isEqualToString:@"default"]) {
        return RGB(108, 108, 108);
    } else if ([colorString isEqualToString:@"blue"]) {
        return [UIColor blueColor];
    } else if ([colorString isEqualToString:@"red"]) {
        return [UIColor redColor];
    } else if ([colorString isEqualToString:@"black"]) {
        return [UIColor blackColor];
    } else {
        return nil;
    }
}

@end
