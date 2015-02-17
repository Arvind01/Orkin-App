//
//  SendMailViewController.h
//  magnetodistribution
//
//  Created by TrinityInc on 06/02/15.
//  Copyright (c) 2015 Involgix. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SendMailViewController : UIViewController<UITextViewDelegate,UITextFieldDelegate,UIScrollViewDelegate>

{
    UITextField *activeField;
UITextView *activeField1;
}

@property (weak, nonatomic) IBOutlet UIButton *pestControlButton;

@property (weak, nonatomic) IBOutlet UIButton *termiteControl;

@property (weak, nonatomic) IBOutlet UITextField *selectSub;

- (IBAction)selectSubjectAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollview;

@property (weak, nonatomic) IBOutlet UITextView *emailTextView;

- (IBAction)sendAction:(id)sender;

@property (nonatomic, strong)  UITapGestureRecognizer *tap;

- (IBAction)cancelButton:(id)sender;


@end
