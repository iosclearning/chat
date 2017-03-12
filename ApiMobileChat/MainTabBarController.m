//
//  MainTabBarController.m
//  ApiMobileChat
//
//  Created by Selma Opanovic on 1/16/17.
//  Copyright © 2017 api. All rights reserved.
//

#import "MainTabBarController.h"
#import "Common.h"
#import "DBManager.h"

@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSDictionary *headers = @{ @"content-type": @"application/json" };
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%d", Common.ApiUrl, @"contacts/getallcontacts?userId=", [DBManager getInstance].currentUser.userId]]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"GET"];
    [request setAllHTTPHeaderFields:headers];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data,
                                                                    NSURLResponse *response,
                                                                    NSError *error) {
                                                    if (error) {
                                                        // Development environment.
                                                        NSLog(@"Error%@", error);
                                                    } else {
                                                        NSArray *userData = [NSJSONSerialization JSONObjectWithData:data                                   options:0                                                                                                 error:NULL];
                                                        NSLog(@"userData\n%@", userData);
                                                        int currentUserId = [[DBManager getInstance] currentUser].userId;
                                                        if(userData.count > 0) {
                                                            for (int i = 0; i < userData.count; i++) {
                                                                Contact *user = [[Contact alloc] init];
                                                                user.userId = [userData[i][@"id"] intValue];
                                                                user.firstName = userData[i][@"firstName"];
                                                                user.lastName = userData[i][@"lastName"];
                                                                user.email = userData[i][@"email"];
                                                                user.userName = userData[i][@"username"];
                                                                user.current = NO;
                                                                [[DBManager getInstance] insertUser:user];
                                                                [[DBManager getInstance] insertUserContact:currentUserId userIdFriend:user.userId];
                                                            }
                                                        } else {
                                                            Contact *user = [[Contact alloc] init];
                                                            user.userId = 1;//[userData[i][@"id"] intValue];
                                                            user.firstName = @"Dzemal";//userData[i][@"firstName"];
                                                            user.lastName = @"Cengic";//userData[i][@"lastName"];
                                                            user.email = @"dzemailcengic@gmail.com";//userData[i][@"email"];
                                                            user.userName = @"dzemalcengic@gmail.com";//userData[i][@"username"];
                                                            user.current = NO;
                                                            [[DBManager getInstance] insertUser:user];
                                                            [[DBManager getInstance] insertUserContact:currentUserId userIdFriend:user.userId];
                                                        }
                                                    }}];
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

@end
