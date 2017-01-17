//
//  ChatsTableViewCell.h
//  ApiMobileChat
//
//  Created by Selma Opanovic on 1/16/17.
//  Copyright © 2017 api. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *chatImage;
@property (weak, nonatomic) IBOutlet UITextField *chatName;
@property (weak, nonatomic) IBOutlet UITextField *chatDate;
@property (weak, nonatomic) IBOutlet UITextField *chatMsg;

@end
