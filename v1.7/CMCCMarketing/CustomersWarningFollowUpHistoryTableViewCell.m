//
//  CustomersWarningFollowUpHistoryTableViewCell.m
//  CMCCMarketing
//
//  Created by talkweb on 14-9-24.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import "CustomersWarningFollowUpHistoryTableViewCell.h"

@implementation CustomersWarningFollowUpHistoryTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    self.itemGroup.adjustsFontSizeToFitWidth=YES;
    self.itemFollowUpContent.numberOfLines=0;
    self.itemFollowUpContent.adjustsFontSizeToFitWidth=YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
