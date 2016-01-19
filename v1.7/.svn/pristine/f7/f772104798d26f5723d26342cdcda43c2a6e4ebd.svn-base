//
//  CheckLittleGrounpViewController.m
//  CMCCMarketing
//
//  Created by kevin on 15/8/27.
//  Copyright (c) 2015年 talkweb. All rights reserved.
//

#import "CheckLittleGrounpViewController.h"
#import "CheckLittleGrounpTableViewCell.h"
#import "NetworkHandling.h"
#import "MBProgressHUD.h"

@interface CheckLittleGrounpViewController ()<UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate>{
    BOOL hubFlag;
   
}


@end

@implementation CheckLittleGrounpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self.whichtype isEqualToString:@"grounp"]) {
        self.navigationItem.title=@"审核中小集团";
    }
    else  {
        self.navigationItem.title=@"审核关键人";
    }

    _tb.delegate=self;
    _tb.dataSource=self;
    _tb.separatorStyle = UITableViewCellSeparatorStyleNone;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.whichtype isEqualToString:@"grounp"]) {
        return 9;
    }
    else
    {    return 4;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 25;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CheckLittleGrounpTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CheckLittleGrounpTableViewCell" forIndexPath:indexPath];
    
    cell.itemValue.text=@"-";
    
    //    if ([self.whichtype isEqualToString:@"boss"])
    
    if ([self.whichtype isEqualToString:@"grounp"])
    {
        switch (indexPath.row) {
            case 0:
                cell.itemTitle.text =@"集团名称:";
                cell.itemValue.text = [self.msgDict objectForKey:@"grp_name"];
                break;
            case 1:
            {
                cell.itemTitle.text = @"集团编码:";
                    cell.itemValue.text = [self.msgDict objectForKey:@"grp_code"];
            }
                break;
            case 2:
                cell.itemTitle.text = @"集团状态:";
                if([[self.msgDict objectForKey:@"state"] isEqualToString:@"0" ]){
                    cell.itemValue.text = @"未审核";}
                if([[self.msgDict objectForKey:@"state"] isEqualToString:@"1"]){
                   cell.itemValue.text =@" 通过审核";
                }
                if([[self.msgDict objectForKey:@"state"] isEqualToString:@"2"]){
                    cell.itemValue.text =@"审核失败";
                }

                break;
            case 3:
            {
                cell.itemTitle.text = @"集团门牌号:";
                NSString *linkman_tel = [self.msgDict objectForKey:@"grp_address"];
            
                cell.itemValue.text = linkman_tel;
            }
            case 4:
            {
                cell.itemTitle.text = @"楼宇名称:";
                NSString *linkmanBirthday=[self.msgDict objectForKey:@"market_name"];
                // if(linkmanBirthday && (NSNull*)linkmanBirthday != [NSNull null] && linkmanBirthday.length > 0)
                cell.itemValue.text = linkmanBirthday;
            }
                break;
            case 5:
            {
                cell.itemTitle.text = @"楼宇区县:";
                NSString *depart = [self.msgDict objectForKey:@"b_cnty_name"];
                
                cell.itemValue.text = depart;
            }
                break;
            case 6:
            {
                cell.itemTitle.text = @"楼宇街道:";
                cell.itemValue.text = @"-";
                NSString *job = [self.msgDict objectForKey:@"b_street"];
                
                cell.itemValue.text = job;
            }
                break;
            case 7:
            {
                cell.itemTitle.text = @"楼宇详细地址:";
                cell.itemValue.text = [self.msgDict objectForKey:@"grp_addr"];
            }
                break;
            case 8:
            {
                cell.itemTitle.text = @"专业市场类别:";
                cell.itemValue.text = [self.msgDict objectForKey:@"market_tpye"];
            }
                break;
           
            default:
                break;
        }
        
        
    }
    
    if ([self.whichtype isEqualToString:@"man"])
    {
        switch (indexPath.row) {
            case 0:
                cell.itemTitle.text = @"名称：";
                cell.itemValue.text = [self.msgDict objectForKey:@"key_name"];
                break;
            case 1:
                cell.itemTitle.text = @"手机号码:";
                cell.itemValue.text = [self.msgDict objectForKey:@"key_mobile"];
                break;
            case 2:
            {
                cell.itemTitle.text = @"部门:";
                NSString *linkman_tel = [self.msgDict objectForKey:@"key_dept"];
//                if(linkman_tel && (NSNull*)linkman_tel != [NSNull null] && linkman_tel.length > 0)
                    cell.itemValue.text = linkman_tel;
            }
                break;
            case 3:
                cell.itemTitle.text = @"职务:";
                cell.itemValue.text = [self.msgDict objectForKey:@"key_post"];
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
    if ([self.whichtype isEqualToString:@"grounp"]) {
        [self checkGrounp];
    }
    else  {
         [self checkMan];
    }

    
}
-(void)checkMan{
    /**
     审核中小集团关键人
     接口：changsha\v1_7\msgrpuserlink\exammsUserInfo
     必传参数
     user_id 审核人id
     row_id 行号
     state 审核结果 1=通过 2=不通过
     返回参数
     flag true/false
     */
    hubFlag=YES;
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"正在提交数据，请稍后...";
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
    
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    [bDict setObject:[NSNumber numberWithInt:self.user.userID] forKey:@"user_id"];
    [bDict setObject:[self.msgDict objectForKey:@"row_id"] forKey:@"row_id"];
    int verifyflag = _swVerify.on ? 1 : 2;
    [bDict setObject:[NSNumber numberWithInt:verifyflag] forKey:@"state"];
    [NetworkHandling sendPackageWithUrl:@"msgrpuserlink/exammsUserInfo" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
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
-(void)checkGrounp{
    /**
     *   审核中小集团信息
     接口：changsha\v1_7\msgrpuserlink\exammsGrpInfo
     必传参数
     user_id 用户id
     grp_code 集团编码
     state 审核结果 1通过 2不通过
     返回参数
     flag  true/false
     */
    hubFlag=YES;
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"正在提交数据，请稍后...";
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
    
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
        [bDict setObject:[NSNumber numberWithInt:self.user.userID] forKey:@"user_id"];
        [bDict setObject:[self.msgDict objectForKey:@"grp_code"] forKey:@"grp_code"];
    
        int verifyflag = _swVerify.on ? 1 : 2;
        [bDict setObject:[NSNumber numberWithInt:verifyflag] forKey:@"state"];

    [NetworkHandling sendPackageWithUrl:@"msgrpuserlink/exammsGrpInfo" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
