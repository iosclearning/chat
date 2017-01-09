//
//  SignUpController.m
//  ApiMobileChat
//
//  Created by Anel Memic on 1/4/17.
//  Copyright © 2017 api. All rights reserved.
//

#import "SignUpController.h"
#import "ChatViewController.h"

@interface SignUpController ()

@end

@implementation SignUpController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.ConfirmPasswordErrorLabel.text = @"";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)SignUpButtonTouchUpInside:(id)sender {
    bool confirmPassword = [self ConfirmPassword];
    if(confirmPassword == true) {
        [self SignUp];
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
    ChatViewController *controller = (ChatViewController *)[storyboard instantiateViewControllerWithIdentifier:@"ChatViewController"];
    [self.navigationController presentViewController:controller animated:YES completion:NULL];
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
