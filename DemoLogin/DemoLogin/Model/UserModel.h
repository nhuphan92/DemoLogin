//
//  UserModel.h
//  DemoLogin
//
//  Created by East Agile on 12/13/17.
//  Copyright © 2017 East Agile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>

@interface UserModel : JSONModel

@property (strong, nonatomic) NSString * username;
@property (strong, nonatomic) NSString * password;
@property (strong, nonatomic) NSString * userID;
@property (strong, nonatomic) NSString * token;

@end
