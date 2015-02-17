//
//  GuessTrudyDB.m
//  GuessTrudy
//
//  Created by Vaibhav on 2/14/14.
//  Copyright (c) 2014 Vaibhav. All rights reserved.
//

#import "DatabaseAdapter.h"


@implementation DatabaseAdapter






#pragma mark Class functions
+ (NSString *) getDBPath {
    

	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
	return [documentsDir stringByAppendingPathComponent:@"magneto.db3"];
}



- (void) copyDatabaseIfNeeded {
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSError *error;
	NSString *dbPath = [DatabaseAdapter getDBPath];
    NSLog(@"path %@",dbPath);
	BOOL success = [fileManager fileExistsAtPath:dbPath];
	
	if(!success) {
		
		NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"magneto.db3"];
		success = [fileManager copyItemAtPath:defaultDBPath toPath:dbPath error:&error];
		
		if (!success)
			NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
	}
}


-(int)insertUserInfo:(UserInfoObject *)record {
    sqlite3 *database;
    int result;
    if(sqlite3_open([[DatabaseAdapter getDBPath] UTF8String], &database) == SQLITE_OK)
    {
        // Setup the SQL Statement and compile it for faster access
        const char* sqliteQuery = "INSERT INTO UserData (FirstName, LastName,email) VALUES (?, ? ,? )";
        sqlite3_stmt * statement = NULL;
        
        if( sqlite3_prepare_v2(database, sqliteQuery, -1, &statement, NULL) == SQLITE_OK )
        {
            
            sqlite3_bind_text(statement, 1, [record.firstName UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 2, [record.lastName UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 3, [record.emailId UTF8String], -1, SQLITE_TRANSIENT);
            
            result=  sqlite3_step(statement);
            
        }
        else
        {
            NSLog( @"SaveBody: Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(database) );
        }
        sqlite3_finalize(statement);
        
    }
    sqlite3_close(database);
        
    return result;
}

-(int)updateUserInfo:(UserInfoObject *) record{
    
    BOOL success = false;
    
    sqlite3_stmt *statement = NULL;
    sqlite3 *database;
    
    
    if(sqlite3_open([[DatabaseAdapter getDBPath] UTF8String], &database) == SQLITE_OK)
        
    {
        
        
        NSString *stmt=[NSString stringWithFormat:@"UPDATE UserData  SET FirstName=\"%@\",LastName=\"%@\",email=\"%@\" where id=%d",record.firstName,record.lastName,record.emailId,0];
        
        
        
        const char *update_stmt = [stmt UTF8String];
        sqlite3_prepare_v2(database,update_stmt, -1, &statement, NULL );
        
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            success = true;
            
        }
        
        else{
            NSLog(@"New data, Nothing to delete");
            success = false;
        }
        
        sqlite3_finalize(statement);
        sqlite3_close(database);
        
    }
    
    return success;
    
}

-(int)insertPropertyDetails:(PropertyDetailsObject *) record {
    
    sqlite3 *database;
    int result;
    if(sqlite3_open([[DatabaseAdapter getDBPath] UTF8String], &database) == SQLITE_OK)
    {
        // Setup the SQL Statement and compile it for faster access
        const char* sqliteQuery = "INSERT INTO Properties (Nickname, AddressOne,AddressTwo,City,State,PostalCode,LocationType,isDefault) VALUES (?, ? ,? ,? ,? ,? ,? ,?)";
        sqlite3_stmt * statement = NULL;
        
        if( sqlite3_prepare_v2(database, sqliteQuery, -1, &statement, NULL) == SQLITE_OK )
        {
            
            sqlite3_bind_text(statement, 1, [record.nickName UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 2, [record.addressOne UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 3, [record.addressTwo UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 4, [record.city UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 5, [record.state UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 6, [record.postalCode UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 7, [record.locationType UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 8, [record.isDefault UTF8String], -1, SQLITE_TRANSIENT);
            
            result=  sqlite3_step(statement);
            
        }
        else
        {
            NSLog( @"SaveBody: Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(database) );
        }
        sqlite3_finalize(statement);
        
    }
    sqlite3_close(database);
    
    return result;
    
}

-(NSMutableArray *)getNickName{
    
    //select Nickname from Properties
    sqlite3 *database;
    NSMutableArray *Templates=[[NSMutableArray alloc]init];
    // Init the animals Array
    
    // Open the database from the users filessytem
    if(sqlite3_open([[DatabaseAdapter getDBPath] UTF8String], &database) == SQLITE_OK) {
        
        NSString *stmt=[NSString stringWithFormat:@"select Nickname from Properties"];
        
        const char *sqlStatement = [stmt cStringUsingEncoding:NSASCIIStringEncoding];
        
        sqlite3_stmt *compiledStatement;
        if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
            // Loop through the results and add them to the feeds array
            while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
                
                
                PropertyDetailsObject *item=[[PropertyDetailsObject alloc]init];
                
                item.nickName= [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,0)];
                
                
                [Templates addObject:item];
                
                
                
            }
            
        }
    }
    
    return Templates;
}

-(int)insertBranchDetails:(branchdataobject *) record {
    
    sqlite3 *database;
    int result;
    if(sqlite3_open([[DatabaseAdapter getDBPath] UTF8String], &database) == SQLITE_OK)
    {
        // Setup the SQL Statement and compile it for faster access
        const char* sqliteQuery = "INSERT INTO BranchData2 (BranchId, PhoneNo) VALUES (?, ? )";
        sqlite3_stmt * statement = NULL;
        
        if( sqlite3_prepare_v2(database, sqliteQuery, -1, &statement, NULL) == SQLITE_OK )
        {
            
            sqlite3_bind_text(statement, 1, [record.BranchId UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 2, [record.Phone UTF8String], -1, SQLITE_TRANSIENT);
            
            
            result=  sqlite3_step(statement);
            
        }
        else
        {
            NSLog( @"SaveBody: Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(database) );
        }
        sqlite3_finalize(statement);
        
    }
    sqlite3_close(database);
    
    return result;
    
}

-(NSString *)getUserName{
    sqlite3 *database;
    NSString *Templates;
    // Init the animals Array
    
    // Open the database from the users filessytem
    if(sqlite3_open([[DatabaseAdapter getDBPath] UTF8String], &database) == SQLITE_OK) {
        
        NSString *stmt=[NSString stringWithFormat:@"select FirstName from UserData"];
        
        const char *sqlStatement = [stmt cStringUsingEncoding:NSASCIIStringEncoding];
        
        sqlite3_stmt *compiledStatement;
        if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
            // Loop through the results and add them to the feeds array
            while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
                
                
               UserInfoObject *item=[[UserInfoObject alloc]init];
                
                item.firstName= [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,0)];
                
                
                Templates = item.firstName;
                
                
                
            }
            
        }
    }
    
    return Templates;

}

-(NSMutableArray *)getPhoneNo{
    
    sqlite3 *database;
    NSMutableArray *Templates = [[NSMutableArray alloc]init];
    // Init the animals Array
    
    // Open the database from the users filessytem
    if(sqlite3_open([[DatabaseAdapter getDBPath] UTF8String], &database) == SQLITE_OK) {
        
        NSString *stmt=[NSString stringWithFormat:@"select PhoneNo from BranchData2"];
        
        const char *sqlStatement = [stmt cStringUsingEncoding:NSASCIIStringEncoding];
        
        sqlite3_stmt *compiledStatement;
        if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
            // Loop through the results and add them to the feeds array
            while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
                
                
               branchdataobject *item=[[branchdataobject alloc]init];
                
                item.Phone= [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,0)];
                
                
                [Templates addObject:item.Phone];
                
                
                
            }
            
        }
    }
    
    return Templates;
    
}

- (BOOL)deletePropertyDetails:(PropertyDetailsObject *)property{
    
    BOOL success = false;
    sqlite3_stmt *statement = NULL;
    sqlite3 *database;
    NSString *deleteSQL;
    
    if(sqlite3_open([[DatabaseAdapter getDBPath] UTF8String], &database) == SQLITE_OK)
        
    {
        //                NSLog(@"Exitsing data, Delete Please");
        
        deleteSQL = [NSString stringWithFormat:@"delete from Properties where Id=%@",property.Id];
        
        
        
        const char *delete_stmt = [deleteSQL UTF8String];
        sqlite3_prepare_v2(database, delete_stmt, -1, &statement, NULL );
        
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            success = true;
            
        }
        
    }
    else{
        //        NSLog(@"New data, Nothing to delete");
        success = true;
    }
    
    sqlite3_finalize(statement);
    sqlite3_close(database);
    
    
    
    return success;
}



-(NSMutableArray *)fetchPropertyDetails;
{
    sqlite3 *database;
    NSMutableArray *fetchProperty=[[NSMutableArray alloc]init];
    
    // Open the database from the users filessytem
    if(sqlite3_open([[DatabaseAdapter getDBPath] UTF8String], &database) == SQLITE_OK) {
        
        NSString *stmt=[NSString stringWithFormat:@"select * from Properties"];
        const char *sqlStatement = [stmt cStringUsingEncoding:NSASCIIStringEncoding];
        
        sqlite3_stmt *compiledStatement;
        
        if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
            // Loop through the results and add them to the feeds array
            while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
                
                
                PropertyDetailsObject *item=[[PropertyDetailsObject alloc]init];
                item.Id = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,0)];
                
                item.nickName= [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,1)];
                
                item.addressOne= [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,2)];
                
                item.addressTwo= [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,3)];
                
                item.city= [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,4)];
                
                
                item.state= [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,5)];
                
                item.postalCode= [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,6)];
                
                item.locationType= [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,7)];
                
                item.isDefault= [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,8)];
                
                [fetchProperty addObject:item];
                
                
                
            }
            
        }
    }
    
    return fetchProperty;
}

-(NSMutableArray *)fetchUserDetails{
    sqlite3 *database;
    NSMutableArray *fetchUserInfo=[[NSMutableArray alloc]init];
    
    // Open the database from the users filessytem
    if(sqlite3_open([[DatabaseAdapter getDBPath] UTF8String], &database) == SQLITE_OK) {
        
        NSString *stmt=[NSString stringWithFormat:@"select * from UserData"];
        const char *sqlStatement = [stmt cStringUsingEncoding:NSASCIIStringEncoding];
        
        sqlite3_stmt *compiledStatement;
        
        if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
            // Loop through the results and add them to the feeds array
            while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
                
                
                UserInfoObject *item=[[UserInfoObject alloc]init];
                item.firstName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,1)];
                
                item.lastName= [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,2)];
                
                item.emailId= [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,3)];
                
               
                
                [fetchUserInfo addObject:item];
                
                
                
            }
            
        }
    }
    
    return fetchUserInfo;
}


/*

-(void)addQuickstats :(NSString *)practise_id :(NSString *)tmpsec :(NSString *)tmpmin :(NSString *)avgsp :(NSString *)vol :(NSString *)forehand_p1 :(NSString *)forehand_p2 :(NSString *)backhand_p1 :(NSString *)backhand_p2
{
    sqlite3 *database;
   
    if(sqlite3_open([[PractiseDB getDBPath] UTF8String], &database) == SQLITE_OK)
    {
		// Setup the SQL Statement and compile it for faster access
        const char* sqliteQuery = "INSERT INTO Practise_Session_Stats(PRACTISE_ID,temposec,tempomin,avgspeed,volume,forehand_p1,forehand_p2,backhand_p1,backhand_p2) VALUES (? ,?, ? ,? ,? ,? ,? ,? ,?)";
        sqlite3_stmt * statement = NULL;
        
        if( sqlite3_prepare_v2(database, sqliteQuery, -1, &statement, NULL) == SQLITE_OK )
        {
            
        sqlite3_bind_text(statement, 1, [practise_id UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 2, [tmpsec UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 3, [tmpmin UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 4, [avgsp UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 5, [vol UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 6, [forehand_p1 UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 7, [forehand_p2 UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 8, [backhand_p1 UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 9, [backhand_p2 UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_step(statement);
            
        }
        else
        {
            NSLog( @"SaveBody: Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(database) );
        }
        sqlite3_finalize(statement);
        
	}
    sqlite3_close(database);
}



-(NSString *)getPlayerName :(NSString *) player_id
{
    
    
    sqlite3 *database;
    NSString *Player_name;
    // Init the animals Array
    
    // Open the database from the users filessytem
    if(sqlite3_open([[PractiseDB getDBPath] UTF8String], &database) == SQLITE_OK) {
        
        NSString *stmt=[NSString stringWithFormat:@"SELECT * FROM PLAYERDETAILS where PID='%@'",player_id];
        
        const char *sqlStatement = [stmt cStringUsingEncoding:NSASCIIStringEncoding];
        
        sqlite3_stmt *compiledStatement;
        if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
            // Loop through the results and add them to the feeds array
            while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
                
                
                Player_name= [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,1)];
                
            }
        }
    }
    
    return Player_name;
    
    
}*/

@end
