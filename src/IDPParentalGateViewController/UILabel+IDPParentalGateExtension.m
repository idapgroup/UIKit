//
//  UILabel+IDPParentalGateExtension.m
//
//  Created by Alexey Nikolaev on 10/30/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import "UILabel+IDPParentalGateExtension.h"

@implementation UILabel (IDPParentalGateExtension)

- (void)setVisible:(BOOL)visible animated:(BOOL)YesOrNo {
    [UIView animateWithDuration:0.2f
                     animations:^{
                         self.alpha = (visible) ? (1.0f) : (0.0f);
                     }];
}

@end
