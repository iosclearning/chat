//
//  SignUpController.m
//  ApiMobileChat
//
//  Created by Anel Memic on 1/4/17.
//  Copyright © 2017 api. All rights reserved.
//

#import "SignUpController.h"
#import "MainViewController.h"
#import "Contact.h"
#import "DBManager.h"

@interface SignUpController ()

@end

@implementation SignUpController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.EnterEmailError.text= @"";
    self.EnterPasswordError.text = @"";
    self.ConfirmPasswordErrorLabel.text = @"";
    self.InformationLabel.text = @"";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)SignUpButtonTouchUpInside:(id)sender {
    bool isEmailEmpty = [self CheckEmailEmpty];
    if(!isEmailEmpty) {
        bool isEmailRegexValid = [self ValidateEmailRegex];
        if(isEmailRegexValid) {
            bool isPasswordEmpty = [self CheckPasswordEmpty];
            if(!isPasswordEmpty) {
                bool isConfirmPasswordEmpty = [self CheckConfirmPasswordEmpty];
                if(!isConfirmPasswordEmpty) {
                    bool arePasswordsTheSame = [self ConfirmPassword];
                    if(arePasswordsTheSame) {
                        [self SendRegisterRequest];
                        [NSThread sleepForTimeInterval: 5];
                        if(self.response.length > 8) {
                            self.InformationLabel.text  = self.response;
                        } else {
                            [self SignUp];
                        }
                    }
                }
            }
        }
    }
}

-(bool) CheckEmailEmpty {
    if(self.EnterEmailTextField.text.length < 1) {
        self.EnterEmailError.text = @"Provide correct email.";
        return true;
    } else {
        self.EnterEmailError.text = @"";
        return false;
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
        return true;
    } else {
        self.EnterPasswordError.text = @"";
        return false;
    }
}

-(bool) CheckConfirmPasswordEmpty {
    if(self.ConfirmPasswordTextField.text.length < 1) {
        self.ConfirmPasswordErrorLabel.text = @"Provide correct password.";
        return true;
    } else {
        self.ConfirmPasswordErrorLabel.text = @"";
        return false;
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

-(void) SendRegisterRequest {
    NSDictionary *headers = @{ @"content-type": @"application/json" };
    NSDictionary *parameters = @{ @"email": self.EnterEmailTextField.text,
                                  @"password": self.EnterPasswordTextField.text };
    NSData *postData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://ioschatapi.azurewebsites.net/api/user/register"]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
    [request setAllHTTPHeaderFields:headers];
    [request setHTTPBody:postData];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data,
                                                                    NSURLResponse *response,
                                                                    NSError *error) {
                                                    if (error) {
                                                        // Development environment.
                                                        NSLog(@"Error%@", error);
                                                    } else {
                                                        NSDictionary *userData = [NSJSONSerialization JSONObjectWithData:data                                   options:0                                                                                                 error:NULL];
                                                        NSLog(@"userData\n%@", userData);
                                                        Contact *currentUser = [[Contact alloc] init];
                                                        currentUser.userId = [userData[@"id"] intValue];
                                                        currentUser.email = userData[@"email"];
                                                        currentUser.current = YES;
                                                        currentUser.accesstoken = userData[@"accessToken"];
                                                        [[DBManager getInstance] insertUser:currentUser];
                                                    }}];
    [dataTask resume];
}

-(void) SignUp {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MainViewController *controller = (MainViewController *)[storyboard instantiateViewControllerWithIdentifier:@"MainTabBar"];
    [self.navigationController pushViewController:controller animated:YES];
}

@end
