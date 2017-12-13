//
//  AgileAPIClient.h
//  DemoLogin
//
//  Created by East Agile on 12/13/17.
//  Copyright © 2017 East Agile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APIClient.h"

@protocol WebServiceType
- (void)loginWithUsername:(NSString *)username
                 password:(NSString *)password
        successCompletion:(LoginSuccessCompletion)successCompletion
        failureCompletion:(FailureCompletion)failureCompletion;
@end

@interface AgileAPIClient : APIClient <WebServiceType>

@end
