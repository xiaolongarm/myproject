//
//  CustomerManagerGroupContactVerifyViewController.m
//  CMCCMarketing
//
//  Created by talkweb on 15-4-30.
//  Copyright (c) 2015年 talkweb. All rights reserved.
//

#import "CustomerManagerGroupContactVerifyViewController.h"
#import "CustomerManagerGroupContactVerifyTableViewCell.h"
#import "NetworkHandling.h"
#import "MBProgressHUD.h"
//#import "KeyboardHanding.h"
//#import "KeyboardExtendHandling.h"

@interface CustomerManagerGroupContactVerifyViewController ()<UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate>{
    BOOL hubFlag;
//    KeyboardHanding *keyboardHanding;
   // KeyboardExtendHandling *keyboardExtendHandling;
}

@end

@implementation CustomerManagerGroupContactVerifyViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    

//    if (self.listType==2) {
//        self.navigationItem.title=@"审核中小集团";
//    }
   if (self.listType==1) {
        self.navigationItem.title=@"审核渠道老板";
    }
    else if(self.listType==0)
    {
        self.navigationItem.title=@"审核关键人";
    }


    
    txtVerifyContent.layer.borderColor=[UIColor lightGrayColor].CGColor;
    txtVerifyContent.layer.borderWidth=.5f;
    
    detailsTableView.delegate=self;
    detailsTableView.dataSource=self;
    detailsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //垃圾代码导致闪退
//    keyboardHanding = [[KeyboardHanding alloc] initWithTextControl:txtVerifyContent adjustView:self.view];
//    keyboardExtendHandling=[[KeyboardExtendHandling alloc] initKeyboardHangling:self.view];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.whichtype isEqualToString:@"boss"]) {
        return 8;
    }
    else
    {    return 12;
  }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 25;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomerManagerGroupContactVerifyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CustomerManagerGroupContactVerifyTableViewCell" forIndexPath:indexPath];
    
    cell.itemValue.text=@"-";
    
//    if ([self.whichtype isEqualToString:@"boss"])
    
    if (self.listType==1)
    {
        switch (indexPath.row) {
            case 0:
                cell.itemTitle.text = @"姓名：";
                cell.itemValue.text = [self.msgDict objectForKey:@"boss_name"];
                break;
            case 1:
            {
                cell.itemTitle.text = @"性别：";
                int sex=[[self.msgDict objectForKey:@"boss_sex"] intValue];
                NSString *sexString=@"";
                switch (sex) {
                    case 0:
                        sexString=@"未知";
                        break;
                    case 1:
                        sexString=@"男";
                        break;
                    case 2:
                        sexString=@"女";
                        break;
                    default:
                        break;
                }
                cell.itemValue.text = sexString;
            }
                break;
            case 2:
                cell.itemTitle.text = @"手机号码：";
                cell.itemValue.text = [self.msgDict objectForKey:@"boss_msisdn"];
                break;
            case 3:
            {
                cell.itemTitle.text = @"其他联系号码：";
                NSString *linkman_tel = [self.msgDict objectForKey:@"boss_tel"];
              //  if(linkman_tel && (NSNull*)linkman_tel != [NSNull null] && linkman_tel.length > 0)
                    cell.itemValue.text = linkman_tel;
            }
            case 4:
            {
                cell.itemTitle.text = @"生日日期：";
                NSString *linkmanBirthday=[self.msgDict objectForKey:@"boss_birthday"];
               // if(linkmanBirthday && (NSNull*)linkmanBirthday != [NSNull null] && linkmanBirthday.length > 0)
                    cell.itemValue.text = linkmanBirthday;
        }
            break;
            case 5:
            {
                cell.itemTitle.text = @"生日提醒：";
                NSString *depart = [NSString stringWithFormat:@"%@",[self.msgDict objectForKey:@"is_birthday_remind"]];
//                if(depart && (NSNull*)depart != [NSNull null] && depart.length > 0)
                    cell.itemValue.text = depart;
            }
                break;
            case 6:
            {
                cell.itemTitle.text = @"异网关键人：";
                cell.itemValue.text = @"-";
                NSString *job = [self.msgDict objectForKey:@"is_diff_key"];
//                if(job && (NSNull*)job != [NSNull null] && job.length > 0)
                    cell.itemValue.text = job;
            }
                break;
            case 7:
            {
                cell.itemTitle.text = @"归属运营商：";
                    cell.itemValue.text = [self.msgDict objectForKey:@"chinamobile"];
            }
                break;
            default:
                break;
        }


    }
    
    if (self.listType==0)
    {
    switch (indexPath.row) {
        case 0:
            cell.itemTitle.text = @"姓名：";
            cell.itemValue.text = [self.msgDict objectForKey:@"linkman"];
            break;
        case 1:
        {
            cell.itemTitle.text = @"性别：";
            int sex=[[self.msgDict objectForKey:@"linkman_sex"] intValue];
            NSString *sexString=@"";
            switch (sex) {
                case 0:
                    sexString=@"未知";
                    break;
                case 1:
                    sexString=@"男";
                    break;
                case 2:
                    sexString=@"女";
                    break;
                default:
                    break;
            }
            cell.itemValue.text = sexString;
        }
            break;
        case 2:
            cell.itemTitle.text = @"手机号码：";
            cell.itemValue.text = [self.msgDict objectForKey:@"linkman_msisdn"];
            break;
        case 3:
        {
            cell.itemTitle.text = @"其他联系号码：";
            NSString *linkman_tel = [self.msgDict objectForKey:@"linkman_tel"];
            if(linkman_tel && (NSNull*)linkman_tel != [NSNull null] && linkman_tel.length > 0)
                cell.itemValue.text = linkman_tel;
        }
            break;
        case 4:
            cell.itemTitle.text = @"所属集团单位：";
            cell.itemValue.text = [self.msgDict objectForKey:@"grp_name"];
            break;
        case 5:
        {
            cell.itemTitle.text = @"所在部门（处室）：";
            NSString *depart = [self.msgDict objectForKey:@"depart"];
            if(depart && (NSNull*)depart != [NSNull null] && depart.length > 0)
                cell.itemValue.text = depart;
        }
            break;
        case 6:
        {
            cell.itemTitle.text = @"职务：";
            cell.itemValue.text = @"-";
            NSString *job = [self.msgDict objectForKey:@"job"];
            if(job && (NSNull*)job != [NSNull null] && job.length > 0)
                cell.itemValue.text = job;
        }
            break;
        case 7:
        {
            cell.itemTitle.text = @"生日日期：";
            NSString *linkmanBirthday=[self.msgDict objectForKey:@"linkman_birthday"];
            if(linkmanBirthday && (NSNull*)linkmanBirthday != [NSNull null] && linkmanBirthday.length > 0)
                cell.itemValue.text = [self.msgDict objectForKey:@"linkman_birthday"];
        }
            break;
        case 8:
            cell.itemTitle.text = @"日期提醒：";
            int flag=[[self.msgDict objectForKey:@"is_birthday_remind"] intValue];
            cell.itemValue.text = flag?@"提醒":@"不提醒";
            break;
        case 9:
        {
            cell.itemTitle.text = @"类别：";
            NSString *key_type = [self.msgDict objectForKey:@"key_type"];
            if(key_type && (NSNull*)key_type != [NSNull null] && key_type.length > 0)
                cell.itemValue.text = key_type;
        }
            break;
        case 10:
            cell.itemTitle.text = @"异网关键人：";
            cell.itemValue.text = [self.msgDict objectForKey:@"is_diff_key"];
            break;
        case 11:
        {
            cell.itemTitle.text = @"归属运用商：";
            NSString *chinaMobile=[self.msgDict objectForKey:@"chinamobile"];
            if(chinaMobile && (NSNull*)chinaMobile != [NSNull null] && chinaMobile.length > 0)
                cell.itemValue.text = chinaMobile;
        }
            break;
        
        default:
            break;
    }
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)connectToNetwork{
    while (hubFlag) {
        usleep(100000);
    }
}
-(void)showMessage:(NSString*)infomation{
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"信息提示" message:infomation delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
    [myAlertView show];
}
-(void)hudWasHidden:(MBProgressHUD *)hud{
    [hud removeFromSuperview];
    hud=nil;
}
//grpuserlink/updleaderremindsta
- (IBAction)submitOnclick:(id)sender {
    hubFlag=YES;
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"正在提交数据，请稍后...";
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
    
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    NSString *url;
    if ([self.whichtype isEqualToString:@"boss"]) {
        [bDict setObject:self.user.userName forKey:@"user_name"];
        [bDict setObject:[NSNumber numberWithInt:self.user.userID] forKey:@"user_id"];
        [bDict setObject:[NSNumber numberWithInt:self.user.userEnterprise] forKey:@"enterprise"];
        [bDict setObject:[self.msgDict objectForKey:@"row_id"] forKey:@"row_id"];
        [bDict setObject:[self.msgDict objectForKey:@"boss_msisdn"] forKey:@"boss_msisdn"];
        [bDict setValue:[self.msgDict objectForKey:@"vip_mngr_msisdn"] forKey:@"vip_mngr_msisdn"];
        [bDict setObject:txtVerifyContent.text forKey:@"examine_remark"];
        int verifyflag = swVerify.on ? 1 : 2;
        [bDict setObject:[NSNumber numberWithInt:verifyflag] forKey:@"flag"];
       url=@"grpuserlink/examineChnlBossInfo";
    }
    else{
        //    row_id 行号
        //    flag 状态 0:未审核 1:审核通过 2:审核未通过
        //    user_id 审核人id
        //    vip_mngr_msisdn 客户经理手机号码
        //    linkman_msisdn 联系人手机号码
        //    user_name 审核人姓名
        
        [bDict setObject:[self.msgDict objectForKey:@"row_id"] forKey:@"row_id"];
        int verifyflag = swVerify.on ? 1 : 2;
        [bDict setObject:[NSNumber numberWithInt:verifyflag] forKey:@"flag"];
        [bDict setObject:[NSNumber numberWithInt:self.user.userID] forKey:@"user_id"];
        //    [bDict setObject:[NSNumber numberWithInt:self.user.userEnterprise] forKey:@"enterprise"];
        [bDict setObject:self.user.userName forKey:@"user_name"];
        //    [bDict setValue:@"ios" forKey:@"client_os"];
        [bDict setValue:[self.msgDict objectForKey:@"vip_mngr_msisdn"] forKey:@"vip_mngr_msisdn"];
        
        [bDict setObject:txtVerifyContent.text forKey:@"examine_remark"];
        [bDict setObject:[self.msgDict objectForKey:@"linkman_msisdn"] forKey:@"linkman_msisdn"];
       url=@"grpuserlink/examineUserInfo";

    }
    
    [NetworkHandling sendPackageWithUrl:url sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        if(!error){
            BOOL flag = [[result objectForKey:@"flag"] boolValue];
            NSLog(@"sign in success");
            if(flag)
                [self performSelectorOnMainThread:@selector(verifySuccess) withObject:nil waitUntilDone:YES];
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
//-(void)updateRemindState{
//    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
//    [bDict setObject:[NSNumber numberWithInt:self.user.userEnterprise] forKey:@"enterprise"];
//    [bDict setObject:[self.msgDict objectForKey:@"grp_code"] forKey:@"grp_code"];
//    [bDict setObject:[self.msgDict objectForKey:@"linkman_msisdn"] forKey:@"linkman_msisdn"];
//    NSString *url=@"grpuserlink/updleaderremindsta";
//    [NetworkHandling sendPackageWithUrl:url sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
//        
//        if(!error){
//            BOOL flag = [[result objectForKey:@"flag"] boolValue];
//            NSLog(@"sign in success");
//            if(flag)
//                [self performSelectorOnMainThread:@selector(verifySuccess) withObject:nil waitUntilDone:YES];
//            else
//                [self performSelectorOnMainThread:@selector(showMessage:) withObject:@"修改审核提醒状态失败！" waitUntilDone:YES];
//            
//            
//        }
//        else{
//            int errorCode=[[result valueForKey:@"errorcode"] intValue];
//            NSString *errorInfo=[result valueForKey:@"errorinf"];
//            if(!errorInfo)
//                errorInfo=@"提交数据出错了！";
//            NSLog(@"error:%d info:%@",errorCode,errorInfo);
//            [self performSelectorOnMainThread:@selector(showMessage:) withObject:errorInfo waitUntilDone:YES];
//            
//        }
//        hubFlag=NO;
//    }];
//    
//}
-(void)verifySuccess{
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.delegate = self;
    HUD.labelText=@"审核成功！";
    [HUD show:YES];
    [HUD hide:YES afterDelay:1];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
       // [self.navigationController popViewControllerAnimated:YES];
//    });
}

@end
