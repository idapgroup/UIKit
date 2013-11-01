//
//  UIScrollView+IDPExtensions.h
//
//  Created by Artem Chabanniy on 5/19/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (IDPExtensions)

- (void)moveViewWithContentOffset:(CGFloat)offset
                            animate:(BOOL)animate
                           duration:(NSTimeInterval)duration;

- (void)moveToDefaultPositionAnimate:(BOOL)animate
                            duration:(NSTimeInterval)duration;


@end
