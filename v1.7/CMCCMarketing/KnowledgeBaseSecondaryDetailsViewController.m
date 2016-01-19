//
//  KnowledgeBaseSecondaryDetailsViewController.m
//  CMCCMarketing
//
//  Created by talkweb on 14-9-23.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import "KnowledgeBaseSecondaryDetailsViewController.h"
#import "MBProgressHUD.h"
#import "NetworkHandling.h"

@interface KnowledgeBaseSecondaryDetailsViewController ()<MBProgressHUDDelegate>
{
    BOOL hudFlag;
    NSArray *tableviewArray;
}


@end

@implementation KnowledgeBaseSecondaryDetailsViewController

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
    if ([_fromFlag isEqualToString:@"fromsetting"]) {
        self.navigationItem.title=@"最新优惠活动";
        [self loadNewDicsData];
    } else {
        UIBarButtonItem *rightButton=[[UIBarButtonItem alloc]initWithTitle:@"收藏" style:UIBarButtonItemStylePlain target:self action:@selector(CollectionKonwledge)];
        [rightButton setTintColor:[UIColor whiteColor]];
        [self.navigationItem setRightBarButtonItem:rightButton];
        [self InitController];
    }
 
    
    }
-(void)InitController{
    lbNewsTitle.text=[self.detailsDict objectForKey:@"title"];
    //    txtNewsContent.text=[self.detailsDict objectForKey:@"content"];
    [mapView setScalesPageToFit:YES];
    //    [mapView setAutoresizesSubviews:YES];
    [mapView loadHTMLString:[self.detailsDict objectForKey:@"content"] baseURL:nil];

}
-(void)loadNewDicsData{
    
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    //    [bDict setObject:self.user.userMobile forKey:@"mobile"];
    [bDict setObject:[_apiDict objectForKey:@"menu_para"] forKey:@"row_id"];
    
    [NetworkHandling sendPackageWithUrl:@"collect/newdiscList" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        if(!error){
            NSLog(@"sign in success");
           _detailsDict =[[result objectForKey:@"result"]objectAtIndex:0];
            
            [self performSelectorOnMainThread:@selector(InitController) withObject:nil waitUntilDone:YES];
        }
        else{
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

-(void)hudWasHidden:(MBProgressHUD *)hud{
    [hud removeFromSuperview];
    hud=nil;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)CollectionKonwledge{
    /**
     * 1、新增收藏夹记录
     changsha\v1_8\collect\addcollect
     必传参数
     menu_name 菜单名称
     menu_para 参数
     type 类型 1:业务知识，2:最新优惠活动
     user_id 用户id
     返回参数
     flag  true/false
     */
    hudFlag=YES;
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"数据提交中，请稍后...";
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
    
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    [bDict setObject:[self.detailsDict objectForKey:@"title"] forKey:@"menu_name"];

    [bDict setObject:[self.detailsDict objectForKey:@"row_id"]  forKey:@"menu_para"];
    
    [bDict setObject:@"2" forKey:@"type"];
    //所以发送成功的手机号码
    //   user_id 客户经理id
    [bDict setObject:[NSNumber numberWithInt:self.user.userID] forKey:@"user_id"];

//    NSString *Svcodestring = [sendcontactArray componentsJoinedByString:@","];
//    [bDict setObject:Svcodestring forKey:@"svc_codes"];
    
    [NetworkHandling sendPackageWithUrl:@"collect/addcollect" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        if(!error){
            NSLog(@"sign in success");
            BOOL flag=[[result objectForKey:@"flag"] boolValue];
            if(flag)
            {
                [self performSelectorOnMainThread:@selector(showMessage:) withObject:@"收藏成功，可到设置->收藏查看" waitUntilDone:YES];
            }
            else{
                [self performSelectorOnMainThread:@selector(showMessage:) withObject:@"收藏失败" waitUntilDone:YES];
            }
            
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
