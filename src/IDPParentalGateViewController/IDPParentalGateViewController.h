//
//  IDPParentalGateViewController.h
//
//  Created by Alexey Nikolaev on 10/23/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import "IDPToTextfieldScrollViewController.h"

typedef void (^IDPParentalGateCompletionHandler)(BOOL allowed);

@interface IDPParentalGateViewController : IDPToTextfieldScrollViewController <UITextFieldDelegate>

//You use any of two methods in case when show parental gate in non rotate controller.
//You shouldn't enherite you own controller
+ (id)showParentalGateWithCompletionHandler:(IDPParentalGateCompletionHandler)completionHandler;
+ (id)showParentalGateWithCompletionHandler:(IDPParentalGateCompletionHandler)completionHandler
                                     inView:(UIView *)view;

//If you like show parental gate in controller, that may rotate you must use this method
//and override methods below in inhereted class. IDPParentalGateViewController shouldn't routate
+ (void)showParentalGateWithCompletionHandler:(IDPParentalGateCompletionHandler)completionHandler
                          modallyInController:(UIViewController *)viewController;

//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
//    return NO;
//}
//
//- (BOOL)shouldAutorotate {
//    return NO;
//}
//
//- (NSUInteger)supportedInterfaceOrientations{
//    return UIInterfaceOrientationMaskPortrait;
//}

@end
