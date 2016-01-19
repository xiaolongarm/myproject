//
//  MarketingCustomerDetailsTableViewCell.m
//  CMCCMarketing
//
//  Created by talkweb on 14-9-30.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import "MarketingCustomerDetailsTableViewCell.h"

@implementation MarketingCustomerDetailsTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        NSLog(@"init with style");
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
//    NSLog(@"init cell with nib");
//    NSLog(@"rect w:%f h:%f",self.itemLabel1Rect.size.width,self.itemLabel1Rect.size.height);
//    
//    NSLog(@"rect current w:%f h:%f",self.itemLabel1.frame.size.width,self.itemLabel1.frame.size.height);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)layoutSubviews{
//    NSLog(@"layoutsubviews cell");
//    NSLog(@"rect w:%f h:%f",self.itemLabel1Rect.size.width,self.itemLabel1Rect.size.height);
//     NSLog(@"rect current w:%f h:%f",self.itemLabel1.frame.size.width,self.itemLabel1.frame.size.height);
    
//    self.itemLabel1.frame=self.itemLabel1Rect;
//    self.itemLabel2.frame=self.itemLabel2Rect;
//    self.itemLabel3.frame=self.itemLabel3Rect;
//    self.itemLabel4.frame=self.itemLabel4Rect;
}

@end
