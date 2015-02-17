//
//  AddPropertyViewController.h
//  Orkin
//
//  Created by TrinityInc on 28/01/15.
//  Copyright (c) 2015 Involgix. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DatabaseAdapter.h"
#import "PropertyDetailsObject.h"
#import "MyPropertyViewController.h"
#import "NSDate+TCUtils.h"
#import "ActionSheetCustomPickerDelegate.h"
#import "AbstractActionSheetPicker.h"
#import "ActionSheetCustomPicker.h"
#import "ActionSheetDatePicker.h"
#import "ActionSheetDistancePicker.h"
#import "ActionSheetLocalePicker.h"
#import "ActionSheetStringPicker.h"
#import "AFNetworking.h"
#import "AFHTTPRequestOperation.h"

#import "AppDelegate.h"

#import "branchdataobject.h"
#import "Reachability.h"
@class AbstractActionSheetPicker;
@interface AddPropertyViewController : UIViewController<UITextFieldDelegate,UIScrollViewDelegate>{
    
     BOOL residentialChecked,commercialChecked,isDefaultChecked;
    UITextField *activeField;

}
    @property (nonatomic,strong)branchdataobject *dataObject;

@property (nonatomic,strong) NSMutableArray *fetchNameArray;


@property (nonatomic,strong) PropertyDetailsObject *showProperty;
@property (nonatomic, strong) AbstractActionSheetPicker *actionSheetPicker;
@property (nonatomic) Reachability *reachability;
//@property (nonatomic, strong) NSArray *stateNameArray;
//@property (nonatomic, assign) NSInteger selectedIndex;

@property (weak, nonatomic) IBOutlet UITextField *nickName;
@property (weak, nonatomic) IBOutlet UITextField *addressOne;

@property (weak, nonatomic) IBOutlet UITextField *addressTwo;
@property (weak, nonatomic) IBOutlet UITextField *city;

@property (weak, nonatomic) IBOutlet UITextField *state;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;


@property (weak, nonatomic) IBOutlet UITextField *postalCode;

@property (weak, nonatomic) IBOutlet UILabel *errorLabel;

@property (weak, nonatomic) IBOutlet UILabel *defaultLabel;

- (IBAction)saveButtonAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *homeButton;

@property (weak, nonatomic) IBOutlet UIButton *backButton;


- (IBAction)homeButtonAction:(id)sender;


@property (weak, nonatomic) IBOutlet UIButton *backButtonAction;

- (IBAction)LocationToggle:(id)sender;

@property (weak, nonatomic) IBOutlet UISegmentedControl *locationSegment;

@property (nonatomic, strong) DatabaseAdapter *dataBase;
@property (nonatomic, strong)  UITapGestureRecognizer *tap;

- (IBAction)stateAction:(id)sender;

- (IBAction)isDefaultButton:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *isDefault;

@property (weak, nonatomic) IBOutlet UIButton *residentialButton;

@property (weak, nonatomic) IBOutlet UIButton *commercial;

- (IBAction)residentialAction:(id)sender;

- (IBAction)commercialAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *cancelButton;


- (IBAction)cancelAction:(id)sender;

@end
