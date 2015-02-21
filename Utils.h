//
//  Utils.h
//  Libas
//
//  Created by Salman Khalid on 13/02/2014.
//  Copyright (c) 2014 Xint Solutions. All rights reserved.
//


#ifndef Libas_Utils_h
#define Libas_Utils_h


#define HTML_HEADEN @"<html><head></head><body>"
#define EmailBody311(C) [NSString stringWithFormat:@"<p>%@</p>",C]
#define EmailBody7(C,D) [NSString stringWithFormat:@"<p>%@ : %@</p>",C,D]
#define EmailBody72(C,D) [NSString stringWithFormat:@"<p>%@  %@</p>",C,D]

#define EmailBodyTime(C,D) [NSString stringWithFormat:@"<p>%@ : <span dir='ltr'>%@</span></p>",C,D]

#define EmailBody71(C,D,E) [NSString stringWithFormat:@"<p>%@ : %@ %@</p>",C,D,E]
#define LAST1(C) [NSString stringWithFormat:@"<p>%@</p><br /><br /></div>",C]

#define LAST @"</body></html>"







#endif
