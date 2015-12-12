//
//  TLCoreTextData.m
//  TLAttributedLabel-Demo
//
//  Created by andezhou on 15/7/7.
//  Copyright (c) 2015年 andezhou. All rights reserved.
//
//  用于保存由CTFrameParser类生成的CTFrameRef实例以及CTFrameRef实际绘制需要的高度。

#import "TLCoreTextData.h"
#import "TLAttributedLabelUtils.h"

@implementation TLCoreTextData

- (void)setCtFrame:(CTFrameRef)ctFrame {
    if (_ctFrame != ctFrame) {
        if (_ctFrame != nil) {
            CFRelease(_ctFrame);
        }
        CFRetain(ctFrame);
        _ctFrame = ctFrame;
    }
}

- (void)dealloc {
    if (_ctFrame != nil) {
        CFRelease(_ctFrame);
        _ctFrame = nil;
    }
}

- (void)setImageArray:(NSArray *)imageArray {
    _imageArray = imageArray;
    
    [self fillImagePosition];
}

//用于找到每张图片在绘制时的位置
- (void)fillImagePosition {
    if (self.imageArray.count == 0) return;

    // 1.获取文字行数lineCount
    NSArray *lines = (NSArray *)CTFrameGetLines(self.ctFrame);
    NSUInteger lineCount = [lines count];
    
    // 2.获取每行的原点坐标
    CGPoint lineOrigins[lineCount];
    CTFrameGetLineOrigins(self.ctFrame, CFRangeMake(0, 0), lineOrigins);
    
    // 3.从imageArray中取出CoreTextImageData，依次遍历后附上坐标
    TLAttributedLabelImage *imageData = self.imageArray[0];
   
    NSInteger imgIndex = 0;
    for (NSInteger i = 0; i < lineCount; i ++) {

        if (imageData == nil) {
            break;
        }
        // 获取该行的CTLineRef
        CTLineRef line = (__bridge CTLineRef)lines[i];

        // 根据获取到的CTLineRef得到该行的所有CTRunRef
        NSArray *runObjArray = (NSArray *)CTLineGetGlyphRuns(line);
        // 遍历该行所有的CTRunRef
        for (id runObj in runObjArray) {
            
            CTRunRef run = (__bridge CTRunRef)runObj;
            NSDictionary *runAttributes = (NSDictionary *)CTRunGetAttributes(run);
            
            CTRunDelegateRef delegate = (__bridge CTRunDelegateRef)[runAttributes valueForKey:(id)kCTRunDelegateAttributeName];
            if (delegate == nil) continue;
            
            CGRect runBounds = CTRunGetTypographicBoundsForImageRect(run, line, lineOrigins[i], imageData);
            
            CGPathRef pathRef = CTFrameGetPath(self.ctFrame);
            CGRect colRect = CGPathGetBoundingBox(pathRef);
            
            if (imageData.imageMode != kCTShowImageModeNone) {
                CGRect imageRect = [self currentLineOnlyImageWithRect:runBounds offset:colRect.origin imageData:imageData];
                imageData.imagePosition = imageRect;
            } else {
                // 找到图片在绘制时的位置
                CGRect imageRect = CGRectOffset(runBounds, colRect.origin.x, colRect.origin.y);
                imageData.imagePosition = imageRect;
            }
            
            imgIndex++;
            if (imgIndex == self.imageArray.count) { // 完成图片寻找
                imageData = nil;
                break;
            } else {
                // 进行下一张寻找
                imageData = self.imageArray[imgIndex];
            }
        }
    }
}

// 处理当前展示行只有一张图片的时候
- (CGRect)currentLineOnlyImageWithRect:(CGRect)rect offset:(CGPoint)offset imageData:(TLAttributedLabelImage *)imageData {
    CGFloat imageWidth = imageData.imageSize.width;
    CGFloat viewWidth = self.config.width;
    
    switch (imageData.imageMode) {
        case kCTShowImageModeLeft:
            return CGRectMake(offset.x, CGRectGetMinY(rect) + offset.y/2.f, imageData.imageSize.width, CGRectGetHeight(rect));
            break;
            
        case kCTShowImageModeRight:
            return CGRectMake(viewWidth - imageData.imageSize.width - offset.x, CGRectGetMinY(rect) + offset.y/2.f, imageData.imageSize.width, CGRectGetHeight(rect));

            break;
            
        case kCTShowImageModeCenter: {
            CGFloat pointX = (viewWidth - imageWidth)/2.0;
            return CGRectMake(pointX , CGRectGetMinY(rect) + offset.y/2.f, imageWidth, CGRectGetHeight(rect));
        }
            break;
            
        default:
            break;
    }
    
    return CGRectZero;
}

@end
