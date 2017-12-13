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
    NSMutableArray * failResults = [[NSMutableArray alloc] init];
    
    for(int i = 0; i < rules.count; i++) {
        NSObject<TextValidationRuleType> * item = (NSObject<TextValidationRuleType>*)rules[i];
        if (item != nil) {
            if ([item isValidWithText:text] == NO) {
                ValidationResult * result = [[ValidationResult alloc] initWithMessage:[item messageError]
                                                                 validationResultType:ValidationResultTypeFail];
                [failResults addObject:result];
            }
        }
    }
    if (failResults.count > 0) {
        return failResults[0];
    }
    ValidationResult * okResult = [[ValidationResult alloc] initWithMessage:@""
                                                       validationResultType:ValidationResultTypeOk];
    return okResult;
}
@end
