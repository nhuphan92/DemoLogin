//
//  LoginViewModel.h
//  DemoLogin
//
//  Created by East Agile on 12/12/17.
//  Copyright © 2017 East Agile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ValidationResult.h"

@interface LoginViewModel : NSObject

@property (assign, nonatomic) BOOL isAbleToLogin;
@property (assign, nonatomic) BOOL isLoginning;
@property (assign, nonatomic) BOOL isLoginSucessfully;
@property (strong, nonatomic) ValidationResult *validatedUsernameResult;
@property (strong, nonatomic) ValidationResult *validatedPasswordResult;
@property (strong, nonatomic) NSString * messageError;

- (void)userTappedBtnLoginWithUserName:(NSString *)username password:(NSString *)password;
- (instancetype)init;

@end
