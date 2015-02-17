//
//  SendTextViewController.h
//  magnetodistribution
//
//  Created by TrinityInc on 06/02/15.
//  Copyright (c) 2015 Involgix. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SendTextViewController : UIViewController<UITextFieldDelegate, UITextViewDelegate, UIScrollViewDelegate>

{

UITextField *activeField;
UITextView *activeField1;
}
@property (nonatomic, strong)  UITapGestureRecognizer *tap;

@property (strong, nonatomic) IBOutlet UITextField *textfeild1;
@property (strong, nonatomic) IBOutlet UITextField *textfield2;
@property (strong, nonatomic) IBOutlet UITextView *textview;
@property (strong, nonatomic) IBOutlet UIButton *sendbutton;
@property (strong, nonatomic) IBOutlet UIButton *backbutton;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollview;

- (IBAction)backAction:(id)sender;


@end
