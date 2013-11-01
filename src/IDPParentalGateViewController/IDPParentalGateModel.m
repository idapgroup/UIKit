//
//  IDPParentalGateModel.m
//
//  Created by Alexey Nikolaev on 10/29/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import "IDPParentalGateModel.h"

static NSUInteger const maxGenerationNumber  = 7;

@interface IDPParentalGateModel ()
@property (nonatomic, assign) IDPParentalGateOperation  operation;
@property (nonatomic, assign) NSUInteger                firstOperand;
@property (nonatomic, assign) NSUInteger                secondOperand;
@property (nonatomic, assign) NSUInteger                rightAnswer;
@end

@implementation IDPParentalGateModel

@synthesize operation      = _operation;
@synthesize firstOperand   = _firstOperand;
@synthesize secondOperand  = _secondOperand;
@synthesize rightAnswer    = _rightAnswer;

#pragma mark -
#pragma mark Accessors

- (NSString *)firstOperandString {
    return [self stringWithUnsignedInteger:self.firstOperand];
}

- (NSString *)secondOperandString {
    return [self stringWithUnsignedInteger:self.secondOperand];
}

- (NSString *)rightAnswerString {
    return [self stringWithUnsignedInteger:self.rightAnswer];
}

#pragma mark -
#pragma mark Public Methods

- (void)generateOperationSet {
    IDPParentalGateOperation operation = [self getOperation];
    
    switch (operation) {
        case IDPParentalGatePlusOperation:
            [self generatePlusOperationSet];
            break;
            
        case IDPParentalGateMinusOperation:
            [self generateMinusOperationSet];
            break;
            
        case IDPParentalGateDivideOperation:
            [self generateDivisionOperationSet];
            break;
            
        case IDPParentalGateMultiplyOperation:
            [self generateMultiplicationOperationSet];
            break;
            
        default:
            break;
    }
    
    self.operation = operation;
}

#pragma mark -
#pragma mark Private Methods

- (NSString *)stringWithUnsignedInteger:(NSUInteger)unsignedInteger {
    return [NSString stringWithFormat:@"%u", unsignedInteger];
}

- (NSUInteger)randomWithCount:(NSUInteger)count {
    return arc4random() % count;
}

- (NSUInteger)getOperand {
    return [self randomWithCount:maxGenerationNumber];
}

- (IDPParentalGateOperation)getOperation {
    return [self randomWithCount:4];
}

- (void)generatePlusOperationSet {
    self.firstOperand = [self getOperand];
    self.secondOperand = [self getOperand];
    self.rightAnswer = self.firstOperand + self.secondOperand;
}

- (void)generateMinusOperationSet {
    NSUInteger firstOperand = [self getOperand];
    NSUInteger secondOperand = [self getOperand];
    
    self.firstOperand = firstOperand;
    self.secondOperand = firstOperand;
    
    (firstOperand > secondOperand) ? (self.secondOperand = secondOperand)
                                   : (self.firstOperand = secondOperand);
    self.rightAnswer = self.firstOperand - self.secondOperand;
}

- (void)generateMultiplicationOperationSet {
    [self generatePlusOperationSet];
    self.rightAnswer = self.firstOperand * self.secondOperand;
}

- (void)generateDivisionOperationSet {
    NSUInteger firstOperand = [self getOperand];
    NSUInteger secondOperand = [self getOperand];
    NSUInteger multiplicationOperation = 0;
    
    if (0 == secondOperand) {
        secondOperand = 1;
    }
    multiplicationOperation = firstOperand * secondOperand;
    
    self.rightAnswer = firstOperand;
    self.firstOperand = multiplicationOperation;
    self.secondOperand = secondOperand;
}

@end
