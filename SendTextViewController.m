//
//  SendTextViewController.m
//  magnetodistribution
//
//  Created by TrinityInc on 06/02/15.
//  Copyright (c) 2015 Involgix. All rights reserved.
//

#import "SendTextViewController.h"
#import "SVProgressHUD.h"
#import "SKPSMTPMessage.h"
#import "DatabaseAdapter.h"
#import "branchdata2object.h"


@interface SendTextViewController (){
    NSMutableArray *propertyData;
}

@end

@implementation SendTextViewController
{
    NSMutableArray *branchData2details;
    
}
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
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleDefault;
    numberToolbar.items = [NSArray arrayWithObjects:[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],
                           nil];
    [numberToolbar sizeToFit];
    self.textfeild1.inputAccessoryView = numberToolbar;
    
    
    self.dataBase = [[DatabaseAdapter alloc]init];
    branchData2details=[[NSMutableArray alloc]init];
    [self.dataBase copyDatabaseIfNeeded];
    
    branchData2details= [self.dataBase fetchPhonenumber];
    


}
-(void)doneWithNumberPad{
    //NSString *numberFromTheKeyboard = self.phoneField.text;
    [self.textfeild1 resignFirstResponder];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{ self.textview.text = @"";
    
    return YES;
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


- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult) result
{
    switch (result) {
        case MessageComposeResultCancelled:
            break;
            
        case MessageComposeResultFailed:
        {
            UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Oups, error while sendind SMS!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [warningAlert show];
            break;
        }
            
        case MessageComposeResultSent:
            
            break;
            
        default:
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(BOOL)checkValidation{
    if (self.textfeild1.text.length <= 0)
    {
        // errorLabel.TextColor = UIColor.Red;
        
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter your cell phone number." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];[alert show];
        return false;
    }
    else if (self.textview.text.length <= 0)
    {
        //errorLabel.TextColor = UIColor.Red;
        
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter message." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];[alert show];
        
        return false;
    }
    else{
        return true;
    }

}

- (IBAction)backAction:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)sendbutton:(id)sender {
    
//    if(![MFMessageComposeViewController canSendText]) {
//        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Your device cannot send text messages" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alert show];
//        return;
//    }
    if ([self checkValidation]) {
        BranchData2Object *branchData = [[BranchData2Object alloc]init];
        branchData = [branchData2details objectAtIndex:0];
        UserInfoObject *userData = [[UserInfoObject alloc]init];
        PropertyDetailsObject *propertyData1 = [[PropertyDetailsObject alloc]init];
        [self.dataBase copyDatabaseIfNeeded];
        userData = [self.dataBase getUserData];
        propertyData = [self.dataBase fetchPropertyDetails];
        propertyData1 = [propertyData lastObject];
        NSString *inquiryType;
        if ([self.pestSegmented selectedSegmentIndex]==0) {
            inquiryType = @"Pest Control";
        }
        else{
            inquiryType = @"Termite Control";
        }
        
        //set receipients
        NSArray *recipients = [NSArray arrayWithObjects:branchData.PhoneNo, nil];
        //NSArray *recipients = [NSArray arrayWithObjects:@"7259241664", nil];
        
        
        //set message text
        NSString * message = [NSString stringWithFormat:@"Subject:USE A PHONE TO TEXT THIS USER AT %@  InquiryType : %@                               Message:IMPORTANT! THIS IS A TEXT MESSAGE - %@                                              Text Message Sent From Orkin Customer : %@ %@ User Email : %@ User Address : %@ %@,%@,%@",self.textfeild1.text,inquiryType,self.textview.text,userData.firstName,userData.lastName,userData.emailId,propertyData1.addressOne,propertyData1.addressTwo,propertyData1.state,propertyData1.postalCode];
        
        
        
        MFMessageComposeViewController *messageController = [[MFMessageComposeViewController alloc] init];
        messageController.messageComposeDelegate = self;
        [messageController setRecipients:recipients];
        [messageController setBody:message];
        
        // Present message view controller on screen
        [self presentViewController:messageController animated:YES completion:nil];
    }
   
    
    
    
}
- (IBAction)pestSegmentAction:(id)sender {
   
}
@end
