//
//  MyPropertyViewController.m
//  Orkin
//
//  Created by TrinityInc on 03/02/15.
//  Copyright (c) 2015 Involgix. All rights reserved.
//

#import "MyPropertyViewController.h"

@interface MyPropertyViewController (){
    NSMutableArray *phoneNos;
}

@end

@implementation MyPropertyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataBase = [[DatabaseAdapter alloc]init];
    phoneNos = [[NSMutableArray alloc]init];
    
    [self.dataBase copyDatabaseIfNeeded];
    self.nameLabel.text = [NSString stringWithFormat:@"Hi %@,how can we help?",[self.dataBase getUserName]];    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
   
}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([segue.identifier isEqualToString:@"toMailController"])
    {
        SendMailViewController *view = (SendMailViewController *)segue.destinationViewController;
        
        //        view.newEntry = true;
        //        view.navigatedFromPreferences = false;
    }
    
    else if ([segue.identifier isEqualToString:@"toTextView"])
        
    {
         SendTextViewController *view = (SendTextViewController *)segue.destinationViewController;
    }
    
    else if([segue.identifier isEqualToString:@"toPreferencesSegue"])
    {
        PreferencesViewController *view = (PreferencesViewController *)segue.destinationViewController;
        
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0) {
        NSLog(@"1");
    } else{
        NSString *phone = [phoneNos objectAtIndex:buttonIndex-1];
        
        //NSString *phone = @"+14043516196";
        NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"telprompt:%@", phone]];
        
        // NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:"]];
        if ([[UIApplication sharedApplication] canOpenURL:phoneURL]) {
            [[UIApplication sharedApplication] openURL:phoneURL];
        }
    }
    

}



- (IBAction)emailButtonAction:(id)sender {
    [self performSegueWithIdentifier:@"toMailController" sender:self];
}

- (IBAction)callButtonAction:(id)sender {
    
    [self.dataBase copyDatabaseIfNeeded];
    phoneNos = [self.dataBase getPhoneNo];
    if ([phoneNos count] > 0) {
        UIAlertView* message = [[UIAlertView alloc]
                                initWithTitle: @""
                                message: @"Call To Orkin Man"
                                delegate: self
                                cancelButtonTitle: @"Cancel"
                                otherButtonTitles: nil];
        
        for(NSString *buttonTitle in phoneNos) {
            [message addButtonWithTitle:buttonTitle];
        }
        
        [message show];

    }
    
}

- (IBAction)textButtonAction:(id)sender {
    
    [self performSegueWithIdentifier:@"toTextView" sender:self];
}

- (IBAction)settingsButtonAction:(id)sender {
    
    [self performSegueWithIdentifier:@"toPreferencesSegue" sender:self];
}
@end
