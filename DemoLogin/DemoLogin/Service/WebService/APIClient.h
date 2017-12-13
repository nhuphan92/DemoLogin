//
//  APIClient.h
//  DemoLogin
//
//  Created by East Agile on 12/13/17.
//  Copyright © 2017 East Agile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"
#import <AFNetworking/AFNetworking.h>

static NSString * kBaseURL = @"https://eastagile.com";
typedef void (^SuccessCompletion)(NSDictionary * data);
typedef void (^FailureCompletion)(NSString * message, NSNumber * code);
typedef void (^LoginSuccessCompletion)(UserModel * user);
typedef enum HTTPSMethodType: NSUInteger {
    HTTPSMethodTypePOST,
    HTTPSMethodTypeGET,
    HTTPSMethodTypePUT,
    HTTPSMethodTypeDELETE
} HTTPSMethodType;

static NSInteger kErrorCodeNoInternet = 400;
static NSInteger kErrorCodeDataWrongFormat = 305;
static NSString * kFailRequestSendingMessage = @"Unexpected Error!";

@interface APIClient : NSObject
- (instancetype)initWithBaseUrlString:(NSString *)url;
+ (instancetype)sharedInstance;
- (void)executeRequestWithMethod:(HTTPSMethodType)method
                            link:(NSString *)link
                           prams:(NSDictionary *)params
               successCompletion:(SuccessCompletion)successCompletion
               failureCompletion:(FailureCompletion)failureCompletion;
@end
