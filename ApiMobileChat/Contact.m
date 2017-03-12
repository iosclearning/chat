//
//  User.m
//  ApiMobileChat
//
//  Created by api on 1/2/17.
//  Copyright © 2017 api. All rights reserved.
//


#import "Contact.h"
#import "DBManager.h"
#import "Common.h"

static NSMutableArray *_contacts;
static Contact *selectedContact = nil;

@implementation Contact : NSObject

+(NSMutableArray *) getContacts{return _contacts;}
+(void) setContacts:(NSMutableArray *) newContacts{_contacts = newContacts;}

+(Contact*) selectedContact { return selectedContact; }
+(void) setSelectedContact:(Contact*)value { selectedContact = value; }


@end
