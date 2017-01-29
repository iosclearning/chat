//
//  LogInController.h
//  ApiMobileChat
//
//  Created by Anel Memic on 1/4/17.
//  Copyright © 2017 api. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LogInController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *EmailLabel;
@property (strong, nonatomic) IBOutlet UITextField *EmailTextField;
@property (strong, nonatomic) IBOutlet UILabel *EmailError;
@property (strong, nonatomic) IBOutlet UILabel *PasswordLabel;
@property (strong, nonatomic) IBOutlet UITextField *PasswordTextField;
@property (strong, nonatomic) IBOutlet UILabel *PasswordError;
@property (strong, nonatomic) IBOutlet UIButton *LoginButton;
@property (strong, nonatomic) IBOutlet UILabel *SignUpLabelOne;
@property (strong, nonatomic) IBOutlet UILabel *SignUpLabelTwo;
@property (strong, nonatomic) IBOutlet UIButton *SignUpButton;
@property (strong, nonatomic) NSString *response;

@end
