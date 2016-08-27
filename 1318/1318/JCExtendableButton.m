//
//  JCExtendableButton.m
//  1318
//
//  Created by Jeff on 8/16/16.
//  Copyright © 2016 Jeff. All rights reserved.
//

#import "JCExtendableButton.h"

@implementation JCExtendableButton

- (BOOL)pointInside:(CGPoint)point withEvent:(nullable UIEvent *)event {
    if (UIEdgeInsetsEqualToEdgeInsets(_extendInset, UIEdgeInsetsZero) ||
        self.hidden ||
        !self.enabled) {
        return [super pointInside:point withEvent:event];
    }
    CGRect hitFrame = UIEdgeInsetsInsetRect(self.bounds, _extendInset);
    hitFrame.size.width = MAX(hitFrame.size.width, 0);
    hitFrame.size.height = MAX(hitFrame.size.height, 0);
    return CGRectContainsPoint(hitFrame, point);
}

@end
