//
//  PropertyDetailsObject.h
//  Orkin
//
//  Created by TrinityInc on 03/02/15.
//  Copyright (c) 2015 Involgix. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PropertyDetailsObject : NSObject{
   // NSInteger isDefault;
}


@property (nonatomic, strong) NSString *Id,*nickName,*addressOne,*addressTwo,*city,*state,*postalCode,*locationType,*isDefault;
@end
