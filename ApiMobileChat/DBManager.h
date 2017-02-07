//
//  DBManager.h
//  ApiMobileChat
//
//  Created by Zajim Kujovic on 2/7/17.
//  Copyright © 2017 api. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Message.h"

@interface DBManager : NSObject

+(DBManager*)getInstance;
-(void)insertDummyData;
-(NSMutableArray*)getMessages;
-(void)insertMessage:(Message*)message;

@end
