//
//  SendMessageCell.m
//  ApiMobileChat
//
//  Created by Zajim Kujovic on 1/28/17.
//  Copyright © 2017 api. All rights reserved.
//

#import "SendMessageCell.h"

@implementation SendMessageCell

@synthesize imgBackView;
@synthesize txtMessageContent;
@synthesize lblDate;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
