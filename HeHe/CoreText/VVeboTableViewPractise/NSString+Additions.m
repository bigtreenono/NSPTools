//
//  NSString+Additions.m
//  Additions
//
//  Created by Johnil on 13-6-15.
//  Copyright (c) 2013年 Johnil. All rights reserved.
//

#import "NSString+Additions.h"
#import <CoreText/CoreText.h>

@implementation NSString (Additions)

#pragma mark - java api

- (NSUInteger) compareTo: (NSString*) comp {
    NSComparisonResult result = [self compare:comp];
    if (result == NSOrderedSame) {
        return 0;
    }
    return result == NSOrderedAscending ? -1 : 1;
}

- (NSUInteger) compareToIgnoreCase: (NSString*) comp {
    return [[self lowercaseString] compareTo:[comp lowercaseString]];
}

- (bool) contains: (NSString*) substring {
    NSRange range = [self rangeOfString:substring];
    return range.location != NSNotFound;
}

- (bool) endsWith: (NSString*) substring {
    NSRange range = [self rangeOfString:substring];
    return range.location == [self length] - [substring length];
}

- (bool) startsWith: (NSString*) substring {
    NSRange range = [self rangeOfString:substring];
    return range.location == 0;
}

- (NSUInteger) indexOf: (NSString*) substring {
    NSRange range = [self rangeOfString:substring options:NSCaseInsensitiveSearch];
    return range.location == NSNotFound ? -1 : range.location;
}

- (NSUInteger) indexOf:(NSString *)substring startingFrom: (NSUInteger) index {
    NSString* test = [self substringFromIndex:index];
    return index+[test indexOf:substring];
}

- (NSUInteger) lastIndexOf: (NSString*) substring {
    NSRange range = [self rangeOfString:substring options:NSBackwardsSearch];
    return range.location == NSNotFound ? -1 : range.location;
}

- (NSUInteger) lastIndexOf:(NSString *)substring startingFrom: (NSUInteger) index {
    NSString* test = [self substringFromIndex:index];
    return [test lastIndexOf:substring];
}

- (NSString*) substringFromIndex:(NSUInteger)from toIndex: (NSUInteger) to {
    NSRange range;
    range.location = from;
    range.length = to - from;
    return [self substringWithRange: range];
}

- (NSString*) trim {
    
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSArray*) split: (NSString*) token {
    return [self split:token limit:0];
}

- (NSArray*) split: (NSString*) token limit: (NSUInteger) maxResults {
    NSMutableArray* result = [NSMutableArray arrayWithCapacity: 8];
    NSString* buffer = self;
    while ([buffer contains:token]) {
        if (maxResults > 0 && [result count] == maxResults - 1) {
            break;
        }
        NSUInteger matchIndex = [buffer indexOf:token];
        NSString* nextPart = [buffer substringFromIndex:0 toIndex:matchIndex];
        buffer = [buffer substringFromIndex:matchIndex + [token length]];
        [result addObject:nextPart];
    }
    if ([buffer length] > 0) {
        [result addObject:buffer];
    }
    
    return result;
}

- (NSString*) replace: (NSString*) target withString: (NSString*) replacement {
    return [self stringByReplacingOccurrencesOfString:target withString:replacement];
}

- (CGSize)sizeWithConstrainedToWidth:(float)width fromFont:(UIFont *)font1 lineSpace:(float)lineSpace{
    return [self sizeWithConstrainedToSize:CGSizeMake(width, CGFLOAT_MAX) fromFont:font1 lineSpace:lineSpace];
}

- (CGSize)sizeWithConstrainedToSize:(CGSize)size fromFont:(UIFont *)font1 lineSpace:(float)lineSpace
{
    CTFontRef fontRef = CTFontCreateWithName((__bridge CFStringRef)font1.fontName, font1.pointSize, NULL);
    
    CTTextAlignment textAlignment = kCTTextAlignmentLeft;
    
    CGFloat minimumLineHeight = font1.pointSize, maximumLineHeight = minimumLineHeight, lineSpace2 = lineSpace;
    
    CTLineBreakMode lineBreakMode = kCTLineBreakByWordWrapping;
    
    CTParagraphStyleSetting paragraphStyleSetting[6] = {
        {kCTParagraphStyleSpecifierAlignment, sizeof(textAlignment), &textAlignment},
        {kCTParagraphStyleSpecifierMinimumLineHeight, sizeof(minimumLineHeight), &minimumLineHeight},
        {kCTParagraphStyleSpecifierMaximumLineHeight, sizeof(maximumLineHeight), &maximumLineHeight},
        {kCTParagraphStyleSpecifierMinimumLineSpacing, sizeof(lineSpace2), &lineSpace2},
        {kCTParagraphStyleSpecifierMaximumLineSpacing, sizeof(lineSpace2), &lineSpace2},
        {kCTParagraphStyleSpecifierLineBreakMode, sizeof(lineBreakMode), &lineBreakMode}
    };
    
    CTParagraphStyleRef paragraphStyleRef = CTParagraphStyleCreate(paragraphStyleSetting, 6);
    
    NSDictionary *attributes2 = @{
                                 (NSString *)kCTFontAttributeName : (__bridge id)fontRef,
                                 (NSString *)kCTParagraphStyleAttributeName : (__bridge id)paragraphStyleRef
                                 };
    CFRelease(fontRef);
    CFRelease(paragraphStyleRef);
    
    NSMutableAttributedString *mutableAttributedString = [[NSMutableAttributedString alloc] initWithString:self attributes:attributes2];
    
    CFAttributedStringRef attributedStringRef = (__bridge CFAttributedStringRef)(mutableAttributedString);
    
    CTFramesetterRef framesetterRef = CTFramesetterCreateWithAttributedString(attributedStringRef);
    
    CGSize result2 = CTFramesetterSuggestFrameSizeWithConstraints(framesetterRef, CFRangeMake(0, mutableAttributedString.length), NULL, size, NULL);
    CFRelease(framesetterRef);
    mutableAttributedString = nil;
    attributedStringRef = nil;
    return result2;
    
#if 0
    CGFloat minimumLineHeight = font1.pointSize,maximumLineHeight = minimumLineHeight, linespace = lineSpace;
    CTFontRef font = CTFontCreateWithName((__bridge CFStringRef)font1.fontName,font1.pointSize,NULL);
    CTLineBreakMode lineBreakMode = kCTLineBreakByWordWrapping;
    //Apply paragraph settings
    CTTextAlignment alignment = kCTLeftTextAlignment;
    CTParagraphStyleRef style = CTParagraphStyleCreate((CTParagraphStyleSetting[6]){
        {kCTParagraphStyleSpecifierAlignment, sizeof(alignment), &alignment},
        {kCTParagraphStyleSpecifierMinimumLineHeight,sizeof(minimumLineHeight),&minimumLineHeight},
        {kCTParagraphStyleSpecifierMaximumLineHeight,sizeof(maximumLineHeight),&maximumLineHeight},
        {kCTParagraphStyleSpecifierMaximumLineSpacing, sizeof(linespace), &linespace},
        {kCTParagraphStyleSpecifierMinimumLineSpacing, sizeof(linespace), &linespace},
        {kCTParagraphStyleSpecifierLineBreakMode,sizeof(CTLineBreakMode),&lineBreakMode}
    },6);
    NSDictionary* attributes = [NSDictionary dictionaryWithObjectsAndKeys:(__bridge id)font,(NSString*)kCTFontAttributeName,(__bridge id)style,(NSString*)kCTParagraphStyleAttributeName,nil];
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:self attributes:attributes];
    //    [self clearEmoji:string start:0 font:font1];
    CFAttributedStringRef attributedString = (__bridge CFAttributedStringRef)string;
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attributedString);
    CGSize result = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0, [string length]), NULL, size, NULL);
    CFRelease(framesetter);
    CFRelease(font);
    CFRelease(style);
    string = nil;
    attributes = nil;
    return result;
#endif
}

- (void)drawInContext:(CGContextRef)context withPosition:(CGPoint)p andFont:(UIFont *)font andTextColor:(UIColor *)color andHeight:(float)height andWidth:(float)width
{
    CGSize size = CGSizeMake(width, font.pointSize + 10);
    
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextConcatCTM(context, CGAffineTransformMake(1, 0, 0, -1, 0, height));
//    CGContextTranslateCTM(context, 0, height);
//    CGContextScaleCTM(context, 1.0, -1.0);

    UIColor *textColor = color;
    
    CGFloat minimumLineHeight = font.pointSize, maximumLineHeight = minimumLineHeight + 10, linespace = 5;
    
    CTLineBreakMode lineBreakMode = kCTLineBreakByTruncatingTail;
    
    CTTextAlignment textAlignment = kCTTextAlignmentLeft;
    
    CTParagraphStyleSetting paragraphStyleSettings[6] = {
        {kCTParagraphStyleSpecifierAlignment, sizeof(textAlignment), &textAlignment},
        {kCTParagraphStyleSpecifierLineBreakMode, sizeof(lineBreakMode), &lineBreakMode},
        {kCTParagraphStyleSpecifierMinimumLineHeight, sizeof(minimumLineHeight), &minimumLineHeight},
        {kCTParagraphStyleSpecifierMaximumLineHeight, sizeof(maximumLineHeight), &maximumLineHeight},
        {kCTParagraphStyleSpecifierMinimumLineSpacing, sizeof(linespace), &linespace},
        {kCTParagraphStyleSpecifierMaximumLineSpacing, sizeof(linespace), &linespace},
    };
    
    CTParagraphStyleRef paragraphStyle = CTParagraphStyleCreate(paragraphStyleSettings, 6);
    
    CTFontRef fontRef = CTFontCreateWithName((__bridge CFStringRef)font.fontName, font.pointSize, NULL);
    
    NSDictionary *attributes = @{
                                 (NSString *)kCTParagraphStyleAttributeName : (__bridge id)paragraphStyle,
                                 (NSString *)kCTFontAttributeName : (__bridge id)fontRef,
                                 (NSString *)kCTForegroundColorAttributeName : (__bridge id)textColor.CGColor
                                 };
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self attributes:attributes];
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)attributedString);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(p.x, height - p.y - size.height, size.width, size.height));
    
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, attributedString.length), path, NULL);
    CTFrameDraw(frame, context);
    CFRelease(framesetter);
    CFRelease(frame);
    CFRelease(fontRef);
    CFRelease(paragraphStyle);
    CGPathRelease(path);
    [[attributedString mutableString] setString:@""];

    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextConcatCTM(context, CGAffineTransformMake(1, 0, 0, -1, 0, height));
    
#if 0
    CGSize size2 = CGSizeMake(width, font.pointSize+10);
    CGContextSetTextMatrix(context,CGAffineTransformIdentity);
    CGContextTranslateCTM(context,0,height);
    CGContextScaleCTM(context,1.0,-1.0);
    
    //Determine default text color
    UIColor* textColor2 = color;
    //Set line height, font, color and break mode
    CTFontRef font1 = CTFontCreateWithName((__bridge CFStringRef)font.fontName, font.pointSize,NULL);
    //Apply paragraph settings
    CGFloat minimumLineHeight2 = font.pointSize, maximumLineHeight2 = minimumLineHeight+10, linespace2 = 5;
    CTLineBreakMode lineBreakMode2 = kCTLineBreakByTruncatingTail;
    CTTextAlignment alignment = kCTLeftTextAlignment;
    //Apply paragraph settings
    CTParagraphStyleRef style = CTParagraphStyleCreate((CTParagraphStyleSetting[6]){
        {kCTParagraphStyleSpecifierAlignment, sizeof(alignment), &alignment},
        {kCTParagraphStyleSpecifierMinimumLineHeight,sizeof(minimumLineHeight2),&minimumLineHeight2},
        {kCTParagraphStyleSpecifierMaximumLineHeight,sizeof(maximumLineHeight2),&maximumLineHeight2},
        {kCTParagraphStyleSpecifierMaximumLineSpacing, sizeof(linespace2), &linespace2},
        {kCTParagraphStyleSpecifierMinimumLineSpacing, sizeof(linespace2), &linespace2},
        {kCTParagraphStyleSpecifierLineBreakMode,sizeof(lineBreakMode2),&lineBreakMode2}
    },6);
    
    NSDictionary* attributes2 = [NSDictionary dictionaryWithObjectsAndKeys:
                                 (__bridge id)font1, (NSString*)kCTFontAttributeName,
                                textColor.CGColor, kCTForegroundColorAttributeName,
                                style, kCTParagraphStyleAttributeName,
                                nil];
    //Create path to work with a frame with applied margins
    CGMutablePathRef path2 = CGPathCreateMutable();
    CGPathAddRect(path2,NULL,CGRectMake(p.x, height-p.y-size2.height,(size2.width),(size2.height)));
    
    //Create attributed string, with applied syntax highlighting
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:self attributes:attributes];
    CFAttributedStringRef attributedString2 = (__bridge CFAttributedStringRef)attributedStr;
    
    //Draw the frame
    CTFramesetterRef framesetter2 = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attributedString);
    CTFrameRef ctframe = CTFramesetterCreateFrame(framesetter, CFRangeMake(0,CFAttributedStringGetLength(attributedString2)),path,NULL);
    CTFrameDraw(ctframe,context);
    CGPathRelease(path2);
    CFRelease(font1);
    CFRelease(framesetter);
    CFRelease(ctframe);
    [[attributedStr mutableString] setString:@""];
    CGContextSetTextMatrix(context,CGAffineTransformIdentity);
    CGContextTranslateCTM(context,0, height);
    CGContextScaleCTM(context,1.0,-1.0);
#endif
}

- (void)drawInContext:(CGContextRef)context withPosition:(CGPoint)p andFont:(UIFont *)font andTextColor:(UIColor *)color andHeight:(float)height{
    [self drawInContext:context withPosition:p andFont:font andTextColor:color andHeight:height andWidth:CGFLOAT_MAX];
}

@end
