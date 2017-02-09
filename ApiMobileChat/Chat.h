//
//  Chat.h
//  ApiMobileChat
//
//  Created by Zajim Kujovic on 2/9/17.
//  Copyright © 2017 api. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Chat : NSObject

@property (nonatomic) int id;
@property (strong, nonatomic) NSString *name;
+(Chat*) selectedChat;
+(void) setSelectedChat:(Chat*)value;

@end
