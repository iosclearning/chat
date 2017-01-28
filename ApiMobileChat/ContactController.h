//
//  ContactTableViewController.h
//  ApiMobileChat
//
//  Created by api on 1/3/17.
//  Copyright © 2017 api. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contact.h"

@interface ContactController : UITableViewController

@property (strong,nonatomic) NSMutableArray *contacts;
@property (strong, nonatomic) UIStoryboard *storyBoard;

@end
