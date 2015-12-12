//
//  TLAttributedLabel.m
//  TLAttributedLabel-Demo
//
//  Created by andezhou on 15/7/7.
//  Copyright (c) 2015年 andezhou. All rights reserved.
//

#import "TLAttributedLabel.h"
#import <CoreText/CoreText.h>
#import "TLAttributedLabelUtils.h"

@interface TLAttributedLabel () <UIGestureRecognizerDelegate>

/**
 *  点击选中的链接数据源
 */
@property (strong, nonatomic) TLAttributedLabelLink *touchedLink;

/**
 点击选中的图片数据源
 */
@property (strong, nonatomic) TLAttributedLabelImage *touchedImage;

@end

@implementation TLAttributedLabel

#pragma mark -
#pragma mark lifecycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

#pragma mark -
#pragma mark 点击事件相应
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    CGPoint point = [[touches anyObject] locationInView:self];
    
    // 检查是否选中图片
    TLAttributedLabelImage *imageData = [TLAttributedLabelUtils touchImageInView:self toPoint:point data:self.data];
    if (imageData) {
        self.touchedImage = imageData;
        return;
    }

    // 检查是否选中链接
    TLAttributedLabelLink *linkData = [TLAttributedLabelUtils touchLinkInView:self atPoint:point data:self.data];
    if (linkData) {
        self.touchedLink = linkData;
        [self setNeedsDisplay];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    CGPoint point = [[touches anyObject] locationInView:self];
    
    if (self.touchedImage) {
        
        TLAttributedLabelImage *imageData = [TLAttributedLabelUtils touchImageInView:self toPoint:point data:self.data];
        if (imageData != self.touchedImage) {
            self.touchedImage = nil;
        }
        
    }else if (self.touchedLink) {
        
        TLAttributedLabelLink *linkData = [TLAttributedLabelUtils touchLinkInView:self atPoint:point data:self.data];
        if (linkData != self.touchedLink) {
            self.touchedLink = nil;
            [self setNeedsDisplay];
        }
    }
}

//- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
//    [super touchesCancelled:touches withEvent:event];
//    self.touchedImage = nil;
//    self.touchedLink = nil;
//    [self setNeedsDisplay];
//}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    // 检查文字
    if (self.touchedLink) {
        if ([self.delegate respondsToSelector:@selector(attributedLabel:linkData:)]) {
            [self.delegate attributedLabel:self linkData:self.touchedLink];
            self.touchedLink = nil;
            [self setNeedsDisplay];
        }
    }
    
    // 检查图片
    if (self.touchedImage) {
        if ([self.delegate respondsToSelector:@selector(attributedLabel:imageData:imageList:)]) {
            [self.delegate attributedLabel:self imageData:self.touchedImage imageList:self.data.imageArray];
            self.touchedImage = nil;
        }
    }
}

#pragma mark -
#pragma mark drawRect
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];

    if (self.data == nil) return;
    
    // 1.获取图形上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 2.将坐标系上下翻转
    CGAffineTransform transform =  CGAffineTransformScale(CGAffineTransformMakeTranslation(0, self.bounds.size.height), 1.f, -1.f);
    CGContextConcatCTM(context, transform);
    
    // 3.绘制高亮背景
    [self drawHighlightWithRect:rect];
    
    // 4.绘制图片
    for (TLAttributedLabelImage *imageData in self.data.imageArray) {
        UIImage *image = [UIImage imageNamed:imageData.imageName];
        if (image) {
            CGContextDrawImage(context, imageData.imagePosition, image.CGImage);
        }
    }
    
    // 5.执行绘图操作
    CTFrameDraw(self.data.ctFrame, context);
}

- (void)drawHighlightWithRect:(CGRect)rect {
    if (self.touchedLink && self.data.config.backgroundColor) {
        [self.data.config.backgroundColor setFill];

        NSRange linkRange = self.touchedLink.range;
        
        // 偏移
        CGPathRef pathRef = CTFrameGetPath(self.data.ctFrame);
        CGRect colRect = CGPathGetBoundingBox(pathRef);
        
        CFArrayRef lines = CTFrameGetLines(self.data.ctFrame);
        CFIndex count = CFArrayGetCount(lines);
        CGPoint lineOrigins[count];
        CTFrameGetLineOrigins(self.data.ctFrame, CFRangeMake(0, 0), lineOrigins);
        
        for (CFIndex i = 0; i < count; i++) {
            CTLineRef line = CFArrayGetValueAtIndex(lines, i);
            
            if (CTLineContainsCharactersFromStringRange(line, linkRange)) continue;
            
            CGRect highlightRect = CTRunGetTypographicBoundsForLinkRect(line, linkRange, lineOrigins[i]);
            
            highlightRect = CGRectOffset(highlightRect, 0, -rect.origin.y);
            highlightRect = CGRectOffset(highlightRect, colRect.origin.x, colRect.origin.y);
            
            CGRect rect = CGRectMake(CGRectGetMinX(highlightRect), CGRectGetMinY(highlightRect) - 2, CGRectGetWidth(highlightRect), CGRectGetHeight(highlightRect) + 4);

            if (!CGRectIsEmpty(rect)) {
                //  绘制背景颜色
                [self drawBackgroundColorWithRect:rect];
            }
        }
    }
}


- (void)drawBackgroundColorWithRect:(CGRect)rect {
    CGFloat radius = 2.0f;
    CGFloat pointX = rect.origin.x;
    CGFloat pointY = rect.origin.y;
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 移动到初始点
    CGContextMoveToPoint(context, pointX, pointY);
    
    // 绘制第1条线和第1个1/4圆弧，右上圆弧
    CGContextAddLineToPoint(context, pointX + width - radius, pointY);
    CGContextAddArc(context, pointX + width - radius, pointY + radius, radius, -0.5*M_PI, 0.0, 0);
    
    // 绘制第2条线和第2个1/4圆弧，右下圆弧
    CGContextAddLineToPoint(context, pointX + width, pointY + height - radius);
    CGContextAddArc(context, pointX + width - radius, pointY + height - radius, radius, 0.0, 0.5*M_PI, 0);
    
    // 绘制第3条线和第3个1/4圆弧，左下圆弧
    CGContextAddLineToPoint(context, pointX + radius, pointY + height);
    CGContextAddArc(context, pointX + radius, pointY + height - radius, radius, 0.5*M_PI, M_PI, 0);
    
    // 绘制第4条线和第4个1/4圆弧，左上圆弧
    CGContextAddLineToPoint(context, pointX, pointY + radius);
    CGContextAddArc(context, pointX + radius, pointY + radius, radius, M_PI, 1.5*M_PI, 0);
    
    // 闭合路径
    CGContextFillPath(context);
}

@end
