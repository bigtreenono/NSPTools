//
//  CTColumnView.m
//  CoreTextMagazine
//
//  Created by FNNishipu on 7/20/15.
//  Copyright (c) 2015 FNNishipu. All rights reserved.
//

#import "CTColumnView.h"

@implementation CTColumnView

- (void)setCTFrame: (id) f
{
    ctFrame = f;
}

- (id)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame])
    {
        self.images = [NSMutableArray array];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Flip the coordinate system
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CTFrameDraw((CTFrameRef)ctFrame, context);
    
    for (NSArray* imageData in self.images)
    {
        UIImage* img = [imageData objectAtIndex:0];
        CGRect imgBounds = CGRectFromString([imageData objectAtIndex:1]);
        CGContextDrawImage(context, imgBounds, img.CGImage);
    }
}

@end





























