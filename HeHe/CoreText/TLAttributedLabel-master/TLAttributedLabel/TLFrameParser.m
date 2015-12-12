//
//  TLFrameParser.m
//  TLAttributedLabel-Demo
//
//  Created by andezhou on 15/7/7.
//  Copyright (c) 2015年 andezhou. All rights reserved.
//
//  用于生成最后绘制界面需要的CTFrameRef实例。

#import "TLFrameParser.h"

@implementation TLFrameParser

#pragma mark -
#pragma mark 通过传入需要展示的文字，来获取CTFrameRef实例以及CTFrameRef实际绘制需要的高度
+ (TLCoreTextData *)parseContent:(NSString *)content config:(TLAttributeConfig *)config link:(NSArray *)linkArray {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] init];
    
    NSMutableArray *images = [NSMutableArray array];
    NSMutableArray *links = [NSMutableArray array];

    // 图片与文字分离
    NSArray *array = [TLAttributedLabelImage detectImagesFromContent:content];
    NSUInteger length = 0;
    NSDictionary *attributes = [self attributesWithConfig:config];
    CTFontRef fontRef = CTFontCreateWithName((CFStringRef)config.fontName, config.fontSize, NULL);
    UIFont *font = (__bridge UIFont *)fontRef;
    
    for (NSDictionary *dict in array) {
        if (dict[@"txt"]) {
            NSDictionary *linkDict = [TLAttributedLabelLink detectLinksFromContent:dict[@"txt"] links:linkArray showUrl:config.showUrl];
            [links addObjectsFromArray:linkDict[@"link"]];

            NSMutableAttributedString *as = [[NSMutableAttributedString alloc] initWithString:linkDict[@"con"] attributes:attributes];
            
            for (TLAttributedLabelLink *linkData in linkDict[@"link"]) {
                NSRange range = linkData.range;
                
                // 如果是链接 添加下划线
                if (linkData.type == kCoreTextLnkDataUrl) {
                    
                    if (config.showUrl) {
                        [as addAttribute:(NSString *)kCTUnderlineStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleSingle] range:range];
                    }else {
                        // 添加链接图标
                        TLAttributedLabelImage *imageData = [[TLAttributedLabelImage alloc] init];
                        imageData.imageName = @"timeline_card_small_web";
                        imageData.imageSize = CGSizeMake(font.pointSize, font.pointSize);
                        imageData.allowClick = NO;
                        
                        NSAttributedString *img = [imageData parseImageDataFromConfig:config attributes:attributes];
                        [as insertAttributedString:img atIndex:range.location];
                        
                        [images addObject:imageData];
                    }
                }
                
                // 设置字体颜色
                [as removeAttribute:(NSString *)kCTForegroundColorAttributeName range:range];
                [as addAttribute:(NSString *)kCTForegroundColorAttributeName value:config.highlightedLinkColor range:range];
                
                linkData.range = NSMakeRange(linkData.range.location + length, linkData.range.length);
            }
            length += as.length;
            [attributedString appendAttributedString:as];
            
        }else{
            // 图片
            UIImage *image = [UIImage imageNamed:dict[@"img"]];
            TLAttributedLabelImage *imageData = [[TLAttributedLabelImage alloc] init];
            imageData.imageName = dict[@"img"];
            imageData.imageSize = image.size;
            
            NSAttributedString *as = [imageData parseImageDataFromConfig:config attributes:attributes];
            [attributedString appendAttributedString:as];
            
            length ++;
            [images addObject:imageData];
        }
    }
    
    TLCoreTextData *data = [self parseAttributedContent:attributedString config:config];
    data.linkArray = links;
    data.imageArray = images;
    
    return data;
}

+ (TLCoreTextData *)parseContent:(NSString *)content link:(NSArray *)links {
    TLAttributeConfig *config = [[TLAttributeConfig alloc] init];
    return [self parseContent:content config:config link:links];
}

+ (TLCoreTextData *)parseContent:(NSString *)content config:(TLAttributeConfig *)config {
    return [self parseContent:content config:config link:@[]];
}

+ (TLCoreTextData *)parseContent:(NSString *)content {
    TLAttributeConfig *config = [[TLAttributeConfig alloc] init];
    return [self parseContent:content config:config];
}

#pragma mark -
#pragma mark 通过已配置好的带属性字符串， 来获取CTFrameRef实例以及CTFrameRef实际绘制需要的高度
+ (TLCoreTextData *)parseAttributedContent:(NSMutableAttributedString *)attrString
                                  config:(TLAttributeConfig *)config {
    // 创建 CTFramesetterRef 实例
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attrString);
    
    // 获得要缓制的区域的高度
    CGSize restrictSize = CGSizeMake(config.width - 2*config.offset.x, CGFLOAT_MAX);
    CGSize coreTextSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0, 0), nil, restrictSize, nil);
    CGFloat textHeight = coreTextSize.height + 2*config.offset.y;
    
    // 生成 CTFrameRef 实例
    CTFrameRef frame = [self createFrameWithFramesetter:framesetter config:config height:textHeight];
    
    // 将生成好的 CTFrameRef 实例和计算好的缓制高度保存到 CoreTextData 实例中，最后返回 CoreTextData 实例
    TLCoreTextData *data = [[TLCoreTextData alloc] init];
    data.ctFrame = frame;
    data.height = textHeight;
    data.config = config;
    data.attributedString = attrString;

    // 释放内存
    CFRelease(frame);
    CFRelease(framesetter);
    return data;
}

+ (TLCoreTextData *)parseAttributedContent:(NSMutableAttributedString *)attributedString {
    TLAttributeConfig *config = [[TLAttributeConfig alloc] init];
    return [self parseAttributedContent:attributedString config:config];
}

#pragma mark -
#pragma mark 通过沙盒地址， 来获取CTFrameRef实例以及CTFrameRef实际绘制需要的高度
+ (TLCoreTextData *)parseTemplateFile:(NSString *)path
                             config:(TLAttributeConfig *)config {
    // 1.从文件中获取数据
    NSData *data = [NSData dataWithContentsOfFile:path];
    if (!data) return nil;
    
    // 2.把二进制文件转化为数组（NSArray）
    NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    // 3.返回CoreTextData
    return [self parseTemplateArray:array config:config];
}

+ (TLCoreTextData *)parseTemplateFile:(NSString *)path {
    TLAttributeConfig *config = [[TLAttributeConfig alloc] init];
    return [self parseTemplateFile:path config:config];
}

#pragma mark -
#pragma mark 通过网络获取下来的数组（NSArray），来获取CTFrameRef实例以及CTFrameRef实际绘制需要的高度
+ (TLCoreTextData *)parseTemplateArray:(NSArray *)dataList
                              config:(TLAttributeConfig *)config {
    NSMutableArray *images = [NSMutableArray array];
    NSMutableArray *links = [NSMutableArray array];
    // 获取带属性的字符串
    NSMutableAttributedString *attributedString = [self appendAttributedStringWithDataList:dataList imageList:images linkArray:links config:config];
    
    // 生成CoreTextData
    TLCoreTextData *data = [self parseAttributedContent:attributedString config:config];
    data.imageArray = images;
    data.linkArray = links;

    return data;
}

+ (TLCoreTextData *)parseTemplateArray:(NSArray *)dataList {
    TLAttributeConfig *config = [[TLAttributeConfig alloc] init];
    return [self parseTemplateArray:dataList config:config];
}

#pragma mark 通过遍历数组获得每条数据的属性并拼接为生成带属性的可变字符串
+ (NSMutableAttributedString *)appendAttributedStringWithDataList:(NSArray *)dataList
                                                        imageList:(NSMutableArray *)images
                                                        linkArray:(NSMutableArray *)links
                                                           config:(TLAttributeConfig *)config {
    NSMutableAttributedString *result = [[NSMutableAttributedString alloc] init];
    
    //遍历数组获取每条数据的属性
    for (NSDictionary *dict in dataList) {
        NSString *type = dict[@"type"];
        TLAttributeConfig *newConfig = [config refreshAttributeConfigWithDict:dict];
        NSMutableDictionary *attributes = [self attributesWithConfig:newConfig];

        if ([type isEqualToString:@"txt"]) {      //处理文字逻辑
            
            NSMutableAttributedString *as = [[NSMutableAttributedString alloc] initWithString:dict[@"content"] attributes:attributes];
            [result appendAttributedString:as];
            
        }else if ([type isEqualToString:@"img"]){ // 处理图片逻辑
            
            TLAttributedLabelImage *imageData = [[TLAttributedLabelImage alloc] init];
            imageData.imageName = dict[@"name"];
            imageData.imageSize = CGSizeMake([dict[@"width"] floatValue], [dict[@"height"] floatValue]);
            
            NSAttributedString *as = [imageData parseImageDataFromConfig:newConfig attributes:attributes];
            [result appendAttributedString:as];
        
            [images addObject:imageData];
        }else if ([type isEqualToString:@"link"]) { // 处理链接逻辑
            
            if (config.showUrl) { // 显示url的时候添加下横线
                attributes[(id)kCTUnderlineStyleAttributeName] = [NSNumber numberWithInt:NSUnderlineStyleSingle];
            }

            NSMutableAttributedString *as = [[NSMutableAttributedString alloc] initWithString:dict[@"content"] attributes:attributes];
            [result appendAttributedString:as];
            
            // 创建 CoreTextLinkData
            TLAttributedLabelLink *linkData = [[TLAttributedLabelLink alloc] init];
            linkData.url = dict[@"url"];
            linkData.type = kCoreTextLnkDataUrl;
            linkData.range = NSMakeRange(result.length - as.length, as.length);
            [links addObject:linkData];
        }
    }
    
    return result;
}

#pragma mark 生成带属性的字符串的attributes
+ (NSMutableDictionary *)attributesWithConfig:(TLAttributeConfig *)config {
    // 设置字体类型和大小
    CTFontRef fontRef = CTFontCreateWithName((CFStringRef)config.fontName, config.fontSize, NULL);    
    // 行间距
    CGFloat lineSpacing            = config.lineSpace;
    // 段间距
    CGFloat paragraphSpacing       = config.paragraphSpacing;
    // 文字排版样式
    CTTextAlignment textAlignment  = config.textAlignment;
    // 断行模式
    CTLineBreakMode lineBreakMode  = config.lineBreakMode;
    
    // 设置行间距
    const CFIndex kNumberOfSettings = 6;
    CTParagraphStyleSetting theSettings[kNumberOfSettings] = {
        {kCTParagraphStyleSpecifierLineBreakMode, sizeof(uint8_t), &lineBreakMode},
        {kCTParagraphStyleSpecifierAlignment, sizeof(uint8_t), &textAlignment},
        {kCTParagraphStyleSpecifierParagraphSpacing, sizeof(CGFloat), &paragraphSpacing},
        {kCTParagraphStyleSpecifierLineSpacingAdjustment, sizeof(CGFloat), &lineSpacing},
        {kCTParagraphStyleSpecifierMaximumLineSpacing, sizeof(CGFloat), &lineSpacing},
        {kCTParagraphStyleSpecifierMinimumLineSpacing, sizeof(CGFloat), &lineSpacing}
    };
    
    CTParagraphStyleRef theParagraphRef = CTParagraphStyleCreate(theSettings, kNumberOfSettings);
    UIColor *textColor = config.textColor;
    
    // 生成带属性的字符串的attributes
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[(id)kCTForegroundColorAttributeName] = (id)textColor.CGColor;
    dict[(id)kCTFontAttributeName] = (__bridge id)fontRef;
    dict[(id)kCTParagraphStyleAttributeName] = (__bridge id)theParagraphRef;

    CFRelease(theParagraphRef);
    CFRelease(fontRef);
    
    return dict;
}

#pragma mark 将坐标系上下翻转
+ (CTFrameRef)createFrameWithFramesetter:(CTFramesetterRef)framesetter
                                  config:(TLAttributeConfig *)config
                                  height:(CGFloat)height {
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPathAddRect(path, NULL, CGRectMake(config.offset.x, -config.offset.y, config.width - 2*config.offset.x, height));
    
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, NULL);
    CFRelease(path);
    return frame;
}

@end
