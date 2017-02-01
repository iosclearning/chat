//
//  Message.h
//  ApiMobileChat
//
//  Created by Zajim Kujovic on 1/28/17.
//  Copyright © 2017 api. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Message : NSObject

@property NSString *message;
@property NSString *sentTime;
@property int userIdFrom;
@property NSString *username;

@end
