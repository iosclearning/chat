//
//  LogInController.m
//  ApiMobileChat
//
//  Created by Anel Memic on 1/4/17.
//  Copyright © 2017 api. All rights reserved.
//

#import "LogInController.h"
#import "ChatViewController.h"

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
    // Login needs to be fixed
    // If wronf credentials (or none),app is failing
    // If login successful Rest method is failing
    
    //[self Rest];
    //bool email = [self CheckEmail];
    //bool password = [self CheckPassword];
    //if(email == true && password == true)
    //{
        [self LogIn];
    //}
}

-(bool) CheckEmail {
    if ([self.response objectForKey:self.EmailTextField.text]) {
        self.EmailError.text = @"";
        return true;
    } else {
        self.EmailError.text = @"Incorrect email";
        return false;
    }
}

-(bool) CheckPassword {
    if(![self.PasswordTextField.text isEqual: @"password"]) {
        self.PasswordError.text = @"Incorrect password";
        return false;
    } else {
        self.PasswordError.text = @"";
        return true;
    }
}

-(void) LogIn {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ChatViewController *controller = (ChatViewController *)[storyboard instantiateViewControllerWithIdentifier:@"ChatViewController"];
    [self.navigationController presentViewController:controller animated:YES completion:NULL];
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