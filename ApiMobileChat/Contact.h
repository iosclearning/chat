//
//  User.h
//  ApiMobileChat
//
//  Created by api on 1/2/17.
//  Copyright © 2017 api. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Contact : NSObject

// Static
+(NSMutableArray *) getContacts;
+(void)setContacts:(NSMutableArray *)value;
+(void)initializeContacts;

@property (nonatomic) int userId;
@property (strong, nonatomic) NSString *image;
@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSString *userName;
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *accesstoken;




@end
