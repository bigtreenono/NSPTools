//
//  VVeboLabel.m
//  VVeboTableViewDemo
//
//  Created by Johnil on 15/5/25.
//  Copyright (c) 2015年 Johnil. All rights reserved.
//

#import "VVeboLabel.h"
#import "UIView+Additions.h"
#import <CoreText/CoreText.h>

#define kRegexHighlightViewTypeURL @"url"
#define kRegexHighlightViewTypeAccount @"account"
#define kRegexHighlightViewTypeTopic @"topic"
#define kRegexHighlightViewTypeEmoji @"emoji"

#define URLRegular @"(http|https)://(t.cn/|weibo.com/)+(([a-zA-Z0-9/])*)"
#define EmojiRegular @"(\\[\\w+\\])"
#define AccountRegular @"@[\u4e00-\u9fa5a-zA-Z0-9_-]{2,30}"
#define TopicRegular @"#[^#]+#"

CTTextAlignment CTTextAlignmentFromUITextAlignment(NSTextAlignment alignment)
{
    switch (alignment)
    {
        case NSTextAlignmentLeft: return kCTLeftTextAlignment;
        case NSTextAlignmentCenter: return kCTCenterTextAlignment;
        case NSTextAlignmentRight: return kCTRightTextAlignment;
        default: return kCTNaturalTextAlignment;
    }
}

@implementation VVeboLabel
{
    UIImageView *labelImageView;
    UIImageView *highlightImageView;
    BOOL highlighting;
    BOOL btnLoaded;
    BOOL emojiLoaded;
    NSRange currentRange;
    NSMutableDictionary *highlightColors;
    NSMutableDictionary *framesDict;
    NSInteger drawFlag;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        drawFlag = arc4random();
        
        framesDict = [NSMutableDictionary dictionary];
        
        highlightColors = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                           [UIColor colorWithRed:106/255.0 green:140/255.0 blue:181/255.0 alpha:1],kRegexHighlightViewTypeAccount,
                           [UIColor colorWithRed:106/255.0 green:140/255.0 blue:181/255.0 alpha:1],kRegexHighlightViewTypeURL,
                           [UIColor colorWithRed:106/255.0 green:140/255.0 blue:181/255.0 alpha:1],kRegexHighlightViewTypeEmoji,
                           [UIColor colorWithRed:106/255.0 green:140/255.0 blue:181/255.0 alpha:1],kRegexHighlightViewTypeTopic, nil];
        
        labelImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -5, frame.size.width, frame.size.height + 10)];
        labelImageView.contentMode = UIViewContentModeScaleAspectFit;
        labelImageView.tag = NSIntegerMin;
        labelImageView.clipsToBounds = YES;
        [self addSubview:labelImageView];

        highlightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -5, frame.size.width, frame.size.height + 10)];
        highlightImageView.contentMode = UIViewContentModeScaleAspectFit;
        highlightImageView.tag = NSIntegerMin;
        highlightImageView.clipsToBounds = YES;
        highlightImageView.backgroundColor = [UIColor clearColor];
        [self addSubview:highlightImageView];

        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor clearColor];
        self.clipsToBounds = NO;
        _textAlignment = NSTextAlignmentLeft;
        _textColor = [UIColor blackColor];
        _font = [UIFont fontWithName:@"HelveticaNeue-Light" size:17];
        _lineSpace = 5;
    }
    return self;
}

// Fix Coretext height
- (void)setFrame:(CGRect)frame
{
    if (!CGSizeEqualToSize(labelImageView.image.size, frame.size))
    {
        labelImageView.image = nil;
        highlightImageView.image = nil;
    }
    labelImageView.frame = CGRectMake(0, -5, frame.size.width, frame.size.height + 10);
    highlightImageView.frame = CGRectMake(0, -5, frame.size.width, frame.size.height + 10);
    [super setFrame:frame];
}

- (NSMutableAttributedString *)highlightText:(NSMutableAttributedString *)coloredString
{
    NSString *string = coloredString.string;
    NSRange range = NSMakeRange(0, string.length);
    NSDictionary *definition = @{
                                 kRegexHighlightViewTypeAccount : AccountRegular,
                                 kRegexHighlightViewTypeURL : URLRegular,
                                 kRegexHighlightViewTypeTopic : TopicRegular,
                                 kRegexHighlightViewTypeEmoji : EmojiRegular,
                                 };
    for (NSString *key in definition)
    {
        NSString *expression = definition[key];
        NSArray *matches = [[NSRegularExpression regularExpressionWithPattern:expression options:NSRegularExpressionDotMatchesLineSeparators error:nil] matchesInString:string options:0 range:range];
        for (NSTextCheckingResult *match in matches)
        {
            if (labelImageView.image &&
                currentRange.location != -1 &&
                currentRange.location >= match.range.location &&
                currentRange.length + currentRange.location <= match.range.length + match.range.location)
            {
                [coloredString addAttribute:(NSString *)kCTForegroundColorAttributeName
                                      value:(id)[UIColor colorWithRed:224/255.0 green:44/255.0 blue:86/255.0 alpha:1].CGColor
                                      range:match.range];
                double delayInSeconds = 1.5;
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                    [self backToNormal];
                });
            }
            else
            {
                UIColor *highlightColor = highlightColors[key];
                [coloredString addAttribute:(NSString *)kCTForegroundColorAttributeName value:(id)highlightColor.CGColor range:match.range];
            }
        }
    }
    return coloredString;
}

// 使用coretext将文本绘制到图片。
- (void)setText:(NSString *)text
{
    if (!text || text.length <= 0)
    {
        labelImageView.image = nil;
        highlightImageView.image = nil;
        return;
    }
    if ([text isEqualToString:_text] && (!highlighting || currentRange.location == -1))
    {
        return;
    }
    if (highlighting && !labelImageView.image)
    {
        return;
    }
    if (!highlighting)
    {
        [framesDict removeAllObjects];
        currentRange = NSMakeRange(-1, -1);
    }
    NSInteger flag = drawFlag;
    BOOL isHighight = highlighting;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

        _text = text;
        CGSize size = self.frame.size;
        size.height += 10;
        UIGraphicsBeginImageContextWithOptions(size, ![self.backgroundColor isEqual:[UIColor clearColor]], 0);
        CGContextRef context = UIGraphicsGetCurrentContext();
        if (context == NULL)
        {
            return ;
        }
        if (![self.backgroundColor isEqual:[UIColor clearColor]])
        {
            [self.backgroundColor set];
            CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height));
        }
        CGContextSetTextMatrix(context, CGAffineTransformIdentity);
        CGContextConcatCTM(context, CGAffineTransformMake(1, 0, 0, -1, 0, size.height));
        
        CGFloat minimumLineHeight = _font.pointSize, maximumLineHeight = minimumLineHeight, linespace = _lineSpace;
        CTLineBreakMode lineBreakMode = kCTLineBreakByWordWrapping;
        CTTextAlignment textAlignment = (CTTextAlignment)_textAlignment;
//        CTTextAlignment textAlignment = CTTextAlignmentFromUITextAlignment(_textAlignment);

        CTParagraphStyleSetting paragraphStyleSettings[6] = {
            {kCTParagraphStyleSpecifierAlignment, sizeof(textAlignment), &textAlignment},
            {kCTParagraphStyleSpecifierLineBreakMode, sizeof(lineBreakMode), &lineBreakMode},
            {kCTParagraphStyleSpecifierMinimumLineHeight, sizeof(minimumLineHeight), &minimumLineHeight},
            {kCTParagraphStyleSpecifierMaximumLineHeight, sizeof(maximumLineHeight), &maximumLineHeight},
            {kCTParagraphStyleSpecifierMinimumLineSpacing, sizeof(linespace), &linespace},
            {kCTParagraphStyleSpecifierMaximumLineSpacing, sizeof(linespace), &linespace}
        };
        
        CTParagraphStyleRef paragraphStyleRef = CTParagraphStyleCreate(paragraphStyleSettings, 6);
        
        CTFontRef fontRef = CTFontCreateWithName((__bridge CFStringRef)_font.fontName, _font.pointSize, NULL);
        NSDictionary *attributes = @{
                                     (NSString *)kCTFontAttributeName : (__bridge id)fontRef,
                                     (NSString *)kCTParagraphStyleAttributeName : (__bridge id)paragraphStyleRef,
                                     (NSString *)kCTForegroundColorAttributeName : _textColor
                                     };
        CFRelease(fontRef);
        CFRelease(paragraphStyleRef);
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:_text attributes:attributes];
        CTFramesetterRef framesetterRef = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)[self highlightText:attributedString]);

        CGRect rect = CGRectMake(0, 5, size.width, size.height - 5);

        [self drawFramesetter:framesetterRef attributedString:attributedString textRange:CFRangeMake(0, text.length) inRect:rect context:context];
        
        CGContextSetTextMatrix(context, CGAffineTransformIdentity);
        CGContextConcatCTM(context, CGAffineTransformMake(1, 0, 0, -1, 0, size.height));
        
        UIImage *screenShotImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [[attributedString mutableString] setString:@""];
            if (drawFlag == flag)
            {
                if (isHighight)
                {
                    if (highlighting)
                    {
                        highlightImageView.image = nil;
                        if (highlightImageView.width != screenShotImage.size.width)
                        {
                            highlightImageView.width = screenShotImage.size.width;
                        }
                        if (highlightImageView.height != screenShotImage.size.height)
                        {
                            highlightImageView.height = screenShotImage.size.height;
                        }
                        highlightImageView.image = screenShotImage;
                    }
                }
                else
                {
                    if (labelImageView.width != screenShotImage.size.width)
                    {
                        labelImageView.width = screenShotImage.size.width;
                    }
                    if (labelImageView.height != screenShotImage.size.height)
                    {
                        labelImageView.height = screenShotImage.size.height;
                    }
                    highlightImageView.image = nil;
                    labelImageView.image = nil;
                    labelImageView.image = screenShotImage;
                }
            }
        });
    });
}

// 确保行高一致，计算所需触摸区域
- (void)drawFramesetter:(CTFramesetterRef)framesetter
       attributedString:(NSAttributedString *)attributedString
              textRange:(CFRange)textRange
                 inRect:(CGRect)rect
                context:(CGContextRef)c
{
    CGMutablePathRef pathRef = CGPathCreateMutable();
    CGPathAddRect(pathRef, NULL, rect);
    
    CTFrameRef frameRef = CTFramesetterCreateFrame(framesetter, textRange, pathRef, NULL);
    CFRelease(framesetter);
    
    CFArrayRef lines = CTFrameGetLines(frameRef);
    CFIndex numberOfLines = CFArrayGetCount(lines);

    CGPoint lineOrigins[numberOfLines];
    CTFrameGetLineOrigins(frameRef, CFRangeMake(0, numberOfLines), lineOrigins);
    
    BOOL truncateLastLine = NO; // tailMode
    
    for (CFIndex lineIndex = 0; lineIndex < numberOfLines; lineIndex++)
    {
        CGPoint lineOrigin = lineOrigins[lineIndex];
        lineOrigin = CGPointMake(ceil(lineOrigin.x), ceil(lineOrigin.y));
        
        CGContextSetTextPosition(c, lineOrigin.x, lineOrigin.y);
        
        CTLineRef line = CFArrayGetValueAtIndex(lines, lineIndex);
        
        CGFloat descent;
        CGFloat ascent;
        CGFloat lineLeading;

        CTLineGetTypographicBounds(line, &ascent, &descent, &lineLeading);
        
        CGFloat flushFactor = NSTextAlignmentLeft;
        CGFloat penOffset;
        CGFloat y;
        if (lineIndex == numberOfLines - 1 && truncateLastLine)
        {
            // Check if the range of text in the last line reaches the end of the full attributed string
            CFRange lastLineRange = CTLineGetStringRange(line);
            
            if (!(lastLineRange.length == 0 && lastLineRange.location == 0) && lastLineRange.location + lastLineRange.length < textRange.location + textRange.length)
            {
                // Get correct truncationType and attribute position
                CTLineTruncationType truncationType = kCTLineTruncationEnd;
                CFIndex truncationAttributePosition = lastLineRange.location;
                
                NSString *truncationTokenString = @"\u2026";
                
                NSDictionary *truncationTokenStringAttributes = [attributedString attributesAtIndex:(NSUInteger)truncationAttributePosition effectiveRange:NULL];
                
                NSAttributedString *attributedTokenString = [[NSAttributedString alloc] initWithString:truncationTokenString attributes:truncationTokenStringAttributes];
                CTLineRef truncationToken = CTLineCreateWithAttributedString((__bridge CFAttributedStringRef)attributedTokenString);
                
                // Append truncationToken to the string
                // because if string isn't too long, CT wont add the truncationToken on it's own
                // There is no change of a double truncationToken because CT only add the token if it removes characters (and the one we add will go first)
                NSMutableAttributedString *truncationString = [[attributedString attributedSubstringFromRange:NSMakeRange((NSUInteger)lastLineRange.location, (NSUInteger)lastLineRange.length)] mutableCopy];
                if (lastLineRange.length > 0) {
                    // Remove any newline at the end (we don't want newline space between the text and the truncation token). There can only be one, because the second would be on the next line.
                    unichar lastCharacter = [[truncationString string] characterAtIndex:(NSUInteger)(lastLineRange.length - 1)];
                    if ([[NSCharacterSet newlineCharacterSet] characterIsMember:lastCharacter]) {
                        [truncationString deleteCharactersInRange:NSMakeRange((NSUInteger)(lastLineRange.length - 1), 1)];
                    }
                }
                [truncationString appendAttributedString:attributedTokenString];
                CTLineRef truncationLine = CTLineCreateWithAttributedString((__bridge CFAttributedStringRef)truncationString);
                
                // Truncate the line in case it is too long.
                CTLineRef truncatedLine = CTLineCreateTruncatedLine(truncationLine, rect.size.width, truncationType, truncationToken);
                if (!truncatedLine) {
                    // If the line is not as wide as the truncationToken, truncatedLine is NULL
                    truncatedLine = CFRetain(truncationToken);
                }
                
                penOffset = (CGFloat)CTLineGetPenOffsetForFlush(truncatedLine, flushFactor, rect.size.width);
                y = lineOrigin.y - descent - self.font.descender;
                CGContextSetTextPosition(c, penOffset, y);
                
                CTLineDraw(truncatedLine, c);
                
                CFRelease(truncatedLine);
                CFRelease(truncationLine);
                CFRelease(truncationToken);
            }
            else
            {
                penOffset = (CGFloat)CTLineGetPenOffsetForFlush(line, flushFactor, rect.size.width);
                y = lineOrigin.y - descent - self.font.descender;
                CGContextSetTextPosition(c, penOffset, y);
                CTLineDraw(line, c);
            }
        }
        else
        {
            penOffset = CTLineGetPenOffsetForFlush(line, flushFactor, rect.size.width);
            y = lineOrigin.y - descent - _font.descender;
            CGContextSetTextPosition(c, penOffset, y);
            CTLineDraw(line, c);
        }
        if (!highlighting && self.superview)
        {
            CFArrayRef runs = CTLineGetGlyphRuns(line);
            for (CFIndex runIndex = 0; runIndex < CFArrayGetCount(runs); ++runIndex)
            {
                CTRunRef run = CFArrayGetValueAtIndex(runs, runIndex);
                NSDictionary *attributes = (__bridge NSDictionary *)CTRunGetAttributes(run);
                if (!CGColorEqualToColor((__bridge CGColorRef)attributes[@"CTForegroundColor"], _textColor.CGColor) && framesDict)
                {
                    CFRange range = CTRunGetStringRange(run);
                    CGRect runRect;
                    CGFloat runAscent, runDescent;
                    runRect.size.width = CTRunGetTypographicBounds(run, CFRangeMake(0, 0), &runAscent, &runDescent, NULL);
                    
                    CGFloat offset = CTLineGetOffsetForStringIndex(line, range.location, NULL);
                    CGFloat height = runAscent;
                    runRect = CGRectMake(lineOrigin.x + offset, (self.height + 5) - y - height + runDescent / 2, runRect.size.width, height);
                    NSRange nRange = NSMakeRange(range.location, range.length);
                    [framesDict setValue:[NSValue valueWithCGRect:runRect] forKey:NSStringFromRange(nRange)];
                }
            }
        }
    }
    CFRelease(frameRef);
    CGPathRelease(pathRef);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint location = [[touches anyObject] locationInView:self];
    for (NSString *key in framesDict.allKeys)
    {
        CGRect frame = [framesDict[key] CGRectValue];
        if (CGRectContainsPoint(frame, location))
        {
            NSRange range = NSRangeFromString(key);
            currentRange = NSMakeRange(0, range.length - 1);
            [self highlightWord];
        }
    }
}

- (void)highlightWord
{
    highlighting = YES;
    [self setText:_text];
}

- (void)backToNormal
{
    if (!highlighting)
    {
        return;
    }
    highlighting = NO;
    currentRange = NSMakeRange(-1, -1);
    highlightImageView.image = nil;
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    if (highlighting)
    {
        [self backToNormal];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    if (highlighting)
    {
        double delayInSeconds = .2;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [self backToNormal];
        });
    }
}

- (void)clear
{
    drawFlag = arc4random();
    _text = @"";
    labelImageView.image = nil;
    highlightImageView.image = nil;
    
    for (UIView *temp in self.subviews)
    {
        if (temp.tag != NSIntegerMin)
        {
            if ([temp isKindOfClass:[UIImageView class]])
            {
                [(UIImageView *)temp setImage:nil];
            }
            [temp removeFromSuperview];
        }
    }
}

- (void)removeFromSuperview
{
    [highlightColors removeAllObjects];
    highlightColors = nil;
    [framesDict removeAllObjects];
    framesDict = nil;
    highlightImageView.image = nil;
    labelImageView.image = nil;
    [super removeFromSuperview];
}

- (void)dealloc
{
    NSLog(@"dealloc %@", self);
}

@end

































