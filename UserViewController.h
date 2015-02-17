//
//  UserViewController.h
//  Orkin
//
//  Created by TrinityInc on 28/01/15.
//  Copyright (c) 2015 Involgix. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DatabaseAdapter.h"
#import "UserInfoObject.h"
#import "AddPropertyViewController.h"
#import "AppDelegate.h"
@interface UserViewController : UIViewController<UITextFieldDelegate,UIAlertViewDelegate,UIScrollViewDelegate,UITextFieldDelegate>{
         UITextField *activeField;

}
@property (weak, nonatomic) IBOutlet UITextField *firstname;
@property (weak, nonatomic) IBOutlet UITextField *lastname;
@property (weak, nonatomic) IBOutlet UITextField *email;
- (IBAction)registerbutton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *registerbutton;
@property (weak, nonatomic) IBOutlet UILabel *errorLabel;

@property (weak, nonatomic) IBOutlet UIButton *homeButton;


@property (weak, nonatomic) IBOutlet UIButton *backButton;


@property (weak, nonatomic) IBOutlet UIButton *saveButton;

- (IBAction)saveButtonAction:(id)sender;

- (IBAction)homeButtonAction:(id)sender;

@property (nonatomic, strong) DatabaseAdapter *dataBase;
@property (nonatomic, strong)  UITapGestureRecognizer *tap;

- (IBAction)backButtonAction:(id)sender;


- (IBAction)cancelButtonAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollview;



@end
