//
//  PreferentialPurchasePhoneInformationViewController.m
//  CMCCMarketing
//
//  Created by talkweb on 14-9-17.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import "PreferentialPurchasePhoneInformationViewController.h"

@interface PreferentialPurchasePhoneInformationViewController ()<UITextFieldDelegate>

@end

@implementation PreferentialPurchasePhoneInformationViewController

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
    
//    UIImageView *userImageView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"元"]];
//    self.txtPhoneFee.rightViewMode=UITextFieldViewModeAlways;
//    self.txtPhoneFee.rightView=userImageView;
    
    self.txtPhoneModel.delegate=self;
    self.txtPhoneIME.delegate=self;
    self.txtPhoneFee.delegate=self;
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
@end
