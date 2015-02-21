//
//  PreferencesViewController.m
//  magnetodistribution
//
//  Created by TrinityInc on 06/02/15.
//  Copyright (c) 2015 Involgix. All rights reserved.
//

#import "PreferencesViewController.h"
#import "AddPropertyViewController.h"
#import "PropertyReelViewController.h"
#import "UserViewController.h"

@interface PreferencesViewController (){
    NSUserDefaults *defaults;
}

@end

@implementation PreferencesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    defaults = [NSUserDefaults standardUserDefaults];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)homeButton:(id)sender {
    
    [self performSegueWithIdentifier:@"toHomeSegue" sender:self];
}

- (IBAction)addPropertyButton:(id)sender {
    
    [self performSegueWithIdentifier:@"toAddPropertySegue" sender:self];
    

}

- (IBAction)editPropertyButton:(id)sender {
    

    [self performSegueWithIdentifier:@"toPropertyReel" sender:self];
}

- (IBAction)userInformationButton:(id)sender {
    
     [self performSegueWithIdentifier:@"toUserInfo" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([segue.identifier isEqualToString:@"toHomeSegue"])
    {
        MyPropertyViewController *view = (MyPropertyViewController *)segue.destinationViewController;
        
        //        view.newEntry = true;
        //        view.navigatedFromPreferences = false;
    }
    else if([segue.identifier isEqualToString:@"toAddPropertySegue"])
    {
        AddPropertyViewController *view = (AddPropertyViewController *)segue.destinationViewController;
        
        //        view.newEntry = true;
        //        view.navigatedFromPreferences = false;
    }
    
    else if([segue.identifier isEqualToString:@"toPropertyReel"])
    {
        PropertyReelViewController *view = (PropertyReelViewController *)segue.destinationViewController;
        
        //        view.newEntry = true;
        //        view.navigatedFromPreferences = false;
    }
    else([segue.identifier isEqualToString:@"toUserInfo"]);
    {
        UserViewController *view = (UserViewController *)segue.destinationViewController;
        
        //        view.newEntry = true;
        //        view.navigatedFromPreferences = false;
    }
    
    
}


@end
