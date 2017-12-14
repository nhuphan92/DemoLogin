//
//  TextValidator.m
//  DemoLogin
//
//  Created by East Agile on 12/13/17.
//  Copyright © 2017 East Agile. All rights reserved.
//

#import "TextValidator.h"
#import "TextValidationRule.h"

@implementation TextValidator

- (ValidationResult *)isValidWithText:(NSString *)text andRules:(NSArray *)rules {
    
    NSArray * failResults = [self findErrorWithText:text andRules:rules];

    if (failResults.count > 0) {
        return failResults[0];
    }
    ValidationResult * okResult = [[ValidationResult alloc] initWithMessage:@""
                                                       validationResultType:ValidationResultTypeOk];
    return okResult;
}

- (NSArray *)findErrorWithText:(NSString *)text andRules:(NSArray *)rules {
    NSMutableArray *array = [NSMutableArray new];

    for (NSObject<TextValidationRuleType> *item in rules) {
        if (item != nil) {
            if ([item isValidWithText:text] == NO) {
                ValidationResult * result = [[ValidationResult alloc] initWithMessage:[item messageError]
                                                                 validationResultType:ValidationResultTypeFail];
                [array addObject:result];
            }
        }
    }
    return array;
}

@end
