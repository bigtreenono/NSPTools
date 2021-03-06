//
//  VVeboTableViewCell.h
//  VVeboTableViewPractise
//
//  Created by FNNishipu on 7/16/15.
//  Copyright (c) 2015 FNNishipu. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SIZE_GAP_LEFT 15
#define SIZE_GAP_TOP 13
#define SIZE_AVATAR 40
#define SIZE_GAP_BIG 10
#define SIZE_GAP_IMG 5
#define SIZE_GAP_SMALL 5
#define SIZE_IMAGE 80
#define SIZE_FONT 17
#define SIZE_FONT_NAME (SIZE_FONT-3)
#define SIZE_FONT_SUBTITLE (SIZE_FONT-8)
#define FontWithSize(s) [UIFont fontWithName:@"HelveticaNeue-Light" size:s]
#define SIZE_FONT_CONTENT 17
#define SIZE_FONT_SUBCONTENT (SIZE_FONT_CONTENT-1)

@interface VVeboTableViewCell : UITableViewCell

@property (nonatomic, weak) NSDictionary *data;

- (void)clear;
- (void)draw;
- (void)releaseMemory;

@end
