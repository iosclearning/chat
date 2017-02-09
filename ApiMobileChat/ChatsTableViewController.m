//
//  ChatsTableViewController.m
//  ApiMobileChat
//
//  Created by Selma Opanovic on 1/16/17.
//  Copyright © 2017 api. All rights reserved.
//

#import "ChatsTableViewController.h"
#import "ChatsTableViewCell.h"
#import "DBManager.h"
static NSString *pCellIdent = @"ChatsCell";

@interface ChatsTableViewControll

@end

@implementation ChatsTableViewController
@synthesize recentChats = _recentChats;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    _recentChats = [[DBManager getInstance] getChats];
}

// This sets top margin of tableView so it does not get over batery indicator
-(void)viewDidLayoutSubviews
{
    if(self.tableView.contentInset.top != self.topLayoutGuide.length)
    {
        self.tableView.contentInset = UIEdgeInsetsMake(self.topLayoutGuide.length, 0.0, 0.0, 0.0);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [_recentChats count];
    
    
}


- (ChatsTableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ChatsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:pCellIdent];
    
    
    
    if (cell == nil)
    {
        cell = [[ChatsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:pCellIdent];
    }
    
    Chat *chat = [_recentChats objectAtIndex:indexPath.row];
    
    [cell.chatName setText:chat.name];
    [cell.chatMsg setText:@"Test"];
    
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"darthvader" ofType:@"jpg"];
    
    if (imagePath !=nil) {
        
        UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
        
//        NSLog(@"Image Path %@",imagePath);
        
        [cell.chatImage setImage:image];
    }
    else {
        NSLog(@"Image Path Not Found");
    }
    
    
    //    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *controller = [self.storyBoard instantiateViewControllerWithIdentifier:@"ChatDetailViewBoard"];
    Chat *chat = [_recentChats objectAtIndex:indexPath.row];
    Chat.selectedChat = chat;
    [self.navigationController pushViewController:controller animated:YES];
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


// Override to support editing the table view.
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        // Delete the row from the data source
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    }
//    else if (editingStyle == UITableViewCellEditingStyleInsert) {
//        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//    }
//}


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
