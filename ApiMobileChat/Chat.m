//
//  Chat.m
//  ApiMobileChat
//
//  Created by Zajim Kujovic on 2/9/17.
//  Copyright © 2017 api. All rights reserved.
//

#import "Chat.h"

@implementation Chat

static Chat *selectedChat = nil;

@synthesize id;
@synthesize name;

+(Chat*) selectedChat { return selectedChat; }
+(void) setSelectedChat:(Chat*)value { selectedChat = value; }

@end
