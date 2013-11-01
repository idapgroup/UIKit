//
//  IDPToTextfieldScrollViewController.m
//
//  Created by Alexey Nikolaev on 9/6/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import "IDPToTextfieldScrollViewController.h"
#import "IDPInputAccessoryView.h"
#import "UINib+IDPExtensions.h"

@interface IDPToTextfieldScrollViewController () {
    UIView          *_inputAccesoryView;
    NSMutableArray  *_arrayYOrigin;
}

@property (nonatomic, assign) UITextField     *currentTextField;
@property (nonatomic, assign) NSUInteger      textFieldsCount;
@property (nonatomic, retain) NSMutableArray  *textFieldsMutable;
@property (nonatomic, assign) BOOL            tagsCounting;
@end

@implementation IDPToTextfieldScrollViewController

@synthesize textFieldsCount  = _textFieldsCount;
@synthesize tagsCounting     = _tagsCounting;

@dynamic textFields;
@dynamic inputAccesoryView;
@dynamic inputAccessoryViewClass;

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.textFieldsMutable  = nil;
    [_inputAccesoryView release];
    
    [super dealloc];
}

+ (id)controllerWithTagsCounter:(BOOL)YesOrNo {
    IDPToTextfieldScrollViewController *controller = [[[self alloc] initWithNibName:NSStringFromClass(self)
                                                                             bundle:nil] autorelease];
    
    if (controller) {
        controller.tagsCounting = YesOrNo;
    }
    
    return controller;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self baseInit];
    }
    
    return self;
}

- (void)baseInit {
}

#pragma mark -
#pragma mark Accessors

- (Class)inputAccessoryViewClass {
    return [IDPInputAccessoryView class];
}

- (UIView *)inputAccesoryView {
    if (!_inputAccesoryView) {
        if (self.inputAccessoryViewClass) {
            IDPInputAccessoryView *accessoryView = [UINib loadClass:self.inputAccessoryViewClass];
            
            [accessoryView.backButton addTarget:self
                                         action:@selector(onBackButton:)
                               forControlEvents:UIControlEventTouchUpInside];
            [accessoryView.nextButton addTarget:self
                                         action:@selector(onNextButton:)
                               forControlEvents:UIControlEventTouchUpInside];
            [accessoryView.doneButton addTarget:self
                                         action:@selector(onDone:)
                               forControlEvents:UIControlEventTouchUpInside];
            _inputAccesoryView = [accessoryView retain];
        }
    }
    
    return _inputAccesoryView;
}

- (UIScrollView *)scrollView {
    return nil;
}

- (UIView *)movingView {
    return (UIView *)self.currentTextField;
}

- (CGFloat)indent {
    return 0.0f;
}

- (NSArray *)textFields {
    return [[self.textFieldsMutable copy] autorelease];
}

#pragma mark -
#pragma mark Lifecircle ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.textFieldsMutable = [NSMutableArray array];
    for (UIView *subview in self.view.subviews) {
        if ([subview isKindOfClass:[UIScrollView class]]) {
            UIScrollView *scrollView = (UIScrollView *)subview;
            
            for (UIView *scrollViewSubview in scrollView.subviews) {
                if ([scrollViewSubview isKindOfClass:[UITextField class]]) {
                    [self processTextField:(UITextField *)scrollViewSubview];
                }
            }
        }
    }
    if (_arrayYOrigin) {
        [_arrayYOrigin release];
    }
}

#pragma mark -
#pragma mark InterfaceHandlig

- (void)onBackButton:(id)sender {
    NSUInteger nextResponderIndex = 0;
    
    if (self.isTagsCounting) {
        nextResponderIndex = (self.currentTextField.tag - 1 == 0) ? self.textFieldsCount
                                                                  : self.currentTextField.tag - 1;
    } else {
        NSUInteger currentIndex = [self.textFieldsMutable indexOfObject:self.currentTextField];
        
        nextResponderIndex = (0 == currentIndex) ? self.textFieldsMutable.count - 1
                                                 : currentIndex - 1;
    }
    [self textFieldBecamesActiveWithIndex:nextResponderIndex];
}

- (void)onNextButton:(id)sender {
    NSUInteger nextResponderIndex = 0;
    
    if (self.isTagsCounting) {
        nextResponderIndex = (self.currentTextField.tag + 1 > self.textFieldsCount) ? 1
                                                                                    : self.currentTextField.tag + 1;
    } else {
        NSUInteger currentIndex = [self.textFieldsMutable indexOfObject:self.currentTextField];
        
        nextResponderIndex = (self.textFieldsMutable.count - 1 == currentIndex) ? 0
                                                                                : currentIndex + 1;
    }
    [self textFieldBecamesActiveWithIndex:nextResponderIndex];
}

- (void)onDone:(id)sender {
    [self.currentTextField resignFirstResponder];
}

#pragma mark -
#pragma mark Private Methods

- (void)processTextField:(UITextField *)textField {
    if (self.isTagsCounting) {
        [self.textFieldsMutable addObject:textField];
        if (textField.tag > self.textFieldsCount) {
            self.textFieldsCount = textField.tag;
        }
    } else {
        NSNumber *currentYOrigin = [NSNumber numberWithFloat:CGRectGetMinY(textField.frame)];
        
        if (!_arrayYOrigin) {
            _arrayYOrigin = [[NSMutableArray array] retain];
            [_arrayYOrigin addObject:currentYOrigin];
            [self.textFieldsMutable addObject:textField];
        } else {
            for (NSNumber *yOrigin in _arrayYOrigin) {
                if (NSOrderedAscending == [currentYOrigin compare:yOrigin]) {
                    NSUInteger index = [_arrayYOrigin indexOfObject:yOrigin];
                    
                    [_arrayYOrigin insertObject:currentYOrigin atIndex:index];
                    [self.textFieldsMutable insertObject:textField
                                                 atIndex:index];
                } else if (yOrigin == _arrayYOrigin.lastObject) {
                    [_arrayYOrigin addObject:currentYOrigin];
                    [self.textFieldsMutable addObject:textField];
                }
            }
        }
        textField.delegate = self;
    }
}

- (void)textFieldBecamesActiveWithIndex:(NSUInteger)index {
    UITextField *textField = nil;
    
    if (self.isTagsCounting) {
        textField = (UITextField *)[self.view viewWithTag:index];
    } else {
        textField = [self.textFieldsMutable objectAtIndex:index];
    }
    
    [textField becomeFirstResponder];
}

#pragma mark -
#pragma mark UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    UITextField *oldTextField = self.currentTextField;
    self.currentTextField = textField;
    textField.inputAccessoryView = self.inputAccesoryView;
    
    if (oldTextField != textField && oldTextField != nil) {
        [self reloadResize];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    self.currentTextField = nil;
    
    return YES;
}

@end
