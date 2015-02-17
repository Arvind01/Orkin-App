//
//  SendTextViewController.m
//  magnetodistribution
//
//  Created by TrinityInc on 06/02/15.
//  Copyright (c) 2015 Involgix. All rights reserved.
//

#import "SendTextViewController.h"

@interface SendTextViewController ()

@end

@implementation SendTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tap = [[UITapGestureRecognizer alloc]
                initWithTarget:self
                action:@selector(hideKeyBoard)];
    [self.view addGestureRecognizer:_tap];
    
    self.textfeild1.delegate = self;
    
    self.textfield2.delegate = self;
    self.textview.delegate = self;
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    
    [textField resignFirstResponder];
     return YES;
}
- (void) viewWillAppear:(BOOL)animated {
    
    
    
    [self registerForKeyboardNotifications];
    
    
}
-(void)hideKeyBoard {
    [self.textfeild1 resignFirstResponder];
    [self.textfield2 resignFirstResponder];
    [self.textview resignFirstResponder];
    
    
}

-(BOOL) textFieldShouldBeginEditing:(UITextField*)textField {
    activeField = textField;
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

- (void)viewWillDisappear:(BOOL)animated {
    
    [self deregisterFromKeyboardNotifications];
    
    [super viewWillDisappear:animated];
    
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

- (void)keyboardWillBeHidden:(NSNotification *)notification {
    
    [self.scrollview setContentOffset:CGPointZero animated:YES];
    
}
-(void)dismissKeyboard {
    
    [activeField1 resignFirstResponder];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)backAction:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
