//
//  TLCoreTextLink.m
//  TLAttributedLabel-Demo
//
//  Created by andezhou on 15/7/7.
//  Copyright (c) 2015年 andezhou. All rights reserved.
//

#import "TLAttributedLabelLink.h"
#import "TLAttributeConfig.h"
#import "TLAttributedLabelUtils.h"

// 检查URL/@/##/手机号
static NSString *const pattern = @"(@([\u4e00-\u9fa5A-Z0-9a-z(é|ë|ê|è|à|â|ä|á|ù|ü|û|ú|ì|ï|î|í)._-]+))|(#[\u4e00-\u9fa5A-Z0-9a-z(é|ë|ê|è|à|â|ä|á|ù|ü|û|ú|ì|ï|î|í)._-]+#)|((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)";

@implementation TLAttributedLabelLink

#pragma mark -
#pragma mark 检查出所有的link，并以数组的形式返回
+ (NSDictionary *)detectLinksFromContent:(NSString *)content
                              links:(NSArray *)linkArray
                             showUrl:(BOOL)showUrl {
    // 处理自定义的link
    NSMutableArray *links = [NSMutableArray array];
    for (NSString *link in linkArray) {
        NSRange range = [content rangeOfString:link];
        if (range.location == NSNotFound) continue;
        
        TLAttributedLabelLink *linkData = [[TLAttributedLabelLink alloc] init];
        linkData.title = link;
        linkData.range = range;
        linkData.type = kCoreTextLnkDataDefault;
        [links addObject:linkData];
    }
    
    // 处理@、#、url和手机号码
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
    [regex enumerateMatchesInString:content options:0 range:NSMakeRange(0, content.length) usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
        
        NSString *txt = [content substringWithRange:result.range];
        TLAttributedLabelLink *linkData = [[TLAttributedLabelLink alloc] init];
        linkData.title = txt;
        linkData.range = result.range;
        [links addObject:linkData];

        if ([txt hasPrefix:@"@"]) {
            linkData.type = kCoreTextLnkDataUser;
        } else if ([txt hasPrefix:@"#"]) {
            linkData.type = kCoreTextLnkDataTopic;
        }  else {
            linkData.type = kCoreTextLnkDataUrl;
            linkData.url = txt;
        }
    }];
    
    // 替换URL
    NSMutableString *result = [[NSMutableString alloc] initWithString:content];
    if (!showUrl) {
        [self replaceUrlFromLinks:links content:result];
    }
    
    return @{@"link" : links, @"con" : result};
}

+ (void)replaceUrlFromLinks:(NSArray *)links content:(NSMutableString *)content {
    NSUInteger length = 0;
    NSUInteger imgIndex = 0;
    for (TLAttributedLabelLink *linkData in links) {
        // link新的range
        NSRange range = NSMakeRange(linkData.range.location - length, linkData.range.length);
        if (linkData.type == kCoreTextLnkDataUrl) {
            imgIndex ++;
            
            linkData.range = NSMakeRange(linkData.range.location - length + imgIndex, contentUrl.length - 1);
            linkData.title = contentUrl;
            
            [content replaceCharactersInRange:range withString:contentUrl];
            length += range.length - contentUrl.length;
        }else {
            linkData.range = NSMakeRange(range.location + imgIndex, range.length);
        }
    }
}

@end
