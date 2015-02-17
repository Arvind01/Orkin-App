//
//  GuessTrudyDB.h
//  GuessTrudy
//
//  Created by  on 2/14/14.
//  Copyright (c) 2014 Vaibhav. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoObject.h"
#import "PropertyDetailsObject.h"
#import "branchdataobject.h"

#import "Sqlite3.h"


@interface DatabaseAdapter : NSObject
{

    
   // NSMutableArray *result;
    NSString *databasepath ;
    
    
}

+ (NSString *) getDBPath;
- (void) copyDatabaseIfNeeded;
-(int)insertUserInfo:(UserInfoObject *) record;
-(int)updateUserInfo:(UserInfoObject *) record;
-(int)insertPropertyDetails:(PropertyDetailsObject *) record ;
-(int)insertBranchDetails:(branchdataobject *) record ;
-(NSMutableArray *)getNickName;
-(NSString *)getUserName;
-(NSMutableArray *)getPhoneNo;

-(NSMutableArray *)fetchPropertyDetails;
-(NSMutableArray *)fetchUserDetails;

- (BOOL)deletePropertyDetails:(PropertyDetailsObject *)property;

@end
