//
//  UINavigationController+Customizer.m
//  Video
//
//  Created by Howard on 13-5-14.
//  Copyright (c) 2013年 DZH. All rights reserved.
//

#import "UINavigationController+Customizer.h"

@implementation UINavigationController(Customizer) 

- (BOOL)shouldAutorotate
{
    return [[self.viewControllers lastObject] shouldAutorotate];
}
//
//- (UIInterfaceOrientationMask)supportedInterfaceOrientations
//{
//    return [[self.viewControllers lastObject] supportedInterfaceOrientations];
//}
//
//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
//{
//    return [[self.viewControllers lastObject] preferredInterfaceOrientationForPresentation];
//}
//
//- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
//{
//    [[self.viewControllers lastObject] willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
//}
//
//- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
//{
//    [[self.viewControllers lastObject] didRotateFromInterfaceOrientation:fromInterfaceOrientation];
//}

@end
