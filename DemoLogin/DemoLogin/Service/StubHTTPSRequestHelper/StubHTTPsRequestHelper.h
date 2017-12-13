//
//  StubHTTPsRequestHelper.h
//  DemoLogin
//
//  Created by East Agile on 12/13/17.
//  Copyright © 2017 East Agile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StubHTTPsRequestHelper : NSObject

+ (instancetype)sharedInstance;
- (void)stubLoginHTTPSRequestWithSuccessResult;

@end
