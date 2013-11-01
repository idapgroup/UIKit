//
//  IDPTextFieldScrollingController.h
//
//  Created by Artem Chabanniy on 5/25/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IDPViewScrollingController : UIViewController

//You must override this property.
@property (nonatomic, readonly)         CGFloat        indent;
@property (nonatomic, retain, readonly) UIScrollView   *scrollView;
@property (nonatomic, retain, readonly) UIView         *movingView;

- (void)keyboardWillShow:(NSNotification *)notification;
- (void)keyboardWillHide:(NSNotification *)notification;
- (void)keyboardDidHide:(NSNotification *)notification;
- (void)showView:(CGRect)frame duration:(NSTimeInterval)duration;
- (void)moveBack:(CGRect)frame duration:(NSTimeInterval)duration;

- (void)reloadResize;

@end
