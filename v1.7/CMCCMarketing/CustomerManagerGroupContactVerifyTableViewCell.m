//
//  CustomerManagerGroupContactVerifyTableViewCell.m
//  CMCCMarketing
//
//  Created by talkweb on 15-5-4.
//  Copyright (c) 2015年 talkweb. All rights reserved.
//

#import "CustomerManagerGroupContactVerifyTableViewCell.h"

@implementation CustomerManagerGroupContactVerifyTableViewCell

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
    self.itemTitle.adjustsFontSizeToFitWidth=YES;
    self.itemValue.adjustsFontSizeToFitWidth=YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
