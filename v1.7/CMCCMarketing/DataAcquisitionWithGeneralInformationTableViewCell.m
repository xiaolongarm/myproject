//
//  DataAcquisitionWithGeneralInformationTableViewCell.m
//  CMCCMarketing
//
//  Created by talkweb on 15-2-27.
//  Copyright (c) 2015年 talkweb. All rights reserved.
//

#import "DataAcquisitionWithGeneralInformationTableViewCell.h"

@implementation DataAcquisitionWithGeneralInformationTableViewCell

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
    
    self.itemActivitiesPromotionalContent.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.itemActivitiesPromotionalContent.layer.borderWidth=0.5f;
    self.itemActivitiesPromotionalContent.layer.cornerRadius=3;
    self.itemActivitiesPromotionalContent.layer.masksToBounds=YES;
    self.itemActivitiesPromotionalContent.text=@"";
    
    self.itemTransactBusinessCase.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.itemTransactBusinessCase.layer.borderWidth=0.5f;
    self.itemTransactBusinessCase.layer.cornerRadius=3;
    self.itemTransactBusinessCase.layer.masksToBounds=YES;
    self.itemTransactBusinessCase.text=@"";
    
    self.itemTariffPolicy.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.itemTariffPolicy.layer.borderWidth=0.5f;
    self.itemTariffPolicy.layer.cornerRadius=3;
    self.itemTariffPolicy.layer.masksToBounds=YES;
    self.itemTariffPolicy.text=@"";
    
    self.itemTerminalPolicy.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.itemTerminalPolicy.layer.borderWidth=0.5f;
    self.itemTerminalPolicy.layer.cornerRadius=3;
    self.itemTerminalPolicy.layer.masksToBounds=YES;
    self.itemTerminalPolicy.text=@"";
    
    self.itemBroadbandPolicy.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.itemBroadbandPolicy.layer.borderWidth=0.5f;
    self.itemBroadbandPolicy.layer.cornerRadius=3;
    self.itemBroadbandPolicy.layer.masksToBounds=YES;
    self.itemBroadbandPolicy.text=@"";
    
    self.itemOtherPolicy.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.itemOtherPolicy.layer.borderWidth=0.5f;
    self.itemOtherPolicy.layer.cornerRadius=3;
    self.itemOtherPolicy.layer.masksToBounds=YES;
    self.itemOtherPolicy.text=@"";
    
    self.itemOtherDetails.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.itemOtherDetails.layer.borderWidth=0.5f;
    self.itemOtherDetails.layer.cornerRadius=3;
    self.itemOtherDetails.layer.masksToBounds=YES;
    self.itemOtherDetails.text=@"";
    
    self.itemOurStrategy.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.itemOurStrategy.layer.borderWidth=0.5f;
    self.itemOurStrategy.layer.cornerRadius=3;
    self.itemOurStrategy.layer.masksToBounds=YES;
    self.itemOurStrategy.text=@"";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
