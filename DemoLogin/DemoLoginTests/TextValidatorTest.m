//
//  TextValidatorTest.m
//  DemoLoginTests
//
//  Created by East Agile on 12/13/17.
//  Copyright © 2017 East Agile. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import <OCMock/OCMock.h>
#import "TextValidator.h"
#import "TextValidationRule.h"


@interface TextValidatorTest : XCTestCase

@end

@implementation TextValidatorTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testValidTextValidateFailly {
    id textValidator = OCMPartialMock([TextValidator new]);
    NSString *testText = @"Password";
    NSString *messageError = @"error";
    TextValidationRuleRequired *requireRule = OCMPartialMock([[TextValidationRuleRequired alloc] initWithMessage:messageError]);
    OCMStub([requireRule isValidWithText:testText]).andReturn(NO);
    ValidationResult* result = [textValidator isValidWithText:testText andRules:@[requireRule]];
    XCTAssert(result != nil);
    XCTAssert(result.result == ValidationResultTypeFail);
}

- (void)testValidTextValidateSuccessfully {
    id textValidator = OCMPartialMock([TextValidator new]);
    NSString *testText = @"Password";
    NSString *messageError = @"error";
    TextValidationRuleRequired *requireRule = OCMPartialMock([[TextValidationRuleRequired alloc] initWithMessage:messageError]);
    OCMStub([requireRule isValidWithText:testText]).andReturn(YES);
    ValidationResult* result = [textValidator isValidWithText:testText andRules:@[requireRule]];
    XCTAssert(result != nil);
    XCTAssert(result.result == ValidationResultTypeOk);
}

- (void)testValidTextSuccessful {
    id textValidator = OCMPartialMock([TextValidator new]);
    NSString *testText = @"Password";
    ValidationResult* result = [textValidator isValidWithText:testText andRules:@[]];
    XCTAssert(result != nil);
    XCTAssert(result.result == ValidationResultTypeOk);
}

- (void)testValidTextMultipleRulesExpectedFailAtFirstRule {
    id textValidator = OCMPartialMock([TextValidator new]);
    NSString *testText = @"";
    NSString *messageErrorRequired = @"error required";
    NSString *messageErrorMinimum = @"error minimum size";
    NSString *messageErrorMaximum = @"error maximum size";
    
    TextValidationRuleRequired *requireRule = OCMPartialMock([[TextValidationRuleRequired alloc] initWithMessage:messageErrorRequired]);
    OCMStub([requireRule isValidWithText:testText]).andReturn(NO);
    
    TextValidationRuleMinimum *minimumRule = OCMPartialMock([[TextValidationRuleMinimum alloc] initWithMessage:messageErrorMinimum minimumSize:5]);
    OCMStub([minimumRule isValidWithText:testText]).andReturn(NO);
    
    TextValidationRuleMinimum *maximumRule = OCMPartialMock([[TextValidationRuleMaximum alloc] initWithMessage:messageErrorMaximum maximumSize:10]);
    OCMStub([maximumRule isValidWithText:testText]).andReturn(NO);
    
    ValidationResult* result = [textValidator isValidWithText:testText andRules:@[requireRule, minimumRule, maximumRule]];
    XCTAssert(result != nil);
    XCTAssert(result.result == ValidationResultTypeFail);
    XCTAssert([result.errorMessage isEqualToString:messageErrorRequired]);
}

- (void)testValidTextMultipleRulesExpectedFailAtSecondRule {
    id textValidator = OCMPartialMock([TextValidator new]);
    NSString *testText = @"abc";
    NSString *messageErrorRequired = @"error required";
    NSString *messageErrorMinimum = @"error minimum size";
    NSString *messageErrorMaximum = @"error maximum size";
    
    TextValidationRuleRequired *requireRule = OCMPartialMock([[TextValidationRuleRequired alloc] initWithMessage:messageErrorRequired]);
    OCMStub([requireRule isValidWithText:testText]).andReturn(YES);
    
    TextValidationRuleMinimum *minimumRule = OCMPartialMock([[TextValidationRuleMinimum alloc] initWithMessage:messageErrorMinimum minimumSize:5]);
    OCMStub([minimumRule isValidWithText:testText]).andReturn(NO);
    
    TextValidationRuleMinimum *maximumRule = OCMPartialMock([[TextValidationRuleMaximum alloc] initWithMessage:messageErrorMaximum maximumSize:10]);
    OCMStub([maximumRule isValidWithText:testText]).andReturn(NO);
    
    ValidationResult* result = [textValidator isValidWithText:testText andRules:@[requireRule, minimumRule, maximumRule]];
    XCTAssert(result != nil);
    XCTAssert(result.result == ValidationResultTypeFail);
    XCTAssert([result.errorMessage isEqualToString:messageErrorMinimum]);
}

- (void)testValidTextMultipleRulesExpectedFailAtThirdRule {
    id textValidator = OCMPartialMock([TextValidator new]);
    NSString *testText = @"abcdefjghtedffsdd";
    NSString *messageErrorRequired = @"error required";
    NSString *messageErrorMinimum = @"error minimum size";
    NSString *messageErrorMaximum = @"error maximum size";
    
    TextValidationRuleRequired *requireRule = OCMPartialMock([[TextValidationRuleRequired alloc] initWithMessage:messageErrorRequired]);
    OCMStub([requireRule isValidWithText:testText]).andReturn(YES);
    
    TextValidationRuleMinimum *minimumRule = OCMPartialMock([[TextValidationRuleMinimum alloc] initWithMessage:messageErrorMinimum minimumSize:5]);
    OCMStub([minimumRule isValidWithText:testText]).andReturn(YES);
    
    TextValidationRuleMinimum *maximumRule = OCMPartialMock([[TextValidationRuleMaximum alloc] initWithMessage:messageErrorMaximum maximumSize:10]);
    OCMStub([maximumRule isValidWithText:testText]).andReturn(NO);
    
    ValidationResult* result = [textValidator isValidWithText:testText andRules:@[requireRule, minimumRule, maximumRule]];
    XCTAssert(result != nil);
    XCTAssert(result.result == ValidationResultTypeFail);
    XCTAssert([result.errorMessage isEqualToString:messageErrorMaximum]);
}

- (void)testValidTextMultipleRulesExpectedPassAllRules {
    id textValidator = OCMPartialMock([TextValidator new]);
    NSString *testText = @"abcdefj";
    NSString *messageErrorRequired = @"error required";
    NSString *messageErrorMinimum = @"error minimum size";
    NSString *messageErrorMaximum = @"error maximum size";
    
    TextValidationRuleRequired *requireRule = OCMPartialMock([[TextValidationRuleRequired alloc] initWithMessage:messageErrorRequired]);
    OCMStub([requireRule isValidWithText:testText]).andReturn(YES);
    
    TextValidationRuleMinimum *minimumRule = OCMPartialMock([[TextValidationRuleMinimum alloc] initWithMessage:messageErrorMinimum minimumSize:5]);
    OCMStub([minimumRule isValidWithText:testText]).andReturn(YES);
    
    TextValidationRuleMinimum *maximumRule = OCMPartialMock([[TextValidationRuleMaximum alloc] initWithMessage:messageErrorMaximum maximumSize:10]);
    OCMStub([maximumRule isValidWithText:testText]).andReturn(YES);
    
    ValidationResult* result = [textValidator isValidWithText:testText andRules:@[requireRule, minimumRule, maximumRule]];
    XCTAssert(result != nil);
    XCTAssert(result.result == ValidationResultTypeOk);
    XCTAssert([result.errorMessage isEqualToString:@""]);
}

@end
