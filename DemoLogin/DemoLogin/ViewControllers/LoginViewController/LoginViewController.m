//
//  LoginViewController.m
//  DemoLogin
//
//  Created by East Agile on 12/12/17.
//  Copyright © 2017 East Agile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"
#import "LoginViewModel.h"
#import <ReactiveObjC/ReactiveObjC.h>

@interface LoginViewController () <UITextFieldDelegate>
@property (strong, nonatomic) LoginViewModel *viewModel;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpView];
    [self setupGestures];
    [self setupViewModel];
    [self setupBinding];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Set up View

- (void)setTextFieldPropertiesWithBackgroundColor:(UIColor *)backgroundColor
                                     cornerRadius:(CGFloat)cornerRadius
                                      borderWidth:(CGFloat)borderWidth
                                    textAlignment:(NSTextAlignment)textAlignment
                                        textColor:(UIColor *)textColor
                                isSecureTextEntry:(BOOL)isSecureTextEntry
                                  placeholderText:(NSString *)placeholderText
                             placeholderTextColor:(UIColor *)placeholderTextColor
                                      ofTextField:(UITextField *)textField{
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
                                      ofButton:(UIButton *)button{
    [button setBackgroundColor:backgroundColor];
    [button.layer setCornerRadius:cornerRadius];
    [button.layer setBorderWidth:borderWidth];
    [button.layer setBorderColor:[borderColor CGColor]];
    [button setTitleColor:textColor forState:UIControlStateNormal];
}

- (void)setUpView {
    [self setTextFieldPropertiesWithBackgroundColor:[UIColor clearColor]
                                       cornerRadius:0
                                        borderWidth:0
                                      textAlignment:NSTextAlignmentLeft
                                          textColor:[UIColor whiteColor]
                                  isSecureTextEntry:NO
                                    placeholderText:@"username"
                               placeholderTextColor:[UIColor grayColor]
                                        ofTextField:self.usernameTextField];
    
    [self setTextFieldPropertiesWithBackgroundColor:[UIColor clearColor]
                                       cornerRadius:0
                                        borderWidth:0
                                      textAlignment:NSTextAlignmentLeft
                                          textColor:[UIColor whiteColor]
                                  isSecureTextEntry:YES
                                    placeholderText:@"password"
                               placeholderTextColor:[UIColor grayColor]
                                        ofTextField:self.passwordTextField];
    
    [self setButtonPropertiesWithBackgroundColor:[UIColor clearColor]
                                    cornerRadius:20
                                     borderWidth:1
                                     borderColor:[UIColor whiteColor]
                                       textColor:[UIColor whiteColor]
                                        ofButton:self.loginButton];
    
    [self.loginButton addTarget:self
                          action:@selector(tappedButtonLogin:)
                forControlEvents:UIControlEventTouchUpInside];
    self.usernameTextField.delegate = self;
    self.passwordTextField.delegate = self;
    [self.loadingView setHidden: YES];
}

# pragma mark - Set up Gestures

- (void)setupGestures {
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                               action:@selector(tappedScreen:)];
    
    [self.view addGestureRecognizer:tapGesture];
}

#pragma mark - Set up view model

- (void)setupViewModel {
    self.viewModel = [[LoginViewModel alloc] init];
}

#pragma mark - Set up Binding

- (void)setupBinding {
    [[RACObserve(self.viewModel, isLoginning) skip:1] subscribeNext:^(id  _Nullable isLoginning) {
        if ([isLoginning boolValue] == YES) {
            [self showLoading];
        } else {
            [self hideLoading];
        }
    }];
    
    [[RACObserve(self.viewModel, isLoginSucessfully) skip:1] subscribeNext:^(id  _Nullable isLoginSucessfully) {
        if ([isLoginSucessfully boolValue] == YES) {
            [self redirectToHomeViewController];
        }
    }];

    [[RACObserve(self.viewModel, messageError) skip:1] subscribeNext:^(id  _Nullable message) {
        if (message != nil && ![message isEqualToString:@""])
        {
            [self alertMessage:message];
        }
    }];
    
}

#pragma mark - Handle Events

- (void)tappedButtonLogin:(UIButton *)button {
    [self.viewModel userTappedBtnLoginWithUserName:self.usernameTextField.text
                                          password:self.passwordTextField.text];
}

- (void)tappedScreen:(UIGestureRecognizer *)gesture {
    [self.view endEditing:true];
}

#pragma mark - Textfield Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}
     
#pragma mark - Other methods

- (void)showLoading {
    [self.loadingView setHidden:NO];
    [self.loadingView startAnimating];
    [self.view endEditing:YES];
    [self.view setUserInteractionEnabled:NO];
}

- (void)hideLoading {
    [self.loadingView setHidden:YES];
    [self.loadingView stopAnimating];
    [self.view setUserInteractionEnabled:YES];
}

- (void)redirectToHomeViewController {
    [self performSegueWithIdentifier:@"LoginToHomeSegue" sender:nil];
}

- (void)alertMessage:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Oops" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
