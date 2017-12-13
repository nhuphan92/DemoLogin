//
//  LoginViewModel.m
//  DemoLogin
//
//  Created by East Agile on 12/12/17.
//  Copyright © 2017 East Agile. All rights reserved.
//

#import "LoginViewModel.h"
#import "ValidationResult.h"

NSString * kMessageEmpty = @"Field is empty.";

@interface LoginViewModel()
@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSString *password;
@end

@implementation LoginViewModel

- (instancetype)init {
    self.isLoginning = NO;
    self.isAbleToLogin = NO;
    self.isLoginSucessfully = NO;
    self.validatedUsernameResult = [[ValidationResult alloc] init];
    self.validatedPasswordResult = [[ValidationResult alloc] init];
    [self.validatedUsernameResult setValues:@"" validationResultType:ValidationResultTypeFail];
    [self.validatedPasswordResult setValues:@"" validationResultType:ValidationResultTypeFail];
    return [super init];
}

- (void)validatePassword:(NSString *)password {
    if (password == nil || [password isEqualToString:@""]) {
        [self.validatedPasswordResult setValues:kMessageEmpty validationResultType:ValidationResultTypeFail];
        return;
    }
    
    [self.validatedPasswordResult setValues:@"" validationResultType:ValidationResultTypeOk];
}

- (void)validateUsername:(NSString *)username {
    if (username == nil || [username isEqualToString:@""]) {
        [self.validatedUsernameResult setValues:kMessageEmpty validationResultType:ValidationResultTypeFail];
        return;
    }
    
    [self.validatedUsernameResult setValues:@"" validationResultType:ValidationResultTypeOk];
}

- (void)userInputTexts:(NSString *)username pasword:(NSString *)password {
    self.username = username;
    self.password = password;
    [self validateUsername:self.username];
    [self validatePassword:self.password];
}

- (BOOL)inputTextsIsOK {
    return (self.validatedUsernameResult.result == ValidationResultTypeOk
            && self.validatedPasswordResult.result == ValidationResultTypeOk);
}

- (NSString *)currentMessageError {
    if (self.validatedUsernameResult.errorMessage != nil
        && [self.validatedUsernameResult.errorMessage isEqualToString:@""] == NO) {
        return self.validatedUsernameResult.errorMessage;
    }
    
    if (self.validatedPasswordResult.errorMessage != nil
        && [self.validatedPasswordResult.errorMessage isEqualToString:@""] == NO) {
        return self.validatedPasswordResult.errorMessage;
    }
    
    return nil;
}

- (void)userTappedBtnLoginWithUserName:(NSString *)username password:(NSString *)password {
    [self userInputTexts:username pasword:password];
    self.isAbleToLogin = [self inputTextsIsOK];
    
    if (self.isAbleToLogin) {
        self.isLoginning = YES;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.isLoginning = NO;
            self.isLoginSucessfully = YES;
        });
    } else {
        self.messageError = [self currentMessageError];
        self.isLoginSucessfully = NO;
    }
}

@end
