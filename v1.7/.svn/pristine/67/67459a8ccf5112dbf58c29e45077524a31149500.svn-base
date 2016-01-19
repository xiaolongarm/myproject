//
//  CustomersWarningWithGroupViewController.m
//  CMCCMarketing
//
//  Created by talkweb on 14-9-23.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import "CustomersWarningWithGroupViewController.h"
#import "CustomersWarningWithGroupTableViewCell.h"
#import "Group.h"
#import "MBProgressHUD.h"
#import "NetworkHandling.h"

#import "CustomersWarningWithGroupIndicatorsViewController.h"

@interface CustomersWarningWithGroupViewController ()<MBProgressHUDDelegate,UIActionSheetDelegate>{
    BOOL hubFlag;
    NSArray *tableArray;
    NSArray *fullArray;
    
    
    NSDictionary *selectGroupDict;
    NSString *sortButtonTitle;
    NSArray *sortArray;
    NSString *queryMonth;
    NSString *timeId;
    int queryPreMonthNumber;
    

}

@end

@implementation CustomersWarningWithGroupViewController

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
    
    UIBarButtonItem *rightButton=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"查询按钮"] style:UIBarButtonItemStylePlain target:self action:@selector(goSearch)];
    [rightButton setTintColor:[UIColor whiteColor]];
    [self.navigationItem setRightBarButtonItem:rightButton];
    
    searchBar.delegate=self;
//    @"日均收入" otherButtonTitles:@"用户渗透率",@"离网用户数"
    sortArray=[[NSArray alloc] initWithObjects:@"日均收入",@"用户渗透率",@"离网用户数", nil];
    
    groupTableView.dataSource=self;
    groupTableView.delegate=self;
    
    queryPreMonthNumber=0;
    queryMonth=[self getPriousorLaterDateFromDate:[NSDate date] withMonth:queryPreMonthNumber];
    lbMonth.text=[NSString stringWithFormat:@"%@%@",[[queryMonth substringToIndex:4] stringByAppendingString:@"年"],[[queryMonth substringFromIndex:4] stringByAppendingString:@"月"]];
    
    [self loadTableViewData];
    
}
-(void)goSearch{
    [searchBar resignFirstResponder];
    vwTopBodyView.hidden=!vwTopBodyView.hidden;
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)sBar{
    [sBar resignFirstResponder];
    [self searchBar:sBar textDidChange:sBar.text];
}
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if(searchText.length==0){
        tableArray=fullArray;
        [self refreshTableView];
        return;
    }
    
    NSMutableArray *tmpArray=[[NSMutableArray alloc] init];
    for (NSDictionary *item in fullArray) {
        NSString *groupName=[item objectForKey:@"grp_name"];
        NSRange range=[groupName rangeOfString:searchText];
        if(range.location!= NSNotFound)
            [tmpArray addObject:item];
    }
    
    tableArray=tmpArray;
    [self refreshTableView];
}

-(void)connectToNetwork{
    while (hubFlag) {
        usleep(100000);
    }
}
//{
//    “enterprise”:企业编码  [必传参数],
//    “mobile”:手机号      [必传参数],
//    “user_lvl”:用户级别    [必传参数],
//    “user_id”:用户ID      [必传参数]
//}
-(void)loadTableViewData{
    hubFlag=YES;
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"数据查询中，请稍后...";
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];

    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    [bDict setObject:self.user.userMobile forKey:@"mobile"];
    [bDict setObject:[NSNumber numberWithInt:self.user.userEnterprise] forKey:@"enterprise"];
    [bDict setObject:[NSNumber numberWithInt:self.user.userID] forKey:@"user_id"];
    [bDict setObject:[NSNumber numberWithInt:self.user.userLvl] forKey:@"user_lvl"];
    
    [bDict setObject:[self getSortKey] forKey:@"orderby"];
//    m_avg_fee 日均收入
//    infiltration_user_4g_per 用户渗透率
//    outnetword_user_cnt 离网用户数
    [bDict setObject:queryMonth forKey:@"time_id"];
//    time_id 传递时间如201502
//    【可选时间范围为当月及当月的前5个月，共6个月可选】
    
    //gprwarn/v15_grptimeList  gprwarn/grptimeList
    [NetworkHandling sendPackageWithUrl:@"gprwarn/v15_grptimeList" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        if(!error){
            NSLog(@"sign in success");
            fullArray =[result objectForKey:@"Response"];
            tableArray=fullArray;
//            NSString *timeValue=[result objectForKey:@"time_id"];
            id timevalue = [result objectForKey:@"time_id"];
            if([timevalue isKindOfClass:[NSString class]])
                timeId=timevalue;
            else{
                NSLog(@"time_id is not nsstring");
                timeId=[NSString stringWithFormat:@"%@",timevalue];
            }
                
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
-(NSString*)getSortKey{
    NSString *sortItem=[sortArray objectAtIndex:0];
    if([sortItem isEqualToString:@"日均收入"])
        return @"m_avg_fee";
    if([sortItem isEqualToString:@"用户渗透率"])
        return @"infiltration_user_4g_per";
    if([sortItem isEqualToString:@"离网用户数"])
        return @"outnetword_user_cnt";
    return @"m_avg_fee";
    
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
-(void)showMessage:(NSString*)infomation{
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"信息提示" message:infomation delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
    [myAlertView show];
}
-(void)refreshTableView{
    if(!tableArray||[tableArray count]==0)
        groupTableView.hidden=YES;
    else
        groupTableView.hidden=NO;
    [groupTableView reloadData];
        
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
    if([segue.identifier isEqualToString:@"CustomersWarningWithGroupIndicatorsSegue"]){
        CustomersWarningWithGroupIndicatorsViewController *controller=segue.destinationViewController;
        controller.groupDict=selectGroupDict;
        controller.user=self.user;
        controller.queryTime=timeId;
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableArray count];
}
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 60;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomersWarningWithGroupTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CustomersWarningWithGroupTableViewCell" forIndexPath:indexPath];
//    Group *group=[self.user.groupInfo objectAtIndex:indexPath.row];
//    cell.itemName.text=group.groupName;
//    cell.itemImageView.hidden=YES;
    
    NSDictionary *dict=[tableArray objectAtIndex:indexPath.row];
    cell.itemName.text=[dict objectForKey:@"grp_name"];
    BOOL flag=[[dict objectForKey:@"threshold_falg"] boolValue];
    cell.itemImageView.hidden=!flag;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    selectGroupDict=[tableArray objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"CustomersWarningWithGroupIndicatorsSegue" sender:self];
}
#pragma mark - 月份筛选
- (IBAction)nextMonthButtonOnclick:(id)sender {
    queryPreMonthNumber++;
    queryMonth=[self getPriousorLaterDateFromDate:[NSDate date] withMonth:queryPreMonthNumber];
    lbMonth.text=[NSString stringWithFormat:@"%@%@",[[queryMonth substringToIndex:4] stringByAppendingString:@"年"],[[queryMonth substringFromIndex:4] stringByAppendingString:@"月"]];
    
    [self loadTableViewData];

}
- (IBAction)lastMonthButtonOnclick:(id)sender {
    queryPreMonthNumber--;
    queryMonth=[self getPriousorLaterDateFromDate:[NSDate date] withMonth:queryPreMonthNumber];
    lbMonth.text=[NSString stringWithFormat:@"%@%@",[[queryMonth substringToIndex:4] stringByAppendingString:@"年"],[[queryMonth substringFromIndex:4] stringByAppendingString:@"月"]];
    
    [self loadTableViewData];
}

#pragma mark - 排序
- (IBAction)sortButtonOnclick:(id)sender {
    
    UIActionSheet *actionSheet=[[UIActionSheet alloc] initWithTitle:@"排序方式选择" delegate:self cancelButtonTitle:@"取 消" destructiveButtonTitle:[sortArray objectAtIndex:0] otherButtonTitles:[sortArray objectAtIndex:1],[sortArray objectAtIndex:2], nil];
    [actionSheet showInView:self.view];
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 3)
        return;
    
    NSArray *tmp=[[NSArray alloc] initWithObjects:[sortArray objectAtIndex:buttonIndex],buttonIndex==1?[sortArray objectAtIndex:0]:[sortArray objectAtIndex:1],buttonIndex==2?[sortArray objectAtIndex:0]:[sortArray objectAtIndex:2], nil];
    sortArray=tmp;
    
    [self loadTableViewData];
}

@end
