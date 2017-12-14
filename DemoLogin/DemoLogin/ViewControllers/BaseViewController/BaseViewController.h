//
//  BaseViewController.h
//  DemoLogin
//
//  Created by East Agile on 12/13/17.
//  Copyright © 2017 East Agile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController
- (void)setTextFieldPropertiesWithBackgroundColor:(UIColor *)backgroundColor
                                     cornerRadius:(CGFloat)cornerRadius
                                      borderWidth:(CGFloat)borderWidth
                                    textAlignment:(NSTextAlignment)textAlignment
                                        textColor:(UIColor *)textColor
                                isSecureTextEntry:(BOOL)isSecureTextEntry
                                  placeholderText:(NSString *)placeholderText
                             placeholderTextColor:(UIColor *)placeholderTextColor
                               autocorrectionType:(UITextAutocorrectionType)autocorrectionType
                                      ofTextField:(UITextField *)textField;

- (void)setButtonPropertiesWithBackgroundColor:(UIColor *)backgroundColor
                                  cornerRadius:(CGFloat)cornerRadius
                                   borderWidth:(CGFloat)borderWidth
                                   borderColor:(UIColor *)borderColor
                                     textColor:(UIColor *)textColor
                                      ofButton:(UIButton *)button;
@end
