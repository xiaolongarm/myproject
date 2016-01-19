//
//  GroupCustomersTableViewCell.m
//  CMCCMarketing
//
//  Created by talkweb on 14-9-9.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import "GroupCustomersTableViewCell.h"

@implementation GroupCustomersTableViewCell

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
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)selectedButtonOnclick:(id)sender {
//    if(!self.itemSelected.tag){
//        self.itemSelected.tag=1;
//        [self.itemSelected setImage:[UIImage imageNamed:@"勾选"] forState:UIControlStateNormal];
//    }
//    else{
//        self.itemSelected.tag=0;
//        [self.itemSelected setImage:[UIImage imageNamed:@"未勾选"] forState:UIControlStateNormal];
//    }
    [self.delegate groupCustomersTableViewCellSelectButtonOnclick:self];
}

@end
