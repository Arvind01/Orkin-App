//
//  AddPropertyViewController.m
//  Orkin
//
//  Created by TrinityInc on 28/01/15.
//  Copyright (c) 2015 Involgix. All rights reserved.
//

#import "AddPropertyViewController.h"
#import "AFNetworking.h"
#import "AFURLResponseSerialization.h"
#import "branchdataobject.h"


@interface AddPropertyViewController (){
    NSUserDefaults *defaults;
     NSDictionary *jsonDict;
    NSMutableArray *fetchdata;
    NSString *zip;
    NSMutableArray *propertyArray;
    
}
@end

@implementation AddPropertyViewController
@synthesize reachability,showProperty;
- (void)viewDidLoad {
    [super viewDidLoad];
    defaults = [NSUserDefaults standardUserDefaults];
    self.dataBase = [[DatabaseAdapter alloc]init];
    self.homeButton.hidden = YES;
    self.backButton.hidden = YES;
  //  self.isDefault.hidden = YES;
   // self.defaultLabel.hidden = YES;
    residentialChecked = YES;
    isDefaultChecked = YES;
    self.nickName.delegate = self;
    self.addressOne.delegate = self;
    self.addressTwo.delegate = self;
    self.city.delegate = self;
    self.state.delegate = self;
    self.postalCode.delegate = self;
    self.errorLabel.text = @"All fields required";
    showProperty = [[PropertyDetailsObject alloc]init];
    propertyArray = [[NSMutableArray alloc]init];
    self.tap = [[UITapGestureRecognizer alloc]
                initWithTarget:self
                action:@selector(hideKeyBoard)];
    [self.view addGestureRecognizer:_tap];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];

    
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleDefault;
    numberToolbar.items = [NSArray arrayWithObjects:[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],
                           nil];
    [numberToolbar sizeToFit];
    self.postalCode.inputAccessoryView = numberToolbar;
    
    fetchdata = [[NSMutableArray alloc]init];
   _fetchNameArray = [[NSMutableArray alloc]init];
    
    self.tap = [[UITapGestureRecognizer alloc]
                initWithTarget:self
                action:@selector(hideKeyBoard)];
    
    [self.view addGestureRecognizer:_tap];
    
    
    self.nickName.delegate = self;
    self.addressOne.delegate = self;
    self.addressTwo.delegate = self;
    self.state.delegate = self;
    self.city.delegate = self;
    
    [self.dataBase copyDatabaseIfNeeded];
    if ([defaults integerForKey:checkSettings]==0) {
        propertyArray= [self.dataBase fetchPropertyDetails];
        if ([propertyArray count]>0) {
            showProperty = [propertyArray objectAtIndex:0];
            self.nickName.text = showProperty.nickName;
            self.addressOne.text = showProperty.addressOne;
            self.addressTwo.text = showProperty.addressTwo;
            self.city.text = showProperty.city;
            self.state.text = showProperty.state;
            self.postalCode.text = showProperty.postalCode;
        }
    }
    
    
    
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)doneWithNumberPad{
    //NSString *numberFromTheKeyboard = self.phoneField.text;
    [self.postalCode resignFirstResponder];
}

-(void)hideKeyBoard
{
    [self.nickName resignFirstResponder];
    [self.addressOne resignFirstResponder];
    [self.addressTwo resignFirstResponder];
    [self.city resignFirstResponder];
    [self.state resignFirstResponder];
    [self.postalCode resignFirstResponder];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
   
    
    [textField resignFirstResponder];
    
    if (textField.tag==1) {
        [self.addressOne becomeFirstResponder];
        
    }
    
    else if (textField.tag==2) {
        [self.addressTwo becomeFirstResponder];
        
    }
    else if (textField.tag==3) {
        [self.city becomeFirstResponder];
        
    }

    else{
        [textField resignFirstResponder];
    }
    
    
    
    
    return YES;
}

-(void)reachabilityChanged:(NSNotification*)note
{
    Reachability * reach = [note object];
    
    if (reach == reachability)
    {
        if([reach isReachable])
        {
            NSString * temp = [NSString stringWithFormat:@"InternetConnection Notification Says Reachable(%@)", reach.currentReachabilityString];
            NSLog(@"%@", temp);
            [self saveButtonAction:self];
            
        }
        else
        {
            NSString * temp = [NSString stringWithFormat:@"InternetConnection Notification Says Unreachable(%@)", reach.currentReachabilityString];
            NSLog(@"%@", temp);
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Error in internet connection" message:@"" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
            
        }
    }
    
}


//- (void)animalWasSelected:(NSNumber *)selectedIndex element:(id)element {
//    
//    
//        self.selectedIndex = [selectedIndex intValue];
//        self.state.text = (stateNameArray)[(NSUInteger) self.selectedIndex];
//        
//    
//    
//    
//}

- (void)actionPickerCancelled:(id)sender {
    NSLog(@"State name Delegate has set so ActionSheetPicker was cancelled");
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([segue.identifier isEqualToString:@"toHomeSegue"])
    {
        MyPropertyViewController *view = (MyPropertyViewController *)segue.destinationViewController;
        
        //        view.newEntry = true;
        //        view.navigatedFromPreferences = false;
    }

    
    
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

- (void) viewWillAppear:(BOOL)animated {
    
    
    
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
        
        [self.scrollView setContentOffset:scrollPoint animated:YES];
        
    }
    
}

- (void)keyboardWillBeHidden:(NSNotification *)notification {
    
    [self.scrollView setContentOffset:CGPointZero animated:YES];
    
}
-(void)dismissKeyboard {
    
    [activeField resignFirstResponder];
}


-(BOOL) textFieldShouldBeginEditing:(UITextField*)textField {
    activeField = textField;
    return YES;
}


- (IBAction)saveButtonAction:(id)sender {
    
//    [self = dismissKeyboard];
    
    
    
    PropertyDetailsObject *property = [[PropertyDetailsObject alloc]init];
    property.nickName = self.nickName.text;
    property.addressOne = self.addressOne.text;
    property.addressTwo = self.addressTwo.text;
    property.city = self.city.text;
    property.state = self.state.text;
    property.postalCode = self.postalCode.text;
    if (residentialChecked)
    {
        property.locationType = @"residential";
    }
    if (commercialChecked) {
        property.locationType = @"Commercial";
    }
   
    if (isDefaultChecked) {
        property.isDefault = @"1";
    }
    else{
        property.isDefault = @"0";
    }
    
    int insert;
    

    if ([self CheckUserInfoValidity]) {
        reachability = [Reachability reachabilityForInternetConnection];
        [reachability startNotifier];
        
        NetworkStatus status = [reachability currentReachabilityStatus];
        
        if(status == NotReachable)
        {
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Error in internet connection" message:@"" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];

            
        }
        
        else{
            [self fetchData];
            
            [self.dataBase copyDatabaseIfNeeded];
            insert = [self.dataBase insertPropertyDetails:property];
//            for (int i=0; i<[self.fetchNameArray count]; i++) {
//                insert1 = [self.dataBase insertBranchDetails:[self.fetchNameArray objectAtIndex:i]];
//            }
            
            if (insert > 0) {
                
                [self performSegueWithIdentifier:@"toHomeSegue" sender:self];
            }
            else{
                UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Failed to insert data" message:@"Please, try again" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];[alert show];
            }
            

            
        }

            }
    
}


-(void)fetchData{


    zip=self.postalCode.text;
    NSString *string = [NSString stringWithFormat:@"http://locations.rollins.com/api/branches/%@",zip];
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 2
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
   operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // 3
//        self.weather = (NSDictionary *)responseObject;
//        self.title = @"JSON Retrieved";
//        [self.tableView reloadData];
//        int insert1 = 0;
        
        int insert1;
     fetchdata = [responseObject objectForKey:@"Branches"];
        [self.dataBase copyDatabaseIfNeeded];
        for (NSDictionary *D in  fetchdata)
        
        {
             _dataObject = [[branchdataobject alloc]init];
            
             _dataObject.BranchId = [D objectForKey:@"BranchId"];
            
             _dataObject.Fax = [D objectForKey:@"Fax"];
            
             _dataObject.Phone = [D objectForKey:@"Phone"];
            
             _dataObject.Name = [D objectForKey:@"Name"];
            
             _dataObject.IsResidential= [D objectForKey:@"IsResidential"];
            
             _dataObject.IsCommercial= [D objectForKey:@"IsCommercial"];
            
             _dataObject.IsTermiteControl= [D objectForKey:@"IsTermiteControl"];
            
             _dataObject.IsOtherServices= [D objectForKey:@"IsOtherServices"];
            
            
             _dataObject.BranchManager= [D objectForKey:@"BranchManager"];
            
             _dataObject.BranchManagerImageUrl= [D objectForKey:@"BranchManagerImageUrl"];
            
             
            insert1 = [self.dataBase insertBranchDetails:_dataObject];
             [_fetchNameArray addObject:_dataObject];
        
        }
        
        
    }
     
                                     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        // 4
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error "
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
    }];
    
    // 5
    [operation start];

    
    
    
    
    
    
    
}

- (IBAction)LocationToggle:(id)sender {
}

-(BOOL)CheckUserInfoValidity{
    PropertyDetailsObject *property = [[PropertyDetailsObject alloc]init];
    NSMutableArray *allNickName = [[NSMutableArray alloc]init];
    [self.dataBase copyDatabaseIfNeeded];
    allNickName = [self.dataBase getNickName];
    
    NSString *phonePattern = @"(^[0-9]{5}(-[0-9]{4})?$)";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phonePattern];
    
    if (self.nickName.text.length <= 0)
    {
       // errorLabel.TextColor = UIColor.Red;
        _errorLabel.Text = @"Please enter a name for your property.";
        
        return false;
    }
    else if (self.addressOne.text.length <= 0)
    {
        //errorLabel.TextColor = UIColor.Red;
        _errorLabel.Text = @"Please enter your street address.";
        return false;
    }
    else if (self.city.text.length <= 0)
    {
       // errorLabel.TextColor = UIColor.Red;
        _errorLabel.Text = @"Please enter your city.";
        return false;
    }
    
    else if (self.state.text.length <= 0)
    {
      //  errorLabel.TextColor = UIColor.Red;
        _errorLabel.Text = @"Please select your state.";
        return false;
    }
    
    else if ([phoneTest evaluateWithObject:self.postalCode.text] == NO)
    {
        
       // (^[0-9]{5}(-[0-9]{4})?$)
        //errorLabel.TextColor = UIColor.Red;
        _errorLabel.Text = @"Please enter a 5 digit postal code.";
        return false;
    }
    else if ([allNickName count] != 0)
    {
        
        for (int i=0; i < [allNickName count]; i++)
        {
            property = [allNickName objectAtIndex:i];
            if ([self.nickName.text isEqualToString: property.nickName])
            {
                //errorLabel.TextColor = UIColor.Red;
                _errorLabel.Text = @"Name in use. Create a unique name.";
                return false;
            }
        }
        
        return true;
    }
    
    else
    {
        return true;
    }
    
}


- (IBAction)stateAction:(id)sender {
    
    [self dismissKeyboard];
    
    ActionStringDoneBlock done = ^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
        if ([sender respondsToSelector:@selector(setText:)]) {
            [sender performSelector:@selector(setText:) withObject:selectedValue];
        }
    };
    ActionStringCancelBlock cancel = ^(ActionSheetStringPicker *picker) {
        NSLog(@"Block Picker Canceled");
    };
    NSArray *stateNameArray = @[@"", @"Alaska", @"Alabama", @"Arkansas", @"Arizona", @"California", @"Colorado", @"Connecticut", @"Delaware", @"Florida",@"Georgia", @"Hawaii", @"Iowa", @"Idaho", @"Illinois", @"Indiana", @"Kansas", @"Kentucky", @"Louisiana", @"Massachusetts",@"Maryland", @"Maine", @"Michigan", @"Minnesota", @"Missouri", @"Mississippi", @"Montana", @"North Carolina", @"North Dakota", @"Nebraska",@"New Hampshire", @"New Jersey", @"New Mexico", @"Nevada", @"New York", @"Ohio", @"Oklahoma", @"Oregon",@"Pennsylvania", @"Rhode Island", @"South Carolina", @"South Dakota", @"Tennessee", @"Texas", @"Utah", @"Virginia",@"Vermont", @"Washington", @"Wisconsin",@"West Virginia", @"Wyoming"];
    [ActionSheetStringPicker showPickerWithTitle:@"Select a State" rows:stateNameArray initialSelection:0 doneBlock:done cancelBlock:cancel origin:sender];
}

- (IBAction)isDefaultButton:(id)sender {
    
    if (!isDefaultChecked) {
        [self.isDefault setImage:[UIImage imageNamed:@"checkMark"] forState:UIControlStateNormal];
        isDefaultChecked = YES;
    }
    
    else if (isDefaultChecked) {
        [self.isDefault setImage:[UIImage  imageNamed:@"uncheckButton"] forState:UIControlStateNormal];
        isDefaultChecked = NO;
    }
}
- (IBAction)homeButtonAction:(id)sender
{
    
    
}


- (IBAction)residentialAction:(id)sender
{
    
    if (!residentialChecked) {
        [self.residentialButton setImage:[UIImage imageNamed:@"redCircleButton"] forState:UIControlStateNormal];
        residentialChecked = YES;
        [self.commercial setImage:[UIImage imageNamed:@"circleButton"] forState:UIControlStateNormal];
        commercialChecked = NO;
    }
    
    else{
        [self.residentialButton setImage:[UIImage imageNamed:@"redCircleButton"] forState:UIControlStateNormal];
        residentialChecked = YES;
        [self.commercial setImage:[UIImage imageNamed:@"circleButton"] forState:UIControlStateNormal];
        commercialChecked = NO;
    }
    
}

- (IBAction)commercialAction:(id)sender {
    
    if (!commercialChecked) {
        [self.commercial setImage:[UIImage imageNamed:@"redCircleButton"] forState:UIControlStateNormal];
        commercialChecked = YES;
        [self.residentialButton setImage:[UIImage imageNamed:@"circleButton"] forState:UIControlStateNormal];
        residentialChecked = NO;
        
    }
    
    else{
        [self.commercial setImage:[UIImage imageNamed:@"redCircleButton"] forState:UIControlStateNormal];
        commercialChecked = YES;
        [self.residentialButton setImage:[UIImage imageNamed:@"circleButton"] forState:UIControlStateNormal];
        residentialChecked = NO;
    }
    
}
- (IBAction)cancelAction:(id)sender {
}
@end
