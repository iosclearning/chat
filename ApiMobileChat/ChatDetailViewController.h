//
//  ChatDetailViewController.h
//  ApiMobileChat
//
//  Created by Zajim Kujovic on 1/28/17.
//  Copyright © 2017 api. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatDetailViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

- (IBAction)onClick:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *txtTypeMessage;
@property (weak, nonatomic) IBOutlet UIButton *btnSend;
- (IBAction)onTextChanged:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *chatTableView;
@property (strong, nonatomic) IBOutlet UINavigationBar *navBar;
@property (strong, nonatomic) NSMutableArray *messages;
@property (strong, nonatomic) UILabel *emptyDataText;
@property (assign, nonatomic) NSInteger chatId;
@property (strong, nonatomic) NSTimer *timer;
@end
