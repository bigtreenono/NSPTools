//
//  CTView.h
//  CoreTextMagazine
//
//  Created by FNNishipu on 7/20/15.
//  Copyright (c) 2015 FNNishipu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTColumnView.h"

@interface CTView : UIScrollView <UIScrollViewDelegate>
{
    float frameXOffset;
    float frameYOffset;
}

@property (retain, nonatomic) NSAttributedString* attString;
@property (retain, nonatomic) NSMutableArray* frames;
@property (retain, nonatomic) NSArray* images;

- (void)buildFrames;

- (void)setAttString:(NSAttributedString *)attString withImages:(NSArray*)imgs;

- (void)attachImagesWithFrame:(CTFrameRef)f inColumnView:(CTColumnView *)col;

@end
