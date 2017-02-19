//
//  ProfileViewController.h
//  ApiMobileChat
//
//  Created by api on 2/13/17.
//  Copyright © 2017 api. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *FirstName;
@property (weak, nonatomic) IBOutlet UITextField *LastName;
@property (weak, nonatomic) IBOutlet UITextField *Username;
@property (weak, nonatomic) IBOutlet UITextField *Password;
@property (weak, nonatomic) IBOutlet UITextField *RepeatedPassword;
@property (weak, nonatomic) IBOutlet UISegmentedControl *Gender;
- (IBAction)ChangeProfilePicture_Clicked:(id)sender;
- (IBAction)SaveChanges_Clicked:(id)sender;


@end
