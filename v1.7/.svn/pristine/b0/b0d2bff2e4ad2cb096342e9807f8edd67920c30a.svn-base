//
//  GroupBroadbandCreaterViewController.m
//  CMCCMarketing
//
//  Created by talkweb on 14-9-18.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import "GroupBroadbandCreaterViewController.h"

@interface GroupBroadbandCreaterViewController ()

@end

@implementation GroupBroadbandCreaterViewController

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
    self.txtGroupId.delegate=self;
    self.txtGroupNo.delegate=self;
    self.txtFee.delegate=self;
    self.txtContract.delegate=self;
    self.txtBroadband.delegate=self;
    
    self.btDataVideo.selected=YES;
    self.speciaLinePro=0;
    self.speciaLineProText=@"数字电视";
    
//    UIImageView *imageViewYuan=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"元"]];
//    self.txtFee.rightViewMode=UITextFieldViewModeAlways;
//    self.txtFee.rightView=imageViewYuan;
//    
//    UIImageView *imageViewM=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"M"]];
//    self.txtBroadband.rightViewMode=UITextFieldViewModeAlways;
//    self.txtBroadband.rightView=imageViewM;
//    
//    UIImageView *imageViewYue=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"月"]];
//    self.txtContract.rightViewMode=UITextFieldViewModeAlways;
//    self.txtContract.rightView=imageViewYue;
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

- (IBAction)selectGroupOnclick:(id)sender {
    [self.delegate selectGroup];
}

- (IBAction)selectStartDateOnclick:(id)sender {
    [self.delegate selectDate:sender];
}
- (IBAction)selectEndDateOnclick:(id)sender {
    [self.delegate selectDate:sender];
}

- (IBAction)dataVideoButtonOnclick:(id)sender {
    self.btDataVideo.selected=YES;
    self.btInternet.selected=NO;
    self.btWLan.selected=NO;
    self.btFDDI.selected=NO;

    self.speciaLinePro=0;
    self.speciaLineProText=@"数字电视";
}
- (IBAction)internetButtonOnclick:(id)sender {
    self.btDataVideo.selected=NO;
    self.btInternet.selected=YES;
    self.btWLan.selected=NO;
    self.btFDDI.selected=NO;
    
    self.speciaLinePro=1;
    self.speciaLineProText=@"互联网";
}
- (IBAction)wlanButtonOnclick:(id)sender {
    self.btDataVideo.selected=NO;
    self.btInternet.selected=NO;
    self.btWLan.selected=YES;
    self.btFDDI.selected=NO;
    
    self.speciaLinePro=2;
    self.speciaLineProText=@"WLAN";
}
- (IBAction)fddiButtonOnclick:(id)sender {
    self.btDataVideo.selected=NO;
    self.btInternet.selected=NO;
    self.btWLan.selected=NO;
    self.btFDDI.selected=YES;
    
    self.speciaLinePro=3;
    self.speciaLineProText=@"裸光纤";
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if(IS_IPHONE4 && textField.tag > 11){
        [self.delegate beginEdit];
    }
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if(IS_IPHONE4 && textField.tag > 11){
        [self.delegate endEdit];
    }
}
-(void)setBroadbandType:(int)type{
    switch (type) {
        case 0:
            [self dataVideoButtonOnclick:nil];
            break;
        case 1:
            [self internetButtonOnclick:nil];
            break;
        case 2:
            [self wlanButtonOnclick:nil];
            break;
        case 3:
            [self fddiButtonOnclick:nil];
            break;
            
        default:
            break;
    }
}

@end
