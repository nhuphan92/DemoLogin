//
//  LoginViewModel.m
//  DemoLogin
//
//  Created by East Agile on 12/12/17.
//  Copyright © 2017 East Agile. All rights reserved.
//

#import "LoginViewModel.h"
#import "ValidationResult.h"
#import "AgileAPIClient.h"
#import "APIClient.h"
#import "TextValidator.h"
#import "TextValidationRule.h"

NSString * kMessageEmpty = @"Field is empty.";

@interface LoginViewModel()

@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSString *password;
@property (strong, nonatomic) TextValidator * textValidator;
@property (strong, nonatomic) NSMutableArray *usernameRules;
@property (strong, nonatomic) NSMutableArray *passwordRules;
@end

@implementation LoginViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.isLoginning = NO;
        self.isAbleToLogin = NO;
        self.isLoginSucessfully = NO;
        self.validatedUsernameResult = [[ValidationResult alloc] init];
        self.validatedPasswordResult = [[ValidationResult alloc] init];
        [self.validatedUsernameResult setValues:@"" validationResultType:ValidationResultTypeFail];
        [self.validatedPasswordResult setValues:@"" validationResultType:ValidationResultTypeFail];
        self.textValidator = [[TextValidator alloc] init];
//        self.usernameRules = @[Text];
    }
    return self;
}

- (void)setupRules {
//    self.usernameRules = [[NSMutableArray alloc] init];
//    TextValidationRuleRequired *requiredRule = [[TextValidationRuleRequired alloc] initWithMessage:@"Username is required"];
//    TextValidationRuleMinimum *minumumRule = [[TextValidationRuleMinimum alloc] initWithMessage:@"Username must be longer than 6" minimumSize:6];
//    TextValidationRuleMaximum *maximumRule = [[[TextValidationRuleMaximum alloc] initWithMessage:@"Username longest is 20 characters" maximumSize:20];
//                                              self.usernameRules addObjectsFromArray:@[requiredRule, minumumRule, maximumRule]]
}

- (void)validatePassword:(NSString *)password {
    self.validatedUsernameResult = [self.textValidator isValidWithText:password
                                                              andRules:self.passwordRules];
}

- (void)validateUsername:(NSString *)username {
    self.validatedUsernameResult = [self.textValidator isValidWithText:username
                                                              andRules:self.usernameRules];
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
        
        [[AgileAPIClient sharedInstance] loginWithUsername:username
                                                 password:password
                                        successCompletion:^(UserModel *user) {
                                            self.isLoginning = NO;
                                            self.isLoginSucessfully = YES;
                                        } failureCompletion:^(NSString *message, NSNumber *code) {
                                            self.isLoginning = NO;
                                            self.isLoginSucessfully = NO;
                                            self.messageError = message;
                                        }];
    } else {
        self.messageError = [self currentMessageError];
        self.isLoginSucessfully = NO;
    }
}

@end
