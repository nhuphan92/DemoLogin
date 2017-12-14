//
//  ViewController.m
//  DemoLogin
//
//  Created by East Agile on 12/12/17.
//  Copyright © 2017 East Agile. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
    [self setAccessibilities];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Set up Views

- (void)setupViews {
    [self setButtonPropertiesWithBackgroundColor:[UIColor clearColor]
                                    cornerRadius:20
                                     borderWidth:1
                                     borderColor:[UIColor whiteColor]
                                       textColor:[UIColor whiteColor]
                                        ofButton:self.logoutButton];
    [self.logoutButton addTarget:self
                          action:@selector(tappedBtnLogout)
                forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)setAccessibilities {
    [self.logoutButton setAccessibilityLabel:@"logout"];
}

#pragma mark - Handle Event
- (void)tappedBtnLogout {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
