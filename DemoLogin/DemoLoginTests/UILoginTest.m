//
//  UILoginTest.m
//  DemoLoginTests
//
//  Created by East Agile on 12/14/17.
//  Copyright © 2017 East Agile. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <KIF/KIF.h>
#import "LoginViewController.h"
#import "ViewController.h"

@interface UILoginTest : KIFTestCase

@end

@implementation UILoginTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testLoginSuccessfully {
    [tester enterText:@"Phan nhu" intoViewWithAccessibilityLabel:@"username"];
    [tester enterText:@"1234567" intoViewWithAccessibilityLabel:@"password"];
    [tester tapViewWithAccessibilityLabel:@"login"];
    
    [tester waitForViewWithAccessibilityLabel:@"logout"];
}

- (void)testLoginFailly {
    [tester enterText:@"Phan nhu" intoViewWithAccessibilityLabel:@"username"];
    [tester enterText:@"" intoViewWithAccessibilityLabel:@"password"];
    [tester tapViewWithAccessibilityLabel:@"login"];
    
    [tester waitForViewWithAccessibilityLabel:@"Oops"];
}

@end
