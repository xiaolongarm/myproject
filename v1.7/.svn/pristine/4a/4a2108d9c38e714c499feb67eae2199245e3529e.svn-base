//
//  DataAcquisitionNetworkProblemsTableViewController.m
//  CMCCMarketing
//
//  Created by talkweb on 14-9-28.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//
#import "DataAcquisitionNetworkProblemsTableViewCell.h"
#import "DataAcquisitionNetworkProblemsTableViewController.h"
//#import "PreferentialPurchaseSelectGroupViewController.h"

#import "MBProgressHUD.h"
#import "NetworkHandling.h"

#import "PreferentialPurchaseSelectDateTimeViewController.h"
#import "W_VisitPlanAddSelectGroupTableViewController.h"

@interface DataAcquisitionNetworkProblemsTableViewController ()<DataAcquisitionNetworkProblemsTableViewCellDeletate,UIActionSheetDelegate,
//PreferentialPurchaseSelectGroupViewControllerDelegate,
MBProgressHUDDelegate,PreferentialPurchaseSelectDateTimeViewControllerDelegate,VisitPlanAddSelectGroupTableViewControllerDelegate>{
    UIButton *selectedButton;
    
//    PreferentialPurchaseSelectGroupViewController *filterController;
    UIView *backView;
    Group *selectedGroup;
    BOOL hubFlag;
    
      PreferentialPurchaseSelectDateTimeViewController *selectDateTimeViewController;
}

@end

@implementation DataAcquisitionNetworkProblemsTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
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
}
-(void)submitData{
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
    DataAcquisitionNetworkProblemsTableViewCell *cell=(DataAcquisitionNetworkProblemsTableViewCell*)[self.tableView cellForRowAtIndexPath:indexPath];
    NSString *alertMes = nil;
    if ([cell.grounpName.text length] == 0) {
        alertMes = @"请输入集团名称";
    }
    else if ([cell.grounpAddress.text length] == 0) {
        alertMes = @"请输入集团地址";
    }
    else if ([cell.officePart.text length] == 0) {
        alertMes = @"请输入所属部门";
    }
    else if ([cell.testName.text length] == 0) {
        alertMes = @"请输入测试人";
    }
    else if ([cell.testPhoneNumber.text length] != 11) {
        alertMes = @"请输入正确的测试人电话号码";
    }

    else if ([cell.customerName.text length] ==0) {
        alertMes = @"请输入联系人";
    }
    else if ([cell.customPhoneNumber.text length] != 11) {
        alertMes = @"请输入正确的联系人电话";
    }
    else if ([cell.whichBuilding.text length] == 0) {
        alertMes = @"请输入地址栋/单元";
    }
    else if ([cell.whichFloor.text length] == 0) {
        alertMes = @"请输入楼层";
    }
    else if ([cell.psrpName.text length] == 0) {
        alertMes = @"请输入RSPR";
    }
    else if ([cell.sinrName.text length] == 0 ){
        alertMes = @"请输入SINR";
    }
    else if ([cell.pciName.text length] == 0) {
        alertMes = @"请输入pci";
    }
    else if ([cell.cellidName.text length] == 0) {
        alertMes = @"请输入cellid";
    }
    else if ([cell.downloadSpeed.text length] == 0) {
        alertMes = @"请输入下载速度";
    }
    else if ([cell.
              arguementTalk.text length] == 0) {
        alertMes = @"请输入投诉电话";
    }
    else if ([cell.arguementNetwork.text length] == 0) {
        alertMes = @"请输入上网";
    }
    else if ([cell.talkAndNetwork.text length] == 0) {
        alertMes = @"请输入投诉通话/上网";
    }
    if (alertMes) {
        [[[UIAlertView alloc] initWithTitle:@"提示"
                                    message:alertMes
                                   delegate:nil
                          cancelButtonTitle:@"确定"
                          otherButtonTitles: nil] show];
        return;
    }
    
    hubFlag=YES;
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"正在提交数据，请稍后...";
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
    [self postData];
}
-(void)connectToNetwork{
    while (hubFlag) {
        usleep(100000);
    }
}
//  长沙新网络台账接口 (备注：替换原有网络台账)
//changsha\v1_5\datacollect\newNetFault
//必传参数
//user_id
//非必传参数
//dept 部门
//grp_name 集团名称
//grp_add 集团单位详细地址
//link_name 业主联系人
//link_msisdn 业主联系电话
//test_name 测试人
//test_msisdn 测试人电话
//unit 栋/单元
//floor 楼层
//rsrp RSRP
//sinr SINR
//pci pci
//cellid cellid
//down_speed 下载速度
//complaint_gms 投诉通话
//complaint_internet 投诉上网
//complaint_gms_internet 投诉通话/上网
//vip_mngr_name 客户经理姓名
//vip_mngr_msisdn 客户经理手机号码
//visit_id 拜访id
//返回参数
//returnFlag

-(void)postData{
    
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
    DataAcquisitionNetworkProblemsTableViewCell *cell=(DataAcquisitionNetworkProblemsTableViewCell*)[self.tableView cellForRowAtIndexPath:indexPath];
    
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    [bDict setObject:[NSNumber numberWithInt:self.user.userID] forKey:@"user_id"];
    [bDict setObject:self.user.userName forKey:@"vip_mngr_name"];
    [bDict setObject:self.user.userMobile forKey:@"vip_mngr_msisdn"];
    NSString *vp_id = self.visit_id;
    vp_id = vp_id?vp_id:@"";
    [bDict setObject:vp_id forKey:@"visit_id"];
//    [bDict setObject:[NSNumber numberWithInt:self.user.userEnterprise] forKey:@"enterprise"];
    
    [bDict setObject:cell.grounpName.text forKey:@"grp_name"];
    [bDict setObject:cell.grounpAddress.text forKey:@"grp_add"];
   
    [bDict setObject:cell.officePart.text forKey:@"dept"];
    [bDict setObject:cell.testName.text forKey:@"test_name"];
    [bDict setObject:cell.testPhoneNumber.text forKey:@"test_msisdn"];
    [bDict setObject:cell.customerName.text forKey:@"link_name"];
    [bDict setObject:cell.customPhoneNumber.text forKey:@"link_msisdn"];
       [bDict setObject:cell.whichBuilding.text forKey:@"unit"];
    [bDict setObject:cell.whichFloor.text forKey:@"floor"];
    [bDict setObject:cell.psrpName.text forKey:@"rsrp"];
    [bDict setObject:cell.sinrName.text forKey:@"sinr"];
    [bDict setObject:cell.pciName.text forKey:@"pci"];
    [bDict setObject:cell.cellidName.text forKey:@"cellid"];
    [bDict setObject:cell.downloadSpeed.text forKey:@"down_speed"];
    [bDict setObject:cell.arguementTalk.text forKey:@"complaint_gms"];
    [bDict setObject:cell.arguementNetwork.text forKey:@"complaint_internet"];
    [bDict setObject:cell.talkAndNetwork.text forKey:@"complaint_gms_internet"];

    
    [NetworkHandling sendPackageWithUrl:@"datacollect/newNetFault" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        if(!error){
            NSLog(@"sign in success");
            NSDictionary *dict=[result objectForKey:@"Response"];
            BOOL flag=[[dict objectForKey:@"returnFlag"] boolValue];
            if(flag)
                [self performSelectorOnMainThread:@selector(showMessage:) withObject:@"提交信息成功！" waitUntilDone:YES];
            else
                [self performSelectorOnMainThread:@selector(showMessage:) withObject:@"提交信息失败！" waitUntilDone:YES];
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
-(void)refreshRemindButton{
    
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 650;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DataAcquisitionNetworkProblemsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DataAcquisitionNetworkProblemsTableViewCell" forIndexPath:indexPath];
    //去掉选中效果
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate=self;
    return cell;
}

-(void)selectServerity:(id)sender{
    UIActionSheet *actionSheet=[[UIActionSheet alloc] initWithTitle:@"严重程度" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"一般" otherButtonTitles:@"严重",@"非常严重", nil];
    actionSheet.tag=1;
    [actionSheet showInView:self.view];
    selectedButton=sender;
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 0){
        [selectedButton setTitle:@"一般" forState:UIControlStateNormal];
    }
    else if(buttonIndex == 1){
        [selectedButton setTitle:@"严重" forState:UIControlStateNormal];
    }
    else if(buttonIndex == 2){
        [selectedButton setTitle:@"非常严重" forState:UIControlStateNormal];
    }
}

-(void)selectGroup:(id)sender{
    selectedButton=sender;
//    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"BusinessProcess" bundle:nil];
//    filterController=[storyboard instantiateViewControllerWithIdentifier:@"MarketingGroupUserFilterViewControllerId"];
//    filterController.delegate=self;
//    filterController.user=self.user;
//    filterController.group=selectedGroup;
//    CGRect rect=filterController.view.frame;
//    
//    rect.origin.x=10;
//    rect.origin.y=80;
//    rect.size.width=300;
//    rect.size.height=340;
//    
//    filterController.view.frame=rect;
//    filterController.view.layer.borderWidth=1;
//    filterController.view.layer.borderColor=[UIColor colorWithRed:55/255.0 green:132/255.0 blue:173/255.0 alpha:1.0].CGColor;
//    filterController.view.layer.shadowOffset = CGSizeMake(2, 2);
//    filterController.view.layer.shadowOpacity = 0.80;
//    
//    backView=[[UIView alloc] init];
//    backView.backgroundColor=[UIColor blackColor];
//    backView.alpha=0.1;
//    
//    backView.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
//    [[self.view superview]addSubview:backView];
//    [[self.view superview]addSubview:filterController.view];
    
    
    
    W_VisitPlanAddSelectGroupTableViewController *controller=[[W_VisitPlanAddSelectGroupTableViewController alloc] initWithNibName:@"W_VisitPlanAddSelectGroupTableViewController" bundle:nil];
    controller.delegate=self;
    controller.user=self.user;
    controller.tableArray=self.user.groupInfo;
    controller.selectGroup=selectedGroup;
    
    [self.navigationController pushViewController:controller animated:YES];
}

//-(void)preferentialPurchaseSelectGroupViewControllerDidCanceled{
//    [backView removeFromSuperview];
//    [filterController.view removeFromSuperview];
//    
//    backView=nil;
//    filterController=nil;
//}
//-(void)preferentialPurchaseSelectGroupViewControllerDidFinished:(PreferentialPurchaseSelectGroupViewController *)controller{
//    selectedGroup=controller.group;
//    [selectedButton setTitle:selectedGroup.groupName forState:UIControlStateNormal];
//    [self preferentialPurchaseSelectGroupViewControllerDidCanceled];
//}
-(void)visitPlanAddSelectGroupTableViewControllerDidFinished:(W_VisitPlanAddSelectGroupTableViewController *)controller{
    selectedGroup=controller.selectGroup;
    [selectedButton setTitle:selectedGroup.groupName forState:UIControlStateNormal];
}

-(void)selectDate:(id)sender{
    selectedButton=sender;
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"BusinessProcess" bundle:nil];
    selectDateTimeViewController=[storyboard instantiateViewControllerWithIdentifier:@"PreferentialPurchaseSelectDateTimeViewControllerId"];
    selectDateTimeViewController.delegate=self;
    CGRect rect=selectDateTimeViewController.view.frame;
    
    rect.origin.x=0;
    rect.origin.y=[[UIScreen mainScreen] bounds].size.height - 200;
    rect.size.width=320;
    rect.size.height=200;
    
    selectDateTimeViewController.view.frame=rect;
    selectDateTimeViewController.view.layer.borderWidth=1;
    selectDateTimeViewController.view.layer.borderColor=[UIColor colorWithRed:55/255.0 green:132/255.0 blue:173/255.0 alpha:1.0].CGColor;
    selectDateTimeViewController.view.layer.shadowOffset = CGSizeMake(2, 2);
    selectDateTimeViewController.view.layer.shadowOpacity = 0.80;
    
    backView=[[UIView alloc] init];
    backView.backgroundColor=[UIColor blackColor];
    backView.alpha=0.1;
    
    backView.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [self.view addSubview:backView];
    [self.view addSubview:selectDateTimeViewController.view];
    
//    selectDateWithButton=sender;
    
}
-(void)preferentialPurchaseSelectDateTimeViewControllerDidCancel{
    [backView removeFromSuperview];
    [selectDateTimeViewController.view removeFromSuperview];
    
    backView=nil;
    selectDateTimeViewController=nil;
}
-(void)preferentialPurchaseSelectDateTimeViewControllerDidFinished:(PreferentialPurchaseSelectDateTimeViewController *)controller{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString=[dateFormatter stringFromDate:controller.datetimePicker.date];
    [selectedButton setTitle:dateString forState:UIControlStateNormal];
    [self preferentialPurchaseSelectDateTimeViewControllerDidCancel];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
