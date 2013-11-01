//
//  IDPParentalGateView.m
//
//  Created by Alexey Nikolaev on 10/23/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import "IDPParentalGateView.h"

@interface IDPParentalGateView ()
@property (nonatomic, retain) NSDictionary  *operationImagesDictionary;
@end

@implementation IDPParentalGateView

@synthesize firstOperand               = _firstOperand;
@synthesize secondOperand              = _secondOperand;
@synthesize operationImageView         = _operationImageView;
@synthesize scrollView                 = _scrollView;
@synthesize textField                  = _textField;
@synthesize littleBackgroundView       = _littleBackgroundView;
@synthesize operationImagesDictionary  = _operationImagesDictionary;

#pragma mark -
#pragma mark Initializations And Deallocation

- (void)dealloc {
    self.firstOperand               = nil;
    self.secondOperand              = nil;
    self.operationImageView         = nil;
    self.scrollView                 = nil;
    self.textField                  = nil;
    self.littleBackgroundView       = nil;
    self.operationImagesDictionary  = nil;

    [super dealloc];
}

#pragma mark -
#pragma mark View's LifeCircle

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.littleBackgroundView.layer.borderWidth = 5.0f;
    self.littleBackgroundView.layer.borderColor = [[UIColor colorWithRed:0.29411765f
                                                                   green:0.5372549f
                                                                    blue:0.81568627f
                                                                   alpha:1.0f] CGColor];
}

#pragma mark -
#pragma mark Accessors

- (NSDictionary *)operationImagesDictionary {
    if (!_operationImagesDictionary) {
        _operationImagesDictionary = [[NSDictionary dictionaryWithObjects:@[@"minus.png",
                                                                           @"plus.png",
                                                                           @"multiplication.png",
                                                                           @"division.png"]
                                                                 forKeys:@[@"0",
                                                                           @"1",
                                                                           @"2",
                                                                           @"3"]] retain];
    }
    
    return _operationImagesDictionary;
}

#pragma mark -
#pragma mark Public Methods

- (void)setOperation:(IDPParentalGateOperation)operation {
    NSString *key = [NSString stringWithFormat:@"%d", operation];
    
    self.operationImageView.image = [UIImage imageNamed:[self.operationImagesDictionary
                                                         objectForKey:key]];
}

@end
