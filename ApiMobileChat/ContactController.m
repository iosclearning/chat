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
    
    // For testing purpose, create test data
    Contact *contact1 = [[Contact alloc]init];
    contact1.userId = 1;
    contact1.firstName = @"Darth";
    contact1.lastName = @"Vader";
    contact1.userName = @"DV";
    contact1.image = @"darthvader.jpg";
    
    Contact *contact2 = [[Contact alloc]init];
    contact2.userId = 2;
    contact2.firstName = @"Obi-Wan";
    contact2.lastName = @"Kenobi";
    contact2.userName = @"OWK";
    contact2.image = @"obiwan.jpg";
    
    Contact *contact3 = [[Contact alloc]init];
    contact3.userId = 3;
    contact3.firstName = @"Mace";
    contact3.lastName = @"Windu";
    contact3.userName = @"MV";
    contact3.image = @"windu.jpg";
    
    self.contacts = [[NSMutableArray alloc] initWithObjects:contact1,contact2,contact3,nil];
    
    
}

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
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", contact.firstName, contact.lastName];
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


@end
