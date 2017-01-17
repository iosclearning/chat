//
//  LogInController.m
//  ApiMobileChat
//
//  Created by Anel Memic on 1/4/17.
//  Copyright © 2017 api. All rights reserved.
//

#import "LogInController.h"
#import "MainTabBarController.h"

@interface LogInController ()

@end

@implementation LogInController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.EmailError.text = @"";
    self.PasswordError.text = @"";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)EmailTextFieldChange:(id)sender {
    //NSLog(@"Email %@", self.EmailTextField.text);
}

- (IBAction)PasswordTextFieldChange:(id)sender {
    //NSLog(@"Password  %@", self.PasswordTextField.text);
}

- (IBAction)LoginButtonTouchUpInside:(id)sender {
    // TODO
    // Implement Rest.
    //[self Rest];
    bool isEmailValid = [self ValidateEmail];
    bool isPasswordValid = [self ValidatePassword];
    if(isEmailValid == true && isPasswordValid == true) {
        [self LogIn];
    }
}

-(bool) ValidateEmail {
    bool isEmailEmpty = [self CheckEmailEmpty];
    if(!isEmailEmpty) {
        bool isEmailRegexValid = [self ValidateEmailRegex];
        if(isEmailRegexValid) {
            // TODO
            // Implement Rest.
            //bool isEmailCorrect = [self CheckEmail];
            //if(isEmailCorrect) {
                //return true;
            //} else {
                //return false;
            //}
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

-(bool) CheckEmail {
    //if (![self.response objectForKey:self.EmailTextField.text]) {
    if (![self.EmailTextField.text isEqual:@"username@api.com"]) {
        self.EmailError.text = @"Incorrect email.";
        return false;
    } else {
        self.EmailError.text = @"";
        return true;
    }
}

-(bool) ValidatePassword {
    bool isPasswordEmpty = [self CheckPasswordEmpty];
    if(!isPasswordEmpty) {
        // TODO
        // Implement Rest.
        //bool isPasswordCorrect = [self CheckPassword];
        //if(isPasswordCorrect) {
            //return true;
        //} else {
            //return false;
        //}
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

-(bool) CheckPassword {
    if(![self.PasswordTextField.text isEqual: @"password"]) {
        self.PasswordError.text = @"Incorrect password.";
        return false;
    } else {
        self.PasswordError.text = @"";
        return true;
    }
}

-(void) LogIn {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MainTabBarController *controller = (MainTabBarController *)[storyboard instantiateViewControllerWithIdentifier:@"MainTabBar"];
    [self.navigationController pushViewController:controller animated:YES];
}

-(void) Rest {
    NSString *url = @"http://localhost:5000/api/values";
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:[NSURL URLWithString:url] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        //NSLog(@"Response %@", response);
        //NSLog(@"Data %@", data);
        //NSLog(@"Error %@", error);
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        //NSLog(@"Dictionary %@", dictionary);
        self.response = dictionary;
    }] resume];
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
