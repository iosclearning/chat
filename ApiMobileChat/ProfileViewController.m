//
//  ProfileViewController.m
//  ApiMobileChat
//
//  Created by api on 2/13/17.
//  Copyright © 2017 api. All rights reserved.
//

#import "ProfileViewController.h"
#import <Foundation/Foundation.h>

@interface ProfileViewController ()

@end

@implementation ProfileViewController
@synthesize FirstName = _firstName;
@synthesize LastName = _lastName;
@synthesize Password = _password;
@synthesize RepeatedPassword = _repeatedPassword;
@synthesize Gender = _gender;
@synthesize Username = _username;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSDictionary *headers = @{ @"content-type": @"application/json"};
    NSDictionary *parameters = @{ @"accessToken": @"3dfc6702" };
    
    NSData *postData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://ioschatapi.azurewebsites.net/api/user/getuserdata"] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
    [request setAllHTTPHeaderFields:headers];
    [request setHTTPBody:postData];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    if (error) {
                                                        NSLog(@"GREEESKA%@", error);
                                                    } else {
                                                        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                                        //NSLog(@"AAAAAAA%@", data);
                                                        NSDictionary *userData = [NSJSONSerialization JSONObjectWithData:data
                                                                                                                 options:0
                                                                                                                   error:NULL];
                                                        //NSString* temp = userData[@"firstName"];
                                                        
                                                        _firstName.text = userData[@"firstName"];
                                                        _lastName.text = userData[@"lastName"];
                                                        _username.text = userData[@"username"];
                                                        _password.text = @"password";
                                                        if([userData[@"sex"]  isEqual: @"1"])
                                                        {
                                                            [_gender setSelectedSegmentIndex:1];
                                                        }
                                                        else
                                                        {
                                                            [_gender setSelectedSegmentIndex:0];
                                                        }
                                                        
                                                    }
                                                }];
    [dataTask resume];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)ChangeProfilePicture_Clicked:(id)sender
{
    //UIImagePickerController* picker = [[UIImagePickerController alloc] init];
}
/*-(void)imagePickerController:(UIImagePickerController *) picker didFinishPickingMediaWithInfo:(nonnull NSDictionary<NSString *,id> *)info
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    UIImage* picture = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    UIImageView *pictureView = (UIImageView *)[
    
}*/

- (IBAction)SaveChanges_Clicked:(id)sender
{
    if(![_password.text isEqualToString: _repeatedPassword.text])
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Passwords did not match" message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *errorAlert = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){}];
        
        [alert addAction:errorAlert];
        [errorAlert setValue:[UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1.0] forKey:@"titleTextColor"];
        [self presentViewController:alert animated:YES completion:nil];
        
        return;
    }
    
    NSDictionary *headers = @{ @"content-type": @"application/json" };
    NSDictionary *parameters = @{ @"firstName": _firstName.text,
                                  @"lastName": _lastName.text,
                                  @"sex": @1,
                                  @"username": _username.text,
                                  @"password": _password.text,
                                  @"accessToken": @"3dfc6702" };
    
    NSData *postData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://ioschatapi.azurewebsites.net/api/user/updateuserdata"]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
    [request setAllHTTPHeaderFields:headers];
    [request setHTTPBody:postData];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData* data, NSURLResponse* response, NSError *error) {
                                                    if (error)
                                                    {
                                                        NSLog(@"%@", error);
                                                    }
                                                    else
                                                    {
                                                        NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse *) response;
                                                        NSLog(@"%@", httpResponse);
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                        UIAlertController *alertSaved = [UIAlertController alertControllerWithTitle:@"Changes saved" message:nil preferredStyle:UIAlertControllerStyleAlert];
                                                        
                                                        UIAlertAction *saved = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){}];
                                                        
                                                        [alertSaved addAction:saved];
                                                        [saved setValue:[UIColor colorWithRed:0.0 green:1.0 blue:0.0 alpha:1.0] forKey:@"titleTextColor"];
                                                        [self presentViewController:alertSaved animated:YES completion:nil];
                                                            _password.text = @"";
                                                            _repeatedPassword.text = @"";
                                                        });
                                                    }
                                                }];
    [dataTask resume];
}
@end
