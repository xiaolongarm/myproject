//
//  AddSigleLittleGrounpViewController.m
//  CMCCMarketing
//
//  Created by kevin on 15/8/26.
//  Copyright (c) 2015年 talkweb. All rights reserved.
//

#import "AddSigleLittleGrounpViewController.h"
#import "BuildingListTableViewController.h"
#import "MBProgressHUD.h"
#import "NetworkHandling.h"
#import "CustomerManagerBodyViewController.h"
#import "CustomerManagerViewController.h"
#import "CustomerManagerCSTableViewController.h"
@interface AddSigleLittleGrounpViewController ()<MBProgressHUDDelegate>{
    BOOL hudFlag;
}


@end

@implementation AddSigleLittleGrounpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //获取楼宇的通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(RecipeData:) name:@"PostMarketName" object:nil];
    UIBarButtonItem *rightButton=[[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(goEdit)];
    [rightButton setTintColor:[UIColor whiteColor]];
    [self.navigationItem setRightBarButtonItem:rightButton];
    //从编辑页面来
    if (self.whereFrom==8) {
        self.navigationItem.title=@"编辑中小集团";
      //grp_address 集团门牌号
        self.doorNumber.text=[_Dict objectForKey:@"grp_address"];
        //grp_name 集团名称

        self.groupName.text=[_Dict objectForKey:@"grp_name"];
         [_BuildingButton setTitle:[_Dict objectForKey:@"market_name"] forState:UIControlStateNormal];
        _BuildingButton.enabled=NO;
        
    }

    // Do any additional setup after loading the view.
}
-(void)RecipeData:(NSNotification*)aNotification{
    self.Dict=[aNotification object];
    NSString *buttonTitle =[_Dict objectForKey:@"market_name"];
     [_BuildingButton setTitle:buttonTitle forState:UIControlStateNormal];
    
}

-(void)goEdit{
    if (self.whereFrom==8) {
        [self updmsGrpInfo];
    }
    else {
        [self addmsGrpInfo];
    }
}
-(void)updmsGrpInfo{
    if(!_Dict)
    {
        MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:HUD];
        HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
        HUD.mode = MBProgressHUDModeCustomView;
        HUD.delegate = self;
        HUD.labelText = @"请选择楼宇！";
        [HUD show:YES];
        [HUD hide:YES afterDelay:1];
        return;
    }
    if ([self.doorNumber.text isEqualToString:@""]) {
        MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:HUD];
        HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
        HUD.mode = MBProgressHUDModeCustomView;
        HUD.delegate = self;
        HUD.labelText = @"请填写集团门牌号！";
        [HUD show:YES];
        [HUD hide:YES afterDelay:1];
        return;
        
    }
    
    if ([self.groupName.text isEqualToString:@""]) {
        MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:HUD];
        HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
        HUD.mode = MBProgressHUDModeCustomView;
        HUD.delegate = self;
        HUD.labelText = @"请填写集团名称！";
        [HUD show:YES];
        [HUD hide:YES afterDelay:1];
        return;
        
    }

    /**
     changsha\v1_7\msgrpuserlink\updmsGrpInfo
     必传参数
     user_id 用户id
     grp_code 集团编码
     grp_name 集团名称
     grp_address 集团门牌号
     */
    hudFlag=YES;
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"数据提交中，请稍后...";
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    [bDict setObject:[NSNumber numberWithInt:self.user.userID] forKey:@"user_id"];
    [bDict setObject:[_Dict objectForKey:@"grp_code"] forKey:@"grp_code"];
    
    //grp_name 集团名称
    [bDict setObject:self.groupName.text forKey:@"grp_name"];
    //grp_address 集团门牌号
    
    [bDict setObject:self.doorNumber.text forKey:@"grp_address"];
    
    [NetworkHandling sendPackageWithUrl:@"msgrpuserlink/updmsGrpInfo" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
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
-(void)addmsGrpInfo{
    
    /**
     changsha\v1_7\msgrpuserlink\addmsGrpInfo
     必传参数
     b_cnty_id 楼宇区县
     b_cnty_name 楼宇区县
     b_street 楼宇街道
     vip_mngr_id 客户经理id
     vip_mngr_name 客户经理名字
     vip_mngr_msisdn 客户经理手机号码
     market_tpye_code 专业市场
     market_tpye 专业市场
     market_code 楼宇id
     market_name 楼宇名称
     market_address 楼宇地址
     grp_name 集团名称
     grp_address 集团门牌号
         */
    if(!_Dict)
    {
        MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:HUD];
        HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
        HUD.mode = MBProgressHUDModeCustomView;
        HUD.delegate = self;
        HUD.labelText = @"请选择楼宇！";
        [HUD show:YES];
        [HUD hide:YES afterDelay:1];
        return;
    }
    if ([self.doorNumber.text isEqualToString:@""]) {
        MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:HUD];
        HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
        HUD.mode = MBProgressHUDModeCustomView;
        HUD.delegate = self;
        HUD.labelText = @"请填写集团门牌号！";
        [HUD show:YES];
        [HUD hide:YES afterDelay:1];
        return;

    }
    
    if ([self.groupName.text isEqualToString:@""]) {
        MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:HUD];
        HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
        HUD.mode = MBProgressHUDModeCustomView;
        HUD.delegate = self;
        HUD.labelText = @"请填写集团名称！";
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
    [bDict setObject:[_Dict objectForKey:@"b_cnty_id"] forKey:@"b_cnty_id"];
    
    [bDict setObject:[_Dict objectForKey:@"b_cnty_name"] forKey:@"b_cnty_name"];
    [bDict setObject:[_Dict objectForKey:@"b_street"]forKey:@"b_street"];
    
    [bDict setObject:[NSNumber numberWithInt:self.user.userID] forKey:@"vip_mngr_id"];
    [bDict setObject:self.user.userName forKey:@"vip_mngr_name"];
    [bDict setObject:self.user.userMobile forKey:@"vip_mngr_msisdn"];
//    [bDict setObject:[_Dict objectForKey:@"vip_mngr_id"] forKey:@"vip_mngr_id"];
//    [bDict setObject:[_Dict objectForKey:@"vip_mngr_name"] forKey:@"vip_mngr_name"];
//    [bDict setObject:[_Dict objectForKey:@"vip_mngr_msisdn"] forKey:@"vip_mngr_msisdn"];
    
    [bDict setObject:[_Dict objectForKey:@"market_tpye_code"] forKey:@"market_tpye_code"];
    [bDict setObject:[_Dict objectForKey:@"market_tpye"] forKey:@"market_tpye"];
    [bDict setObject:[_Dict objectForKey:@"market_code"] forKey:@"market_code"];
    [bDict setObject:[_Dict objectForKey:@"market_name"] forKey:@"market_name"];

     [bDict setObject:_BuildingButton.titleLabel.text forKey:@"market_address"];
    
    //grp_name 集团名称
    [bDict setObject:self.groupName.text forKey:@"grp_name"];
    //grp_address 集团门牌号

    [bDict setObject:self.doorNumber.text forKey:@"grp_address"];
    
    [NetworkHandling sendPackageWithUrl:@"msgrpuserlink/addmsGrpInfo" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
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
    self.groupName.text=@"";
    self.doorNumber.text=@"";
//    self.partText.text=@"";
//    self.posztionText.text=@"";
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.delegate = self;
    HUD.labelText = @"数据提交成功";
    [HUD show:YES];
    [HUD hide:YES afterDelay:3];
    //[self.navigationController popViewControllerAnimated:YES];
    for (UIViewController *temp in self.navigationController.viewControllers) {
        if ([temp isKindOfClass:[CustomerManagerCSTableViewController class]]) {
            [self.navigationController popToViewController:temp animated:YES];
        }
    }


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

- (IBAction)ChooseBuilding:(id)sender {
    BuildingListTableViewController *controller= [[BuildingListTableViewController alloc]init];
     controller.user=self.user;
    [self.navigationController pushViewController:controller animated:YES];
//
//     *dataAcquisitionController = [controller.viewControllers objectAtIndex:0];
//   // BuildingListTableViewController *controller;
//   
//    [self presentViewController:controller animated:YES completion:nil];

}
@end
