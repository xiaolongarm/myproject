//
//  DataAcquisitionNetworkProblemsTableViewCell.m
//  CMCCMarketing
//
//  Created by talkweb on 14-9-28.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import "DataAcquisitionNetworkProblemsTableViewCell.h"

@implementation DataAcquisitionNetworkProblemsTableViewCell

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
//    self.txtName.delegate=self;
//    self.txtPhone.delegate=self;
//    self.txtDepart.delegate=self;
//    self.txtAvenues.delegate=self;
////    self.txtProblemsAriseTime.delegate=self;
////    self.txtCommitmentResolutionTime.delegate=self;
//    self.txtTotalNumberOfGroup.delegate=self;
//    self.txtMobileOfNumber.delegate=self;
//    self.txtFaultPlace.delegate=self;
//    self.txtTDAndWLANSituation.delegate=self;
//    
//    self.txtDescripition.delegate=self;
//    
//    self.txtDescripition.layer.borderColor=[UIColor lightGrayColor].CGColor;
//    self.txtDescripition.layer.borderWidth=0.3f;
//    self.txtDescripition.layer.masksToBounds=YES;
//    self.txtDescripition.layer.cornerRadius=3;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//-(BOOL)textFieldShouldReturn:(UITextField *)textField{
//    [textField resignFirstResponder];
//    return YES;
//}

//- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
//    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
//        //在这里做你响应return键的代码
//        //        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
//        [textView resignFirstResponder];
//        return NO;
//    }
//    
//    return YES;
//}
//- (IBAction)selectGroup:(id)sender {
//    [self.delegate selectGroup:sender];
//}
//- (IBAction)selectServerity:(id)sender {
//    [self.delegate selectServerity:sender];
//}
//- (IBAction)selectStartDate:(id)sender {
//    [self.delegate selectDate:sender];
//}
//- (IBAction)selectEndDate:(id)sender {
//    [self.delegate selectDate:sender];
//}

@end
