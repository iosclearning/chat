//
//  SignUpController.h
//  Chat
//
//  Created by Anel Memic on 1/4/17.
//  Copyright © 2017 api. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *EnterEmailLabel;
@property (strong, nonatomic) IBOutlet UITextField *EnterEmailTextField;
@property (strong, nonatomic) IBOutlet UILabel *EnterEmailError;
@property (strong, nonatomic) IBOutlet UILabel *EnterPasswordLabel;
@property (strong, nonatomic) IBOutlet UITextField *EnterPasswordTextField;
@property (strong, nonatomic) IBOutlet UILabel *EnterPasswordError;
@property (strong, nonatomic) IBOutlet UILabel *ConfirmPasswordLabel;
@property (strong, nonatomic) IBOutlet UITextField *ConfirmPasswordTextField;
@property (strong, nonatomic) IBOutlet UILabel *ConfirmPasswordErrorLabel;
@property (strong, nonatomic) IBOutlet UIButton *SignUpButton;
@property (strong, nonatomic) IBOutlet UILabel *InformationLabel;
@property (strong, nonatomic) NSString *response;

@end
