//
//  SplashScreenViewController.m
//  Orkin
//
//  Created by TrinityInc on 28/01/15.
//  Copyright (c) 2015 Involgix. All rights reserved.
//

#import "SplashScreenViewController.h"

@interface SplashScreenViewController (){
    NSUserDefaults *defaults;
    NSString *userExistsCheck;
    NSMutableArray *PropertyExistsCheck;
}

@end

@implementation SplashScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataBase = [[DatabaseAdapter alloc]init];
    PropertyExistsCheck = [[NSMutableArray alloc]init];
    defaults = [NSUserDefaults standardUserDefaults];
    [self performSelector:@selector(ChooseSegue) withObject:self afterDelay:3];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
   
    if([segue.identifier isEqualToString:@"toPropertyView"])
    {
       AddPropertyViewController *view = (AddPropertyViewController *)segue.destinationViewController;
        
//        view.newEntry = true;
//        view.navigatedFromPreferences = false;
    }
    else  if([segue.identifier isEqualToString:@"toUserSegue"])
    {
        UserViewController *view = (UserViewController *)segue.destinationViewController;
        
        //        view.newEntry = true;
        //        view.navigatedFromPreferences = false;
    }
    else if([segue.identifier isEqualToString:@"toHomeSegue"]){
        
      //  MyPropertyViewController *view = (MyPropertyViewController *)segue.destinationViewController;
    }
    
}

-(void)ChooseSegue
{
    
    
    // Getting values from database to check existing
    // 1. User
    // 2. Property
    
//    var userExists = UserInfoCache.GetUserInfoFromDatabase();
//    PropertiesCache.GetAllProperties();
//    EmailCache.GetAllEmails ();
//    TextCache.GetAllTexts ();
//    ReturnTextNumberCache.GetTextNumberfromDatabase();
//    var propertyExists = PropertiesCache.allProperties;
    
    [self.dataBase copyDatabaseIfNeeded];
    userExistsCheck = [self.dataBase getUserName];
    PropertyExistsCheck = [self.dataBase getNickName];
    
    
    if (userExistsCheck.length == 0)
    {
        
        [self performSegueWithIdentifier:@"toUserSegue" sender:self];
        
        
    }
    else if ([PropertyExistsCheck count] == 0)
    {
        
        [self performSegueWithIdentifier:@"toPropertyView" sender:self];
    }
    else
    {
        
        [self performSegueWithIdentifier:@"toHomeSegue" sender:self];
        
        
    }
    
    
    
}


@end
