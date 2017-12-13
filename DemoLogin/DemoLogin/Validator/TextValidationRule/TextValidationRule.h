//
//  TextValidationRule.h
//  DemoLogin
//
//  Created by East Agile on 12/13/17.
//  Copyright © 2017 East Agile. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TextValidationRuleType
- (NSString *)messageError;
- (BOOL)isValidWithText:(NSString *)text;
@end

@interface TextValidationRuleRequired: NSObject <TextValidationRuleType>
- (instancetype)initWithMessage:(NSString *)message;
@end

@interface TextValidationRuleMaximum: NSObject <TextValidationRuleType>
-(instancetype)initWithMessage:(NSString *)message minimumSize:(NSInteger)maximumSize;
@end

@interface TextValidationRuleMinimum: NSObject <TextValidationRuleType>
-(instancetype)initWithMessage:(NSString *)message minimumSize:(NSInteger)minimumSize;
@end
