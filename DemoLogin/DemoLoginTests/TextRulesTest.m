//
//  TextRulesTest.m
//  DemoLoginTests
//
//  Created by East Agile on 12/14/17.
//  Copyright © 2017 East Agile. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TextValidationRule.h"

@interface TextRulesTest : XCTestCase

@end

@implementation TextRulesTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testRuleRequired {
    TextValidationRuleRequired *requiredRule = [[TextValidationRuleRequired alloc] initWithMessage:@"error"];
    XCTAssert([requiredRule isValidWithText:nil] == NO);
    XCTAssert([requiredRule isValidWithText:@""] == NO);
    XCTAssert([requiredRule isValidWithText:@"haveText"] == YES);
}

- (void)testRuleMinimum {
    TextValidationRuleMinimum *requiredRule = [[TextValidationRuleMinimum alloc] initWithMessage:@"error" minimumSize:4];
    XCTAssert([requiredRule isValidWithText:nil] == NO);
    XCTAssert([requiredRule isValidWithText:@""] == NO);
    XCTAssert([requiredRule isValidWithText:@"dd"] == NO);
    XCTAssert([requiredRule isValidWithText:@"over4characters"] == YES);
}

- (void)testRuleMaximum {
    TextValidationRuleMaximum *requiredRule = [[TextValidationRuleMaximum alloc] initWithMessage:@"error" maximumSize:4];
    XCTAssert([requiredRule isValidWithText:nil] == YES);
    XCTAssert([requiredRule isValidWithText:@""] == YES);
    XCTAssert([requiredRule isValidWithText:@"dd"] == YES);
    XCTAssert([requiredRule isValidWithText:@"over4characters"] == NO);
}


@end
