//
//  ChatDetailViewController.m
//  ApiMobileChat
//
//  Created by Zajim Kujovic on 1/28/17.
//  Copyright © 2017 api. All rights reserved.
//

#import "ChatDetailViewController.h"
#import "SendMessageCell.h"
#import "ReceivedMessageCell.h"
#import "Message.h"
#import "sqlite3.h"
#import "DBManager.h"
#import "Chat.h"

#define keySendMessageCellIdentifier @"SendMessageCellIdentifier"
#define keyReceivedMessageCellIdentifier @"ReceivedMessageCellIdentifier"

@interface ChatDetailViewController ()

@end

@implementation ChatDetailViewController

@synthesize txtTypeMessage;
@synthesize btnSend;
@synthesize chatTableView;
@synthesize messages;
@synthesize emptyDataText;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.btnSend.enabled = NO;
    self.navBar.topItem.title = @"Chat";
    self.navBar.topItem.rightBarButtonItem = self.editButtonItem;
    self.chatTableView.rowHeight = UITableViewAutomaticDimension;
    self.chatTableView.estimatedRowHeight = 75.0;
    UIBarButtonItem *btnBack = [[UIBarButtonItem alloc] initWithTitle:@"Contacts" style:UIBarButtonItemStylePlain target:self.navigationController action:@selector(popViewControllerAnimated:)];
    
    [btnBack setImage:[UIImage imageNamed:@"back.png"]];
    
    self.navBar.topItem.leftBarButtonItem = btnBack;
    if(Chat.selectedChat) {
        self.messages = [[DBManager getInstance] getMessages:Chat.selectedChat.id];
    } else {
        self.messages = [[NSMutableArray alloc] init];
    }
    self.emptyDataText = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.chatTableView.bounds.size.width, self.chatTableView.bounds.size.height)];
    
    self.emptyDataText.hidden = YES;
    
    [self.chatTableView registerNib:[UINib nibWithNibName:@"SendMessageCell" bundle:nil] forCellReuseIdentifier:keySendMessageCellIdentifier];
    [self.chatTableView registerNib:[UINib nibWithNibName:@"ReceivedMessageCell" bundle:nil] forCellReuseIdentifier:keyReceivedMessageCellIdentifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onClick:(id)sender {
    Message *message = [[Message alloc] init];
    message.message = self.txtTypeMessage.text;
    message.sentTime = [NSString stringWithFormat:@"%@", [NSDate date]];
    message.userIdFrom = [[DBManager getInstance] currentUser].userId;
    message.chatId = Chat.selectedChat.id;
    
    [self.messages addObject:message];
    
    [[DBManager getInstance] insertMessage:message];
    
    NSIndexPath *newPath = [NSIndexPath indexPathForRow:self.messages.count - 1 inSection:0];
    
    [self.chatTableView insertRowsAtIndexPaths:@[newPath] withRowAnimation:(UITableViewRowAnimationAutomatic)];
    
    self.txtTypeMessage.text = @"";
    self.btnSend.enabled = NO;
}

- (IBAction)onTextChanged:(id)sender {
    if(self.txtTypeMessage.hasText) {
        self.btnSend.enabled = YES;
    } else {
        self.btnSend.enabled = NO;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BOOL isSendMessageRow = ((Message *) self.messages[indexPath.row]).userIdFrom == 1;
    
    NSString *cellIdentifier;
    
    if(isSendMessageRow) {
        cellIdentifier = keySendMessageCellIdentifier;
    } else {
        cellIdentifier = keyReceivedMessageCellIdentifier;
    }
    
    UITableViewCell *cell = [chatTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(isSendMessageRow) {
        SendMessageCell *mCell = (SendMessageCell *)cell;
        mCell.txtMessageContent.text = ((Message *) self.messages[indexPath.row]).message;
        mCell.lblDate.text = ((Message *) self.messages[indexPath.row]).sentTime;
    } else {
        ReceivedMessageCell *rCell = (ReceivedMessageCell *)cell;
        rCell.txtMessageContent.text = ((Message *) self.messages[indexPath.row]).message;
        rCell.lblDate.text = ((Message *) self.messages[indexPath.row]).sentTime;
        rCell.lblOtherUser.text = ((Message *) self.messages[indexPath.row]).username;
    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.messages count];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    
    [self.chatTableView setEditing:editing animated:animated];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *indexPathArray = [NSArray arrayWithObject:indexPath];
    
    if(editingStyle == UITableViewCellEditingStyleDelete) {
        [self.messages removeObjectAtIndex:indexPath.row];
        
        [self.chatTableView deleteRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if(self.messages == nil || [self.messages count] <= 0 ) {
        emptyDataText.text = @"No conversation yet...";
        emptyDataText.textAlignment = NSTextAlignmentCenter;
        [emptyDataText sizeToFit];
        self.chatTableView.backgroundView = emptyDataText;
        self.chatTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.emptyDataText.hidden = NO;
    } else {
        self.emptyDataText.hidden = YES;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    BOOL isSendMessageRow = ((Message *) self.messages[indexPath.row]).userIdFrom == 1;
    if(isSendMessageRow) {
        return 65.0;
    } else {
        return 100.0;
    }
}

@end
