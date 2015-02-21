//
//  UserViewController.m
//  Orkin
//
//  Created by TrinityInc on 28/01/15.
//  Copyright (c) 2015 Involgix. All rights reserved.
//

#import "UserViewController.h"

@interface UserViewController ()
{
    NSString *emailPattern;
    NSUserDefaults *defaults;
}

@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    defaults = [NSUserDefaults standardUserDefaults];
    self.firstname.delegate = self;
    self.lastname.delegate = self;
    self.email.delegate = self;
    
//    if ([defaults integerForKey:checkUserLogin] == 0) {
//        self.saveButton.hidden = YES;
//        self.homeButton.hidden = YES;
//        self.backButton.hidden = YES;
//        self.cancelButton.hidden = YES;
//    }
//    else{
//        self.cancelButton.hidden = NO;
//    }
//    
    
    self.dataBase=[[DatabaseAdapter alloc]init];
    
    NSMutableArray *userData = [[NSMutableArray alloc]init];
    userData = [self.dataBase fetchUserDetails];
    if ([userData count]>0) {
        UserInfoObject *userInfo = [[UserInfoObject alloc]init];
        userInfo = [userData objectAtIndex:0];
        self.firstname.text = userInfo.firstName;
        self.lastname.text = userInfo.lastName;
        self.email.text = userInfo.emailId;
         self.cancelButton.hidden = NO;
    }
    else{
        self.saveButton.hidden = YES;
        self.homeButton.hidden = YES;
        self.backButton.hidden = YES;
        self.cancelButton.hidden = YES;
    }
  emailPattern = @"^((([a-z]|\\d|[!#\\$%&amp;'\\*\\+\\-\\/=\\?\\^_`{\\|}~]|[\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF])+(\\.([a-z]|\\d|[!#\\$%&amp;'\\*\\+\\-\\/=\\?\\^_`{\\|}~]|[\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF])+)*)|((\\x22)((((\\x20|\\x09)*(\\x0d\\x0a))?(\\x20|\\x09)+)?(([\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x7f]|\\x21|[\\x23-\\x5b]|[\\x5d-\\x7e]|[\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF])|(\\\\([\\x01-\\x09\\x0b\\x0c\\x0d-\\x7f]|[\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF]))))*(((\\x20|\\x09)*(\\x0d\\x0a))?(\\x20|\\x09)+)?(\\x22)))@((([a-z]|\\d|[\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF])|(([a-z]|\\d|[\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF])([a-z]|\\d|-|\\.|_|~|[\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF])*([a-z]|\\d|[\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF])))\\.)+(([a-z]|[\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF])|(([a-z]|[\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF])([a-z]|\\d|-|\\.|_|~|[\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF])*([a-z]|[\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF])))\\.?$";
    
    self.tap = [[UITapGestureRecognizer alloc]
                initWithTarget:self
                action:@selector(hideKeyBoard)];
     [self.view addGestureRecognizer:_tap];
  //  bool isValid;
    
//    NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
//    
//    
//    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
//    
//    
//    if ([emailTest evaluateWithObject:self.email.text] == YES ) {
//    }
    // Do any additional setup after loading the view.
    
    self.tap = [[UITapGestureRecognizer alloc]
                initWithTarget:self
                action:@selector(hideKeyBoard)];
    
    [self.view addGestureRecognizer:_tap];

}

-(BOOL)CheckUserInfoValidity{
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailPattern];
    if (self.firstname.text.length <= 0 ) {
        
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please, Enter Your First Name" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];[alert show];
        return false;
        
    }
    else if( self.lastname.text.length <= 0){
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please, Enter Your Last Name" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];[alert show];
        return false;
        
    }
    
    else if([emailTest evaluateWithObject:self.email.text] == NO ){
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Invalid Email" message:@"Please, Provide Valid Email Id" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];[alert show];
        return false;
        
    }
    
    else{
        return true;
    }
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)hideKeyBoard {
    [self.firstname resignFirstResponder];
    [self.email resignFirstResponder];
    [self.lastname resignFirstResponder];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
   
    
    [textField resignFirstResponder];
    
    if (textField.tag==1) {
        [self.lastname becomeFirstResponder];
        
    }
    
    else if (textField.tag==2) {
        [self.email becomeFirstResponder];
        
    }
    else{
        [textField resignFirstResponder];
    }
    
    
    
    
    return YES;

}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  
    if([segue.identifier isEqualToString:@"toPropertyView"])
    {
        AddPropertyViewController *view = (AddPropertyViewController *)segue.destinationViewController;
        
        //        view.newEntry = true;
        //        view.navigatedFromPreferences = false;
    }
    else if ([segue.identifier isEqualToString:@"toMyPropertyView"]){
        MyPropertyViewController *view = (MyPropertyViewController *)segue.destinationViewController;
        
    }
    
    
}


- (IBAction)registerbutton:(id)sender {
   // [defaults setInteger:1 forKey:checkUserLogin];
    UserInfoObject *object = [[UserInfoObject alloc]init];
    object.firstName = self.firstname.text;
    object.lastName = self.lastname.text;
    object.emailId = self.email.text;
    int insert;
    NSMutableArray *userData = [[NSMutableArray alloc]init];
    [self.dataBase copyDatabaseIfNeeded];
    userData = [self.dataBase fetchUserDetails];
    if ([self CheckUserInfoValidity]) {
        if ([userData count] == 0) {
            //[self.dataBase copyDatabaseIfNeeded];
            insert = [self.dataBase insertUserInfo:object];
        }
        else{
           // [self.dataBase copyDatabaseIfNeeded];
            insert = [self.dataBase updateUserInfo:object];
        }
        
        if (insert > 0) {
            if ([userData count] == 0) {
                [self performSegueWithIdentifier:@"toPropertyView" sender:self];
            }
            
            else{
                [self performSegueWithIdentifier:@"toMyPropertyView" sender:self];
            }
            
        }
        else{
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Failed to insert data" message:@"Please, try again" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];[alert show];
            self.registerbutton.hidden = NO;
        }
        
    }
    
    
    
}

- (void) viewWillAppear:(BOOL)animated
{
     [self registerForKeyboardNotifications];
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
    
    CGPoint buttonOrigin = activeField.frame.origin;
    
    CGFloat buttonHeight = activeField.frame.size.height;
    
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
    
    [activeField resignFirstResponder];
}




-(BOOL) textFieldShouldBeginEditing:(UITextField*)textField {
    activeField = textField;
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    activeField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    activeField = nil;
}

- (IBAction)saveButtonAction:(id)sender {
    
    
    
}

- (IBAction)homeButtonAction:(id)sender {
}
- (IBAction)backButtonAction:(id)sender {
}

- (IBAction)cancelButtonAction:(id)sender {
}
@end
