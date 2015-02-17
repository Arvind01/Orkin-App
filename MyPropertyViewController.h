//
//  MyPropertyViewController.h
//  Orkin
//
//  Created by TrinityInc on 03/02/15.
//  Copyright (c) 2015 Involgix. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SendMailViewController.h"
#import "SendTextViewController.h"
#import "PreferencesViewController.h"
#import "DatabaseAdapter.h"
#import "AppDelegate.h"

@interface MyPropertyViewController : UIViewController<UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

- (IBAction)emailButtonAction:(id)sender;

- (IBAction)callButtonAction:(id)sender;

- (IBAction)textButtonAction:(id)sender;

- (IBAction)settingsButtonAction:(id)sender;

@property (nonatomic, strong) DatabaseAdapter *dataBase;

@end
