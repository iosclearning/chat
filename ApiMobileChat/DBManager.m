//
//  DBManager.m
//  ApiMobileChat
//
//  Created by Zajim Kujovic on 2/7/17.
//  Copyright © 2017 api. All rights reserved.
//

#import "DBManager.h"
#import "sqlite3.h"

static DBManager *sharedInstance = nil;
static sqlite3 *database = nil;
static sqlite3_stmt *stmt = nil;

@interface DBManager()

-(NSString *)dataFilePath;
-(void)createDb;

@end

@implementation DBManager

- (NSString *)dataFilePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    return [documentDirectory stringByAppendingPathComponent:@"data.sqlite"];
}

+(DBManager*)getInstance {
    if(!sharedInstance) {
        sharedInstance = [[super allocWithZone:NULL] init];
        [sharedInstance createDb];
    }
    return sharedInstance;
}

-(void)createDb {
    
    if(sqlite3_open([[self dataFilePath] UTF8String], &database) != SQLITE_OK) {
        sqlite3_close(database);
        NSAssert(0, @"Failed to open database");
    }
    
    NSString *createUsersTableSQL = @"CREATE TABLE IF NOT EXISTS users (id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, username TEXT, password TEXT, access_token TEXT); ";
    
    char *errorMsg;
    if(sqlite3_exec(database, [createUsersTableSQL UTF8String], NULL, NULL, &errorMsg) != SQLITE_OK) {
        sqlite3_close(database);
        NSAssert(0, @"Error creating table: %s", errorMsg);
    }
    
    NSString *creatChatTableSQL = @"CREATE TABLE IF NOT EXISTS chat (id INTEGER PRIMARY KEY, name TEXT, is_group INTEGER, created_date TEXT); ";
    
    if(sqlite3_exec(database, [creatChatTableSQL UTF8String], NULL, NULL, &errorMsg) != SQLITE_OK) {
        sqlite3_close(database);
        NSAssert(0, @"Error creating table: %s", errorMsg);
    }
    
    NSString *creatMessagesTableSQL = @"CREATE TABLE IF NOT EXISTS messages (id INTEGER PRIMARY KEY AUTOINCREMENT, user_id_from INTEGER, sent_time TEXT, message TEXT, chat_id INTEGER); ";
    
    if(sqlite3_exec(database, [creatMessagesTableSQL UTF8String], NULL, NULL, &errorMsg) != SQLITE_OK) {
        sqlite3_close(database);
        NSAssert(0, @"Error creating table: %s", errorMsg);
    }
    
    NSString *creatGroupUsersTableSQL = @"CREATE TABLE IF NOT EXISTS group_users (id INTEGER PRIMARY KEY, user_id_participant INTEGER, chat_id INTEGER); ";
    
    if(sqlite3_exec(database, [creatGroupUsersTableSQL UTF8String], NULL, NULL, &errorMsg) != SQLITE_OK) {
        sqlite3_close(database);
        NSAssert(0, @"Error creating table: %s", errorMsg);
    }
    
    /*NSString *creatMessageStateTableSQL = @"CREATE TABLE IF NOT EXISTS message_state (id INTEGER PRIMARY KEY, received_time TEXT, status INTEGER, seen INTEGER, seen_time TEXT, user_id INTEGER, message_id INTEGER); ";
     
     if(sqlite3_exec(database, [creatMessageStateTableSQL UTF8String], NULL, NULL, &errorMsg) != SQLITE_OK) {
     sqlite3_close(database);
     NSAssert(0, @"Error creating table: %s", errorMsg);
     }*/
    
    sqlite3_close(database);
}

-(void)insertDummyData {
    if(sqlite3_open([[self dataFilePath] UTF8String], &database) != SQLITE_OK) {
        sqlite3_close(database);
        NSAssert(0, @"Failed to open database");
    }
    for (int i = 1; i <= 2; i++) {
        char *updateUser = "INSERT OR REPLACE INTO users (id, first_name, last_name, username, password, access_token) VALUES (?, ?, ?, ?, ?, ?);";
        char *errorMsg = NULL;
        if(sqlite3_prepare_v2(database, updateUser, -1, &stmt, nil) == SQLITE_OK) {
            sqlite3_bind_int(stmt, 1, i);
            sqlite3_bind_text(stmt, 2, (i == 1) ? "Zajim" : "Anela", -1, NULL);
            sqlite3_bind_text(stmt, 3, "Kujovic", -1, NULL);
            sqlite3_bind_text(stmt, 4, (i == 1) ? "zajim" : "anela", -1, NULL);
            sqlite3_bind_text(stmt, 5, (i == 1) ? "zajim123" : "anela123", -1, NULL);
            sqlite3_bind_text(stmt, 6, "1234567890", -1, NULL);
        }
        if(sqlite3_step(stmt) != SQLITE_DONE) {
            NSAssert(0, @"Error updating table: %s", errorMsg);
        }
        sqlite3_finalize(stmt);
    }
    
    char *updateChat = "INSERT OR REPLACE INTO chat (id, name, is_group, created_date) VALUES (?, ?, ?, ?);";
    char *errorMsg = NULL;
    if(sqlite3_prepare_v2(database, updateChat, -1, &stmt, nil) == SQLITE_OK) {
        sqlite3_bind_int(stmt, 1, 1);
        sqlite3_bind_text(stmt, 2, "Chat", -1, NULL);
        sqlite3_bind_int(stmt, 3, 0);
        sqlite3_bind_text(stmt, 4, [[NSString stringWithFormat:@"%@", [NSDate date]] UTF8String], -1, NULL);
    }
    if(sqlite3_step(stmt) != SQLITE_DONE) {
        NSAssert(0, @"Error updating table: %s", errorMsg);
    }
    sqlite3_finalize(stmt);
    
    char *updateGroupUsers1 = "INSERT OR REPLACE INTO group_users (id, user_id_participant, chat_id) VALUES (?, ?, ?);";
    char *errorMsg1 = NULL;
    if(sqlite3_prepare_v2(database, updateGroupUsers1, -1, &stmt, nil) == SQLITE_OK) {
        sqlite3_bind_int(stmt, 1, 1);
        sqlite3_bind_int(stmt, 2, 1);
        sqlite3_bind_int(stmt, 3, 1);
    }
    if(sqlite3_step(stmt) != SQLITE_DONE) {
        NSAssert(0, @"Error updating table: %s", errorMsg1);
    }
    sqlite3_finalize(stmt);
    
    char *updateGroupUsers2 = "INSERT OR REPLACE INTO group_users (id, user_id_participant, chat_id) VALUES (?, ?, ?);";
    char *errorMsg2 = NULL;
    if(sqlite3_prepare_v2(database, updateGroupUsers2, -1, &stmt, nil) == SQLITE_OK) {
        sqlite3_bind_int(stmt, 1, 2);
        sqlite3_bind_int(stmt, 2, 2);
        sqlite3_bind_int(stmt, 3, 1);
    }
    if(sqlite3_step(stmt) != SQLITE_DONE) {
        NSAssert(0, @"Error updating table: %s", errorMsg2);
    }
    sqlite3_finalize(stmt);
    
    for (int i = 1; i <= 3; i++) {
        char *updateMessage = "INSERT OR REPLACE INTO messages (user_id_from, sent_time, message, chat_id) VALUES (?, ?, ?, ?);";
        char *errorMsg = NULL;
        if(sqlite3_prepare_v2(database, updateMessage, -1, &stmt, nil) == SQLITE_OK) {
            sqlite3_bind_int(stmt, 1, (i == 1) ? 1 : 2);
            sqlite3_bind_text(stmt, 2, [[NSString stringWithFormat:@"%@", [NSDate date]] UTF8String], -1, NULL);
            sqlite3_bind_text(stmt, 3, (i == 1) ? "message 1" : "other message", -1, NULL);
            sqlite3_bind_int(stmt, 4, 1);
        }
        if(sqlite3_step(stmt) != SQLITE_DONE) {
            NSAssert(0, @"Error updating table: %s", errorMsg);
        }
        sqlite3_finalize(stmt);
    }
    
    sqlite3_close(database);
}

-(NSMutableArray *)getMessages {
    NSMutableArray *messages = [[NSMutableArray alloc] init];
    if(sqlite3_open([[self dataFilePath] UTF8String], &database) != SQLITE_OK) {
        sqlite3_close(database);
        NSAssert(0, @"Failed to open database");
    }
    NSString *queryMessages = @"SELECT messages.message, messages.sent_time, messages.user_id_from, users.username FROM messages INNER JOIN users ON users.id = messages.user_id_from WHERE messages.chat_id = 1;";
    if(sqlite3_prepare_v2(database, [queryMessages UTF8String], -1, &stmt, nil) == SQLITE_OK) {
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            Message *m = [[Message alloc] init];
            m.message = [NSString stringWithUTF8String:(char*)sqlite3_column_text(stmt, 0)];
            m.sentTime = [NSString stringWithUTF8String:(char*)sqlite3_column_text(stmt, 1)];
            m.userIdFrom = sqlite3_column_int(stmt, 2);
            m.username = [NSString stringWithUTF8String:(char*)sqlite3_column_text(stmt, 3)];
            [messages addObject:m];
        }
        sqlite3_finalize(stmt);
    }
    sqlite3_close(database);
    
    return messages;
}

-(void)insertMessage:(Message *)message {
    if(sqlite3_open([[self dataFilePath] UTF8String], &database) != SQLITE_OK) {
        sqlite3_close(database);
        NSAssert(0, @"Failed to open database");
    }
    char *updateMessage = "INSERT OR REPLACE INTO messages (user_id_from, sent_time, message, chat_id) VALUES (?, ?, ?, ?);";
    char *errorMsg = NULL;
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
}

@end
