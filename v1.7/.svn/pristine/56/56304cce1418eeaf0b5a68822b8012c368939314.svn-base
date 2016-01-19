//
//  CustomersWarningWithGroupIndicatorsViewController.m
//  CMCCMarketing
//
//  Created by talkweb on 14-9-23.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import "CustomersWarningWithGroupIndicatorsViewController.h"
#import "CustomersWarningWithGroupIndicatorsTableViewCell.h"
#import "MBProgressHUD.h"
#import "NetworkHandling.h"

#import "CustomersWarningWithGroupInformationViewController.h"
#import "CustomersWarningFollowUpViewController.h"
#import "CustomersWarningFollowUpHistoryTableViewController.h"

@interface CustomersWarningWithGroupIndicatorsViewController ()<MBProgressHUDDelegate>{
    BOOL hubFlag;
    NSDictionary *groupDetails;

    NSString *queryMonth;
    int queryPreMonthNumber;
}

@end

@implementation CustomersWarningWithGroupIndicatorsViewController

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
    indicatorsTableView.dataSource=self;
    indicatorsTableView.delegate=self;
    indicatorsTableView.separatorStyle=UITableViewCellSeparatorStyleNone;

    UIBarButtonItem *rightButton=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"详细信息"] style:UIBarButtonItemStylePlain target:self action:@selector(goGroupInformation)];
    [rightButton setTintColor:[UIColor whiteColor]];
    [self.navigationItem setRightBarButtonItem:rightButton];
    
    self.title=[self.groupDict objectForKey:@"grp_name"];
    
#if (defined MANAGER_CS_VERSION) || (defined MANAGER_SY_VERSION)
    btProgressReply.hidden=YES;
#endif
    
    queryPreMonthNumber=1;
//    queryMonth=[self getPriousorLaterDateFromDate:[NSDate date] withMonth:-queryPreMonthNumber];
//    lbMonth.text=[NSString stringWithFormat:@"%@%@",[[queryMonth substringToIndex:4] stringByAppendingString:@"年"],[[queryMonth substringFromIndex:4] stringByAppendingString:@"月"]];
    

    queryMonth=self.queryTime;
    
    NSRange yearRange;
    yearRange.length=4;
    yearRange.location=0;
    
    NSRange monRange;
    monRange.length=2;
    monRange.location=4;
    
//    NSRange dateRange;
//    dateRange.length=2;
//    dateRange.location=6;
    
    NSString *year=[queryMonth substringWithRange:yearRange];
    NSString *month=[queryMonth substringWithRange:monRange];
//    NSString *date=[queryMonth substringWithRange:dateRange];

//    lbMonth.text=[NSString stringWithFormat:@"%@年 %@月%@日",year,month,date];
    lbMonth.text=[NSString stringWithFormat:@"%@年 %@月",year,month];
    
    hubFlag=YES;
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"数据查询中，请稍后...";
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
    [self loadTableViewData];
    
}
-(void)connectToNetwork{
    while (hubFlag) {
        usleep(100000);
    }
}
-(void)goGroupInformation{
    [self performSegueWithIdentifier:@"CustomersWarningWithGroupInformationSegue" sender:self];
}
//{
//    “enterprise”:企业编码  [必传参数],
//    “mobile”:手机号      [必传参数],
//    “user_lvl”:用户级别    [必传参数],
//    “user_id”:用户ID      [必传参数],
//    “time_id”:时间      [必传参数]
//    “grp_code”:集团编码      [必传参数]
//    
//}
-(void)loadTableViewData{
    
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    [bDict setObject:self.user.userMobile forKey:@"mobile"];
    [bDict setObject:[NSNumber numberWithInt:self.user.userEnterprise] forKey:@"enterprise"];
    [bDict setObject:[NSNumber numberWithInt:self.user.userID] forKey:@"user_id"];
    [bDict setObject:[NSNumber numberWithInt:self.user.userLvl] forKey:@"user_lvl"];
    [bDict setObject:queryMonth forKey:@"time_id"];
    [bDict setObject:[self.groupDict objectForKey:@"grp_code"] forKey:@"grp_code"];
    
    [NetworkHandling sendPackageWithUrl:@"gprwarn/grpList" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        if(!error){
            NSLog(@"sign in success");
            groupDetails =[result objectForKey:@"Response"];
            
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
    [indicatorsTableView reloadData];
    if([groupDetails count]>0)
        lbCustomerManager.text=[groupDetails objectForKey:@"vip_mngr_name"];
    else
        lbCustomerManager.text=@"无";
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

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString *groupcode=[self.groupDict objectForKey:@"grp_code"];
    
    if([segue.identifier isEqualToString:@"CustomersWarningWithGroupInformationSegue"]){
        CustomersWarningWithGroupInformationViewController *controller=segue.destinationViewController;
        controller.groupDetails = groupDetails;
#if (defined MANAGER_CS_VERSION) || (defined MANAGER_SY_VERSION)
        for (CustomerManager *cm in self.user.customerManagerInfo) {
            for (Group *group in cm.groupList) {
                if([groupcode isEqualToString:group.groupId]){
                    controller.group=group;
                    break;
                }
            }
        }
#endif
        
#if (defined STANDARD_CS_VERSION) || (defined STANDARD_SY_VERSION)
        for (Group *group in self.user.groupInfo) {
            if([groupcode isEqualToString:group.groupId]){
                controller.group=group;
                break;
            }
        }
#endif
    }
    if([segue.identifier isEqualToString:@"CustomersWarningFollowUpWithGroupSegue"]){
        CustomersWarningFollowUpViewController *controller=segue.destinationViewController;
        controller.user=self.user;
        
#if (defined MANAGER_CS_VERSION) || (defined MANAGER_SY_VERSION)
        for (CustomerManager *cm in self.user.customerManagerInfo) {
            for (Group *group in cm.groupList) {
                if([groupcode isEqualToString:group.groupId]){
                    controller.group=group;
                    break;
                }
            }
        }
#endif
        
#if (defined STANDARD_CS_VERSION) || (defined STANDARD_SY_VERSION)
        for (Group *group in self.user.groupInfo) {
            if([groupcode isEqualToString:group.groupId]){
                controller.group=group;
                break;
            }
        }
#endif
        
    }
    
    if([segue.identifier isEqualToString:@"CustomersWarningFollowUpHistoryWithGroupSegue"]){
        CustomersWarningFollowUpHistoryTableViewController *controller=segue.destinationViewController;
        controller.user=self.user;
        controller.groupDict=self.groupDict;
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 21;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 25;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomersWarningWithGroupIndicatorsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CustomersWarningWithGroupIndicatorsTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    NSArray *thresholds;
    
    if(groupDetails && [groupDetails count] > 0)
        thresholds=[groupDetails objectForKey:@"thresholds"];

    switch (indexPath.row) {
        case 0:
            cell.itemTitle.text=@"拍照成员基数:";
            if(groupDetails&&[groupDetails count]>0)
            cell.itemValue.text=[groupDetails objectForKey:@"photo_user_cnt"];
            else
                cell.itemValue.text=@"-";
            cell.itemImageView.hidden =![thresholds containsObject:@"photo_user_cnt"];
            
            break;
            
    case 1:
    cell.itemTitle.text=@"在网用户数:";
            if(groupDetails&&[groupDetails count]>0)
    cell.itemValue.text=[groupDetails objectForKey:@"innetwork_user_cnt"];
            else
                cell.itemValue.text=@"-";
            cell.itemImageView.hidden =![thresholds containsObject:@"innetwork_user_cnt"];
    break;
    case 2:
    cell.itemTitle.text=@"离网用户数:";
            if(groupDetails&&[groupDetails count]>0)
    cell.itemValue.text=[groupDetails objectForKey:@"outnetword_user_cnt"];
            else
                cell.itemValue.text=@"-";
            cell.itemImageView.hidden =![thresholds containsObject:@"outnetword_user_cnt"];
    break;
            
        case 3:
            cell.itemTitle.text=@"累计离网率:";
            if(groupDetails&&[groupDetails count]>0)
                cell.itemValue.text=[groupDetails objectForKey:@"outnetword_user_cnt_per"];
            else
                cell.itemValue.text=@"-";
            cell.itemImageView.hidden =![thresholds containsObject:@"outnetword_user_cnt_per"];
            break;

            
    case 4:
    cell.itemTitle.text=@"注销客户数:";
            if(groupDetails&&[groupDetails count]>0)
    cell.itemValue.text=[groupDetails objectForKey:@"cancellation_user_cnt"];
            else
                cell.itemValue.text=@"-";
            cell.itemImageView.hidden =![thresholds containsObject:@"cancellation_user_cnt"];
    break;
            
            
    case 5:
    cell.itemTitle.text=@"零次用户数:";
            if(groupDetails&&[groupDetails count]>0)
    cell.itemValue.text=[groupDetails objectForKey:@"zero_user_cnt"];
            else
                cell.itemValue.text=@"-";
            cell.itemImageView.hidden =![thresholds containsObject:@"zero_user_cnt"];
    break;
    case 6:
    cell.itemTitle.text=@"日均收入:";
            if(groupDetails&&[groupDetails count]>0)
    cell.itemValue.text=[groupDetails objectForKey:@"m_avg_fee"];
            else
                cell.itemValue.text=@"-";
            cell.itemImageView.hidden =![thresholds containsObject:@"m_avg_fee"];
    break;
    case 7:
    cell.itemTitle.text=@"日均收入占比:";
            if(groupDetails&&[groupDetails count]>0)
    cell.itemValue.text=[groupDetails objectForKey:@"m_avg_fee_per"];
            else
                cell.itemValue.text=@"-";
            cell.itemImageView.hidden =![thresholds containsObject:@"m_avg_fee_per"];
    break;
    case 8:
    cell.itemTitle.text=@"日均通话时长:";
            if(groupDetails&&[groupDetails count]>0)
    cell.itemValue.text=[groupDetails objectForKey:@"m_avg_dur"];
            else
                cell.itemValue.text=@"-";
            cell.itemImageView.hidden =![thresholds containsObject:@"m_avg_dur"];
    break;
    case 9:
    cell.itemTitle.text=@"日均通话时长占比:";
            if(groupDetails&&[groupDetails count]>0)
    cell.itemValue.text=[groupDetails objectForKey:@"m_avg_dur_per"];
            else
                cell.itemValue.text=@"-";
            cell.itemImageView.hidden =![thresholds containsObject:@"m_avg_dur_per"];
    break;
    case 10:
    cell.itemTitle.text=@"APRU:";
            if(groupDetails&&[groupDetails count]>0)
    cell.itemValue.text=[groupDetails objectForKey:@"arpu"];
            else
                cell.itemValue.text=@"-";
            cell.itemImageView.hidden =![thresholds containsObject:@"arpu"];
    break;
    case 11:
    cell.itemTitle.text=@"APRU环比:";
            if(groupDetails&&[groupDetails count]>0)
    cell.itemValue.text=[groupDetails objectForKey:@"arpu_per"];
            else
                cell.itemValue.text=@"-";
            cell.itemImageView.hidden =![thresholds containsObject:@"arpu_per"];
    break;
    case 12:
    cell.itemTitle.text=@"DOU:";
            if(groupDetails&&[groupDetails count]>0)
    cell.itemValue.text=[groupDetails objectForKey:@"dou"];
            else
                cell.itemValue.text=@"-";
            cell.itemImageView.hidden =![thresholds containsObject:@"dou"];
    break;
    case 13:
    cell.itemTitle.text=@"DOU环比:";
            if(groupDetails&&[groupDetails count]>0)
    cell.itemValue.text=[groupDetails objectForKey:@"dou_per"];
            else
                cell.itemValue.text=@"-";
            cell.itemImageView.hidden =![thresholds containsObject:@"dou_per"];
    break;
    case 14:
    cell.itemTitle.text=@"4g终端渗透率:";
            if(groupDetails&&[groupDetails count]>0)
    cell.itemValue.text=[groupDetails objectForKey:@"infiltration_term_4g_per"];
            else
                cell.itemValue.text=@"-";
            cell.itemImageView.hidden =![thresholds containsObject:@"infiltration_term_4g_per"];
    break;
    case 15:
    cell.itemTitle.text=@"4g终端渗透率环比:";
            if(groupDetails&&[groupDetails count]>0)
    cell.itemValue.text=[groupDetails objectForKey:@"term_4g_ring_per"];
            else
                cell.itemValue.text=@"-";
            cell.itemImageView.hidden =![thresholds containsObject:@"term_4g_ring_per"];
    break;
    case 16:
    cell.itemTitle.text=@"4g用户渗透率:";
            if(groupDetails&&[groupDetails count]>0)
    cell.itemValue.text=[groupDetails objectForKey:@"infiltration_user_4g_per"];
            else
                cell.itemValue.text=@"-";
            cell.itemImageView.hidden =![thresholds containsObject:@"infiltration_user_4g_per"];
    break;
    case 17:
    cell.itemTitle.text=@"4g用户渗透率环比:";
            if(groupDetails&&[groupDetails count]>0)
    cell.itemValue.text=[groupDetails objectForKey:@"user_4g_ring_per"];
            else
                cell.itemValue.text=@"-";
            cell.itemImageView.hidden =![thresholds containsObject:@"user_4g_ring_per"];
    break;
    case 18:
    cell.itemTitle.text=@"三方市场占有率:";
            if(groupDetails&&[groupDetails count]>0)
    cell.itemValue.text=[groupDetails objectForKey:@"three_hold_per"];
            else
                cell.itemValue.text=@"-";
            cell.itemImageView.hidden =![thresholds containsObject:@"three_hold_per"];
    break;
    case 19:
    cell.itemTitle.text=@"三方市场占有率环比:";
            if(groupDetails&&[groupDetails count]>0)
    cell.itemValue.text=[groupDetails objectForKey:@"three_hold_ring_per"];
            else
                cell.itemValue.text=@"-";
            cell.itemImageView.hidden =![thresholds containsObject:@"three_hold_ring_per"];
    break;
    case 20:
    cell.itemTitle.text=@"当月保底客户到期数:";
            if(groupDetails&&[groupDetails count]>0)
    cell.itemValue.text=[groupDetails objectForKey:@"baodi_user"];
            else
                cell.itemValue.text=@"-";
            cell.itemImageView.hidden =![thresholds containsObject:@"baodi_user"];
    break;
    case 21:
    cell.itemTitle.text=@"当月套餐用户溢出客户数:";
            if(groupDetails&&[groupDetails count]>0)
    cell.itemValue.text=[groupDetails objectForKey:@"overflow_user"];
            else
                cell.itemValue.text=@"-";
            cell.itemImageView.hidden =![thresholds containsObject:@"overflow_user"];
    break;
    
        default:
            break;
    }
    
    
    return cell;
}
//Response =     {
//    arpu = "103.25";
//    "arpu_per" = "0.03";
//    "baodi_user" = 1;
//    "cancellation_user_cnt" = 8;
//    "cnty_name" = "A_\U57ce\U5317";
//    dou = "172.87";
//    "dou_per" = "9.14";
//    "grp_code" = 7319003870;
//    "grp_name" = "\U6e56\U5357\U8302\U534e\U7f6e\U4e1a\U6709\U9650\U8d23\U4efb\U516c\U53f8";
//    "infiltration_term_4g_per" = "9.84";
//    "infiltration_user_4g_per" = "9.84";
//    "innetwork_user_cnt" = 124;
//    "m_avg_dur" = 2685;
//    "m_avg_dur_per" = "84.16";
//    "m_avg_fee" = "439.66";
//    "m_avg_fee_per" = "84.69";
//    "outnetword_user_cnt" = 8;
//    "overflow_user" = 59;
//    "photo_user_cnt" = 132;
//    rank = 1;
//    "term_4g_ring_per" = "8.25";
//    "three_hold_per" = "72.05";
//    "three_hold_ring_per" = "0.60";
//    thresholds =         (
//                          "dou_per"
//                          );
//    "time_id" = 201408;
//    "user_4g_ring_per" = "8.25";
//    "vip_mngr_id" = A1KZZQ36;
//    "vip_mngr_msisdn" = 15073111492;
//    "vip_mngr_name" = "\U5f90\U9759";
//    "zero_user_cnt" = 14;
//};

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPat{

}
- (IBAction)forwardButtonOnclick:(id)sender {
    queryPreMonthNumber++;
    queryMonth=[self getPriousorLaterDateFromDate:[NSDate date] withMonth:-queryPreMonthNumber];
//    lbMonth.text=[[queryMonth substringFromIndex:4] stringByAppendingString:@"月"];
    lbMonth.text=[NSString stringWithFormat:@"%@%@",[[queryMonth substringToIndex:4] stringByAppendingString:@"年"],[[queryMonth substringFromIndex:4] stringByAppendingString:@"月"]];
    hubFlag=YES;
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"数据查询中，请稍后...";
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
    [self loadTableViewData];
}
- (IBAction)backwardButtonOnclick:(id)sender {
    queryPreMonthNumber--;
    queryMonth=[self getPriousorLaterDateFromDate:[NSDate date] withMonth:-queryPreMonthNumber];
//    lbMonth.text=[[queryMonth substringFromIndex:4] stringByAppendingString:@"月"];
    lbMonth.text=[NSString stringWithFormat:@"%@%@",[[queryMonth substringToIndex:4] stringByAppendingString:@"年"],[[queryMonth substringFromIndex:4] stringByAppendingString:@"月"]];
    hubFlag=YES;
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"数据查询中，请稍后...";
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
    [self loadTableViewData];
}
-(NSString *)getPriousorLaterDateFromDate:(NSDate *)date withMonth:(int)month
{
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setMonth:month];
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *mDate = [calender dateByAddingComponents:comps toDate:date options:0];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMM"];
    return [dateFormatter stringFromDate:mDate];
}
- (IBAction)goReply:(id)sender {
    [self performSegueWithIdentifier:@"CustomersWarningFollowUpWithGroupSegue" sender:self];
}
- (IBAction)goHistoryReply:(id)sender {
    [self performSegueWithIdentifier:@"CustomersWarningFollowUpHistoryWithGroupSegue" sender:self];
}

@end
