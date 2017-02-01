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

- (NSString *)dataFilePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    return [documentDirectory stringByAppendingPathComponent:@"data.sqlite"];
}

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
    
    self.messages = [[NSMutableArray alloc] init];
    
    sqlite3 *database;
    if(sqlite3_open([[self dataFilePath] UTF8String], &database) != SQLITE_OK) {
        sqlite3_close(database);
        NSAssert(0, @"Failed to open database");
    }
    NSString *queryMessages = @"SELECT messages.message, messages.sent_time, messages.user_id_from, users.username FROM messages INNER JOIN users ON users.id = messages.user_id_from WHERE messages.chat_id = 1;";
    sqlite3_stmt *stmt;
    if(sqlite3_prepare_v2(database, [queryMessages UTF8String], -1, &stmt, nil) == SQLITE_OK) {
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            Message *m = [[Message alloc] init];
            m.message = [NSString stringWithUTF8String:(char*)sqlite3_column_text(stmt, 0)];
            m.sentTime = [NSString stringWithUTF8String:(char*)sqlite3_column_text(stmt, 1)];
            m.userIdFrom = sqlite3_column_int(stmt, 2);
            m.username = [NSString stringWithUTF8String:(char*)sqlite3_column_text(stmt, 3)];
            [self.messages addObject:m];
        }
        sqlite3_finalize(stmt);
    }
    sqlite3_close(database);
    
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
    message.userIdFrom = 1;
    
    [self.messages addObject:message];
    
    sqlite3 *database;
    if(sqlite3_open([[self dataFilePath] UTF8String], &database) != SQLITE_OK) {
        sqlite3_close(database);
        NSAssert(0, @"Failed to open database");
    }
    char *updateMessage = "INSERT OR REPLACE INTO messages (user_id_from, sent_time, message, chat_id) VALUES (?, ?, ?, ?);";
    char *errorMsg = NULL;
    sqlite3_stmt *stmt;
    if(sqlite3_prepare_v2(database, updateMessage, -1, &stmt, nil) == SQLITE_OK) {
        sqlite3_bind_int(stmt, 1, message.userIdFrom);
        sqlite3_bind_text(stmt, 2, [[NSString stringWithFormat:@"%@", message.sentTime] UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 3, [[NSString stringWithFormat:@"%@", message.message] UTF8String], -1, NULL);
        sqlite3_bind_int(stmt, 4, 1);
    }
    if(sqlite3_step(stmt) != SQLITE_DONE) {
        NSAssert(0, @"Error updating table: %s", errorMsg);
    }
    sqlite3_finalize(stmt);
    sqlite3_close(database);
    
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
