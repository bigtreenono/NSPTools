//
//  CustomView.m
//  CoreTextDemo
//
//  Created by FNNishipu on 7/17/15.
//  Copyright (c) 2015 FNNishipu. All rights reserved.
//

#import "CustomView.h"
#import <CoreText/CoreText.h>

@implementation CustomView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    // 1
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    
    // 2、由于Quartz库中是以左下角为（0，0）原点坐标，而CoreText的原点坐标是右上角，那么就需要上下翻转一下。
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0); // 在y轴缩放-1相当于沿着x轴旋转180
    
    
    // 3 设置绘制的区域，本例中是矩形，当然你也可以尝试其他设置，比如：CGPathAddArc()方法设置绘制区域为圆形。
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, self.bounds);
    
    
    // 4 创建NSAttributedString，NSAttributedString就是CoreText的数据源，所有要绘制的格式都是在NSAttributedString里面设置，比如字体颜色、字形、段落、行距等等。
    NSAttributedString *attString = [[NSAttributedString alloc] initWithString:@"Hello CoreText!"];
    
    
    // 5 把NSAttributedString转化成CTFramesetterRef，再通过CTFramesetterRef创建CTFrameRef，CoreText的核心就是通过CTFrameRef绘制。
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attString);
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, [attString length]), path, NULL);
    
    // 6 绘制。
    CTFrameDraw(frame, context);
    
    CFRelease(frame);
    CFRelease(framesetter);
    CFRelease(path);
}

@end



























