//
//  SendMessageCell.h
//  ApiMobileChat
//
//  Created by Zajim Kujovic on 1/28/17.
//  Copyright © 2017 api. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SendMessageCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIView *imgBackView;

@property (strong, nonatomic) IBOutlet UITextView *txtMessageContent;

@property (strong, nonatomic) IBOutlet UILabel *lblDate;

@end
