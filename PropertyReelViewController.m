//
//  PropertyReelViewController.m
//  MagnetoDistributions
//
//  Created by TrinityInc on 13/02/15.
//  Copyright (c) 2015 Involgix. All rights reserved.
//

#import "PropertyReelViewController.h"
#import "DatabaseAdapter.h"


@interface PropertyReelViewController ()
{
    NSMutableArray *propertyArray;
    NSInteger rowIndex;
    NSUserDefaults *defaults;
}
@end

@implementation PropertyReelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dataBase = [[DatabaseAdapter alloc]init];
    propertyArray =[[NSMutableArray alloc]init];
    
    defaults = [NSUserDefaults standardUserDefaults];
    [self.dataBase copyDatabaseIfNeeded];
    
    propertyArray= [self.dataBase fetchPropertyDetails];
    
    [self.propertytableview reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [propertyArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PropertyDetailsObject *property = [[PropertyDetailsObject alloc]init];
    property = [propertyArray objectAtIndex:indexPath.row];
    
    static NSString *simpleTableIdentifier = @"PropertyCellitem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = property.nickName;
    return cell;
}

//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
//    return YES;
//}
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.dataBase deletePropertyDetails:[propertyArray objectAtIndex:indexPath.row]];
    [propertyArray removeObjectAtIndex:indexPath.row];
    
    [self.propertytableview reloadData];
}



// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
   
    if([segue.identifier isEqualToString:@"goToDetails"])
    {
       // [defaults setInteger:1 forKey:checkSettings];
        AddPropertyViewController *view = (AddPropertyViewController *)segue.destinationViewController;
        view.showProperty1 = [[PropertyDetailsObject alloc]init];
        view.showProperty1 = [propertyArray objectAtIndex:rowIndex];
        view.updateProperty1 = @"1";
        
        //        view.newEntry = true;
        //        view.navigatedFromPreferences = false;
    }
    
    
}
 



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    rowIndex = indexPath.row;
    [self performSegueWithIdentifier:@"goToDetails" sender:self];
    
    
}
- (IBAction)cancelButton:(id)sender {
    
   [self dismissViewControllerAnimated:YES completion:nil];
}
@end
