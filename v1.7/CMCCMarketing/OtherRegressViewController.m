//
//  OtherRegressViewController.m
//  CMCCMarketing
//
//  Created by talkweb on 14-9-19.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import "OtherRegressViewController.h"
#import "OtherRegressTableViewCell.h"
#import "MBProgressHUD.h"
#import "NetworkHandling.h"
#import "MJRefresh.h"

#define PAGE_ROW_COUNT 20

#import "OtherRegressMessageViewController.h"
#import "OtherRegressCustomerViewController.h"
@interface OtherRegressViewController ()<MBProgressHUDDelegate>{
    BOOL hubFlag;
    NSMutableArray *tableArray;
    int pageNO;
    NSString *currentState;
    
    NSArray *remindTableArray;
    NSDictionary *selectDict;
    NSTimer *_timer;
}

@end

@implementation OtherRegressViewController

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
    
    UIBarButtonItem *rightButton=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"喇叭"] style:UIBarButtonItemStylePlain target:self action:@selector(goMessageCenter)];
    [rightButton setTintColor:[UIColor whiteColor]];
    
    [self.navigationItem setRightBarButtonItem:rightButton];
    
    otherRegressTableView.delegate=self;
    otherRegressTableView.dataSource=self;
    
    remindButton.hidden=YES;
    NSDate *date=[NSDate date];
    NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone localTimeZone]];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString* strDate = [formatter stringFromDate:date];
    lbDate.text=[NSString stringWithFormat:@"今天 %@",strDate];
//    lbDate.layer.cornerRadius=2;
//    lbDate.layer.masksToBounds=YES;
    
    hubFlag=YES;
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"数据查询中，请稍后...";
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
    currentState=@"0";
    contactedButton.selected=YES;
    tableArray=[[NSMutableArray alloc] init];
    [self loadRemindData];
    [self loadRecordWithState:currentState numberWithPage:PAGE_ROW_COUNT indexWithPage:pageNO];
//    [self loadRecordWithState:@"1" numberWithPage:PAGE_ROW_COUNT indexWithPage:pageNO loadFlag:NO];
//    if([isLink isEqualToString:@"1"])
//        pendingContactButton.titleLabel.text=[NSString stringWithFormat:@"待联系（%d）",[tableArray count]];
    
    searchBar.delegate=self;
}
-(void)connectToNetwork{
    while (hubFlag) {
        usleep(100000);
    }
}

-(void)loadRecordWithState:(NSString*)isLink numberWithPage:(int)pagesTotal indexWithPage:(int)index{
    NSLog(@"load data with index:%d",index);
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    [bDict setObject:self.user.userMobile forKey:@"grp_svc_code"];
    [bDict setObject:[NSNumber numberWithInt:self.user.userEnterprise] forKey:@"enterprise"];
    [bDict setObject:isLink forKey:@"is_link"]; //“state”:办理状态,“0”已提交/”1”受理成功/”2”受理失败/”3”逻辑删除
    [bDict setObject:[NSNumber numberWithInt:pagesTotal] forKey:@"pageNum"];
    [bDict setObject:[NSNumber numberWithInt:index] forKey:@"start"];
//    [bDict setObject:@"" forKey:@"whereVal"];
//    [bDict setObject:@"0" forKey:@"type"];  //合约类型，"0"查询三个月到期/"1"否
    
    [NetworkHandling sendPackageWithUrl:@"diffuserback/lastlinkList" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        if(!error){
            NSLog(@"sign in success");
            NSArray *tmpArray =[result objectForKey:@"linkUser"];
            
     
                if([tmpArray count]==PAGE_ROW_COUNT){
                    pageNO++;
                    [self performSelectorOnMainThread:@selector(setupRefresh) withObject:nil waitUntilDone:YES];
                    //                [self setupRefresh];
                }
                else{
                    [otherRegressTableView removeFooter];
                }
                for (NSDictionary *item in tmpArray) {
                    [tableArray addObject:item];
                }
            
            int num=[[result objectForKey:@"newUsers"] intValue];
//                if([isLink isEqualToString:@"1"])
            [self performSelectorOnMainThread:@selector(refreshPendingContactButton:) withObject:[NSNumber numberWithInt:num] waitUntilDone:YES];
            
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
-(void)loadRemindData{
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    [bDict setObject:self.user.userMobile forKey:@"grp_svc_code"];
    [bDict setObject:[NSNumber numberWithInt:self.user.userEnterprise] forKey:@"enterprise"];
    
    [NetworkHandling sendPackageWithUrl:@"diffuserback/remindList" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        if(!error){
            NSLog(@"sign in success");
            remindTableArray =[result objectForKey:@"remindUser"];
            
            [self performSelectorOnMainThread:@selector(refreshRemindButton) withObject:nil waitUntilDone:YES];
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
-(void)updateRemindData{
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    [bDict setObject:self.user.userMobile forKey:@"grp_svc_code"];
    [bDict setObject:[NSNumber numberWithInt:self.user.userEnterprise] forKey:@"enterprise"];
    
    [NetworkHandling sendPackageWithUrl:@"diffuserback/updremindsta" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
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
-(void)refreshTableView{
    [otherRegressTableView reloadData];
    [otherRegressTableView footerEndRefreshing];
}
-(void)refreshPendingContactButton:(NSNumber*)num{
    lbPendingContactNumber.text=[NSString stringWithFormat:@"（%@）",num];
    if(num>0){
        lbPendingContactNumber.textColor=[UIColor redColor];
    }
    else{
        lbPendingContactNumber.textColor=[UIColor darkGrayColor];
    }
//    [pendingContactButton setTitle:@"" forState:UIControlStateNormal];
//    lbPendingContactTitle.hidden=NO;
//    lbPendingContactNumber.hidden=NO;
}
-(void)showMessage:(NSString*)infomation{
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"信息提示" message:infomation delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
    [myAlertView show];
}
-(void)refreshRemindButton{
    int count = (int)[remindTableArray count];
    if(count>0){
        lbDate.hidden=YES;
        remindButton.hidden=NO;
        NSString *remindString=[NSString stringWithFormat:@"您有%d条新消息",count];
        [remindButton setTitle:remindString forState:UIControlStateNormal];
    }
    else{
        remindButton.hidden=YES;
        lbDate.hidden=NO;
    }
}
-(void)hudWasHidden:(MBProgressHUD *)hud{
    [hud removeFromSuperview];
    hud=nil;
}
-(void)goBack{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)goMessageCenter{
    [self performSegueWithIdentifier:@"OtherRegressMessageSegue" sender:self];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)remingButtonOnclick:(id)sender {
    [self updateRemindData];
}
-(void)remindLoadFinished{
//    [self loadRemindData];
    remindButton.hidden=YES;
    remindTableArray=nil;
    [self goMessageCenter];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"OtherRegressMessageSegue"]){
        OtherRegressMessageViewController *controller=segue.destinationViewController;
        controller.user=self.user;
    }
    if([segue.identifier isEqualToString:@"OtherRegressCustomerSegue"]){
        OtherRegressCustomerViewController *controller=segue.destinationViewController;
        controller.diffUserDict=selectDict;
        controller.user=self.user;
    }
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    otherRegressTableView.hidden=![tableArray count];
    lbNullLabel.hidden=[tableArray count];
    return [tableArray count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
//{
//    "diff_svc_code" = 13307319379;
//    "diff_type" = "\U7535\U4fe1";
//    "diff_user_name" = "\U9ec4\U6587";
//    "is_back" = "\U662f";
//    "is_high_user" = "\U662f";
//    "is_look" = 0;
//    "is_school_user" = "\U5426";
//    "is_sensitive_user" = 0;
//    "link_date" = "2014-10-27T08:04:28+0000";
//    "link_type" = 0;
//    "user_type" = "\U5e02\U533a";
//    "week_day" = "\U661f\U671f\U4e00";
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OtherRegressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OtherRegressTableViewCell" forIndexPath:indexPath];
    
    NSDictionary *dict=[tableArray objectAtIndex:indexPath.row];
    cell.itemName.text=[dict objectForKey:@"diff_user_name"];
    cell.itemPhone.text=[dict objectForKey:@"diff_svc_code"];
    cell.itemLvl.text=@"";
    
    NSString *isHighUser=[dict objectForKey:@"is_high_user"];
    if([isHighUser isEqualToString:@"是"]){
        cell.itemLvl.text=@"高端用户";
        cell.itemLvl.textColor=[UIColor colorWithRed:55/255.0 green:132/255.0 blue:173/255.0 alpha:1];
    }
    
    BOOL isSensitiveUserFlag=[[dict objectForKey:@"is_sensitive_user"] boolValue];
    if(isSensitiveUserFlag){
        cell.itemLvl.text=@"敏感";
        cell.itemLvl.textColor=[UIColor orangeColor];
    }
    
    NSString *link_date=[dict objectForKey:@"link_date"];
    if((NSNull*)link_date != [NSNull null]){
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *linkDate=[dateFormatter dateFromString:link_date];
        NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
        [dateFormatter1 setDateFormat:@"MM-dd HH:mm"];
        cell.itemContactDate.text=[dateFormatter1 stringFromDate:linkDate];
    }
    
    NSString *diff_type=[dict objectForKey:@"diff_type"];
    if((NSNull*)diff_type != [NSNull null])
        cell.itemMainImageView.image=[UIImage imageNamed:diff_type];
    
    NSString *week_day=[dict objectForKey:@"week_day"];
    cell.itemWeek.text=(NSNull*)week_day != [NSNull null]?week_day:@"";
    NSString *isback=[dict objectForKey:@"is_back"];
    BOOL isbackFlag=[isback isEqualToString:@"是"];
    cell.itemIsBackBodyView.hidden=!isbackFlag;
    cell.itemTeleImageView.hidden=isbackFlag;
    cell.itemWeek.hidden=isbackFlag;
    cell.itemContactDate.hidden=isbackFlag;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    selectDict=[tableArray objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"OtherRegressCustomerSegue" sender:self];
}
- (IBAction)pendingContactButtonOnclick:(id)sender {
    pendingContactButton.selected=YES;
    contactedButton.selected=NO;
    
    [tableArray removeAllObjects];
    
    hubFlag=YES;
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"数据查询中，请稍后...";
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
    currentState=@"1";
    pageNO=0;
    [self loadRecordWithState:currentState numberWithPage:PAGE_ROW_COUNT indexWithPage:pageNO];

}

- (IBAction)contactedButtonOnclick:(id)sender {
    pendingContactButton.selected=NO;
    contactedButton.selected=YES;
    
    [tableArray removeAllObjects];
    
    hubFlag=YES;
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"数据查询中，请稍后...";
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
    currentState=@"0";
    pageNO=0;
    [self loadRecordWithState:currentState numberWithPage:PAGE_ROW_COUNT indexWithPage:pageNO];
}
- (IBAction)searchOnclick:(id)sender {
    searchBodyView.hidden=NO;
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)sBar{
    [sBar resignFirstResponder];
    BOOL flag=NO;
    for (NSDictionary * dict in tableArray) {
        if([[dict objectForKey:@"diff_svc_code"] isEqualToString:sBar.text]){
            selectDict=dict;
            [self performSegueWithIdentifier:@"OtherRegressCustomerSegue" sender:self];
            flag=YES;
            break;
        }
    }
    
    if(!flag){
        MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:HUD];
        HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
        HUD.mode = MBProgressHUDModeCustomView;
        HUD.delegate = self;
        HUD.labelText = @"没有搜索到相关信息！";
        [HUD show:YES];
        [HUD hide:YES afterDelay:2];
    }
}
- (IBAction)exitSearchOnclick:(id)sender {
    searchBodyView.hidden=YES;
    [searchBar resignFirstResponder];
}

/**
 *  集成刷新控件
 */
#pragma mark - 集成刷新控件
- (void)setupRefresh
{
    [otherRegressTableView addFooterWithTarget:self action:@selector(footerRereshing)];
    otherRegressTableView.footerPullToRefreshText = @"上拉加载更多数据";
    otherRegressTableView.footerReleaseToRefreshText = @"松开加载更多数据";
    otherRegressTableView.footerRefreshingText = @"加载中,请稍后...";
}

#pragma mark 开始进入刷新状态

- (void)footerRereshing
{
    [self loadRecordWithState:currentState numberWithPage:PAGE_ROW_COUNT indexWithPage:pageNO];
    
}
@end
