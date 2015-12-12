//
//  TLCoreTextUtils.m
//  TLAttributedLabel-Demo
//
//  Created by andezhou on 15/7/7.
//  Copyright (c) 2015年 andezhou. All rights reserved.
//

#import "TLAttributedLabelUtils.h"
#import "TLAttributedLabelLink.h"
#import "TLCoreTextData.h"

@implementation TLAttributedLabelUtils

#pragma mark - NSRange / CFRange
NSRange NSRangeFromCFRange(CFRange range) {
    return NSMakeRange((NSUInteger)range.location, (NSUInteger)range.length);
}

#pragma mark - CoreText CTLine/CTRun utils
BOOL CTRunContainsCharactersFromStringRange(CTRunRef run, NSRange range) {
    NSRange runRange = NSRangeFromCFRange(CTRunGetStringRange(run));
    NSRange intersectedRange = NSIntersectionRange(runRange, range);
    return (intersectedRange.length <= 0);
}

BOOL CTLineContainsCharactersFromStringRange(CTLineRef line, NSRange range) {
    NSRange lineRange = NSRangeFromCFRange(CTLineGetStringRange(line));
    NSRange intersectedRange = NSIntersectionRange(lineRange, range);
    return (intersectedRange.length <= 0);
}

CGRect CTRunGetTypographicBoundsAsRect(CTRunRef run, CTLineRef line, CGPoint lineOrigin) {
    CGFloat ascent = 0.0f;
    CGFloat descent = 0.0f;
    CGFloat leading = 0.0f;
    CGFloat width = (CGFloat)CTRunGetTypographicBounds(run, CFRangeMake(0, 0), &ascent, &descent, &leading);
    CGFloat height = ascent + descent;
    
    CGFloat xOffset = CTLineGetOffsetForStringIndex(line, CTRunGetStringRange(run).location, NULL);
    
    return CGRectMake(lineOrigin.x + xOffset - leading,
                      lineOrigin.y - descent,
                      width + leading,
                      height);
}

CGRect CTLineGetTypographicBoundsAsRect(CTLineRef line, CGPoint lineOrigin) {
    CGFloat ascent = 0.0f;
    CGFloat descent = 0.0f;
    CGFloat leading = 0.0f;
    CGFloat width = (CGFloat)CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
    CGFloat height = ascent + descent;
    
    return CGRectMake(lineOrigin.x,
                      lineOrigin.y - descent,
                      width,
                      height);
}

CGRect CTRunGetTypographicBoundsForImageRect(CTRunRef run, CTLineRef line, CGPoint lineOrigin, TLAttributedLabelImage *imageData) {
    CGRect runBounds = CGRectZero;

    CGFloat ascent = 0.0f;
    CGFloat descent = 0.0f;
    CGFloat leading = 0.0f;
    
    CGFloat width = CTRunGetTypographicBounds(run, CFRangeMake(0, 0), &ascent, &descent, &leading);
    CGFloat lineHeight = ascent + descent + leading;
    CGFloat lineBottomY = lineOrigin.y - descent;

    runBounds.size.width = width;

    runBounds.size.height = imageData.imageSize.height;
    
    CGFloat xOffset = CTLineGetOffsetForStringIndex(line, CTRunGetStringRange(run).location, NULL);
    runBounds.origin.x = lineOrigin.x + xOffset;
    
    // 设置Y坐标
    CGFloat imagePointY = 0.0f;
    switch (imageData.imageAlignment) {
        case kCTImageAlignmentTop:
            imagePointY = lineBottomY + (lineHeight - imageData.imageSize.height);
            break;
        case kCTImageAlignmentCenter:
            imagePointY = lineBottomY + (lineHeight - imageData.imageSize.height) / 2.0;
            break;
        case kCTImageAlignmentBottom:
            imagePointY = lineBottomY;
            break;
    }
    runBounds.origin.y = imagePointY;
    
    return runBounds;
}

CGRect CTRunGetTypographicBoundsForLinkRect(CTLineRef line, NSRange range, CGPoint lineOrigin) {
    CGRect rectForRange = CGRectZero;
    CFArrayRef runs = CTLineGetGlyphRuns(line);
    CFIndex runCount = CFArrayGetCount(runs);
    
    for (CFIndex k = 0; k < runCount; k++) {
        CTRunRef run = CFArrayGetValueAtIndex(runs, k);
        
        if (CTRunContainsCharactersFromStringRange(run, range)) {
            continue;
        }
        
        CGRect linkRect = CTRunGetTypographicBoundsAsRect(run, line, lineOrigin);
        
        linkRect.origin.y = roundf(linkRect.origin.y);
        linkRect.origin.x = roundf(linkRect.origin.x);
        linkRect.size.width = roundf(linkRect.size.width);
        linkRect.size.height = roundf(linkRect.size.height);
        
        rectForRange = CGRectIsEmpty(rectForRange) ? linkRect : CGRectUnion(rectForRange, linkRect);
    }
    
    return rectForRange;
}

// 检查是否点中图片
+ (TLAttributedLabelImage *)touchImageInView:(UIView *)view toPoint:(CGPoint)point data:(TLCoreTextData *)data {
    
    CGAffineTransform transform = CGAffineTransformMakeTranslation(0, view.bounds.size.height);
    transform = CGAffineTransformScale(transform, 1.f, -1.f);
    
    // 检测图片
    for (TLAttributedLabelImage *imageData in data.imageArray) {
        CGRect rect = CGRectApplyAffineTransform(imageData.imagePosition, transform);
        
        if (CGRectContainsPoint(rect, point) && imageData.allowClick) {
            
            return imageData;
            break;
        }
    }
    
    return nil;
}

// 检测点击位置是否在链接上
+ (TLAttributedLabelLink *)touchLinkInView:(UIView *)view atPoint:(CGPoint)point data:(TLCoreTextData *)data {
    CFIndex idx = [self touchContentOffsetInView:view atPoint:point data:data];

    if (idx == -1) return nil;
    
    // 返回被选中的链接所对应的数据模型，如果没选中foundLink为nil
    return [self linkAtIndex:idx linkArray:data.linkArray];;
}

// 将点击的位置转换成字符串的偏移量，如果没有找到，则返回-1
+ (CFIndex)touchContentOffsetInView:(UIView *)view atPoint:(CGPoint)point data:(TLCoreTextData *)data {
    // 获取CFArrayRef
    CTFrameRef textFrame = data.ctFrame;
    CFArrayRef lines = CTFrameGetLines(textFrame);
    
    if (!lines) return -1;
        
    CFIndex count = CFArrayGetCount(lines);
    
    CGPoint origins[count];
    CTFrameGetLineOrigins(textFrame, CFRangeMake(0,0), origins);
    
    // 翻转坐标系
    CGAffineTransform transform =  CGAffineTransformMakeTranslation(0, view.bounds.size.height);
    transform = CGAffineTransformScale(transform, 1.f, -1.f);

    CFIndex idx = -1;
    for (NSInteger index = 0; index < count; index++) {
        CGPoint linePoint = origins[index];
        
        CTLineRef line = CFArrayGetValueAtIndex(lines, index);
        CGRect flippedRect = CTLineGetTypographicBoundsAsRect(line, linePoint);

        CGRect rect = CGRectApplyAffineTransform(flippedRect, transform);
        // 容错保护
        rect = CGRectMake(CGRectGetMinX(rect), CGRectGetMinY(rect) - 3, CGRectGetWidth(rect), CGRectGetHeight(rect) + 6);
        rect = CGRectOffset(rect, data.config.offset.x, data.config.offset.y);


        if (CGRectContainsPoint(rect, point)) {
            // 将点击的坐标转换成相对于当前行的坐标
            CGPoint relativePoint = CGPointMake(point.x - CGRectGetMinX(rect), point.y - CGRectGetMinY(rect));
            // 获取点击位置所处的字符位置，就是相当于点击了第几个字符
            idx = CTLineGetStringIndexForPosition(line, relativePoint);
        }
    }
    return idx;
}

+ (TLAttributedLabelLink *)linkAtIndex:(CFIndex)index linkArray:(NSArray *)linkArray {
    TLAttributedLabelLink *link = nil;

    for (TLAttributedLabelLink *data in linkArray) {
        // 如果index在data.range中，这证明点中链接
        if (NSLocationInRange(index, data.range)) {
            link = data;
            break;
        }
    }
    return link;
}

@end
