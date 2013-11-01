//
//  IDPParentalGateView.h
//
//  Created by Alexey Nikolaev on 10/23/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IDPParentalGateOperations.h"

@interface IDPParentalGateView : UIView

@property (nonatomic, retain) IBOutlet UILabel       *firstOperand;
@property (nonatomic, retain) IBOutlet UILabel       *secondOperand;
@property (nonatomic, retain) IBOutlet UIImageView   *operationImageView;
@property (nonatomic, retain) IBOutlet UIScrollView  *scrollView;
@property (nonatomic, retain) IBOutlet UITextField   *textField;
@property (nonatomic, retain) IBOutlet UIView        *littleBackgroundView;

- (void)setOperation:(IDPParentalGateOperation)operation;

@end
