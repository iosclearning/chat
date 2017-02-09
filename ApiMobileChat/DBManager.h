//
//  DBManager.h
//  ApiMobileChat
//
//  Created by Zajim Kujovic on 2/7/17.
//  Copyright © 2017 api. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Message.h"
#import "Contact.h"
#import "Chat.h"

@interface DBManager : NSObject

+(DBManager*)getInstance;
-(void)insertDummyData;
-(void)createChat:(NSString*)name:(int)participant;
-(NSMutableArray*)getMessages:(int)chatId;
-(NSMutableArray*)getChats;
-(void)insertUser:(Contact*)user;
-(void)insertMessage:(Message*)message;
-(Contact*)currentUser;
-(NSMutableArray*)getOtherUsers;

@end
