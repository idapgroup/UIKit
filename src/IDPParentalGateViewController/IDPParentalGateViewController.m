//
//  IDPParentalGateViewController.m
//
//  Created by Alexey Nikolaev on 10/23/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import "IDPParentalGateViewController.h"
#import "IDPParentalGateView.h"
#import "IDPParentalGateModel.h"
#import "IDPParentalInputAccessoryView.h"
#import "UIViewController+IDPExtensions.h"

@interface IDPParentalGateViewController ()
@property (nonatomic, copy)                      IDPParentalGateCompletionHandler  handler;
@property (nonatomic, readonly)                  IDPParentalGateView               *gateView;
@property (nonatomic, retain)                    IDPParentalGateModel              *model;
@property (nonatomic, assign, getter = isPassed) BOOL                              passed;
@end

@implementation IDPParentalGateViewController

@synthesize handler  = _handler;
@synthesize model    = _model;
@synthesize passed   = _passed;

@dynamic gateView;

#pragma mark -
#pragma mark Class Methods

+ (void)showParentalGateWithCompletionHandler:(IDPParentalGateCompletionHandler)completionHandler
                          modallyInController:(UIViewController *)viewController
{
    IDPParentalGateViewController *controller = [[[[self class] alloc] initWithNibName:@"IDPParentalGateViewController"
                                                                                bundle:nil] autorelease];
    
    controller.model = [[[IDPParentalGateModel alloc] init] autorelease];
    controller.handler = completionHandler;
    
    [viewController portablePresentModalViewController:controller animated:NO];
}

+ (id)showParentalGateWithCompletionHandler:(IDPParentalGateCompletionHandler)completionHandler {
    return [self showParentalGateWithCompletionHandler:completionHandler
                                                inView:[[[UIApplication sharedApplication] delegate] window]];
}

+ (id)showParentalGateWithCompletionHandler:(IDPParentalGateCompletionHandler)completionHandler
                                     inView:(UIView *)view
{
    IDPParentalGateViewController *controller = [IDPParentalGateViewController controllerWithTagsCounter:NO];
    
    controller.model = [[[IDPParentalGateModel alloc] init] autorelease];
    controller.handler = completionHandler;
    [view addSubview:controller.view];
    
    return controller;
}

#pragma mark -
#pragma mark Initializations And Deallocations

- (void)dealloc {
    self.handler  = nil;
    self.model    = nil;
    
    [super dealloc];
}

#pragma mark -
#pragma mark View's Lifecircle

- (void)showGate:(BOOL)showGate {
    [UIView animateWithDuration:0.3f
                     animations:^{
                         self.view.alpha = (showGate) ? (1.0f)
                                                      : (0.0f);
                     }
                     completion:^(BOOL finished) {
                         if (showGate) {
                             NSUInteger textFieldIndex = [self.textFields indexOfObject:self.gateView.textField];
                             
                             [self textFieldBecamesActiveWithIndex:textFieldIndex];
                         } else {
                             if (self.presentingViewController) {
                                 [self.presentingViewController portableDismissModalViewControllerAnimated:NO];
                             } else {
                                 [self.view removeFromSuperview];
                             }
                             self.handler(self.isPassed);
                             self.handler = nil;
                         }
                     }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self showGate:YES];
    [self generateNewQuestion];
}

- (void)generateNewQuestion {
    [self.model generateOperationSet];
    self.gateView.firstOperand.text = self.model.firstOperandString;
    self.gateView.secondOperand.text = self.model.secondOperandString;
    [self.gateView setOperation:self.model.operation];
    self.gateView.textField.text = nil;
}

#pragma mark -
#pragma mark Accessors

- (UIView *)inputAccesoryView {
    IDPParentalInputAccessoryView *accessoryView = (IDPParentalInputAccessoryView *)[super inputAccesoryView];
    
    [accessoryView.cancelButton addTarget:self
                                   action:@selector(onCancel:)
                         forControlEvents:UIControlEventTouchUpInside];
    
    return accessoryView;
}

- (IDPParentalGateView *)gateView {
    if ([self.view isKindOfClass:[IDPParentalGateView class]]) {
        return (IDPParentalGateView *)self.view;
    }
    
    return nil;
}

- (Class)inputAccessoryViewClass {
    return [IDPParentalInputAccessoryView class];
}

- (CGFloat)indent {
    UIUserInterfaceIdiom interfaceIdiom = [[UIDevice currentDevice] userInterfaceIdiom];
    
    if (interfaceIdiom == UIUserInterfaceIdiomPhone) {
        return 10.0f;
    } else {
        return 50.0f;
    }
}

- (UIScrollView *)scrollView {
    return self.gateView.scrollView;
}

#pragma mark -
#pragma mark InterfaceHandlig

- (void)onDone:(id)sender {
    [self checkAnswer];
}

- (void)onCancel:(id)sender {
    [self.currentTextField resignFirstResponder];
    self.passed = NO;
}

#pragma mark -
#pragma mark Private Methods

- (void)keyboardDidHide:(NSNotification *)notification {
    [self showGate:NO];
}

- (void)checkAnswer {
    if ([self.model.rightAnswerString isEqualToString:self.gateView.textField.text]) {
        [self.currentTextField resignFirstResponder];
        self.passed = YES;
    } else {
        [(IDPParentalInputAccessoryView *)self.inputAccesoryView setAlertViewVisible:YES
                                                                           animated:YES];
        [self generateNewQuestion];
    }
}

#pragma mark -
#pragma mark UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField
shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string
{
    IDPParentalInputAccessoryView *alerView = (IDPParentalInputAccessoryView *)self.inputAccesoryView;
    
    if (alerView.isAlertViewVisible) {
        [alerView setAlertViewVisible:NO
                             animated:YES];
    }
    
    NSUInteger textFieldLength = [textField.text length];
    if (textFieldLength >= 3 && ![string isEqualToString:@""]) {
        return NO;
    }
    
    return YES;
}

@end
