//
//  TextValidationRule.m
//  DemoLogin
//
//  Created by East Agile on 12/13/17.
//  Copyright © 2017 East Agile. All rights reserved.
//

#import "TextValidationRule.h"

#pragma mark - TextValidationRuleRequired
@interface TextValidationRuleRequired() <TextValidationRuleType>
@property (strong, nonatomic) NSString *message;
@end

@implementation TextValidationRuleRequired

- (instancetype)initWithMessage:(NSString *)message {
    self = [super init];
    if (self) {
        self.message = message;
    }
    return self;
}

- (NSString *)messageError {
    return self.message;
}

-(BOOL)isValidWithText:(NSString *)text {
    return !(text == nil || [text isEqualToString:@""]);
}

@end

#pragma mark - TextValidationRuleMinimum
@interface TextValidationRuleMinimum() <TextValidationRuleType>
@property (strong, nonatomic) NSString *message;
@property (assign, nonatomic) NSInteger minimumSize;
@end

@implementation TextValidationRuleMinimum

-(instancetype)initWithMessage:(NSString *)message minimumSize:(NSInteger)minimumSize {
    self = [super init];
    if (self) {
        self.message = message;
        self.minimumSize = minimumSize;
    }
    return self;
}

- (NSString *)messageError {
    return self.message;
}

-(BOOL)isValidWithText:(NSString *)text {
    NSInteger lenghthText = 0;
    if (text == nil || [text isEqualToString:@""]) {
        lenghthText = 0;
    } else {
        lenghthText = [text length];
    }
    return lenghthText >= self.minimumSize;
}

@end

#pragma mark - TextValidationRuleMaximum
@interface TextValidationRuleMaximum() <TextValidationRuleType>
@property (strong, nonatomic) NSString *message;
@property (assign, nonatomic) NSInteger maximumSize;
@end

@implementation TextValidationRuleMaximum

-(instancetype)initWithMessage:(NSString *)message minimumSize:(NSInteger)maximumSize {
    self = [super init];
    if (self) {
        self.message = message;
        self.maximumSize = maximumSize;
    }
    return self;
}

- (NSString *)messageError {
    return self.message;
}

-(BOOL)isValidWithText:(NSString *)text {
    NSInteger lenghthText = 0;
    if (text == nil || [text isEqualToString:@""]) {
        lenghthText = 0;
    } else {
        lenghthText = [text length];
    }
    return lenghthText <= self.maximumSize;
}

@end

