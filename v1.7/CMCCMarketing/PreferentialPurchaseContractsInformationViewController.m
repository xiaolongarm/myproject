//
//  PreferentialPurchaseContractsInformationViewController.m
//  CMCCMarketing
//
//  Created by talkweb on 14-9-17.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import "PreferentialPurchaseContractsInformationViewController.h"

@interface PreferentialPurchaseContractsInformationViewController ()<UITextFieldDelegate>

@end

@implementation PreferentialPurchaseContractsInformationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
  
//    UIImageView *imageViewTai=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"元"]];
//    self.txtQuantity.rightViewMode=UITextFieldViewModeAlways;
//    self.txtQuantity.rightView=imageViewTai;
//    
//    UIImageView *imageViewYuan1=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"元"]];
//    self.txtStoredFee.rightViewMode=UITextFieldViewModeAlways;
//    self.txtStoredFee.rightView=imageViewYuan1;
//    UIImageView *imageViewYuan2=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"元"]];
//    self.txtGiftOfMonthFee.rightViewMode=UITextFieldViewModeAlways;
//    self.txtGiftOfMonthFee.rightView=imageViewYuan2;
//    UIImageView *imageViewYuan3=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"元"]];
//    self.txtLowestMonthFee.rightViewMode=UITextFieldViewModeAlways;
//    self.txtLowestMonthFee.rightView=imageViewYuan3;
//    UIImageView *imageViewYuan4=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"元"]];
//    self.txtReturnOfMonthFee.rightViewMode=UITextFieldViewModeAlways;
//    self.txtReturnOfMonthFee.rightView=imageViewYuan4;
//    
//    UIImageView *imageViewYue1=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"月"]];
//    self.txtContractTerm.rightViewMode=UITextFieldViewModeAlways;
//    self.txtContractTerm.rightView=imageViewYue1;
//    UIImageView *imageViewYue2=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"月"]];
//    self.txtPostNumberOfMonth.rightViewMode=UITextFieldViewModeAlways;
//    self.txtPostNumberOfMonth.rightView=imageViewYue2;
    
    self.txtQuantity.delegate=self;
    self.txtStoredFee.delegate=self;
    self.txtGiftOfMonthFee.delegate=self;
    self.txtLowestMonthFee.delegate=self;
    self.txtReturnOfMonthFee.delegate=self;
    self.txtContractTerm.delegate=self;
//    self.txtStartDate.delegate=self;
//    self.txtEndDate.delegate=self;
    self.txtPostNumberOfMonth.delegate=self;
    self.txtMemo.delegate=self;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
//    if(textField.tag == 16 || textField.tag == 17){
//        [textField resignFirstResponder];
//        [self.delegate selectDate:textField];
//    }
    if(IS_IPHONE4 && textField.tag > 13){
        [self.delegate beginEdit];
    }
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if(IS_IPHONE4 && textField.tag > 13){
        [self.delegate endEdit];
    }
}

- (IBAction)selectStartDateOnclick:(id)sender {
    [self.delegate selectDate:sender];
}
- (IBAction)selectEndDateOnclick:(id)sender {
    [self.delegate selectDate:sender];
}

@end
