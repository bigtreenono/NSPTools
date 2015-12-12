//
//  TLCoreTextUtils.h
//  TLAttributedLabel-Demo
//
//  Created by andezhou on 15/7/7.
//  Copyright (c) 2015年 andezhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreText/CoreText.h>
#import <UIKit/UIKit.h>

@class TLAttributedLabelImage;
@class TLAttributedLabelLink;
@class TLCoreTextData;

@interface TLAttributedLabelUtils : NSObject

#pragma mark - NSRange / CFRange
NSRange NSRangeFromCFRange(CFRange range);

#pragma mark - CoreText CTLine/CTRun utils
BOOL CTRunContainsCharactersFromStringRange(CTRunRef run, NSRange range);
BOOL CTLineContainsCharactersFromStringRange(CTLineRef line, NSRange range);

CGRect CTRunGetTypographicBoundsAsRect(CTRunRef run, CTLineRef line, CGPoint lineOrigin);
CGRect CTLineGetTypographicBoundsAsRect(CTLineRef line, CGPoint lineOrigin);
CGRect CTRunGetTypographicBoundsForImageRect(CTRunRef run, CTLineRef line, CGPoint lineOrigin, TLAttributedLabelImage *imageData);
CGRect CTRunGetTypographicBoundsForLinkRect(CTLineRef line, NSRange range, CGPoint lineOrigin);

/**
 *  @return 判断点击坐标是否在图片上， 如果点中反回图片的TLCoreTextImage， 如果没点中反回nil
 */
+ (TLAttributedLabelImage *)touchImageInView:(UIView *)view toPoint:(CGPoint)point data:(TLCoreTextData *)data;

/**
 *  @return 判断点击坐标是否在连接上， 如果点中反回链接的TLCoreTextLink， 如果没点中反回nil
 */
+ (TLAttributedLabelLink *)touchLinkInView:(UIView *)view atPoint:(CGPoint)point data:(TLCoreTextData *)data;

@end
