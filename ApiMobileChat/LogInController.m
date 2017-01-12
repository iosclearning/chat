//
//  LogInController.m
//  ApiMobileChat
//
//  Created by Anel Memic on 1/4/17.
//  Copyright © 2017 api. All rights reserved.
//

#import "LogInController.h"
#import "MainViewController.h"

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
    //[self Rest]; - uncomment after setting rest service locally. it is located on git
    
    bool email = [self CheckEmail];
    bool password = [self CheckPassword];
    
    if(email == true && password == true)
    {
        [self LogIn];
    }
}

-(bool) CheckEmail
{
    bool emailEmtpty = [self CheckEmailEmpty];
    if(emailEmtpty == true)
    {
        bool emailRegex = [self CheckEmailRegex:self.EmailTextField.text];
        if(emailRegex == true)
        {
            if (![self.EmailTextField.text isEqual:@"anelmemija@gmail.com"])
            {
                self.EmailError.text = @"Incorrect email.";
                return false;
            } else
            {
                self.EmailError.text = @"";
                return true;
            }
        } else
        {
            self.EmailError.text = @"Incorrect email format.";
            return false;
        }
    }
    else
    {
        return false;
    }
}

-(bool) CheckEmailEmpty
{
    if(self.EmailTextField.text.length < 1)
    {
        self.EmailError.text = @"Provide correct email.";
        return false;
    }
    else
    {
        self.EmailError.text = @"";
        return true;
    }
}

-(bool) CheckEmailRegex:(NSString *) email
{
    NSString *emailRegex = @"[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailCheck = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailCheck evaluateWithObject:email];
}

-(bool) CheckPassword
{
    bool passwordEmpty = [self CheckPasswordEmpty];
    if(passwordEmpty == true)
    {
        if(![self.PasswordTextField.text isEqual: @"password"])
        {
            self.PasswordError.text = @"Incorrect password.";
            return false;
        }
        else
        {
            self.PasswordError.text = @"";
            return true;
        }
    } else
    {
        return false;
    }
}

-(bool) CheckPasswordEmpty
{
    if(self.PasswordTextField.text.length < 1) {
        self.PasswordError.text = @"Provide correct password.";
        return false;
    } else {
        self.PasswordError.text = @"";
        return true;
    }
}

-(void) LogIn
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MainViewController *controller = (MainViewController *)[storyboard instantiateViewControllerWithIdentifier:@"MainViewBoard"];
    [self.navigationController pushViewController:controller animated:YES];
}

-(void) Rest
{
    NSString *url = @"http://localhost:5000/api/values";
    NSURLSession *session = [NSURLSession sharedSession];
    
    [[session dataTaskWithURL:[NSURL URLWithString:url] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
    {
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
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
