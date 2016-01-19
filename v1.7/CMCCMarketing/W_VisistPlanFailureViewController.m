//
//  W_VisistPlanFailureViewController.m
//  CMCCMarketing
//
//  Created by gmj on 14-11-27.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import "W_VisistPlanFailureViewController.h"
#import "W_VisitPlanDetailsViewController.h"

#import "NetworkHandling.h"
#import "MBProgressHUD.h"

@interface W_VisistPlanFailureViewController ()<MBProgressHUDDelegate>{
    
    BOOL hubFlag;
}

@end

@implementation W_VisistPlanFailureViewController

#pragma mark - UITextView delegate

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
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}

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
    // Do any additional setup after loading the view from its nib.
    [self initSubView];
}

-(void)initSubView{
    
    self.navigationItem.title = @"失访";
    UIBarButtonItem *rightButton=[[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(submitFailure)];
    [rightButton setTintColor:[UIColor whiteColor]];
    [self.navigationItem setRightBarButtonItem:rightButton];
    
    self.txtViewContent.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.txtViewContent.layer.borderWidth=1;
    self.txtViewContent.layer.cornerRadius=3;
    self.txtViewContent.layer.masksToBounds=YES;
    self.txtViewContent.delegate=self;
    
    self.lblVip_mngr_name.text = [self.dicSelectVisitPlanDetail objectForKey:@"vip_mngr_name"];
    self.lblLinkman.text = [self.dicSelectVisitPlanDetail objectForKey:@"linkman"];
    self.lblVip_mngr_name.text = [self.dicSelectVisitPlanDetail objectForKey:@"vip_mngr_name"];
    self.lblVip_mngr_msisdn.text = [self.dicSelectVisitPlanDetail objectForKey:@"vip_mngr_msisdn"];
    self.lblVisit_grp_add.text = [self.dicSelectVisitPlanDetail objectForKey:@"visit_grp_add"];
    
}

-(void)submitFailure{
    
    [self addFailureData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)toVisitPlanDetailOnClick:(id)sender{
    
    W_VisitPlanDetailsViewController *vc = [[W_VisitPlanDetailsViewController alloc] initWithNibName:@"W_VisitPlanDetailsViewController" bundle:nil];
    vc.user = self.user;
    vc.dicSelectVisitPlanDetail = self.dicSelectVisitPlanDetail;
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)showMessage:(NSString*)infomation{
    
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"信息提示" message:infomation delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
    [myAlertView show];
}

-(void)connectToNetwork{
    
    while (hubFlag) {
        usleep(100000);
    }
}

-(void)addFailureData{
    
    hubFlag=YES;
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"数据提交中，请稍后...";
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
    
    /*
     
     enterprise企业编码
     visit_id拜访计划id
     client_os "ios"
     user_lvl用户级别
     reply_name回复人名字
     reply_msisdn回复人电话
     reply_content回复内容
     reply_user_id回复人id
     
     */
    
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    [bDict setObject:[NSNumber numberWithInt:self.user.userEnterprise] forKey:@"enterprise"];
    int uid = self.user.userID;
    NSString *reply_user_id = [NSString stringWithFormat:@"%d",uid];
    [bDict setObject:reply_user_id forKey:@"user_id"];
    
    NSString *visit_id = [self.dicSelectVisitPlanDetail objectForKey:@"row_id"];
    [bDict setObject:visit_id forKey:@"row_id"];
    NSString *client_os = @"ios";
    [bDict setObject:client_os forKey:@"client_os"];
    
    NSString *visit_remark =self.txtViewContent.text;//失访原因
    [bDict setObject:visit_remark forKey:@"visit_remark"];
    NSString *img_url = @"";
    [bDict setObject:img_url forKey:@"img_url"];
    NSString *visit_sta = @"3";
    [bDict setObject:visit_sta forKey:@"visit_sta"];
    

    [NetworkHandling sendPackageWithUrl:@"visitplan/addvisitplanresult" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        hubFlag=NO;
        if(!error){
            
            NSLog(@"sign in success");
            BOOL flag=[[result objectForKey:@"flag"] boolValue];
            if(flag){
                
                [self performSelectorOnMainThread:@selector(showMessage:) withObject:@"提交成功！" waitUntilDone:YES];
                
            }else{
                
                [self performSelectorOnMainThread:@selector(showMessage:) withObject:@"提交失败！" waitUntilDone:YES];
            }
            
        }else{
            
            int errorCode=[[result valueForKey:@"errorcode"] intValue];
            NSString *errorInfo=[result valueForKey:@"errorinf"];
            if(!errorInfo)
                errorInfo=@"提交数据出错了！";
            NSLog(@"error:%d info:%@",errorCode,errorInfo);
            [self performSelectorOnMainThread:@selector(showMessage:) withObject:errorInfo waitUntilDone:YES];
        }
        
    }];
}

@end
