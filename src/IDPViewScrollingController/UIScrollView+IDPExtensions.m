//
//  UIScrollView+IDPExtensions.m
//
//  Created by Artem Chabanniy on 5/19/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import "UIScrollView+IDPExtensions.h"

@implementation UIScrollView (IDPExtensions)

- (void)moveViewWithContentOffset:(CGFloat)offset
                            animate:(BOOL)animate
                           duration:(NSTimeInterval)duration {
    CGPoint contentOffset = CGPointMake(0.0, offset);
    [self moveWithContentInset:contentOffset animate:animate duration:duration];
}

- (void)moveToDefaultPositionAnimate:(BOOL)animate
                            duration:(NSTimeInterval)duration {
    [self moveWithContentInset:CGPointZero animate:animate duration:duration];
}

- (void)moveWithContentInset:(CGPoint)contentOffset animate:(BOOL)animate
                    duration:(NSTimeInterval)duration{
    [UIView animateWithDuration: (animate ? duration : 0)
                     animations:^{
                         self.contentOffset = contentOffset;
    }];
}

@end
