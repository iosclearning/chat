//
//  ContactTableViewController.m
//  ApiMobileChat
//
//  Created by api on 1/3/17.
//  Copyright © 2017 api. All rights reserved.
//

#import "ContactTableViewController.h"
#import "Contact.h"


static NSString *pCellIdentifier = @"Cell";
@interface ContactTableViewController ()

@end

@implementation ContactTableViewController

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
    self.tableView.contentInset = UIEdgeInsetsMake(100, 0, 0, 0);
    
}

-(UIImage *)getImageByName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]];
    
    CGRect rect = CGRectMake(0, 0, 40, 30);
    UIGraphicsBeginImageContext(rect.size);
    [image drawInRect:rect];
    UIImage *picture = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImage *img = [UIImage imageWithData:UIImagePNGRepresentation(picture)];
    
    return img;
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
    
    Contact *contact = [self.contacts objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", contact.firstName, contact.lastName];
    cell.imageView.image = [self getImageByName : contact.image];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
