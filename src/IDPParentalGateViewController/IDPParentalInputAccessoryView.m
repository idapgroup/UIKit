//
//  IDPParentalInputAccessoryView.m
//
//  Created by Alexey Nikolaev on 9/6/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import "IDPParentalInputAccessoryView.h"
#import "UILabel+IDPParentalGateExtension.h"

@interface IDPParentalInputAccessoryView ()
@property (nonatomic, assign) BOOL  alertViewVisible;
@end

@implementation IDPParentalInputAccessoryView

@synthesize cancelButton      = _cancelButton;
@synthesize alertView         = _alertView;
@synthesize alertViewVisible  = _alertViewVisible;

#pragma mark -
#pragma mark Initializations And Deallocations

- (void)dealloc {
    self.cancelButton  = nil;
    self.alertView     = nil;

    [super dealloc];
}

#pragma mark -
#pragma mark View's Lifecircle

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.alertViewVisible = NO;
}

#pragma mark -
#pragma mark Accessors

- (void)setAlertViewVisible:(BOOL)visible {
    [self setAlertViewVisible:visible animated:NO];
}

- (void)setAlertViewVisible:(BOOL)visible animated:(BOOL)YesOrNo {
    [self.alertView setVisible:visible animated:YesOrNo];
    _alertViewVisible = visible;
}

#pragma mark -
#pragma mark Public Methods

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.alertView setVisible:NO animated:YES];
}

@end
