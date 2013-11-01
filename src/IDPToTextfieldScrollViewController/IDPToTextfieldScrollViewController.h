//
//  IDPToTextfieldScrollViewController.h
//
//  Created by Alexey Nikolaev on 9/6/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import "IDPViewScrollingController.h"

@interface IDPToTextfieldScrollViewController : IDPViewScrollingController <UITextFieldDelegate>

@property (nonatomic, readonly)                          UITextField   *currentTextField;

//reload properties (by default indent == 10, scroll view == nil)
@property (nonatomic, readonly)                          CGFloat       indent;
@property (nonatomic, readonly)                          UIScrollView  *scrollView;

@property (nonatomic, readonly, getter = isTagsCounting) BOOL          tagsCounting;
@property (nonatomic, readonly)                          NSArray       *textFields;
//for custom inputAccessoryView assign it class (inhereted only from IDPInputAccessoryView)
//name outlets as in base class
@property (nonatomic, readonly)                          Class         inputAccessoryViewClass;
//reload this property with super call if you like add others buttons to input accessory
//view besides base
@property (nonatomic, readonly)                          UIView        *inputAccesoryView;

//Use this metho with "YES" if you assign every textfield unique tag beginning with "1".
//in this case textFields navigation will realized in order tag to tag. If you use "NO" or
//method "initWithNibName:bundle:" textFields navigation will realized from smallest
//to largest or conversely
+ (id)controllerWithTagsCounter:(BOOL)YesOrNo;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil;

//method for reloading with super call
- (void)onDone:(id)sender;

//if You'd like use this methods call super for it
- (void)textFieldDidBeginEditing:(UITextField *)textField;
- (BOOL)textFieldShouldReturn:(UITextField *)textField;

//You can assign active any of textFields
- (void)textFieldBecamesActiveWithIndex:(NSUInteger)index;

@end
