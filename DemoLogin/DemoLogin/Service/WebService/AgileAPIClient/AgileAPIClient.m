//
//  AgileAPIClient.m
//  DemoLogin
//
//  Created by East Agile on 12/13/17.
//  Copyright © 2017 East Agile. All rights reserved.
//

#import "AgileAPIClient.h"

@interface AgileAPIClient() <WebServiceType>

@end

@implementation AgileAPIClient

#pragma mark - API

- (void)loginWithUsername:(NSString *)username
                 password:(NSString *)password
        successCompletion:(LoginSuccessCompletion)successCompletion
        failureCompletion:(FailureCompletion)failureCompletion {
    
    NSDictionary * params = @{@"username": username,
                              @"password": password};
    
    [self executeRequestWithMethod:HTTPSMethodTypePOST
                              link:@"/login"
                             prams:params
                 successCompletion:^(NSDictionary *data) {
                     NSError *error;
                     UserModel *userModel = [[UserModel alloc] initWithDictionary:data error:&error];
                     if (error == nil) {
                         successCompletion(userModel);
                     } else {
                         failureCompletion(@"Cannot parse the Data!", @(kErrorCodeDataWrongFormat));
                     }
                 } failureCompletion:failureCompletion];
    
}

@end

