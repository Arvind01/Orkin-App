//
//  branchdataobject.h
//  MagnetoDistributions
//
//  Created by TrinityInc on 11/02/15.
//  Copyright (c) 2015 Involgix. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface branchdataobject : NSObject

@property (nonatomic, strong) NSString *BranchId,*Fax,*Phone, *Name,*IsResidential, *IsCommercial, *IsTermiteControl,*IsOtherServices,*BranchManager, *BranchManagerImageUrl, *Address;
@end
