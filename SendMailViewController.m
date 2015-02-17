//
//  SendMailViewController.m
//  magnetodistribution
//
//  Created by TrinityInc on 06/02/15.
//  Copyright (c) 2015 Involgix. All rights reserved.
//

#import "SendMailViewController.h"

@interface SendMailViewController ()

@end

@implementation SendMailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.emailTextView.delegate = self;
    self.selectSub.delegate = self;
    
    self.tap = [[UITapGestureRecognizer alloc]
                initWithTarget:self
                action:@selector(hideKeyBoard)];
    [self.view addGestureRecognizer:_tap];
    
    [self.emailTextView.layer setBorderColor:[[[UIColor grayColor] colorWithAlphaComponent:0.5] CGColor]];
    [self.emailTextView.layer setBorderWidth:2.0];
    
    //The rounded corner part, where you specify your view's corner radius:
   // self.emailTextView.layer.cornerRadius = 5;

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)hideKeyBoard
{
    [self.emailTextView resignFirstResponder];
    [self.selectSub resignFirstResponder];
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{ self.emailTextView.text = @"";
    
    return YES;
}



- (void)textViewDidBeginEditing:(UITextView *)textView
{
    // save the text view that is being edited
    activeField1 = textView;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    // release the selected text view as we don't need it anymore
    activeField1 = nil;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}


- (void)registerForKeyboardNotifications {
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
}
- (void)deregisterFromKeyboardNotifications {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardDidHideNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
    
}



-(BOOL) textFieldShouldBeginEditing:(UITextField*)textField {
    // activeField = textField;
    return YES;
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // Any additional checks to ensure you have the correct textField here.
    [textField resignFirstResponder];
    //[self.popupView1Text resignFirstResponder];
    
    return YES;
}
- (void)keyboardWasShown:(NSNotification *)notification {
    
    NSDictionary* info = [notification userInfo];
    
    CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    CGPoint buttonOrigin = activeField1.frame.origin;
    
    CGFloat buttonHeight = activeField1.frame.size.height;
    
    CGRect visibleRect = self.view.frame;
    
    visibleRect.size.height -= keyboardSize.height;
    
    if (!CGRectContainsPoint(visibleRect, buttonOrigin)){
        
        CGPoint scrollPoint = CGPointMake(0.0, buttonOrigin.y - visibleRect.size.height + buttonHeight);
        
        [self.scrollview setContentOffset:scrollPoint animated:YES];
        
    }
    
}

- (void) viewWillAppear:(BOOL)animated {
    
    
    
    [self registerForKeyboardNotifications];
    
    
}


//-(void)hideKeyboard
//{
//    [self.selectSub resignFirstResponder];
//    
//    [self.emailTextView resignFirstResponder];
//}


- (void)viewWillDisappear:(BOOL)animated {
    
    [self deregisterFromKeyboardNotifications];
    
    [super viewWillDisappear:animated];
    
}


- (void)keyboardWillBeHidden:(NSNotification *)notification {
    
    [self.scrollview setContentOffset:CGPointZero animated:YES];
    
}
-(void)dismissKeyboard {
    
    [activeField resignFirstResponder];
}





- (IBAction)selectSubjectAction:(id)sender {
}
- (IBAction)sendAction:(id)sender {
}
- (IBAction)cancelButton:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
@end
