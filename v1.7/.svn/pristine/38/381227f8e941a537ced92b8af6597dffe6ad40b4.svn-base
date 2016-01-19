//
//  AddLittleGrounpViewController.m
//  CMCCMarketing
//
//  Created by kevin on 15/8/26.
//  Copyright (c) 2015年 talkweb. All rights reserved.
//

#import "AddLittleGrounpViewController.h"
#import "MBProgressHUD.h"
#import "NetworkHandling.h"
#import "CustomerManagerBodyViewController.h"
@interface AddLittleGrounpViewController ()<MBProgressHUDDelegate>{
    BOOL hudFlag;
}

@end

@implementation AddLittleGrounpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *rightButton=[[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(goEdit)];
    [rightButton setTintColor:[UIColor whiteColor]];
    [self.navigationItem setRightBarButtonItem:rightButton];
    if (self.whereFrom==9) {
        self.nameText.text=[_Dict objectForKey:@"key_name"];
        self.cellPhoneNumber.text=[_Dict objectForKey:@"key_mobile"];
        self.partText.text=[_Dict objectForKey:@"key_dept"];
        self.posztionText.text=[_Dict objectForKey:@"key_post"];
    }
    // Do any additional setup after loading the view.
}
-(void)goEdit{
    if (self.whereFrom==9) {
        [self UpdatteLittleGrounpContact];
    }
    else {
        [self addLittleGrounpContact];
    }
}
-(void)UpdatteLittleGrounpContact{
    /**
     *  msgrpuserlink\updmsUserInfo
     必传参数
     row_id  行号
     key_name 关键人名字
     key_mobile 关键热手机号码
     非必传
     key_dept 关键人部门
     key_post 关键人职务
     */
    if ([self.nameText.text isEqualToString:@""]) {
        MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:HUD];
        HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
        HUD.mode = MBProgressHUDModeCustomView;
        HUD.delegate = self;
        HUD.labelText = @"请填写关键人名称！";
        [HUD show:YES];
        [HUD hide:YES afterDelay:1];
        return;
        
    }
    
    if ([self.cellPhoneNumber.text isEqualToString:@""]) {
        MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:HUD];
        HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
        HUD.mode = MBProgressHUDModeCustomView;
        HUD.delegate = self;
        HUD.labelText = @"请填写手机号码！";
        [HUD show:YES];
        [HUD hide:YES afterDelay:1];
        return;
        
    }

    hudFlag=YES;
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"数据提交中，请稍后...";
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    [bDict setObject:[_Dict objectForKey:@"row_id"] forKey:@"row_id"];
    [bDict setObject:self.nameText.text forKey:@"key_name"];
    [bDict setObject:self.cellPhoneNumber.text forKey:@"key_mobile"];
    [bDict setObject:self.partText.text forKey:@"key_dept"];
    [bDict setObject:self.posztionText.text forKey:@"key_post"];
    
    [NetworkHandling sendPackageWithUrl:@"msgrpuserlink/updmsUserInfo" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        if(!error){
            NSLog(@"sign in success");
            BOOL flag=[[result objectForKey:@"flag"] boolValue];
            if(flag)
                [self performSelectorOnMainThread:@selector(sendFinished) withObject:nil waitUntilDone:YES];
            else
                [self performSelectorOnMainThread:@selector(showMessage:) withObject:@"提交数据失败" waitUntilDone:YES];
            
        }else{
            int errorCode=[[result valueForKey:@"errorcode"] intValue];
            NSString *errorInfo=[result valueForKey:@"errorinf"];
            if(!errorInfo)
                errorInfo=@"提交数据出错了！";
            NSLog(@"error:%d info:%@",errorCode,errorInfo);
            [self performSelectorOnMainThread:@selector(showMessage:) withObject:errorInfo waitUntilDone:YES];
        }
        hudFlag=NO;
    }];

}
-(void)addLittleGrounpContact{
    /**
     *  changsha\v1_7\msgrpuserlink\addUserInfo
     必传参数
     vip_mngr_id  客户经理编码
     vip_mngr_name 客户经理姓名
     vip_mngr_msisdn 客户经理手机号码
     grp_code 集团编码
     grp_name 集团名称
     key_name 关键人
     key_mobile 关键人手机号码
     非比惨参数
     key_dept 关键人部门
     key_post 关键人职务
     */
    if ([self.nameText.text isEqualToString:@""]) {
        MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:HUD];
        HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
        HUD.mode = MBProgressHUDModeCustomView;
        HUD.delegate = self;
        HUD.labelText = @"请填写关键人名称！";
        [HUD show:YES];
        [HUD hide:YES afterDelay:1];
        return;
        
    }

    if ([self.cellPhoneNumber.text isEqualToString:@""]) {
        MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:HUD];
        HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
        HUD.mode = MBProgressHUDModeCustomView;
        HUD.delegate = self;
        HUD.labelText = @"请填写手机号码！";
        [HUD show:YES];
        [HUD hide:YES afterDelay:1];
        return;
        
    }

    hudFlag=YES;
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"数据提交中，请稍后...";
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
       NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    [bDict setObject:[NSNumber numberWithInt:self.user.userID] forKey:@"vip_mngr_id"];
    [bDict setObject:self.user.userName forKey:@"vip_mngr_name"];
    [bDict setObject:self.user.userMobile forKey:@"vip_mngr_msisdn"];

//    [bDict setObject:[_Dict objectForKey:@"vip_mngr_id"] forKey:@"vip_mngr_id"];
//    [bDict setObject:[_Dict objectForKey:@"vip_mngr_name"] forKey:@"vip_mngr_name"];
//    [bDict setObject:[_Dict objectForKey:@"vip_mngr_msisdn"]forKey:@"vip_mngr_msisdn"];
    
    [bDict setObject:[_Dict objectForKey:@"grp_code"] forKey:@"grp_code"];
     [bDict setObject:[_Dict objectForKey:@"grp_name"] forKey:@"grp_name"];
    [bDict setObject:self.nameText.text forKey:@"key_name"];
    [bDict setObject:self.cellPhoneNumber.text forKey:@"key_mobile"];
    [bDict setObject:self.partText.text forKey:@"key_dept"];
    [bDict setObject:self.posztionText.text forKey:@"key_post"];
    
    [NetworkHandling sendPackageWithUrl:@"msgrpuserlink/addUserInfo" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        if(!error){
            NSLog(@"sign in success");
            BOOL flag=[[result objectForKey:@"flag"] boolValue];
            if(flag)
                [self performSelectorOnMainThread:@selector(sendFinished) withObject:nil waitUntilDone:YES];
            else
                [self performSelectorOnMainThread:@selector(showMessage:) withObject:@"提交数据失败" waitUntilDone:YES];
            
        }else{
            int errorCode=[[result valueForKey:@"errorcode"] intValue];
            NSString *errorInfo=[result valueForKey:@"errorinf"];
            if(!errorInfo)
                errorInfo=@"提交数据出错了！";
            NSLog(@"error:%d info:%@",errorCode,errorInfo);
            [self performSelectorOnMainThread:@selector(showMessage:) withObject:errorInfo waitUntilDone:YES];
        }
        hudFlag=NO;
    }];

    
}
#pragma mark -网络API相关
-(void)connectToNetwork{
    while (hudFlag) {
        usleep(100000);
    }
}
-(void)showMessage:(NSString*)infomation{
    
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"信息提示" message:infomation delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
    [myAlertView show];
}

-(void)sendFinished{
    self.nameText.text=@"";
    self.cellPhoneNumber.text=@"";
    self.partText.text=@"";
    self.posztionText.text=@"";
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    
    [self.view addSubview:HUD];
    
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    
    HUD.mode = MBProgressHUDModeCustomView;
    
    HUD.delegate = self;
    
    HUD.labelText = @"数据提交成功";
    [HUD show:YES];
    [HUD hide:YES afterDelay:3];
//     CustomerManagerBodyViewController *controller=[[CustomerManagerBodyViewController alloc]init];
    for (UIViewController *temp in self.navigationController.viewControllers) {
        if ([temp isKindOfClass:[CustomerManagerBodyViewController class]]) {
            [self.navigationController popToViewController:temp animated:YES];
        }
    }
   
//    [self.navigationController popToViewController:controller animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
