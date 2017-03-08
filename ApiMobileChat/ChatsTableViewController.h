//
//  ChatsTableViewController.h
//  ApiMobileChat
//
//  Created by Selma Opanovic on 1/16/17.
//  Copyright © 2017 api. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatDetailViewController.h"

@interface ChatsTableViewController : UITableViewController
@property (strong, nonatomic) NSMutableArray *recentChats;
@property (strong, nonatomic) UIStoryboard *storyBoard;
@property (strong, nonatomic) NSArray *chatsData;
@property (strong, nonatomic) NSTimer *timer;

@end
