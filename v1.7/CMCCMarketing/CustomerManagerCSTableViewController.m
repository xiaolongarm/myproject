//
//  CustomerManagerCSTableViewController.m
//  CMCCMarketing
//
//  Created by kevin on 15/8/13.
//  Copyright (c) 2015年 talkweb. All rights reserved.
//

#import "CustomerManagerCSTableViewController.h"
#import "CustomerManagerViewController.h"
#import "CustomerManagerMessageTableViewController.h"
#import "CustomerManagerMessageWithManageTableViewController.h"
#import "MBProgressHUD.h"
#import "NetworkHandling.h"

@interface CustomerManagerCSTableViewController (){
    NSArray *tableArray;
    UIButton *messageRemindButtonView;
    BOOL hubFlag;
    NSMutableArray *forpasstableArray;
    NSArray *remindTableArray;
    
    NSArray *remindWithGroupAddressTableArray;
    NSArray *remindWithLinkManTableArray;

}

@end

@implementation CustomerManagerCSTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //传递数组初始化
    forpasstableArray =[NSMutableArray new];
    if(IOS7)
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"320X64"] forBarMetrics:UIBarMetricsDefault];
    else
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"320X44"] forBarMetrics:UIBarMetricsDefault];
    
    UIBarButtonItem *leftButton=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回1"] style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    [leftButton setTintColor:[UIColor whiteColor]];
    
    [self.navigationItem setLeftBarButtonItem:leftButton];
    
    UIColor * color = [UIColor whiteColor];
    NSDictionary * dict=[NSDictionary dictionaryWithObject:color forKey:UITextAttributeTextColor];
    [self.navigationController.navigationBar setTitleTextAttributes:dict];
    
    self.title = @"客户管理";
    //查看历史信息button
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"喇叭"] style:UIBarButtonItemStylePlain target:self action:@selector(checkCSMessageRecord)];
    [self.navigationItem setRightBarButtonItem:rightButton];
    
    //查看最新提醒消息button
    messageRemindButtonView=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    [messageRemindButtonView addTarget:self action:@selector(checkCSLastMessage:) forControlEvents:UIControlEventTouchUpInside];
    NSString *remindString=[NSString stringWithFormat:@"您有%d条新消息",0];
    [messageRemindButtonView setTitle:remindString forState:UIControlStateNormal];
    [messageRemindButtonView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.tableView.tableHeaderView =messageRemindButtonView;
    messageRemindButtonView.hidden=YES;
   
//#if (defined MANAGER_CS_VERSION)
            tableArray = [[NSArray alloc] initWithObjects:@"集团客户",@"中小集团客户",@"楼宇信息", nil];
        [self loadCSRemindData];

//#endif
    
//#if (defined STANDARD_CS_VERSION)
//    if([[NSString stringWithFormat:@"%d",self.user.managerRole]   isEqualToString:@"2"])
//    {
//        
//        tableArray = [[NSArray alloc] initWithObjects:@"中小集团客户",@"楼宇信息", nil];
//        // 中小集团要隐藏提醒按钮
//        messageRemindButtonView.hidden=YES;
//    
//    }
//    else
//    {
//         tableArray = [[NSArray alloc] initWithObjects:@"集团客户", nil];
//        //要抓取提醒消息
//        [self loadCSRemindData];
//    }
//    #endif
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark-（喇叭）查看历史消息
-(void)checkCSMessageRecord
{
    
    NSLog(@"查看历史消息");
    //跳转到CustomerManagerMessageTableViewController中
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"CustomerManager" bundle:nil];
    CustomerManagerMessageTableViewController *controller =[storyboard instantiateViewControllerWithIdentifier:@"message"];
    controller.user=self.user;
    [self.navigationController pushViewController:controller animated:YES];
}
#pragma mark-获取最新提醒消息方法
-(void)loadCSRemindData{
    
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    [bDict setObject:[NSNumber numberWithInt:self.user.userID] forKey:@"user_id"];

    [bDict setObject:self.user.userMobile forKey:@"mobile"];
    [bDict setObject:[NSNumber numberWithInt:self.user.userEnterprise] forKey:@"enterprise"];
    
    NSString *url=@"";
    //为主管 时抓取新消息
    #if (defined MANAGER_CS_VERSION)
    url=@"grpuserlink/leaderReminder";
#endif
    
    //为客户经理时抓取新消息
    #if (defined STANDARD_CS_VERSION)

    url=@"grpuserlink/birthdayReminder";
#endif

    
    [NetworkHandling sendPackageWithUrl:url sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        if(!error){
            NSLog(@"sign in successa");
        #if (defined MANAGER_CS_VERSION) 
            remindTableArray =[result objectForKey:@"birthday"];
            remindWithGroupAddressTableArray=[result objectForKey:@"grp_add"];
            remindWithLinkManTableArray=[result objectForKey:@"linkman"];
            
            for (NSDictionary *item in remindTableArray) {
                NSMutableDictionary *dict =[NSMutableDictionary new];
                 [dict setObject:[item objectForKey:@"grp_code"] forKey:@"grp_code"];
                 [dict setObject:[item objectForKey:@"grp_addr"] forKey:@"grp_addr"];
                [dict setObject:[item objectForKey:@"grp_name"] forKey:@"grp_name"];
                [dict setObject:[item objectForKey:@"linkman_birthday"] forKey:@"date"];
                [dict setObject:[item objectForKey:@"vip_mngr_name"] forKey:@"vip_mngr_msisdn"];
                [dict setObject:@"生日提醒" forKey:@"type"];
//                [item objectForKey:@"grp_name"] forKey:@"name"];
//                [item objectForKey:@"grp_name"] forKey:@"name"];
                /**
                 *  需要取到 linkman_msisdn
                 */
                [dict setObject:[item objectForKey:@"linkman_msisdn"] forKey:@"linkman_msisdn"];
                [forpasstableArray addObject:dict];
            }

            for (NSDictionary *item in remindWithGroupAddressTableArray) {
                NSMutableDictionary *dict =[NSMutableDictionary new];
                 [dict setObject:[item objectForKey:@"grp_code"] forKey:@"grp_code"];
                 [dict setObject:[item objectForKey:@"grp_addr"] forKey:@"grp_addr"];
                [dict setObject:[item objectForKey:@"grp_name"] forKey:@"grp_name"];
                [dict setObject:[item objectForKey:@"op_date"] forKey:@"date"];
                [dict setObject:[item objectForKey:@"vip_mngr_name"] forKey:@"vip_mngr_msisdn"];
                [dict setObject:@"集团地理位置待审核" forKey:@"type"];
                [dict setObject:[item objectForKey:@"baidu_latitude"] forKey:@"latitude"];
                [dict setObject:[item objectForKey:@"baidu_longtitude"] forKey:@"longtitude"];
                /**
                 *  需要取到 grp_code,不需要linkman_msisdn
                 */
                [dict setObject:[item objectForKey:@"grp_code"] forKey:@"grp_code"];
//                /**
//                 *  需要取到 linkman_msisdn
//                 */
//                [dict setObject:[item objectForKey:@"linkman_msisdn"] forKey:@"linkman_msisdn"];
                [forpasstableArray addObject:dict];
            }
            
            for (NSDictionary *item in remindWithLinkManTableArray) {
                NSMutableDictionary *dict =[NSMutableDictionary new];
                 [dict setObject:[item objectForKey:@"grp_code"] forKey:@"grp_code"];
//                 [dict setObject:[item objectForKey:@"grp_addr"] forKey:@"grp_addr"];
                [dict setObject:[item objectForKey:@"grp_name"] forKey:@"grp_name"];
                [dict setObject:[item objectForKey:@"op_date"] forKey:@"date"];
                [dict setObject:[item objectForKey:@"vip_mngr_name"] forKey:@"vip_mngr_msisdn"];
                [dict setObject:@"新增关键人待审核" forKey:@"type"];
                 [dict setObject:[item objectForKey:@"row_id"] forKey:@"row_id"];
                /**
                 *  需要取到 linkman_msisdn
                 */
                [dict setObject:[item objectForKey:@"linkman_msisdn"] forKey:@"linkman_msisdn"];
                [forpasstableArray addObject:dict];
            }
            
            

#endif
            
           #if (defined STANDARD_CS_VERSION)
            remindTableArray =[result objectForKey:@"Response"];
            [forpasstableArray setArray:remindTableArray ];
#endif
            [self performSelectorOnMainThread:@selector(refreshCSRemindButton) withObject:nil waitUntilDone:YES];
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
#pragma mark-获取最新提醒消息显示到messageRemindButtonView得标题
-(void)refreshCSRemindButton{
    int count = 0;
 #if (defined MANAGER_CS_VERSION)
    count = [remindTableArray count];
    count += [remindWithGroupAddressTableArray count];
    count += [remindWithLinkManTableArray count];
#endif
    
  #if (defined STANDARD_CS_VERSION)
    count = [remindTableArray count];
#endif

    if(count>0){
        messageRemindButtonView.hidden=NO;
        NSString *remindString=[NSString stringWithFormat:@"您有%d条新消息",count];
        [messageRemindButtonView setTitle:remindString forState:UIControlStateNormal];
    }
    else{
        messageRemindButtonView.hidden=YES;
    }
}

#pragma mark-点击提醒消息按钮
-(void)checkCSLastMessage:(id)sender
{
    NSLog(@"查看最新消息");
    
    //点击提醒按钮，上传已查看该消息
    [self ChangeStaustsRemindData];
}

#pragma mark-上传已查看该消息提醒的接口
-(void)ChangeStaustsRemindData{
    /**
     提交参数：
     user_id	 客户经理ID
     enterprise	客户经理企业编码
     linkman_msisdn 审核联系人电话号码 及 生日提醒客户电话号码，用逗号分隔
     长沙参数：
     grp_code 审核集团地址集团编码，用逗号分隔
     邵阳参数：
     grp_code 审核集团地址集团编码 及 审核渠道地址渠道编码，用逗号分隔
     boss_msisdn 审核渠道老板电话号码，用逗号分隔
     */
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    //审核联系人电话号码 及 生日提醒客户电话号码，用逗号分隔
    [bDict setObject:[NSNumber numberWithInt:self.user.userID] forKey:@"user_id"];
     [bDict setObject:[NSNumber numberWithInt:self.user.userEnterprise] forKey:@"enterprise"];
    
    
    
    NSString *url=@"";
#if (defined MANAGER_CS_VERSION)
    //linkman_msisdn 审核联系人电话号码 及 生日提醒客户电话号码，用逗号分隔
    NSMutableArray *linkmanArray= [NSMutableArray new];
    for (NSDictionary *item in remindTableArray) {
        
        NSString *linkman_msisdnString=[item objectForKey:@"linkman_msisdn"];
        [linkmanArray addObject:linkman_msisdnString];
    }
    for (NSDictionary *item in remindWithLinkManTableArray) {
        
        NSString *linkman_msisdnString=[item objectForKey:@"linkman_msisdn"];
        [linkmanArray addObject:linkman_msisdnString];
    }
    NSString *linkmanmsisdnString=[linkmanArray componentsJoinedByString:@","];
    [bDict setObject:linkmanmsisdnString forKey:@"linkman_msisdn"];
    //grp_code 审核集团地址集团编码，用逗号分隔
    NSMutableArray *grpcodeArray= [NSMutableArray new];
     for (NSDictionary *item in remindWithGroupAddressTableArray) {
        NSString *grp=[item objectForKey:@"grp_code"];
         [grpcodeArray addObject:grp];
     }
     NSString *grpcodeString=[grpcodeArray componentsJoinedByString:@","];
     [bDict setObject:grpcodeString forKey:@"grp_code"];    url=@"grpuserlink/updleaderremindsta";
    
#endif
    
#if (defined STANDARD_CS_VERSION)
    [bDict setObject:self.user.userMobile forKey:@"vip_mngr_msisdn"];
    url=@"grpuserlink/updremindsta";
#endif
    [NetworkHandling sendPackageWithUrl:url sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        if(!error){
            NSLog(@"sign in success");
            //            remindTableArray =[result objectForKey:@"remindUser"];
            BOOL flag=[[result objectForKey:@"flag"] boolValue];
            if(flag)
                [self performSelectorOnMainThread:@selector(remindCSLoadFinished) withObject:nil waitUntilDone:YES];
            else
                [self performSelectorOnMainThread:@selector(showMessage:) withObject:@"查看消息失败！" waitUntilDone:YES];
            
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
#pragma mark-上传已查看消息状态成功后跳转页面
-(void)remindCSLoadFinished{
    messageRemindButtonView.hidden=YES;
    remindTableArray=nil;
    //跳转页面
    //加载需要显示的界面的大storyboard名称（就是storyboard文件名成）
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"CustomerManager" bundle:nil];
    
    //加载需要显示CustomerManagerMessageWithManageTableViewController中的UIStoryboard的ID
    
    CustomerManagerMessageTableViewController *controller =[storyboard instantiateViewControllerWithIdentifier:@"message"];
    controller.user=self.user;
    controller.fromType=@"11";
    
    controller.passArray=forpasstableArray;
    //controller.listType=indexPath.row;CustomerManagerViewControllerId
    [self.navigationController pushViewController:controller animated:YES];
}


-(void)showMessage:(NSString*)infomation{
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"信息提示" message:infomation delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
    [myAlertView show];
}


#pragma mark -navigationController

-(void)goBack{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [tableArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *tableSampleIdentifier = @"reuseIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableSampleIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:tableSampleIdentifier];
    }
    
    cell.textLabel.text = [tableArray objectAtIndex:indexPath.row];
    cell.textLabel.textColor =  [UIColor darkGrayColor];
    cell.accessoryType= UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"CustomerManager" bundle:nil];
    
    CustomerManagerViewController *controller =[storyboard instantiateViewControllerWithIdentifier:@"CustomerManagerViewController"];
    controller.user=self.user;
//    if([[NSString stringWithFormat:@"%d",self.user.managerRole] isEqualToString:@"2"])
//    {
//        //选中中小集团客户那行
//        if (indexPath.row==0 ) {
//            controller.listType=2;
//        }
//        //选中楼宇信息那行
//        if (indexPath.row==1 ) {
//            controller.listType=3;
//        }
//    }
//    else{
    //选中集团客户那行
        if (indexPath.row==0 ){
         controller.listType=0;
        }
        //选中中小集团客户那行
        if (indexPath.row==1 ) {
            controller.listType=2;
        }
        //选中楼宇信息那行
        if (indexPath.row==2 ) {
            controller.listType=3;
        }
   // }
    [self.navigationController pushViewController:controller animated:YES];
}

@end
