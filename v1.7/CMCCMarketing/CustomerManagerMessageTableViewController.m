//
//  CustomerManagerMessageTableViewController.m
//  CMCCMarketing
//
//  Created by talkweb on 14-9-22.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//
#import "CustomerManagerMessageTableViewCell.h"
#import "CustomerManagerMessageTableViewController.h"
#import "ForHIsTableViewCell.h"
#import "MBProgressHUD.h"
#import "NetworkHandling.h"
#import "CustomerManagerGroupAddressVerifyViewController.h"
#import "CustomerManagerGroupContactVerifyViewController.h"
@interface CustomerManagerMessageTableViewController ()<MBProgressHUDDelegate>{
//    NSArray *disArray;
//    NSArray *tableArray;
    //主管所需要得数组
//    NSArray *remindTableArray;
//    NSArray *remindWithGroupAddressTableArray;
//    NSArray *remindWithLinkManTableArray;
//    NSArray *remindChnlboosTableArray;
//    NSArray *remindChnlAddTableArray;
    NSDictionary *selectDict;
    NSString *passType;
    NSMutableArray *tableArray;
    BOOL hubFlag;
}

@end

@implementation CustomerManagerMessageTableViewController

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
    //历史消息界面
    [super viewDidLoad];
    
   
    if ([self.fromType isEqualToString:@"11"]) {
        [self loadNewMessage];
    } else {
        hubFlag=YES;
        MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:HUD];
        HUD.delegate=self;
        HUD.labelText=@"数据查询中，请稍后...";
        [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
        [self loadHisRemindData];

    }
    
}
-(void)connectToNetwork{
    while (hubFlag) {
        usleep(100000);
    }
}
#pragma mark -从点击最新提醒按钮过来，加载最新消息接口(不分cs,sy)
-(void)loadNewMessage{
    tableArray=_passArray;
    [self.tableView reloadData];
}
#pragma mark -从点击历史按钮过来，加载历史消息接口(不分cs,sy)
-(void)loadHisRemindData{
    
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    [bDict setObject:[NSNumber numberWithInt:self.user.userID] forKey:@"user_id"];
    [bDict setObject:self.user.userMobile forKey:@"mobile"];
    [bDict setObject:[NSNumber numberWithInt:self.user.userEnterprise] forKey:@"enterprise"];

    NSString *url=@"";
#if (defined MANAGER_CS_VERSION) || (defined MANAGER_SY_VERSION)
    url=@"grpuserlink/hisleaderReminder";
#endif
    
    
#if (defined STANDARD_CS_VERSION) || (defined STANDARD_SY_VERSION)
    url=@"grpuserlink/hisbirthdayReminder";
#endif
    [NetworkHandling sendPackageWithUrl:url sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        if(!error){
            NSLog(@"sign in success");
           #if (defined STANDARD_CS_VERSION) || (defined STANDARD_SY_VERSION)
            tableArray =[result objectForKey:@"Response"];
            #endif
            #if (defined MANAGER_CS_VERSION) || (defined MANAGER_SY_VERSION)

            NSArray *remindWithGroupAddressTableArray=[result objectForKey:@"grp_add"];
            NSArray *remindWithLinkManTableArray=[result objectForKey:@"linkman"];
            NSArray *remindChnlboosTableArray=[result objectForKey:@"chnlboss"];
            NSArray *remindChnlAddTableArray=[result objectForKey:@"chnl_add"];
            
            tableArray=[NSMutableArray new];
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
              
                [tableArray addObject:dict];
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
               
                [tableArray addObject:dict];
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
                [dict setObject:@"渠道新增联系人待审核" forKey:@"type"];
               
                [tableArray addObject:dict];
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
                [tableArray addObject:dict];
            }
            
            #endif
            
            [self performSelectorOnMainThread:@selector(refreshTableView) withObject:nil waitUntilDone:YES];
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
-(void)refreshTableView{
    [self.tableView reloadData];
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
  //  #if (defined STANDARD_CS_VERSION) || (defined STANDARD_SY_VERSION)
    return [tableArray count];
   //#endif
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict=[tableArray objectAtIndex:indexPath.row];
    
#if (defined STANDARD_CS_VERSION) || (defined STANDARD_SY_VERSION)
    static NSString *simpleTableIdentifier = @"CustomerManagerMessageTableViewCell";
    CustomerManagerMessageTableViewCell *cell = (CustomerManagerMessageTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CustomerManagerMessageTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.itemName.text=[dict objectForKey:@"linkman"];
    cell.itemPhone.text=[dict objectForKey:@"linkman_msisdn"];
    cell.itemAddress.text=[dict objectForKey:@"grp_name"];
    

    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    [dateFormatter1 setDateFormat:@"yyyy"];
    
    NSString *newDateString=[dateFormatter1 stringFromDate:[NSDate date]];
    newDateString=[newDateString stringByAppendingString:[[dict objectForKey:@"linkman_birthday"] substringFromIndex:4]];
    
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
    [dateFormatter2 setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *newDate=[dateFormatter2 dateFromString:newDateString];
    
    NSString *nowDateString=[dateFormatter2 stringFromDate:[NSDate date]];
    NSDate *nowDate=[dateFormatter2 dateFromString:nowDateString];
    
    NSTimeInterval secondsBetweenDates=[newDate timeIntervalSinceDate:nowDate];
    int intervalDay=secondsBetweenDates/(24*60*60);
    cell.itemBirthday.text=[dict objectForKey:@"linkman_birthday"];
    cell.itemDate.text=[NSString stringWithFormat:@"%d",intervalDay];
    return cell;

    #endif
    
    #if (defined MANAGER_CS_VERSION) || (defined MANAGER_SY_VERSION)
    //histableviewcell

    
    static NSString *simpleTableIdentifier = @"ForHIsTableViewCell";
    ForHIsTableViewCell *cell2= [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell2 == nil)
    {
        cell2 = [[[NSBundle mainBundle]loadNibNamed:@"ForHIsTableViewCell" owner:nil options:nil]lastObject];
    }
    //cell2
    cell2.companyName.text=[dict objectForKey:@"grp_name"];
    cell2.managerName.text=[dict objectForKey:@"vip_mngr_msisdn"];
    cell2.messageType.text =[dict objectForKey:@"type"];
    cell2.timePrint.text= [dict objectForKey:@"date"];

    return cell2;
   #endif
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    #if (defined MANAGER_CS_VERSION) || (defined MANAGER_SY_VERSION)
    if([[[tableArray objectAtIndex:indexPath.row] objectForKey:@"type"] isEqualToString:@"集团地理位置待审核"]){
        selectDict =[tableArray objectAtIndex:indexPath.row];
        [self performSegueWithIdentifier:@"AddressVerifySegue" sender:self];
    }
    if([[[tableArray objectAtIndex:indexPath.row] objectForKey:@"type"] isEqualToString:@"渠道地理位置待审核"]){
        selectDict =[tableArray objectAtIndex:indexPath.row];
        [self performSegueWithIdentifier:@"AddressVerifySegue" sender:self];
    }

    else if([[[tableArray objectAtIndex:indexPath.row] objectForKey:@"type"] isEqualToString:@"新增关键人待审核"])
    {
         //passType=@"notboss";
        self.listType=0;
        selectDict =[tableArray objectAtIndex:indexPath.row];
        [self performSegueWithIdentifier:@"ContactVerifySegue" sender:self];
    }
    else if([[[tableArray objectAtIndex:indexPath.row] objectForKey:@"type"] isEqualToString:@"渠道新增联系人待审核"])
    {
//        passType=@"boss";
        self.listType=1;
        selectDict =[tableArray objectAtIndex:indexPath.row];
        [self performSegueWithIdentifier:@"ContactVerifySegue" sender:self];
    }

     #endif
}


#pragma mark - Navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 if([segue.identifier isEqualToString:@"AddressVerifySegue"]){
 CustomerManagerGroupAddressVerifyViewController *controller = segue.destinationViewController;
 controller.addrmsgDict=selectDict;
 controller.user=self.user;
 }
      if([segue.identifier isEqualToString:@"ContactVerifySegue"]){
         CustomerManagerGroupContactVerifyViewController *controller = segue.destinationViewController;
         controller.msgDict=selectDict;
         controller.user=self.user;
           controller.listType=self.listType;
         //controller.whichtype=passType;
     }

     NSLog(@"1111111111111");
 }

@end
