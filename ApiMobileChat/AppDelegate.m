//
//  AppDelegate.m
//  ApiMobileChat
//
//  Created by api on 1/2/17.
//  Copyright © 2017 api. All rights reserved.
//

#import "AppDelegate.h"
#import "sqlite3.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (NSString *)dataFilePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    return [documentDirectory stringByAppendingPathComponent:@"data.sqlite"];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    sqlite3 *database;
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
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    sqlite3 *database;
    if(sqlite3_open([[self dataFilePath] UTF8String], &database) != SQLITE_OK) {
        sqlite3_close(database);
        NSAssert(0, @"Failed to open database");
    }
    for (int i = 1; i <= 2; i++) {
        char *updateUser = "INSERT OR REPLACE INTO users (id, first_name, last_name, username, password, access_token) VALUES (?, ?, ?, ?, ?, ?);";
        char *errorMsg = NULL;
        sqlite3_stmt *stmt;
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
    sqlite3_stmt *stmt;
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
    sqlite3_stmt *stmt1;
    if(sqlite3_prepare_v2(database, updateGroupUsers1, -1, &stmt1, nil) == SQLITE_OK) {
        sqlite3_bind_int(stmt1, 1, 1);
        sqlite3_bind_int(stmt1, 2, 1);
        sqlite3_bind_int(stmt1, 3, 1);
    }
    if(sqlite3_step(stmt1) != SQLITE_DONE) {
        NSAssert(0, @"Error updating table: %s", errorMsg1);
    }
    sqlite3_finalize(stmt1);
    
    char *updateGroupUsers2 = "INSERT OR REPLACE INTO group_users (id, user_id_participant, chat_id) VALUES (?, ?, ?);";
    char *errorMsg2 = NULL;
    sqlite3_stmt *stmt2;
    if(sqlite3_prepare_v2(database, updateGroupUsers2, -1, &stmt2, nil) == SQLITE_OK) {
        sqlite3_bind_int(stmt2, 1, 2);
        sqlite3_bind_int(stmt2, 2, 2);
        sqlite3_bind_int(stmt2, 3, 1);
    }
    if(sqlite3_step(stmt2) != SQLITE_DONE) {
        NSAssert(0, @"Error updating table: %s", errorMsg2);
    }
    sqlite3_finalize(stmt2);
    
    for (int i = 1; i <= 3; i++) {
        char *updateMessage = "INSERT OR REPLACE INTO messages (user_id_from, sent_time, message, chat_id) VALUES (?, ?, ?, ?);";
        char *errorMsg = NULL;
        sqlite3_stmt *stmt;
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


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
