//
//  VisitPlanAddViewController.m
//  CMCCMarketing
//
//  Created by talkweb on 14-9-24.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import "VisitPlanAddViewController.h"
#import "MBProgressHUD.h"
#import "NetworkHandling.h"

#import "VisitPlanAddSelectGroupTableViewController.h"
#import "VisitPlanAddSelectGroupContactUserTableViewController.h"
#import "Group.h"

@interface VisitPlanAddViewController ()<MBProgressHUDDelegate,UITextViewDelegate,VisitPlanAddSelectGroupTableViewControllerDelegate,VisitPlanAddSelectGroupContactUserTableViewControllerDelegate>{
    BOOL hubFlag;
    Group *selectGroup;
    NSArray *groupContactUserList;
    NSDictionary *selectGroupContactUserDict;
}

@end

@implementation VisitPlanAddViewController

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
    
    lbUserName.text=self.user.userName;
    
    UIBarButtonItem *rightButton=[[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(addVisitPlan)];
    [rightButton setTintColor:[UIColor whiteColor]];
    [self.navigationItem setRightBarButtonItem:rightButton];
    
    txtContent.layer.borderColor=[UIColor lightGrayColor].CGColor;
    txtContent.layer.borderWidth=1;
    txtContent.layer.cornerRadius=3;
    txtContent.layer.masksToBounds=YES;
    
    txtContent.delegate=self;
}
-(void)testShow{
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"信息提示" message:@"test show" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
    [myAlertView show];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)connectToNetwork{
    while (hubFlag) {
        usleep(100000);
    }
}
-(void)addVisitPlan{
    hubFlag=YES;
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"数据查询中，请稍后...";
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
    [self postData];
}

//visit_grp_code 集团编码
//client_os 系统类型:ios
//visit_grp_name 集团名称
//visit_statr_time 拜访开始时间
//visit_end_time 拜访结束时间
//group_type_name 集团单位类别
//visit_grp_add 拜访地址
//linkman 联系人 格式"名字1,名字2" 最多三个三个关键联系人
//linkman_msisdn 联系人电话 联系人电话 格式与联系人一致
//vip_mngr_name 集团经理
//vip_mngr_msisdn 集团经理电话
//user_id 用户编码
//enterprise 企业编码
//longitude 经度
//latitude 维度
//baidu_latitude 百度维度
//baidu_longitude 百度经度
//非必传
//accman 陪同人 格式"名字1,名字2" 最多三个陪同人
//accman_msisdn 陪同人电话 格式与陪同人一致
//返回参数
//flag:true/false 成功或失败

-(void)postData{
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    
    [NetworkHandling sendPackageWithUrl:@"visitplan\addvisitplan" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        if(!error){
            NSLog(@"sign in success");
            //            remindTableArray =[result objectForKey:@"remindUser"];
            BOOL flag=[[result objectForKey:@"flag"] boolValue];
            if(flag)
                [self performSelectorOnMainThread:@selector(remindLoadFinished) withObject:nil waitUntilDone:YES];
            else
                [self performSelectorOnMainThread:@selector(showMessage:) withObject:@"状态变更失败！" waitUntilDone:YES];
            
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
-(void)loadGroupContactUser{
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    [bDict setObject:selectGroup.groupId forKey:@"grp_code"];
    [bDict setObject:[NSNumber numberWithInt:self.user.userEnterprise] forKey:@"enterprise"];
    
    [NetworkHandling sendPackageWithUrl:@"grpuserlink/getUserInfoList" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        if(!error){
            NSLog(@"sign in success");
 
            groupContactUserList =[result objectForKey:@"Response"];
            [self performSelectorOnMainThread:@selector(goSelectGroupContactUser) withObject:nil waitUntilDone:YES];

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
-(void)goSelectGroupContactUser{
     [self performSegueWithIdentifier:@"VisitPlanAddSelectGroupContactUserSegue" sender:self];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqual:@"VisitPlanAddSelectGroupSegue"]){
        VisitPlanAddSelectGroupTableViewController *controller=segue.destinationViewController;
        controller.delegate=self;
        controller.tableArray=self.user.groupInfo;
        controller.selectGroup=selectGroup;
    }
    if([segue.identifier isEqual:@"VisitPlanAddSelectGroupContactUserSegue"]){
        VisitPlanAddSelectGroupContactUserTableViewController *controller=segue.destinationViewController;
        controller.tableArray=groupContactUserList;
        controller.selectUserDict=selectGroupContactUserDict;
        controller.delegate=self;
    }
    
}


- (IBAction)selectGroupOnclick:(id)sender {
    [self performSegueWithIdentifier:@"VisitPlanAddSelectGroupSegue" sender:self];
}
- (IBAction)selectGroupContactUserOnclick:(id)sender {
    if(!selectGroup)
        return;
    
    if(selectGroupContactUserDict){
        [self performSegueWithIdentifier:@"VisitPlanAddSelectGroupContactUserSegue" sender:self];
        return;
    }
    
    hubFlag=YES;
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"数据查询中，请稍后...";
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
    
    [self loadGroupContactUser];
//    [self performSegueWithIdentifier:@"VisitPlanAddSelectGroupContactUserSegue" sender:self];
}

- (IBAction)selectAccompanyUserOnclick:(id)sender {
}
- (IBAction)selectAddressOnclick:(id)sender {
}
- (IBAction)selectStartTimeOnclick:(id)sender {
}
- (IBAction)selectEndTimeOnclick:(id)sender {
}


#pragma mark - select delegate
-(void)visitPlanAddSelectGroupTableViewControllerDidFinished:(VisitPlanAddSelectGroupTableViewController *)controller{
    if(![selectGroup.groupId isEqualToString:controller.selectGroup.groupId] && selectGroupContactUserDict)
        selectGroupContactUserDict=nil;
    selectGroup=controller.selectGroup;
//    [btGroup setTitle:selectGroup.groupName forState:UIControlStateNormal];
    lbGroup.text=selectGroup.groupName;
}
-(void)visitPlanAddSelectGroupContactUserTableViewControllerDidFinished:(VisitPlanAddSelectGroupContactUserTableViewController *)controller{
    selectGroupContactUserDict=controller.selectUserDict;
//    [btContactUser setTitle:[selectGroupContactUserDict objectForKey:@"linkman"] forState:UIControlStateNormal];
    lbContactUser.text=[selectGroupContactUserDict objectForKey:@"linkman"];
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    CGRect rect=self.view.frame;
    rect.origin.y-=200;
    self.view.frame=rect;
    return YES;
}
-(BOOL)textViewShouldEndEditing:(UITextView *)textView{
    CGRect rect=self.view.frame;
    rect.origin.y+=200;
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
@end
