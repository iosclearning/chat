//
//  LogInController.m
//  Chat
//
//  Created by Anel Memic on 1/4/17.
//  Copyright © 2017 api. All rights reserved.
//

#import "MainTabBarController.h"
#import "LogInController.h"
#import "Contact.h"
#import "DBManager.h"

@interface LogInController ()

@end

@implementation LogInController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.EmailError.text = @"";
    self.PasswordError.text = @"";
    self.InformationLabel.text = @"";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)EmailTextFieldChange:(id)sender {
    // Development environment.
    NSLog(@"Email text field value %@", self.EmailTextField.text);
}

- (IBAction)PasswordTextFieldChange:(id)sender {
    // Development environment.
    NSLog(@"Password text field value %@", self.PasswordTextField.text);
}

- (IBAction)LoginButtonTouchUpInside:(id)sender {
    bool isEmailValid = [self ValidateEmail];
    bool isPasswordValid = [self ValidatePassword];
    if(isEmailValid == true && isPasswordValid == true) {
        [self SendLoginRequest];
        [NSThread sleepForTimeInterval: 5];
        if(self.response.length > 8) {
            self.InformationLabel.text  = self.response;
        } else {
            [self LogIn];
        }
    }
}

-(bool) ValidateEmail {
    bool isEmailEmpty = [self CheckEmailEmpty];
    if(!isEmailEmpty) {
        bool isEmailRegexValid = [self ValidateEmailRegex];
        if(isEmailRegexValid) {
            return true;
        } else {
            return false;
        }
    } else {
        return false;
    }
}

-(bool) CheckEmailEmpty {
    if(self.EmailTextField.text.length < 1) {
        self.EmailError.text = @"Provide correct email.";
        return true;
    } else {
        self.EmailError.text = @"";
        return false;
    }
}

-(bool) ValidateEmailRegex {
    bool isEmailRegex = [self CheckEmailRegex:self.EmailTextField.text];
    if(isEmailRegex == false) {
        self.EmailError.text = @"Incorrect email format.";
        return false;
    } else {
        self.EmailError.text = @"";
        return true;
    }
}

-(bool) CheckEmailRegex:(NSString *) email {
    NSString *emailRegex = @"[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailCheck = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailCheck evaluateWithObject:email];
}

-(bool) ValidatePassword {
    bool isPasswordEmpty = [self CheckPasswordEmpty];
    if(!isPasswordEmpty) {
        return true;
    } else {
        return false;
    }
}

-(bool) CheckPasswordEmpty {
    if(self.PasswordTextField.text.length < 1) {
        self.PasswordError.text = @"Provide correct password.";
        return true;
    } else {
        self.PasswordError.text = @"";
        return false;
    }
}

-(void) SendLoginRequest {
    NSDictionary *headers = @{ @"content-type": @"application/json" };
    NSDictionary *parameters = @{ @"email": self.EmailTextField.text,
                                  @"password": self.PasswordTextField.text };
    NSData *postData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://ioschatapi.azurewebsites.net/api/user/login"]
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
                                                        currentUser.userId = 1;//[userData[@"id"] intValue];
                                                        currentUser.firstName = @"Anel";//userData[@"firstName"];
                                                        currentUser.lastName = @"Memic";//userData[@"lastName"];
                                                        currentUser.email = @"anelmemija@gmail.com";//userData[@"email"];
                                                        currentUser.userName = @"anelmemija@gmail.com";//userData[@"username"];
                                                        currentUser.current = YES;
                                                        currentUser.accesstoken = @"3dfc6702";//userData[@"accessToken"];
                                                        [[DBManager getInstance] insertUser:currentUser];
                                                    }}];
    [dataTask resume];
}

-(void) LogIn {
    [Contact initializeContacts];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MainTabBarController *controller = (MainTabBarController *)[storyboard instantiateViewControllerWithIdentifier:@"MainTabBar"];
    [self.navigationController pushViewController:controller animated:YES];
}

@end
