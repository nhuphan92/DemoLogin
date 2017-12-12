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
    [RACObserve(self.viewModel, isLoginSucessfully) subscribeNext:^(id  _Nullable result) {
        NSLog(@"isLoginSucessfully %@", result);
        XCTAssertNotNil(result);
        XCTAssertEqual([result boolValue], isLoginSuccessfully);
        [expectation fulfill];
    }];
}

- (void)checkWithExpectedBeAbleToLogin:(BOOL)isAbleToLogin {
    [RACObserve(self.viewModel, isAbleToLogin) subscribeNext:^(id  _Nullable result) {
        XCTAssertNotNil(result);
        XCTAssertEqual([result boolValue], isAbleToLogin);
        
    }];
}

- (void)checkExpectedIsLoginning:(BOOL)isLoginning {
    __block NSInteger tempValue = 0;
    [RACObserve(self.viewModel, isLoginning) subscribeNext:^(id  _Nullable result) {
        XCTAssertNotNil(result);
        NSLog(@"                                       isLoginning %@", result);
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
                 expectedIsLoginning:(BOOL)isLoginning
{
    expectation = [self expectationWithDescription:@"Should return result after 4s"];
    [expectation setAssertForOverFulfill:NO];
    [self checkWithExpectedLoginResult:isLoginSuccessfully  xCTestExpectation:expectation];
    [self checkWithExpectedBeAbleToLogin:isAbleToLogin];
    [self checkExpectedIsLoginning:isLoginning];
    [self waitForExpectationsWithTimeout:4 handler:nil];
}

- (void)testInputsIsNil {
    username = nil;
    password = nil;
    
    [self checkWithExpectedLoginResult:NO expectedBeAbleToLogin:NO expectedIsLoginning:NO];
    [self.viewModel userTappedBtnLoginWithUserName:username password:password];
}

- (void)testInputsIsEmpty {
    username = @"";
    password = @"";
    
    [self checkWithExpectedLoginResult:NO expectedBeAbleToLogin:NO expectedIsLoginning:NO];
    [self.viewModel userTappedBtnLoginWithUserName:username password:password];
}

- (void)testInputsIsEmptyAndNil {
    username = @"";
    password = nil;
    
    [self checkWithExpectedLoginResult:NO expectedBeAbleToLogin:NO expectedIsLoginning:NO];
    [self.viewModel userTappedBtnLoginWithUserName:username password:password];
    
}

- (void)testInputsIsNilAndEmpty {
    username = @"";
    password = nil;
    
    [self checkWithExpectedLoginResult:NO expectedBeAbleToLogin:NO expectedIsLoginning:NO];
    [self.viewModel userTappedBtnLoginWithUserName:username password:password];
}

- (void)testInputsIsNilAndValuable {
    username = nil;
    password = @"Nhu";
    
    [self checkWithExpectedLoginResult:NO expectedBeAbleToLogin:NO expectedIsLoginning:NO];
    [self.viewModel userTappedBtnLoginWithUserName:username password:password];
}

- (void)testInputsIsValuableAndNil {
    username = @"Nhu";
    password = nil;
    
    [self checkWithExpectedLoginResult:NO expectedBeAbleToLogin:NO expectedIsLoginning:NO];
    [self.viewModel userTappedBtnLoginWithUserName:username password:password];
}

- (void)testInputsIsValuableAndValuable {
    username = @"nhu Phan";
    password = @"123456";
    
    [self checkWithExpectedLoginResult:YES expectedBeAbleToLogin:YES expectedIsLoginning:YES];
    [self.viewModel userTappedBtnLoginWithUserName:username password:password];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
