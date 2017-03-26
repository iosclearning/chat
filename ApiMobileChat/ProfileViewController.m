//
//  ProfileViewController.m
//  ApiMobileChat
//
//  Created by api on 2/13/17.
//  Copyright © 2017 api. All rights reserved.
//

#import "ProfileViewController.h"
#import "DBManager.h"
#import <Foundation/Foundation.h>
#import "Common.h"

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
    /*NSDictionary *headers = @{ @"content-type": @"application/json"};
    
    NSString *url = Common.ApiUrl;
    
    NSString *getURL = [NSString stringWithFormat:@"%@user/getUser?userId=%d", url, [DBManager getInstance].currentUser.userId];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:getURL] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    [request setHTTPMethod:@"GET"];
    [request setAllHTTPHeaderFields:headers];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    if (error) {
                                                        NSLog(@"Error getting user data: %@", error);
                                                    } else {
                                                        self.chatsData = [NSJSONSerialization JSONObjectWithData:data
                                                                                                         options:0
                                                                                                           error:NULL];
                                                        
                                                        //                                                        NSLog(@"Chats: %@", self.chatsData);
                                                        
                                                        NSLog(@"ChatsView data received.");
                                                        
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            [self.tableView reloadData];
                                                            
                                                        });
                                                        
                                                    }
                                                }];
    [dataTask resume];*/

    // Do any additional setup after loading the view.
    NSDictionary *headers = @{ @"content-type": @"application/json"};
  
    NSString *url = Common.ApiUrl;
    
    NSString *getURL = [NSString stringWithFormat:@"%@user/getUser?userId=%d", url, [DBManager getInstance].currentUser.userId];
    NSLog(@"UUURL%@", getURL);
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:getURL] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    [request setHTTPMethod:@"GET"];
    [request setAllHTTPHeaderFields:headers];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    if (error) {
                                                        NSLog(@"GREEESKA%@", error);
                                                    } else {
                                                        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                                        
                                                        NSDictionary *userData = [NSJSONSerialization JSONObjectWithData:data
                                                                                                                 options:0
                                                                                                                   error:NULL];
                                                        
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                        _firstName.text = userData[@"firstName"];
                                                        _lastName.text = userData[@"lastName"];
                                                        _username.text = userData[@"username"];
                                                        
                                                        if([userData[@"sex"]  isEqual: @"1"])
                                                        {
                                                            [_gender setSelectedSegmentIndex:1];
                                                        }
                                                        else
                                                        {
                                                            [_gender setSelectedSegmentIndex:0];
                                                        }
                                                        });
                                                    }
                                                }];
    [dataTask resume];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)ChangeProfilePicture_Clicked:(id)sender
{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        [self presentViewController:picker animated:YES completion:NULL];
    });
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.imageView.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

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
    int id = [DBManager getInstance].currentUser.userId;
    NSDictionary *headers = @{ @"content-type": @"application/json" };
    NSDictionary *parameters = @{ @"firstName": _firstName.text,
                                  @"lastName": _lastName.text,
                                  @"sex": @1,
                                  @"username": _username.text,
                                  @"password": _password.text,
                                  @"Id": [NSNumber numberWithInt:id] };
    
    NSData *postData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", Common.ApiUrl, @"user/updateuser"]]
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
