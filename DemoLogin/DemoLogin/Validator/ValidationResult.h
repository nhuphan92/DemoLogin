//
//  ValidationResult.h
//  DemoLogin
//
//  Created by East Agile on 12/12/17.
//  Copyright © 2017 East Agile. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum ValidationResultType: NSUInteger {
    ValidationResultTypeFail,
    ValidationResultTypeOk
} ValidationResultType;

@interface ValidationResult: NSObject

@property (strong, nonatomic) NSString * errorMessage;
@property (assign, nonatomic) ValidationResultType result;

-(void)setValues:(NSString *)message validationResultType:(ValidationResultType)validationResultType;

@end
