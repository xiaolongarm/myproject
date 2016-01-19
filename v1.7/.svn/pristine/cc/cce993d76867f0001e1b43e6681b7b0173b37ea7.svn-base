//
//  DataAcquisitionReportedTableViewCell.m
//  CMCCMarketing
//
//  Created by talkweb on 14-9-28.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import "DataAcquisitionReportedTableViewCell.h"

@implementation DataAcquisitionReportedTableViewCell

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
//    self.itemGroupName.delegate=self;
    self.itemGroupStaffNumber.delegate=self;
    self.itemGroupNum.delegate=self;
    self.itemMarketShareWithCMCC.delegate=self;
    self.itemMarketShareWithTeleCom.delegate=self;
    self.itemInformationTech.delegate=self;
    self.itemWarnLVL.delegate=self;
    self.itemType.delegate=self;
    self.itemContactNameWithFirst.delegate=self;
    self.itemContactJobWithfirst.delegate=self;
    self.itemContactPhoneWithFirst.delegate=self;
    self.itemContactNameWithSecond.delegate=self;
    self.itemContactJobWithSecond.delegate=self;
    self.itemContactPhoneWithSecond.delegate=self;
    
    self.itemCompetition.delegate=self;
    
    self.itemGroupDemand.delegate=self;
    self.itemWeDealWith.delegate=self;
    self.itemFollowUpContent.delegate=self;
    
    self.itemCompetition.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.itemCompetition.layer.borderWidth=0.3;
    self.itemCompetition.layer.masksToBounds=YES;
    self.itemCompetition.layer.cornerRadius=3;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        //在这里做你响应return键的代码
        //        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}
- (IBAction)selectGroupButtonOnclick:(id)sender {
    [self.delegate selectGroup:sender];
}

@end
