//
//  SignUpController.m
//  ApiMobileChat
//
//  Created by Anel Memic on 1/4/17.
//  Copyright © 2017 api. All rights reserved.
//

#import "SignUpController.h"
#import "MainViewController.h"

@interface SignUpController ()

@end

@implementation SignUpController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.EnterEmailError.text= @"";
    self.ConfirmPasswordErrorLabel.text = @"";
    self.EnterPasswordError.text = @"";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)SignUpButtonTouchUpInside:(id)sender {
    bool isEmailEmpty = [self CheckEmailEmpty];
    if(isEmailEmpty == true) {
        bool isEmailRegexValid = [self ValidateEmailRegex];
        if(isEmailRegexValid == true) {
            bool isPasswordEmpty = [self CheckPasswordEmpty];
            if(isPasswordEmpty == true) {
                bool isConfirmPasswordEmpty = [self CheckConfirmPasswordEmpty];
                if(isConfirmPasswordEmpty == true) {
                    bool arePasswordsTheSame = [self ConfirmPassword];
                    if(arePasswordsTheSame == true) {
                        [self SignUp];
                    }
                }
            }
        }
    }
}

-(bool) CheckEmailEmpty {
    if(self.EnterEmailTextField.text.length < 1) {
        self.EnterEmailError.text = @"Provide correct email.";
        return false;
    } else {
        self.EnterEmailError.text = @"";
        return true;
    }
}

-(bool) ValidateEmailRegex {
    bool isEmailRegex = [self CheckEmailRegex:self.EnterEmailTextField.text];
    if(isEmailRegex == false) {
        self.EnterEmailError.text = @"Incorrect email format.";
        return false;
    } else {
        self.EnterEmailError.text = @"";
        return true;
    }
}

-(bool) CheckEmailRegex:(NSString *) email {
    NSString *emailRegex = @"[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailCheck = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailCheck evaluateWithObject:email];
}

-(bool) CheckPasswordEmpty {
    if(self.EnterPasswordTextField.text.length < 1) {
        self.EnterPasswordError.text = @"Provide correct password.";
        return false;
    } else {
        self.EnterPasswordError.text = @"";
        return true;
    }
}

-(bool) CheckConfirmPasswordEmpty {
    if(self.ConfirmPasswordTextField.text.length < 1) {
        self.ConfirmPasswordErrorLabel.text = @"Provide correct password.";
        return false;
    } else {
        self.ConfirmPasswordErrorLabel.text = @"";
        return true;
    }
}

- (bool) ConfirmPassword {
    if(![self.EnterPasswordTextField.text isEqual:self.ConfirmPasswordTextField.text]) {
        self.ConfirmPasswordErrorLabel.text = @"Passwords do not match.";
        return false;
    } else {
        self.ConfirmPasswordErrorLabel.text = @"";
        return true;
    }
}

-(void) SignUp {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MainViewController *controller = (MainViewController *)[storyboard instantiateViewControllerWithIdentifier:@"MainViewBoard"];
    [self.navigationController pushViewController:controller animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
