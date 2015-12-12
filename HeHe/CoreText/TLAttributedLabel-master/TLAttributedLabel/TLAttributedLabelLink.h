//
//  TLCoreTextLink.h
//  TLAttributedLabel-Demo
//
//  Created by andezhou on 15/7/7.
//  Copyright (c) 2015年 andezhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>
@class TLAttributeConfig;

static NSString *const contentUrl = @" 网页连接 ";

/**
 kCoreTextLnkDataDefault 张三
 kCoreTextLnkDataUrl     网址
 kCoreTextLnkDataUser    @张三
 kCoreTextLnkDataTopic   #话题#
 */
typedef enum : NSUInteger {
    kCoreTextLnkDataDefault = 0,
    kCoreTextLnkDataUrl,
    kCoreTextLnkDataUser,
    kCoreTextLnkDataTopic
} CoreTextLnkDataType;

@interface TLAttributedLabelLink : NSObject

/**
 *  需要显示的内容
 */
@property (strong, nonatomic) NSString *title;

/**
 *  网址，kCoreTextLnkDataUrl独有
 */
@property (strong, nonatomic) NSString *url;

/**
 *  link在该行的range，用来计算link的位置
 */
@property (assign, nonatomic) NSRange range;

/**
 *  该条link的类型
 */
@property (assign, nonatomic) CoreTextLnkDataType type;

/**
 *  该link对应的坐标，此坐标是CoreText的坐标系，而不是UIKit的坐标系
 */
@property (nonatomic) CGRect linkPosition;

/**
 *  用来保存是否需要显示url
 */
@property (assign, nonatomic) BOOL showUrl;

/**
 *  检查出所有的link，并以数组的形式返回
 *
 *  @param content   需要检查的字符串
 *  @param linkArray 永不自定义的link
 *  @param showUrl   是否显示url
 *
 *  @return 对应的link数组和文字数组
 */
+ (NSDictionary *)detectLinksFromContent:(NSString *)content links:(NSArray *)linkArray showUrl:(BOOL)showUrl;

@end
