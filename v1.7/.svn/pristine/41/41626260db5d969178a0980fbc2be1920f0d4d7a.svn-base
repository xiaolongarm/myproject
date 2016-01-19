//
//  VerifyAddressViewController.m
//  CMCCMarketing
//
//  Created by kevin on 15/8/21.
//  Copyright (c) 2015年 talkweb. All rights reserved.
//

#import "VerifyAddressViewController.h"

#import "NetworkHandling.h"
#import "MBProgressHUD.h"


@interface VerifyAddressViewController ()<MBProgressHUDDelegate>{
    BOOL hubFlag;
 
}

@end

@implementation VerifyAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //初始化标签
    _commit.layer.borderColor=[UIColor lightGrayColor].CGColor;
    _commit.layer.borderWidth=.5f;
    _companyName.text = [self.addrmsgDict objectForKey:@"grp_name"];
    _companyAddr.text = [self.addrmsgDict objectForKey:@"grp_addr"];
    
    
    NSString *latitude = [self.addrmsgDict objectForKey:@"latitude"];
    NSString *longtitude = [self.addrmsgDict objectForKey:@"longtitude"];
    
    CGRect rect=CGRectMake(0, 0, self.mapView.frame.size.width, self.mapView.frame.size.height);
   BMKMapView *BDmap=[[BMKMapView alloc] initWithFrame:rect];
    [self.mapView addSubview:BDmap];
   BDmap.delegate=self;
//    mapView.hidden=YES;
    
    
        [BDmap removeAnnotations:BDmap.annotations];
    
           BDmap.centerCoordinate=CLLocationCoordinate2DMake(latitude.doubleValue, longtitude.doubleValue);
            BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
            item.coordinate=BDmap.centerCoordinate;
    item.title = [self.addrmsgDict objectForKey:@"grp_addr"];//子标题
            [BDmap addAnnotation:item];
            BDmap.zoomLevel=13;
    

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

-(void)verifySuccess{
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.delegate = self;
    HUD.labelText=@"审核成功！";
    [HUD show:YES];
    [HUD hide:YES afterDelay:1];
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //[self.navigationController popViewControllerAnimated:YES];
//    });
}

- (IBAction)PostDataButton:(id)sender {
    hubFlag=YES;
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"正在提交数据，请稍后...";
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
    
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    
    [bDict setObject:[self.addrmsgDict objectForKey:@"grp_code"] forKey:@"grp_code"];
    int verifyflag = _passSwicth.on ? 1 : 2;
    [bDict setObject:[NSNumber numberWithInt:verifyflag] forKey:@"flag"];
    [bDict setObject:[NSNumber numberWithInt:self.user.userID] forKey:@"user_id"];
    [bDict setObject:[NSNumber numberWithInt:self.user.userEnterprise] forKey:@"enterprise"];
    [bDict setObject:self.user.userName forKey:@"user_name"];
    [bDict setValue:@"ios" forKey:@"client_os"];
    [bDict setValue:[self.addrmsgDict objectForKey:@"vip_mngr_msisdn"] forKey:@"vip_mngr_msisdn"];
    [bDict setObject:_commit.text forKey:@"examine_remark"];
    NSString *url=@"grpuserlink/examineGrpAdd";
    
    [NetworkHandling sendPackageWithUrl:url sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        if(!error){
            BOOL flag = [[result objectForKey:@"flag"] boolValue];
            NSLog(@"sign in success");
            if(flag){
                [self performSelectorOnMainThread:@selector(verifySuccess) withObject:nil waitUntilDone:YES];
            }
            else{
                [self performSelectorOnMainThread:@selector(showMessage:) withObject:@"修改审核提醒状态失败！" waitUntilDone:YES];
            }
        }
        else{
            int errorCode=[[result valueForKey:@"errorcode"] intValue];
            NSString *errorInfo=[result valueForKey:@"errorinf"];
            if(!errorInfo)
                errorInfo=@"提交数据出错！";
            NSLog(@"error:%d info:%@",errorCode,errorInfo);
            [self performSelectorOnMainThread:@selector(showMessage:) withObject:errorInfo waitUntilDone:YES];
        }
        hubFlag=NO;
    }];
    

}
@end
