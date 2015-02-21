//
//  PropertyReelViewController.h
//  MagnetoDistributions
//
//  Created by TrinityInc on 13/02/15.
//  Copyright (c) 2015 Involgix. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DatabaseAdapter.h"
#import "PropertyDetailsObject.h"
#import "AddPropertyViewController.h"
@protocol senddataProtocol <NSObject>
-(void)sendDataToParent:(PropertyDetailsObject *)property;
@end
@interface PropertyReelViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic,assign)id delegate;
@property (weak, nonatomic) IBOutlet UITableView *propertytableview;
@property (nonatomic, strong) DatabaseAdapter *dataBase;

- (IBAction)cancelButton:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *cancelButton;


@end
