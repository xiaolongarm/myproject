//
//  CustomersWarningFollowUpViewController.m
//  CMCCMarketing
//
//  Created by talkweb on 14-9-24.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import "CustomersWarningFollowUpViewController.h"
#import "MBProgressHUD.h"
#import "NetworkHandling.h"

@interface CustomersWarningFollowUpViewController ()<MBProgressHUDDelegate>{
    BOOL hubFlag;
}

@end

@implementation CustomersWarningFollowUpViewController

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
    
    UIBarButtonItem *rightButton=[[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(submitData)];
    [rightButton setTintColor:[UIColor whiteColor]];
    [self.navigationItem setRightBarButtonItem:rightButton];
    
    
    txtFollowUpContent.layer.borderColor=[UIColor lightGrayColor].CGColor;
    txtFollowUpContent.layer.borderWidth=.5f;
    txtFollowUpContent.layer.masksToBounds=YES;
    txtFollowUpContent.layer.cornerRadius=3;
    
    txtFollowUpContent.delegate=self;
    txtContactNames.delegate=self;
    txtContactPhone.delegate=self;
    
    if(self.isPersion){
        self.lbCustomerName.text=[self.customerDict objectForKey:@"grp_name"];
        txtContactPhone.text = [self.customerDict objectForKey:@"user_msisdn"];
    }
    else
        self.lbCustomerName.text=self.group.groupName;
    
    self.lbCustomerName.adjustsFontSizeToFitWidth=YES;
    
}
-(void)submitData{
    if(txtContactNames.text.length == 0){
        [self showTips:@"联系人不能为空！"];
        return;
    }
    if(txtContactPhone.text.length == 0){
        [self showTips:@"联系电话不能为空！"];
        return;
    }
    if(txtContactPhone.text.length != 11){
        [self showTips:@"联系电话号码不正确！"];
        return;
    }
    
    
    
    hubFlag=YES;
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"正在提交数据，请稍后...";
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
    [self addReply];
    
}
-(void)showTips:(NSString*)msg{
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.delegate = self;
    HUD.labelText = msg;
    [HUD show:YES];
    [HUD hide:YES afterDelay:1];
}
-(void)connectToNetwork{
    while (hubFlag) {
        usleep(100000);
    }
}

//{
//    arpu = "99.60";
//    "arpu_per" = "51.59";
//    "baodi_end_date" = 20141231;
//    "disc_name" = "\U52a8\U611f\U5730\U5e26\U4e0a\U7f51\U5957\U991038\U5143\U5957\U9910\U4f18\U60e0";
//    dou = "244.30";
//    "dou_per" = "22.55";
//    "gprs_disc_name" = "\U52a8\U611f\U5730\U5e26\U4e0a\U7f51\U5957\U991038\U5143\U5957\U9910\U4f18\U60e0";
//    "grp_code" = 7311000158;
//    "grp_name" = "\U6e56\U5357\U65e5\U62a5\U793e\U5370\U5237\U5382";
//    "is_4g_card" = "\U5426";
//    "is_4g_disc" = "\U5426";
//    "is_4g_term" = "\U5426";
//    "is_baodi" = "\U662f";
//    "photo_arpu" = "65.70";
//    rank = 1;
//    "term_standard" = GSM;
//    thresholds =     (
//    );
//    "time_id" = 201409;
//    "user_msisdn" = 18874238126;
//    "user_stat" = "\U5f00\U901a";
//    "user_type" = "201408\U6708BOSS\U5173\U952e\U4eba";
//    "vip_mngr_id" = A1KZZQ36;
//    "vip_mngr_msisdn" = 15073111492;
//    "vip_mngr_name" = "\U5f90\U9759";
//}
-(void)addReply{

    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
//    [bDict setObject:self.user.userMobile forKey:@"mobile"];
    [bDict setObject:[NSNumber numberWithInt:self.user.userEnterprise] forKey:@"enterprise"];
    if(self.isPersion){
        [bDict setObject:[self.customerDict objectForKey:@"grp_code"] forKey:@"grp_code"];
        [bDict setObject:[self.customerDict objectForKey:@"grp_name"] forKey:@"grp_name"];
    }
    else if(self.group){
        [bDict setObject:self.group.groupId forKey:@"grp_code"];
        [bDict setObject:self.group.groupName forKey:@"grp_name"];
    }
    [bDict setObject:self.user.userMobile forKey:@"vip_mngr_msisdn"];
    [bDict setObject:self.user.userName forKey:@"vip_mngr_name"];
    [bDict setObject:txtFollowUpContent.text forKey:@"reply_content"];
    [bDict setObject:txtContactNames.text forKey:@"linkman"];
    [bDict setObject:txtContactPhone.text forKey:@"linkman_msisdn"];
    
    [NetworkHandling sendPackageWithUrl:@"gprwarn/addgrpReply" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        if(!error){
            NSLog(@"sign in success");
            BOOL flag=[[result objectForKey:@"flag"] boolValue];
            if(flag)
                [self performSelectorOnMainThread:@selector(showMessage:) withObject:@"回复提交成功！" waitUntilDone:YES];
            else
                [self performSelectorOnMainThread:@selector(showMessage:) withObject:@"回复提交失败！" waitUntilDone:YES];
//            [self performSelectorOnMainThread:@selector(submitFinished) withObject:nil waitUntilDone:YES];
        }
        else{
            int errorCode=[[result valueForKey:@"errorcode"] intValue];
            NSString *errorInfo=[result valueForKey:@"errorinf"];
            if(!errorInfo)
                errorInfo=@"提交数据出错了！";
            NSLog(@"error:%d info:%@",errorCode,errorInfo);
            [self performSelectorOnMainThread:@selector(showMessage:) withObject:errorInfo waitUntilDone:YES];
        }
        hubFlag=NO;
    }];
}
//Response =     {
//    arpu = "103.25";
//    "arpu_per" = "0.03";
//    "baodi_user" = 1;
//    "cancellation_user_cnt" = 8;
//    "cnty_name" = "A_\U57ce\U5317";
//    dou = "172.87";
//    "dou_per" = "9.14";
//    "grp_code" = 7319003870;
//    "grp_name" = "\U6e56\U5357\U8302\U534e\U7f6e\U4e1a\U6709\U9650\U8d23\U4efb\U516c\U53f8";
//    "infiltration_term_4g_per" = "9.84";
//    "infiltration_user_4g_per" = "9.84";
//    "innetwork_user_cnt" = 124;
//    "m_avg_dur" = 2685;
//    "m_avg_dur_per" = "84.16";
//    "m_avg_fee" = "439.66";
//    "m_avg_fee_per" = "84.69";
//    "outnetword_user_cnt" = 8;
//    "overflow_user" = 59;
//    "photo_user_cnt" = 132;
//    rank = 1;
//    "term_4g_ring_per" = "8.25";
//    "three_hold_per" = "72.05";
//    "three_hold_ring_per" = "0.60";
//    thresholds =         (
//                          "dou_per"
//                          );
//    "time_id" = 201408;
//    "user_4g_ring_per" = "8.25";
//    "vip_mngr_id" = A1KZZQ36;
//    "vip_mngr_msisdn" = 15073111492;
//    "vip_mngr_name" = "\U5f90\U9759";
//    "zero_user_cnt" = 14;
//};
-(void)showMessage:(NSString*)infomation{
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"信息提示" message:infomation delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
    [myAlertView show];
}
-(void)submitFinished{

}
-(void)hudWasHidden:(MBProgressHUD *)hud{
    [hud removeFromSuperview];
    hud=nil;
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

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    CGRect rect=self.view.frame;
    rect.origin.y-=100;
    self.view.frame=rect;
    return YES;
}
-(BOOL)textViewShouldEndEditing:(UITextView *)textView{
    CGRect rect=self.view.frame;
    rect.origin.y+=100;
    self.view.frame=rect;
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
@end
