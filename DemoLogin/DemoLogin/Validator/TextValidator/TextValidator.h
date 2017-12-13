//
//  TextValidator.h
//  DemoLogin
//
//  Created by East Agile on 12/13/17.
//  Copyright © 2017 East Agile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ValidationResult.h"
#import "TextValidationRule.h"

@interface TextValidator : NSObject
- (ValidationResult *)isValidWithText:(NSString *)text andRules:(NSArray *)rules;
@end
