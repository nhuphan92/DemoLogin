//
//  BaseViewController.m
//  DemoLogin
//
//  Created by East Agile on 12/13/17.
//  Copyright © 2017 East Agile. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UI helper methods
- (void)setTextFieldPropertiesWithBackgroundColor:(UIColor *)backgroundColor
                                     cornerRadius:(CGFloat)cornerRadius
                                      borderWidth:(CGFloat)borderWidth
                                    textAlignment:(NSTextAlignment)textAlignment
                                        textColor:(UIColor *)textColor
                                isSecureTextEntry:(BOOL)isSecureTextEntry
                                  placeholderText:(NSString *)placeholderText
                             placeholderTextColor:(UIColor *)placeholderTextColor
                                      ofTextField:(UITextField *)textField {
    [textField setBackgroundColor:backgroundColor];
    [textField.layer setCornerRadius:cornerRadius];
    [textField.layer setBorderWidth:borderWidth];
    [textField setTextAlignment:textAlignment];
    [textField setTextColor:textColor];
    [textField setSecureTextEntry:isSecureTextEntry];
    [textField setPlaceholder:placeholderText];
    if ([textField respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholderText attributes:@{NSForegroundColorAttributeName: placeholderTextColor}];
    } else {
        NSLog(@"Cannot set placeholder text's color, because deployment target is earlier than iOS 6.0");
    }
}

- (void)setButtonPropertiesWithBackgroundColor:(UIColor *)backgroundColor
                                  cornerRadius:(CGFloat)cornerRadius
                                   borderWidth:(CGFloat)borderWidth
                                   borderColor:(UIColor *)borderColor
                                     textColor:(UIColor *)textColor
                                      ofButton:(UIButton *)button {
    [button setBackgroundColor:backgroundColor];
    [button.layer setCornerRadius:cornerRadius];
    [button.layer setBorderWidth:borderWidth];
    [button.layer setBorderColor:[borderColor CGColor]];
    [button setTitleColor:textColor forState:UIControlStateNormal];
}

@end
