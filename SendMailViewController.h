//
//  SendMailViewController.h
//  magnetodistribution
//
//  Created by TrinityInc on 06/02/15.
//  Copyright (c) 2015 Involgix. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Utils.h"
#import "SKPSMTPMessage.h"
#import "Reachability.h"
#import "SVProgressHUD.h"
#import "UserInfoObject.h"
#import "PropertyDetailsObject.h"
#import "DatabaseAdapter.h"
#import "MyPropertyViewController.h"

@interface SendMailViewController : UIViewController<UITextViewDelegate,UITextFieldDelegate,UIScrollViewDelegate,SKPSMTPMessageDelegate>

{
    BOOL pestControl,termiteControl1;
    UITextField *activeField;
UITextView *activeField1;
}
@property (nonatomic) Reachability *reachability;
@property (strong,nonatomic) SKPSMTPMessage *mail1;
@property (nonatomic, strong) DatabaseAdapter *dataBase;



@property (weak, nonatomic) IBOutlet UIButton *pestControlButton;

@property (weak, nonatomic) IBOutlet UIButton *termiteControl;

@property (weak, nonatomic) IBOutlet UITextField *selectSub;

- (IBAction)selectSubjectAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollview;

@property (weak, nonatomic) IBOutlet UITextView *emailTextView;

- (IBAction)sendAction:(id)sender;

@property (nonatomic, strong)  UITapGestureRecognizer *tap;

- (IBAction)cancelButton:(id)sender;

- (IBAction)pestControlAction:(id)sender;
- (IBAction)termiteControlAction:(id)sender;





@end
