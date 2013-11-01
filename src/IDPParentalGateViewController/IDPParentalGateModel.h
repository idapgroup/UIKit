//
//  IDPParentalGateModel.h
//
//  Created by Alexey Nikolaev on 10/29/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IDPParentalGateOperations.h"

@interface IDPParentalGateModel : NSObject

@property (nonatomic, readonly) IDPParentalGateOperation  operation;
@property (nonatomic, readonly) NSString                  *firstOperandString;
@property (nonatomic, readonly) NSString                  *secondOperandString;
@property (nonatomic, readonly) NSString                  *rightAnswerString;

- (void)generateOperationSet;

@end
