//
//  IDPParentalInputAccessoryView.h
//
//  Created by Alexey Nikolaev on 9/6/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import "IDPInputAccessoryView.h"

@interface IDPParentalInputAccessoryView : IDPInputAccessoryView

@property (nonatomic, retain)                                IBOutlet UIButton  *doneButton;
@property (nonatomic, retain)                                IBOutlet UIButton  *cancelButton;
@property (nonatomic, retain)                                IBOutlet UILabel   *alertView;
@property (nonatomic, readonly, getter = isAlertViewVisible) BOOL               alertViewVisible;

- (void)setAlertViewVisible:(BOOL)visible animated:(BOOL)YesOrNo;

@end
