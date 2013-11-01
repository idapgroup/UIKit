//
//  IDPInputAccessoryView.m
//
//  Created by Alexey Nikolaev on 9/6/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import "IDPInputAccessoryView.h"

@implementation IDPInputAccessoryView

@synthesize backButton = _backButton;
@synthesize nextButton = _nextButton;
@synthesize doneButton = _doneButton;

- (void)dealloc {
    self.backButton = nil;
    self.nextButton = nil;
    self.doneButton = nil;
    
    [super dealloc];
}

@end
