//
//  TipsViewController.m
//  CMCCMarketing
//
//  Created by talkweb on 14-9-2.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import "TipsViewController.h"
#import "MainViewController.h"
#import "MBProgressHUD.h"
#import "NetworkHandling.h"
#import "LocationDataAcquisition.h"
#import "VariableStore.h"

@interface TipsViewController ()<MBProgressHUDDelegate>{
    BOOL hubFlag;
//    LocationDataAcquisition *locationDataAcquisition;
}

@end

@implementation TipsViewController

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
//    NSLog(@"user :%@",self.user.userName);
    
//    hubFlag=YES;
//    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
//    [self.view addSubview:HUD];
//    HUD.delegate=self;
//    HUD.labelText=@"数据查询中，请稍后...";
//    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
//    [self loadData];
    
//#ifdef MANAGER_VERSION
// 
//#endif
    
//#ifdef STANDARD_VERSION
//#if (defined STANDARD_CS_VERSION) || (defined STANDARD_SY_VERSION)
////    dispatch_async(dispatch_get_main_queue(), ^{
//        if([VariableStore sharedInstance].isStopGPSReport)
//            return;
//        
//        if(![VariableStore sharedInstance].locationDataAcquisition){
//            [VariableStore sharedInstance].locationDataAcquisition=[[LocationDataAcquisition alloc] init];
//        }
//        [VariableStore sharedInstance].locationDataAcquisition.user=self.user;
//        [[VariableStore sharedInstance].locationDataAcquisition startLocationDataAcquisition];
////    });
//#endif
    
//#ifdef MANAGER_SY_VERSION
//    imgTopBackground.image=[UIImage imageNamed:@"邵阳－640X311(主管端）.png"];
//#endif
//    
//    
//#ifdef STANDARD_SY_VERSION
//    imgTopBackground.image=[UIImage imageNamed:@"邵阳－640X311(营销经理端）.png"];
//#endif
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *buildVersionString = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    
    lbVersion.text=[NSString stringWithFormat:@"-v%@",buildVersionString];
#ifdef MANAGER_SY_VERSION
    //     imgBackground.image=[UIImage imageNamed:@"邵阳－登陆页（主管端）.png"];
    lbTitle.text=@"和营销 (主管端)";
#endif
    
    
#ifdef STANDARD_SY_VERSION
    //     imgBackground.image=[UIImage imageNamed:@"邵阳－登陆页（营销经理端）.png"];
    lbTitle.text=@"和营销 (营销经理端)";
#endif
    
    
    
}
-(void)connectToNetwork{
    while (hubFlag) {
        usleep(100000);
    }
}
//获取预警信息
-(void)loadCustomerWarningData{
    
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    [bDict setObject:self.user.userMobile forKey:@"mobile"];
    [bDict setObject:[NSNumber numberWithInt:self.user.userEnterprise] forKey:@"enterprise"];
    
    [NetworkHandling sendPackageWithUrl:@"gprwarn/remindList" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        if(!error){
            NSLog(@"sign in success");
//            remindTableArray =[result objectForKey:@"remind"];
            
//            [self performSelectorOnMainThread:@selector(refreshRemindButton) withObject:nil waitUntilDone:YES];
        }
        else{
            int errorCode=[[result valueForKey:@"errorcode"] intValue];
            NSString *errorInfo=[result valueForKey:@"errorinf"];
            if(!errorInfo)
                errorInfo=@"提交数据出错了！";
            NSLog(@"error:%d info:%@",errorCode,errorInfo);
            [self performSelectorOnMainThread:@selector(showMessage:) withObject:errorInfo waitUntilDone:YES];
        }
//        hubFlag=NO;
    }];
}

//最新优惠活动
-(void)loadNewDicsData{
    
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    //    [bDict setObject:self.user.userMobile forKey:@"mobile"];
    [bDict setObject:[NSNumber numberWithInt:self.user.userEnterprise] forKey:@"enterprise"];
    
    [NetworkHandling sendPackageWithUrl:@"knowledge/newdiscList" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        if(!error){
            NSLog(@"sign in success");
//            tableArray =[result objectForKey:@"result"];
            
//            [self performSelectorOnMainThread:@selector(refreshTableView) withObject:nil waitUntilDone:YES];
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


-(void)showMessage:(NSString*)infomation{
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"信息提示" message:infomation delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
    [myAlertView show];
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    MainViewController *controller=[segue destinationViewController];
    controller.user=self.user;
}

//- (IBAction)goMain:(id)sender {
//    UIViewController *mainViewController=[[self storyboard] instantiateViewControllerWithIdentifier:@"mainViewControllerId"];
////     [self presentModalViewController:mainViewController animated:NO];
//    [self presentViewController:mainViewController animated:YES completion:nil];
//}
//- (IBAction)goBack:(id)sender {
//    [self dismissViewControllerAnimated:YES completion:nil];
//}
- (IBAction)sqlRead:(id)sender {
    NSArray *array = [[VariableStore sharedInstance].locationDataAcquisition readSqlEntity];
    NSLog(@"count:%d",[array count]);
    
//    [object setValue:userLocation.userid forKey:@"userid"];
//    [object setValue:userLocation.type forKey:@"type"];
//    [object setValue:userLocation.time forKey:@"time"];
//    [object setValue:userLocation.latitude forKey:@"latitude"];
//    [object setValue:userLocation.longitude forKey:@"longitude"];

    for (NSManagedObject *o in array) {
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSTimeInterval tt=[[o valueForKey:@"time"] longLongValue]/1000;
        NSDate *dd = [NSDate dateWithTimeIntervalSince1970:tt];
        
        NSLog(@"id:%@ type:%@ time:%@ %@ lat:%@ lon:%@",[o valueForKey:@"userid"],[o valueForKey:@"type"],[o valueForKey:@"time"],[dateFormatter stringFromDate:dd],[o valueForKey:@"latitude"],[o valueForKey:@"longitude"]);
    }
    
}

@end
