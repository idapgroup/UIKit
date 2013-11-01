//
//  IDPTextFieldScrollingController.m
//
//  Created by Artem Chabanniy on 5/25/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import "IDPViewScrollingController.h"
#import "UIScrollView+IDPExtensions.h"

@interface IDPViewScrollingController ()
@property (nonatomic, assign) CGRect  frame;
@property (nonatomic, assign) CGFloat duration;
@property (nonatomic, assign) CGFloat offset;
@end

@implementation IDPViewScrollingController

@synthesize frame     = _frame;
@synthesize duration  = _duration;
@synthesize offset    = _offset;

@dynamic indent;
@dynamic scrollView;
@dynamic movingView;

#pragma mark -
#pragma mark Initializations and Deallocations

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter]  removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]  removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter]  removeObserver:self name:UIKeyboardDidHideNotification object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Public methods

- (void)keyboardWillShow:(NSNotification *)notification {
    CGRect keyboardFrame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSTimeInterval duration = [[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    self.frame = keyboardFrame;
    self.duration = duration;
    [self showView:keyboardFrame duration:duration];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    self.offset = 0.0f;
    
    CGRect keyboardFrame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSTimeInterval duration = [[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [self moveBack:keyboardFrame duration:duration];
}

- (void)keyboardDidHide:(NSNotification *)notification {
}
    
- (void)showView:(CGRect)frame duration:(NSTimeInterval)duration{
    CGRect movingRect = [self.view convertRect:self.movingView.frame fromView:self.scrollView];
    CGRect keyboardRect = [self.view convertRect:frame fromView:nil];
    
    self.offset = movingRect.origin.y + CGRectGetHeight(movingRect) - keyboardRect.origin.y + self.offset + self.indent;
    [self.scrollView moveViewWithContentOffset:self.offset animate:YES duration:duration];
}

- (void)moveBack:(CGRect)frame duration:(NSTimeInterval)duration {
    [self.scrollView moveToDefaultPositionAnimate:YES duration:duration];
}

#pragma mark -
#pragma mark Private methods

- (void)reloadResize {
    [self showView:self.frame duration:self.duration];
}

@end
