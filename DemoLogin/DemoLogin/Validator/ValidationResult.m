//
//  ValidationResult.m
//  DemoLogin
//
//  Created by East Agile on 12/12/17.
//  Copyright © 2017 East Agile. All rights reserved.
//

#import "ValidationResult.h"

@implementation ValidationResult

- (instancetype)initWithMessage:(NSString *)message
           validationResultType:(ValidationResultType)validationResultType
{
    self = [super init];
    if (self) {
        self.errorMessage = message;
        self.result = validationResultType;
    }
    return self;
}

-(void)setValues:(NSString *)message validationResultType:(ValidationResultType)validationResultType {
    self.errorMessage = message;
    self.result = validationResultType;
}

@end
