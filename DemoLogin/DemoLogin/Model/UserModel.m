//
//  UserModel.m
//  DemoLogin
//
//  Created by East Agile on 12/13/17.
//  Copyright © 2017 East Agile. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
                                                                  @"username": @"username",
                                                                  @"password": @"password",
                                                                  @"userID": @"user_id",
                                                                  @"token": @"token"
                                                                  }];
}

@end
