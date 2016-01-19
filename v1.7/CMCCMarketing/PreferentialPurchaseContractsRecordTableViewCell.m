//
//  PreferentialPurchaseContractsRecordTableViewCell.m
//  CMCCMarketing
//
//  Created by talkweb on 14-9-18.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import "PreferentialPurchaseContractsRecordTableViewCell.h"

@implementation PreferentialPurchaseContractsRecordTableViewCell

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
    self.itemGroup.numberOfLines=0;
    self.itemCustomer.numberOfLines=0;
    self.itemPhone.numberOfLines=0;
    self.itemContracts.numberOfLines=0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
