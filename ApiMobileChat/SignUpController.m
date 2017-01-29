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
    self.EnterPasswordError.text = @"";
    self.ConfirmPasswordErrorLabel.text = @"";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)SignUpButtonTouchUpInside:(id)sender {
    // TODO
    // Implement Rest.
    //[self Rest];
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
                        [self ServerResponse];
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

-(void) SignUp {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MainViewController *controller = (MainViewController *)[storyboard instantiateViewControllerWithIdentifier:@"MainTabBar"];
    [self.navigationController pushViewController:controller animated:YES];
}

-(void) ServerResponse {
    //if(self.response.length > 10) {
    //self.EmailError.text = self.response;
    //self.PasswordError.text = self.response;
    //} else {
    [self SignUp];
    //}
}


-(void) Rest {
    NSDictionary *headers = @{ @"content-type": @"application/json" };
    NSDictionary *parameters = @{ @"email": self.EnterEmailTextField.text,
                                  @"password": self.EnterPasswordTextField.text };
    NSData *postData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://localhost:5000/api/values"]
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
                                                        NSLog(@"Error%@", error);
                                                    } else {
                                                        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                                        NSLog(@"Response%@", httpResponse);
                                                        NSString* response;
                                                        response = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
                                                        self.response = response;
                                                    }}];
    [dataTask resume];
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
