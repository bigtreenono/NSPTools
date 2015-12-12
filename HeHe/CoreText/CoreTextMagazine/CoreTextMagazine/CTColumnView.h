//
//  CTColumnView.h
//  CoreTextMagazine
//
//  Created by FNNishipu on 7/20/15.
//  Copyright (c) 2015 FNNishipu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>

@interface CTColumnView : UIView
{
    id ctFrame;
}

@property (retain, nonatomic) NSMutableArray* images;

- (void)setCTFrame:(id)f;

@end
