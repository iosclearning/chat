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
#import "Common.h"
static NSString *pCellIdent = @"ChatsCell";

@interface ChatsTableViewControll

@end

@implementation ChatsTableViewController
@synthesize recentChats = _recentChats;
@synthesize chatsData = _chatsData;

- (void) getAllChats :(NSTimer *)timer{
    
    NSDictionary *headers = @{ @"content-type": @"application/json"};

    NSString *url = Common.ApiUrl;
                        
    NSString *getURL = [NSString stringWithFormat:@"%@chats/getChats?userId=%d", url, [DBManager getInstance].currentUser.userId ];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:getURL] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    [request setHTTPMethod:@"GET"];
    [request setAllHTTPHeaderFields:headers];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    if (error) {
                                                        NSLog(@"Error getting response for ChatsView: %@", error);
                                                    } else {
                                                        self.chatsData = [NSJSONSerialization JSONObjectWithData:data
                                                                                                         options:0
                                                                                                           error:NULL];
                                                        
                                                        NSLog(@"Chats: %@", self.chatsData);
                                                        
                                                        NSLog(@"ChatsView data received.");
                                                        
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            [self.tableView reloadData];

                                                        });
                                                                                                             
                                                    }
                                                }];
    [dataTask resume];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //_recentChats = [[DBManager getInstance] getChats];
}

-(void) viewDidAppear:(BOOL)animated {
    self.timer = [NSTimer scheduledTimerWithTimeInterval: 5.0 target: self
                                                selector: @selector(getAllChats:) userInfo: nil repeats: YES];
    
    [self.timer fire];
}

-(void) viewDidDisappear:(BOOL)animated{
    [self.timer invalidate];
    self.timer = nil;
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
    
    return [self.chatsData count];
    
    
}


- (ChatsTableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ChatsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:pCellIdent];
    
    
    
    if (cell == nil)
    {
        cell = [[ChatsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:pCellIdent];
    }
    
    
    NSDictionary *chatData = [self.chatsData objectAtIndex:indexPath.row];
    
    NSLog(@"Chat data: %@", chatData);
    
    NSString *name = [chatData valueForKey:@"name"];
    NSLog(@"Name %@", name);
    if(name && name != [NSNull null]) {
        [cell.chatName setText:name];
    } else {
        [cell.chatName setText:[NSString stringWithFormat:@"Chat %ld", indexPath.row + 1]];
    }
    NSString *lastMessage = [chatData valueForKey:@"lastMessage"];
    if(lastMessage && lastMessage != [NSNull null]) {
        [cell.chatMsg setText:lastMessage];
    }
    NSString *sentTime = [chatData valueForKey:@"sentTime"];
    if(sentTime && sentTime != [NSNull null]) {
        sentTime = [sentTime substringToIndex:10];
    }

    [cell.chatDate setText:sentTime];
    
//    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"darthvader" ofType:@"jpg"];
//    
//    if (imagePath !=nil) {
//        
//        UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
//        
//        
//        [cell.chatImage setImage:image];
//    }
//    else {
//        NSLog(@"Image Path Not Found");
//    }
    
    
    //    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    ChatDetailViewController *controller = [self.storyBoard instantiateViewControllerWithIdentifier:@"ChatDetailViewBoard"];
    NSString *idStr = [[self.chatsData objectAtIndex:indexPath.row] valueForKey:@"id"];
    controller.chatId = [idStr intValue];

    Chat *chat = [_chatsData objectAtIndex:indexPath.row];
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
