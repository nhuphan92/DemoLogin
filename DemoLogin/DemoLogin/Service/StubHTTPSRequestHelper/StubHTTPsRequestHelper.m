//
//  StubHTTPsRequestHelper.m
//  DemoLogin
//
//  Created by East Agile on 12/13/17.
//  Copyright © 2017 East Agile. All rights reserved.
//

#import "StubHTTPsRequestHelper.h"
#import <OHHTTPStubs/OHHTTPStubs.h>
#import "OHHTTPStubsResponse+JSON.h"

@implementation StubHTTPsRequestHelper

+ (instancetype)sharedInstance {
    static StubHTTPsRequestHelper *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[StubHTTPsRequestHelper alloc] init];
    });
    return sharedInstance;
}

- (void)stubLoginHTTPSRequestWithSuccessResult {
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return [request.URL.host isEqualToString:@"eastagile.com"];
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        NSDictionary* obj = @{ @"data": @{@"username": @"Nhu Phan",
                                          @"password": @"123456",
                                          @"user_id": @(1),
                                          @"token": @"kasdfhsjfdhahffbfiuaahbsfuiwwbaifbfwiwbvaibibuwfeskjbfsjfksjdfsakhfasjfhwhbfwuifkjbvsdj"
                                          }
                               };
        return [OHHTTPStubsResponse responseWithJSONObject:obj statusCode:200 headers:nil];
    }];
}


@end
