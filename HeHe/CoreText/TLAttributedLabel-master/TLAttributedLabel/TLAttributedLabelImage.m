//
//  TLCoreTextImage.m
//  TLAttributedLabel-Demo
//
//  Created by andezhou on 15/7/7.
//  Copyright (c) 2015年 andezhou. All rights reserved.
//

#import "TLAttributedLabelImage.h"
#import <CoreText/CoreText.h>
#import "TLAttributeConfig.h"

NSString *const BEGIN_FLAG = @"[/";
NSString *const END_FLAG = @"]";

@interface TLAttributedLabelImage ()

@property (assign, nonatomic) CGFloat fontAscent;
@property (assign, nonatomic) CGFloat fontDescent;
@property (assign, nonatomic) CGFloat fontHeight;
@property (strong, nonatomic) TLAttributeConfig *config;

@end

@implementation TLAttributedLabelImage

#pragma mark -
#pragma mark lifecycle
- (instancetype)init {
    self = [super init];
    if (self) {
        self.allowClick = YES;
    }
    return self;
}

// 获取图片高度
static CGFloat ascentCallback(void *ref) {
    TLAttributedLabelImage *labelImage = (__bridge TLAttributedLabelImage*)ref;
    CGFloat height = labelImage.imageSize.height;
    
    if (!height) return 0;
    
    CGFloat ascent = 0;

    switch (labelImage.imageAlignment){
        case kCTImageAlignmentTop:
            ascent = labelImage.fontAscent;
            break;
        case kCTImageAlignmentCenter:{
            CGFloat baseLine = (labelImage.fontAscent + labelImage.fontDescent) / 2 - labelImage.fontDescent;
            ascent = height / 2 + baseLine;
        }
            break;
        case kCTImageAlignmentBottom:
            ascent = height - labelImage.fontDescent;
            break;
        default:
            break;
    }
    return ascent;
}

// 调整图片对齐方式
static CGFloat descentCallback(void *ref) {
    TLAttributedLabelImage *labelImage = (__bridge TLAttributedLabelImage*)ref;
    CGFloat height = labelImage.imageSize.height;

    if (!height) return 0;
    CGFloat descent = 0;

    switch (labelImage.imageAlignment) {
        case kCTImageAlignmentTop:{
            descent = height - labelImage.fontAscent;
            break;
        }
        case kCTImageAlignmentCenter:{
            CGFloat baseLine = (labelImage.fontAscent + labelImage.fontDescent) / 2.f - labelImage.fontDescent;
            descent = height / 2.f - baseLine;
        }
            break;
        case kCTImageAlignmentBottom:{
            descent = labelImage.fontDescent;
            break;
        }
        default:
            break;
    }
    
    return descent;
}

// 获取图片宽度
static CGFloat widthCallback(void *ref) {
    TLAttributedLabelImage *imageData = (__bridge TLAttributedLabelImage*)ref;

    if (!imageData.imageSize.width || !imageData.config) return 0;
    
    if (imageData.imageMode != kCTShowImageModeNone) {
        return imageData.config.width - 2*imageData.config.offset.x;
    }else{
        return imageData.imageSize.width;
    }
}

//CTRun的回调，销毁内存的回调
void runDelegateDeallocCallback(void *ref) {
}

// 处理当前展示行只有一张图片的时候
- (void)imageModeWithRect:(CGSize)imageSize config:(TLAttributeConfig *)config {
    CGFloat imageWidth = imageSize.width;
    CGFloat viewWidth = self.config.width - 2*config.offset.x;
    
    if (imageWidth > viewWidth) { // 处理图片宽度大于展示视图宽度
        CGFloat imageHeight = viewWidth * imageSize.height / imageWidth;
        self.imageSize = CGSizeMake(viewWidth, imageHeight);
        
    } else {
        CGFloat imageHeight = imageWidth * imageSize.height / imageWidth;
        self.imageSize = CGSizeMake(imageWidth, imageHeight);
    }
}

#pragma mark 生成图片空白的占位符
- (NSAttributedString *)parseImageDataFromConfig:(TLAttributeConfig *)config
                                      attributes:(NSDictionary *)attributes {

    self.config = config;
    _imageMode = config.imageMode;
    _imageAlignment = config.imageAlignment;
    
    if (self.imageMode != kCTShowImageModeNone) {
       [self imageModeWithRect:self.imageSize config:config];
    }
    
    CTFontRef fontRef = CTFontCreateWithName((CFStringRef)config.fontName, config.fontSize, NULL);
    if (fontRef) {
        self.fontAscent  = CTFontGetAscent(fontRef);
        self.fontDescent = CTFontGetDescent(fontRef);
        self.fontHeight  = CTFontGetSize(fontRef);
    }

    CTRunDelegateCallbacks callbacks;
    memset(&callbacks, 0, sizeof(CTRunDelegateCallbacks));
    callbacks.version = kCTRunDelegateVersion1;
    callbacks.dealloc = runDelegateDeallocCallback;
    callbacks.getAscent = ascentCallback;
    callbacks.getDescent = descentCallback;
    callbacks.getWidth = widthCallback;
    // 创建CTRun回调
    CTRunDelegateRef runDelegate = CTRunDelegateCreate(&callbacks, (__bridge void *)(self));
    
    // 使用 0xFFFC 作为空白的占位符
    unichar objectReplacementChar = 0xFFFC;
    NSString *content = [NSString stringWithCharacters:&objectReplacementChar length:1];
    NSMutableAttributedString *imageAttributedString = [[NSMutableAttributedString alloc] initWithString:content attributes:attributes];
    [imageAttributedString addAttribute:(NSString *)kCTRunDelegateAttributeName value:(__bridge id)runDelegate range:NSMakeRange(0, 1)];
    CFRelease(runDelegate);
        
    return imageAttributedString;
}

#pragma mark -
#pragma mark 把图片和文字分离
+ (NSArray *)detectImagesFromContent:(NSString *)content {
    NSMutableArray *array = [NSMutableArray array];
    [self detectImagesFromContent:content array:array];
    
    return array;
}

// 通过递归查询出所有的图片， 并把字符串中的图片替换掉
+ (void)detectImagesFromContent:(NSString *)content array:(NSMutableArray *)array {
    NSRange range1 = [content rangeOfString:BEGIN_FLAG];
    NSRange range2 = [content rangeOfString:END_FLAG];
    
    if (range2.location != NSNotFound || range1.location != NSNotFound) {
        
        NSUInteger location = range1.location + range1.length;
        NSUInteger length = range2.location - location;
        
        NSString *imageName = [content substringWithRange:NSMakeRange(location, length)];
        NSString *txt = [content substringWithRange:NSMakeRange(0, range1.location)];
        
        if (txt.length > 0) {
            [array addObject:@{@"txt" : txt}];
        }
        [array addObject:@{@"img" : imageName}];
        
        NSString *result = [content substringFromIndex:range2.location + range2.length];
        
        [self detectImagesFromContent:result array:array];
        
    }else{
        [array addObject:@{@"txt" : content}];
    }
}

@end
