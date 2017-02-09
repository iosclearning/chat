//
//  User.m
//  ApiMobileChat
//
//  Created by api on 1/2/17.
//  Copyright © 2017 api. All rights reserved.
//


#import "Contact.h"
#import "DBManager.h"

static NSMutableArray *_contacts;
static Contact *selectedContact = nil;

@implementation Contact : NSObject

// Static
+(void)initializeContacts
{
    /*NSDictionary *headers = @{ @"content-type": @"application/json" };
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://ioschatapi.azurewebsites.net/api/contact/getallcontacts"]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"GET"];
    [request setAllHTTPHeaderFields:headers];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data,
                                                                    NSURLResponse *response,
                                                                    NSError *error) {
                                                    if (error) {
                                                        // Development environment.
                                                        NSLog(@"Error%@", error);
                                                    } else {
                                                        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                                        // Development environment.
                                                        NSLog(@"Response%@", httpResponse);
                                                        NSString* responseData = [[NSString alloc] initWithBytes:data.bytes length:data.length encoding:NSUTF8StringEncoding];
                                                        
                                                        NSArray *jsonObject = [NSJSONSerialization JSONObjectWithData:[responseData dataUsingEncoding:NSUTF8StringEncoding] options:0 error:NULL];
                                                        
                                                        
                                                        
                                                    }}];
    [dataTask resume];*/
    
    
    
    [self setContacts: [DBManager getInstance].getOtherUsers];
}


+(NSMutableArray *) getContacts{return _contacts;}
+(void) setContacts:(NSMutableArray *) newContacts{_contacts = newContacts;}

+(Contact*) selectedContact { return selectedContact; }
+(void) setSelectedContact:(Contact*)value { selectedContact = value; }


@end
