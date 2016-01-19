//
//  CustomerManagerSYTableViewController.m
//  CMCCMarketing
//
//  Created by talkweb on 15-5-12.
//  Copyright (c) 2015年 talkweb. All rights reserved.
//

#import "CustomerManagerSYTableViewController.h"
#import "CustomerManagerViewController.h"
#import "CustomerManagerMessageTableViewController.h"
#import "CustomerManagerMessageWithManageTableViewController.h"
#import "MBProgressHUD.h"
#import "NetworkHandling.h"

@interface CustomerManagerSYTableViewController (){
    NSArray *tableArray;
    NSMutableArray *forpasstableArray;
    NSArray *remindTableArray;
    NSArray *remindWithGroupAddressTableArray;
    NSArray *remindWithLinkManTableArray;
    NSArray *remindChnlboosTableArray;
    NSArray *remindChnlAddTableArray;
    
    UIButton *messageRemindButtonView;

}

@end

@implementation CustomerManagerSYTableViewController
@synthesize user;

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
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"喇叭"] style:UIBarButtonItemStylePlain target:self action:@selector(checkSYHisMessage)];
    
    [self.navigationItem setRightBarButtonItem:rightButton];
    
    //查看最新提醒消息button
    messageRemindButtonView=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    [messageRemindButtonView addTarget:self action:@selector(checkSYLastMessage:) forControlEvents:UIControlEventTouchUpInside];
    NSString *remindString=[NSString stringWithFormat:@"您有%d条新消息",0];
    [messageRemindButtonView setTitle:remindString forState:UIControlStateNormal];
    [messageRemindButtonView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.tableView.tableHeaderView =messageRemindButtonView;
    messageRemindButtonView.hidden=YES;
    
    
   
    #ifdef MANAGER_SY_VERSION
    
    if ([user.channelManagerInfo count] >0) {
        //为区域经理可以看集团客户,渠道信息
         tableArray = [[NSArray alloc] initWithObjects:@"集团客户",@"渠道信息", nil];
    }
   else
   {
       //其他经理只看集团信息
      tableArray = [[NSArray alloc] initWithObjects:@"集团客户", nil];
   }
    #endif
    
    #ifdef STANDARD_SY_VERSION
    
    if ([user.chnlInfo count] >0)
    {
        tableArray = [[NSArray alloc] initWithObjects:@"集团客户",@"渠道信息", nil];

    }
    else
    {
        tableArray = [[NSArray alloc] initWithObjects:@"集团客户", nil];
    }
   
    #endif
    
    //邵阳客户经理和主管API请求
    [self loadSYRemindData];

    
}

#pragma mark -获取提醒消息方法
-(void)loadSYRemindData{
    
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    [bDict setObject:[NSNumber numberWithInt:self.user.userID] forKey:@"user_id"];
    [bDict setObject:self.user.userMobile forKey:@"mobile"];
    [bDict setObject:[NSNumber numberWithInt:self.user.userEnterprise] forKey:@"enterprise"];
    
    NSString *url=@"";
    //为主管时抓取新消息
#if  (defined MANAGER_SY_VERSION)
    url=@"grpuserlink/leaderReminder";
#endif
    
    //为客户经理时抓取新消息
#if (defined STANDARD_SY_VERSION)
    url=@"grpuserlink/birthdayReminder";
#endif

    [NetworkHandling sendPackageWithUrl:url sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        if(!error){
            NSLog(@"sign in successa");
            #if  (defined MANAGER_SY_VERSION)
            remindTableArray =[result objectForKey:@"birthday"];
            remindWithGroupAddressTableArray=[result objectForKey:@"grp_add"];
            remindWithLinkManTableArray=[result objectForKey:@"linkman"];
           // remindTableArray =[result objectForKey:@"Response"];
            remindChnlboosTableArray=[result objectForKey:@"chnlboss"];
            remindChnlAddTableArray=[result objectForKey:@"chnl_add"];
            
           // forpasstableArray=[NSMutableArray new];
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
                 *  需要取到 linkman_msisdn
                 */
//                [dict setObject:[item objectForKey:@"linkman_msisdn"] forKey:@"linkman_msisdn"];
                [forpasstableArray addObject:dict];
            }
            
            for (NSDictionary *item in remindWithLinkManTableArray) {
                NSMutableDictionary *dict =[NSMutableDictionary new];
                /**
                 *  linkman linkman_sex linkman_msisdn linkman_tel grp_name depart job linkman_birthday is_birthday_remind key_type is_diff_key chinamobile
                 */
                
                [dict setObject:[item objectForKey:@"linkman"] forKey:@"linkman"];
                [dict setObject:[item objectForKey:@"linkman_sex"] forKey:@"linkman_sex"];
                [dict setObject:[item objectForKey:@"linkman_msisdn"] forKey:@"linkman_msisdn"];
                [dict setObject:[item objectForKey:@"depart"] forKey:@"depart"];
                [dict setObject:[item objectForKey:@"job"] forKey:@"job"];
                [dict setObject:[item objectForKey:@"linkman_birthday"] forKey:@"linkman_birthday"];
                [dict setObject:[item objectForKey:@"is_birthday_remind"] forKey:@"is_birthday_remind"];
                [dict setObject:[item objectForKey:@"key_type"] forKey:@"key_type"];
                [dict setObject:[item objectForKey:@"is_diff_key"] forKey:@"is_diff_key"];
                [ dict setObject:[item objectForKey:@"chinamobile"] forKey:@"chinamobile"];
                
                [dict setObject:[item objectForKey:@"row_id"] forKey:@"row_id"];
                
                //
                [dict setObject:[item objectForKey:@"grp_code"] forKey:@"grp_code"];
                
                //                [dict setObject:[item objectForKey:@"grp_addr"] forKey:@"grp_addr"];
                [dict setObject:[item objectForKey:@"grp_name"] forKey:@"grp_name"];
                [dict setObject:[item objectForKey:@"op_date"] forKey:@"date"];
                
                [dict setObject:[item objectForKey:@"vip_mngr_name"] forKey:@"vip_mngr_msisdn"];
                [dict setObject:@"新增关键人待审核" forKey:@"type"];

                [forpasstableArray addObject:dict];
            }
            
            for (NSDictionary *item in remindChnlboosTableArray) {
                NSMutableDictionary *dict =[NSMutableDictionary new];
                /**
                 *
                 */
                [dict setObject:[item objectForKey:@"boss_name"] forKey:@"boss_name"];
                [dict setObject:[item objectForKey:@"boss_sex"] forKey:@"boss_sex"];
                [dict setObject:[item objectForKey:@"boss_msisdn"] forKey:@"boss_msisdn"];
                [dict setObject:[item objectForKey:@"boss_tel"] forKey:@"boss_tel"];
                [dict setObject:[item objectForKey:@"boss_birthday"] forKey:@"boss_birthday"];
                [dict setObject:[item objectForKey:@"is_birthday_remind"] forKey:@"is_birthday_remind"];
                [dict setObject:[item objectForKey:@"is_diff_key"] forKey:@"is_diff_key"];
                [ dict setObject:[item objectForKey:@"chinamobile"] forKey:@"chinamobile"];
                [dict setObject:[item objectForKey:@"row_id"] forKey:@"row_id"];
                //                 [dict setObject:[item objectForKey:@"grp_code"] forKey:@"grp_code"];
                //                 [dict setObject:[item objectForKey:@"grp_addr"] forKey:@"grp_addr"];
                [dict setObject:[item objectForKey:@"chnl_name"] forKey:@"grp_name"];
                [dict setObject:[item objectForKey:@"op_date"] forKey:@"date"];
                [dict setObject:[item objectForKey:@"vip_mngr_name"] forKey:@"vip_mngr_msisdn"];
                [dict setObject:@"渠道新增联系人待审核" forKey:@"type"];                [forpasstableArray addObject:dict];
            }
            
            for (NSDictionary *item in remindChnlAddTableArray) {
                NSMutableDictionary *dict =[NSMutableDictionary new];
                [dict setObject:[item objectForKey:@"chnl_code"] forKey:@"grp_code"];
                [dict setObject:[item objectForKey:@"grp_addr"] forKey:@"grp_addr"];
                [dict setObject:[item objectForKey:@"chnl_name"] forKey:@"grp_name"];
                [dict setObject:[item objectForKey:@"op_date"] forKey:@"date"];
                [dict setObject:[item objectForKey:@"vip_mngr_name"] forKey:@"vip_mngr_msisdn"];
                [dict setObject:@"渠道地理位置待审核" forKey:@"type"];
                [dict setObject:[item objectForKey:@"baidu_latitude"] forKey:@"latitude"];
                [dict setObject:[item objectForKey:@"baidu_longtitude"] forKey:@"longtitude"];
                //                /**
                //                 *  需要取到 linkman_msisdn
                //                 */
                //                [dict setObject:[item objectForKey:@"linkman_msisdn"] forKey:@"linkman_msisdn"];

                [forpasstableArray addObject:dict];
            }

            
            #endif
            
            #if (defined STANDARD_SY_VERSION)
            remindTableArray =[result objectForKey:@"Response"];
            [forpasstableArray setArray:remindTableArray ];
            

            #endif
            [self performSelectorOnMainThread:@selector(refreshSYRemindButton) withObject:nil waitUntilDone:YES];
        }
        else{
            int errorCode=[[result valueForKey:@"errorcode"] intValue];
            NSString *errorInfo=[result valueForKey:@"errorinf"];
            if(!errorInfo)
                errorInfo=@"提交数据出错了！";
            NSLog(@"error:%d info:%@",errorCode,errorInfo);
            [self performSelectorOnMainThread:@selector(showMessage:) withObject:errorInfo waitUntilDone:YES];
        }
       // hubFlag=NO;
    }];
}

-(void)refreshSYRemindButton{
    int count = 0;
#if  (defined MANAGER_SY_VERSION)
    count = [remindTableArray count];
    count += [remindWithGroupAddressTableArray count];
    count += [remindWithLinkManTableArray count];
    count += [remindChnlboosTableArray count];
    count += [remindChnlAddTableArray count];
#endif
    
#if (defined STANDARD_SY_VERSION)
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


-(void)showMessage:(NSString*)infomation{
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"信息提示" message:infomation delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
    [myAlertView show];
}

#pragma mark-点击查看最新消息
-(void)checkSYLastMessage:(id)sender
{
    NSLog(@"查看最新消息");
    
    //点击提醒按钮，上传已查看该消息
    [self ChangeStaustsSYRemindData];
    
    }
#pragma mark-上传已查看该消息提醒的接口
-(void)ChangeStaustsSYRemindData{
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    /**
     *  a)	提交参数：
     user_id	 客户经理ID
     enterprise	客户经理企业编码
     linkman_msisdn 审核联系人电话号码 及 生日提醒客户电话号码，用逗号分隔
     长沙参数：
     grp_code 审核集团地址集团编码，用逗号分隔
     邵阳参数：
     grp_code 审核集团地址集团编码 及 审核渠道地址渠道编码，用逗号分隔
     boss_msisdn 审核渠道老板电话号码，用逗号分隔
     */
    [bDict setObject:self.user.userMobile forKey:@"vip_mngr_msisdn"];
    [bDict setObject:[NSNumber numberWithInt:self.user.userEnterprise] forKey:@"enterprise"];
    
    NSString *url=@"";
#if (defined MANAGER_SY_VERSION)
    url=@"grpuserlink/updleaderremindsta";
    ///linkman_msisdn 审核联系人电话号码 及 生日提醒客户电话号码，用逗号分隔
    NSMutableArray *linkmanArray= [NSMutableArray new];
    for (NSDictionary *item in remindTableArray) {
        
        
        [linkmanArray addObject:[item objectForKey:@"linkman_msisdn"]];
    }
    for (NSDictionary *item in remindWithLinkManTableArray) {
        
        [linkmanArray addObject:[item objectForKey:@"linkman_msisdn"]];
    }
    NSString *linkmanmsisdnString=[linkmanArray componentsJoinedByString:@","];
    [bDict setObject:linkmanmsisdnString forKey:@"linkman_msisdn"];
    //grp_code 审核集团地址集团编码，用逗号分隔
    NSMutableArray *grpcodeArray= [NSMutableArray new];
    
    for (NSDictionary *item in remindWithGroupAddressTableArray) {
        [grpcodeArray addObject:[item objectForKey:@"grp_code"]];
    }
    for (NSDictionary *item in remindChnlAddTableArray) {
       [grpcodeArray addObject:[item objectForKey:@"grp_code"]];
    }

    NSString *grpcodeString=[grpcodeArray componentsJoinedByString:@","];
    [bDict setObject:grpcodeString forKey:@"grp_code"];
    
    // boss_msisdn 审核渠道老板电话号码，用逗号分隔
    NSMutableArray *gboss_msisdnArray= [NSMutableArray new];
    for (NSDictionary *item in remindChnlboosTableArray) {
        
        [gboss_msisdnArray addObject:[item objectForKey:@"boss_msisdn"]];
    }
    NSString *gbossmsisdnArrayString=[gboss_msisdnArray componentsJoinedByString:@","];
    [bDict setObject:gbossmsisdnArrayString forKey:@"boss_msisdn"];
  #endif
    
#if (defined STANDARD_SY_VERSION)
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
                [self performSelectorOnMainThread:@selector(showMessage:) withObject:@"查看消息失败" waitUntilDone:YES];
            
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

#pragma mark-查看历史消息
-(void)checkSYHisMessage
{
    
     NSLog(@"查看历史消息");
    //跳转到CustomerManagerMessageTableViewController中
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"CustomerManager" bundle:nil];
    CustomerManagerMessageTableViewController *controller =[storyboard instantiateViewControllerWithIdentifier:@"message"];
    controller.user=self.user;
    //controller.listType=indexPath.row;CustomerManagerViewControllerId
    [self.navigationController pushViewController:controller animated:YES];}

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
    controller.listType=indexPath.row;
    [self.navigationController pushViewController:controller animated:YES];
}


@end
