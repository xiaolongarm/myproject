//
//  IndividualCustomerPackageTerminalTableViewCell.m
//  CMCCMarketing
//
//  Created by talkweb on 14-12-12.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import "IndividualCustomerPackageTerminalTableViewCell.h"

@implementation IndividualCustomerPackageTerminalTableViewCell

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
    self.itemImageView.contentMode = UIViewContentModeScaleAspectFit;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
