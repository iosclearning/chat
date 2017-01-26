//
//  User.m
//  ApiMobileChat
//
//  Created by api on 1/2/17.
//  Copyright © 2017 api. All rights reserved.
//


#import "Contact.h"

static NSMutableArray *_contacts;

@implementation Contact : NSObject

// Static
+(void)initializeContacts
{
    
    // For testing purpose, create test data
    Contact *contact1 = [[Contact alloc]init];
    contact1.userId = 1;
    contact1.firstName = @"Darth";
    contact1.lastName = @"Vader";
    contact1.userName = @"DV";
    contact1.image = @"darthvader.jpg";
    contact1.email = @"darth@darth.com";
    
    Contact *contact2 = [[Contact alloc]init];
    contact2.userId = 2;
    contact2.firstName = @"Mace";
    contact2.lastName = @"Windu";
    contact2.userName = @"MV";
    contact2.image = @"windu.jpg";
    contact2.email = @"windu@darth.com";
    
    Contact *contact3 = [[Contact alloc]init];
    contact3.userId = 3;
    contact3.firstName = @"Obi-Wan";
    contact3.lastName = @"Kenobi";
    contact3.userName = @"OWK";
    contact3.image = @"obiwan.jpg";
    contact3.email = @"obi@darth.com";
    
    [self setContacts: [[NSMutableArray alloc] initWithObjects:contact1,contact2,contact3,nil]];
}


+(NSMutableArray *) getContacts{return _contacts;}
+(void) setContacts:(NSMutableArray *) newContacts{_contacts = newContacts;}


@end
