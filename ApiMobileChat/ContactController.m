//
//  ContactTableViewController.m
//  ApiMobileChat
//
//  Created by api on 1/3/17.
//  Copyright © 2017 api. All rights reserved.
//

#import "ContactController.h"
#import "Contact.h"

static NSString *pCellIdentifier = @"Cell";

@interface ContactController ()

@end

@implementation ContactController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Fill local contacts
    self.contacts = [Contact getContacts];}

// This sets top margin of tableView so it does not get over batery indicator
-(void)viewDidLayoutSubviews
{
    if(self.tableView.contentInset.top != self.topLayoutGuide.length)
    {
        self.tableView.contentInset = UIEdgeInsetsMake(self.topLayoutGuide.length, 0.0, 0.0, 0.0);
    }
}

// Format and load image
-(UIImage *)getImageByName:(NSString *)imageName
{
    
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]];
    
    CGSize newSize = CGSizeMake(50,40);
    CGRect newRect = CGRectIntegral(CGRectMake(0,0,newSize.width,newSize.height));
    CGImageRef imageRef = image.CGImage;
    
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Set the qualit level to use when rescaling
    CGContextSetInterpolationQuality(context, kCGInterpolationHigh);
    CGAffineTransform flipVertical = CGAffineTransformMake(1, 0, 0, -1, 0, newSize.height);
    
    CGContextConcatCTM(context, flipVertical);
    
    // Draw into the context
    CGContextDrawImage(context,newRect,imageRef);
    
    // Get the resized image from the context and UIImage
    CGImageRef newImageRef = CGBitmapContextCreateImage(context);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    
    CGImageRelease(newImageRef);
    UIGraphicsEndImageContext();
    
    return newImage;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.contacts count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:pCellIdentifier];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:pCellIdentifier];
    }
    
    // Get Contact on specified row
    Contact *contact = [self.contacts objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@", contact.userName];
    cell.imageView.image = [self getImageByName : contact.image];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
   
    return cell;
}

// Remove contact
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete)
    {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Warning" message:@"Are you sure that you want to remove selected contact" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *yesButton = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
        {
            
            [_contacts removeObjectAtIndex:indexPath.row];
            [self.tableView reloadData];
        }];
        
        UIAlertAction *noButton = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){}];
        
        [alert addAction:yesButton];
        [alert addAction:noButton];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    // This is just a test.. Custom Alert Should be created
    
   Contact *contact = [_contacts objectAtIndex:indexPath.row];
    
   UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Edit Contact" message:nil preferredStyle:UIAlertControllerStyleAlert];
   //[alert.view setBackgroundColor:[UIColor colorWithRed:0.29 green:0.46 blue:0.29 alpha:1.0]];
   
   //Actions
   UIAlertAction *saveButton = [UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                                {
                                    contact.firstName = alert.textFields[0].text;
                                    contact.lastName = alert.textFields[1].text;
                                    contact.userName = alert.textFields[2].text;
                                    [self.tableView reloadData];
                                }];
    UIAlertAction *cancelButton = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){}];

    // Visible controls and colors on alert
    [alert addAction:saveButton];
    [saveButton setValue:[UIColor colorWithRed:0.0 green:0.0 blue:1.0 alpha:1.0] forKey:@"titleTextColor"];
    [alert addAction:cancelButton];
    [cancelButton setValue:[UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1.0] forKey:@"titleTextColor"];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField)
     {
         textField.text = contact.firstName;
         textField.placeholder = @"First Name";
         
     }];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField)
     {
         textField.text = contact.lastName;
         textField.placeholder = @"Last Name";

     }];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField)
     {
         textField.text = contact.userName;
         textField.placeholder = @"Username";
         
     }];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField)
     {
         textField.enabled = NO;
         textField.text = contact.email;
     }];
    

    [self presentViewController:alert animated:YES completion:nil];}


@end
