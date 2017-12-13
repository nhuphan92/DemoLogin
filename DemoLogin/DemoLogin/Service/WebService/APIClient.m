//
//  APIClient.m
//  DemoLogin
//
//  Created by East Agile on 12/13/17.
//  Copyright © 2017 East Agile. All rights reserved.
//

#import "APIClient.h"
#import "AgileAPIClient.h"

@interface APIClient()

@property (strong, nonatomic) NSString * baseUrlString;
@property (strong, nonatomic) NSURL * _baseURL;
@property (strong, nonatomic) AFHTTPSessionManager * _sessionManager;

@end

@implementation APIClient

- (instancetype)initWithBaseUrlString:(NSString *)baseUrlString {
    self.baseUrlString = baseUrlString;
    return [super init];
}

+ (instancetype)shareInstance {
    static APIClient *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[AgileAPIClient alloc] initWithBaseUrlString:kBaseURL];
    });
    return sharedInstance;
}

- (NSURL *)baseURL {
    if (self._baseURL == nil) {
        self._baseURL = [NSURL URLWithString:self.baseUrlString];
    }
    return self._baseURL;
}

- (AFHTTPSessionManager *)sessionManager {
    if (self._sessionManager == nil) {
        self._sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[self baseURL]];
        self._sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    return self._sessionManager;
}

- (void)executeRequestWithMethod:(HTTPSMethodType)method
                            link:(NSString *)link
                           prams:(NSDictionary *)params
               successCompletion:(SuccessCompletion)successCompletion
               failureCompletion:(FailureCompletion)failureCompletion {
    if (method == HTTPSMethodTypePOST) {
        [[self sessionManager] POST:link
                         parameters:params
                           progress:nil
                            success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                NSDictionary * data = responseObject[@"data"];
                                if (data == nil) {
                                    failureCompletion(responseObject[@"message"], responseObject[@"code"]);
                                } else {
                                    successCompletion(data);
                                }
                            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                failureCompletion(kFailRequestSendingMessage, @(kErrorCodeNoInternet));
                            }];
    }
    
}

@end
