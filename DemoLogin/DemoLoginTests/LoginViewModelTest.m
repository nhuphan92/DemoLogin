//
//  LoginViewModelTest.m
//  DemoLoginTests
//
//  Created by East Agile on 12/12/17.
//  Copyright © 2017 East Agile. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LoginViewModel.h"
#import <ReactiveObjC/ReactiveObjC.h>

NSString * kUsername = @"Phan Nhu";
NSString * kPassword = @"123456";
NSString * kEmptyText = @"";

@interface LoginViewModelTest : XCTestCase
@property (strong, nonatomic) LoginViewModel *viewModel;
@end

@implementation LoginViewModelTest
{
    NSString * username;
    NSString * password;
    XCTestExpectation *expectation;
}

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.viewModel = [[LoginViewModel alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    username = nil;
    password = nil;
    self.viewModel = nil;
}

- (void)checkWithExpectedLoginResult:(BOOL)isLoginSuccessfully
                   xCTestExpectation:(XCTestExpectation *)expectation {
    [[RACObserve(self.viewModel, isLoginSucessfully) skip:1] subscribeNext:^(id  _Nullable result) {
        NSLog(@"isLoginSucessfully %@", result);
        XCTAssertNotNil(result);
        XCTAssertEqual([result boolValue], isLoginSuccessfully);
        [expectation fulfill];
    }];
}

- (void)checkWithExpectedBeAbleToLogin:(BOOL)isAbleToLogin {
    [[RACObserve(self.viewModel, isAbleToLogin) skip:1] subscribeNext:^(id  _Nullable result) {
        NSLog(@"isAbleToLogin %@", result);
        XCTAssertNotNil(result);
        XCTAssertEqual([result boolValue], isAbleToLogin);
        
    }];
}

- (void)checkWithExpectedIsLoginningAtFirst:(BOOL)isLoginning {
    __block NSInteger tempValue = 0;
    [[RACObserve(self.viewModel, isLoginning) skip:1] subscribeNext:^(id  _Nullable result) {
        XCTAssertNotNil(result);
        NSLog(@"isLoginning %@", result);
        if (tempValue % 2 == 0) {
            XCTAssertEqual([((NSNumber *)result) boolValue], isLoginning);
        } else {
            XCTAssertEqual([((NSNumber *)result) boolValue], !isLoginning);
        }
        tempValue = tempValue + 1;
        
    }];
}

- (void)checkWithExpectedLoginResult:(BOOL)isLoginSuccessfully
               expectedBeAbleToLogin:(BOOL)isAbleToLogin
          expectedIsLoginningAtFirst:(BOOL)isLoginning
{
    [self checkWithExpectedLoginResult:isLoginSuccessfully  xCTestExpectation:expectation];
    [self checkWithExpectedBeAbleToLogin:isAbleToLogin];
    [self checkWithExpectedIsLoginningAtFirst:isLoginning];
}

- (void)runTestWithUserName:(NSString *)username_
                   password:(NSString *)password_
        expectedLoginResult:(BOOL)isLoginSuccessfully
      expectedBeAbleToLogin:(BOOL)isAbleToLogin
        expectedIsLoginning:(BOOL)isLoginning {
    
    username = username_;
    password = password_;
    expectation = [self expectationWithDescription:@"Should return result after 6s"];
    [expectation setAssertForOverFulfill:NO];
    
    [self checkWithExpectedLoginResult:isLoginSuccessfully
                 expectedBeAbleToLogin:isAbleToLogin
            expectedIsLoginningAtFirst:isLoginning];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.viewModel userTappedBtnLoginWithUserName:username password:password];
    });
    [self waitForExpectationsWithTimeout:6 handler:nil];
}

- (void)testInputsIsNil {
    [self runTestWithUserName:nil
                     password:nil
          expectedLoginResult:NO
        expectedBeAbleToLogin:NO
          expectedIsLoginning:NO];
}

- (void)testInputsIsEmpty {
    [self runTestWithUserName:kEmptyText
                     password:kEmptyText
          expectedLoginResult:NO
        expectedBeAbleToLogin:NO
          expectedIsLoginning:NO];
}

- (void)testInputsIsEmptyAndNil {
    [self runTestWithUserName:kEmptyText
                     password:nil
          expectedLoginResult:NO
        expectedBeAbleToLogin:NO
          expectedIsLoginning:NO];

}

- (void)testInputsIsNilAndEmpty {
    [self runTestWithUserName:nil
                     password:kEmptyText
          expectedLoginResult:NO
        expectedBeAbleToLogin:NO
          expectedIsLoginning:NO];

}

- (void)testInputsIsNilAndValuable {
    [self runTestWithUserName:nil
                     password:kPassword
          expectedLoginResult:NO
        expectedBeAbleToLogin:NO
          expectedIsLoginning:NO];
}

- (void)testInputsIsValuableAndNil {
    [self runTestWithUserName:kUsername
                     password:nil
          expectedLoginResult:NO
        expectedBeAbleToLogin:NO
          expectedIsLoginning:NO];
}

- (void)testInputsIsValuableAndValuable {
    [self runTestWithUserName:kUsername
                     password:kPassword
          expectedLoginResult:YES
        expectedBeAbleToLogin:YES
          expectedIsLoginning:YES];
}

@end
