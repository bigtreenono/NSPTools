//
//  UIImage+FNSystemImage.m
//  FNMarket
//
//  Created by FNNishipu on 10/26/15.
//  Copyright © 2015 cn.com.feiniu. All rights reserved.
//

#import "UIImage+FNAppImage.h"

@implementation UIImage (FNAppImage)

+ (NSString *)splashImageNameForOrientation:(UIDeviceOrientation)orientation
{
    CGSize viewSize = [UIScreen mainScreen].bounds.size;
    NSString *viewOrientation = @"Portrait";
    if (UIDeviceOrientationIsLandscape(orientation))
    {
        viewSize = CGSizeMake(viewSize.height, viewSize.width);
        viewOrientation = @"Landscape";
    }
    NSArray *imagesDict = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    for (NSDictionary *dict in imagesDict)
    {
        CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
        if (CGSizeEqualToSize(imageSize, viewSize) &&
            [viewOrientation isEqualToString:dict[@"UILaunchImageOrientation"]])
        {
            return dict[@"UILaunchImageName"];
        }
    }
    return nil;
}

+ (NSString *)fn_iconImageName
{
    NSDictionary *iconInfo = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleIcons"];
    NSDictionary *primaryIcon = iconInfo[@"CFBundlePrimaryIcon"];
    NSArray *iconFiles = primaryIcon[@"CFBundleIconFiles"];
    return iconFiles.count ? iconFiles.lastObject : nil;
}

+ (UIImage *)fn_lanuchImage
{
    return [self fn_lanuchImageForOrientation:UIDeviceOrientationPortrait];
}

+ (UIImage *)fn_lanuchImageForOrientation:(UIDeviceOrientation)orientation
{
    return [UIImage imageNamed:[self splashImageNameForOrientation:orientation]];
}

+ (UIImage *)fn_appIconImage
{
    return [UIImage imageNamed:[self fn_iconImageName]];
}

+ (UIImage *)test
{
#if FNMarket
NSString *imageName = @"FNMarketLaunchImage";
#else
NSString *imageName = @"RTMartLaunchImage";
#endif
    NSDictionary *launchImageInfo = @{ @"320x480" : [NSString stringWithFormat:@"%@-700@2x",
                                                     imageName],
                                       @"320x568" : [NSString stringWithFormat:@"%@-700-568h@2x",
                                                     imageName],
                                       @"375x667" : [NSString stringWithFormat:@"%@-800-667h@2x",
                                                     imageName],
                                       @"414x736" : [NSString stringWithFormat:@"%@-800-Portrait-736h@3x"
                                                     , imageName] };
    NSString *key = [NSString stringWithFormat:@"%dx%d", (int)Main_Screen_Width, (int)Main_Screen_Height];
    return [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:launchImageInfo[key] ofType:@"png"]];
}

@end

































