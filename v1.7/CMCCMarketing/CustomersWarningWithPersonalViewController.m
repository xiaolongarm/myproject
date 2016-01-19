//
//  CustomersWarningWithPersonalViewController.m
//  CMCCMarketing
//
//  Created by talkweb on 14-9-23.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import "CustomersWarningWithPersonalViewController.h"
#import "CustomersWarningWithPersonalTableViewCell.h"
#import "MBProgressHUD.h"
#import "NetworkHandling.h"
#import "MJRefresh.h"
#import "CustomersWarningWithPersonalIndicatorsViewController.h"

#define PAGE_ROW_COUNT 20

@interface CustomersWarningWithPersonalViewController ()<MBProgressHUDDelegate>{
    BOOL hubFlag;
    int pageNO;
    NSMutableArray *tableArray;
    NSMutableArray *fullArray;
    
    NSDictionary *selectedDict;
//    UISearchBar *searchBar;
    
    UISearchBar *searchbar;
    NSString *queryMonth;
    NSString *timeId;
    int queryPreMonthNumber;
}

@end

@implementation CustomersWarningWithPersonalViewController

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
    
    personalTableView.dataSource=self;
    personalTableView.delegate=self;
    
    fullArray=[[NSMutableArray alloc] init];
    pageNO=0;
    
    CGRect rect=self.view.frame;
    rect.size.height=44;
    rect.origin.y=64;
    rect.origin.x=0;
    searchbar=[[UISearchBar alloc] init];
    searchbar.placeholder=@"请输入名称关键字或是电话号码查询";
    searchbar.frame=rect;
    searchbar.delegate=self;
    [self.view addSubview:searchbar];
    searchbar.hidden=YES;
    
    queryPreMonthNumber=0;
    queryMonth=[self getPriousorLaterDateFromDate:[NSDate date] withMonth:queryPreMonthNumber];
    lbMonth.text=[NSString stringWithFormat:@"%@%@",[[queryMonth substringToIndex:4] stringByAppendingString:@"年"],[[queryMonth substringFromIndex:4] stringByAppendingString:@"月"]];
    
    hubFlag=YES;
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"数据查询中，请稍后...";
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
    [self loadDataWithPage:PAGE_ROW_COUNT indexWithPage:pageNO];
}
-(void)connectToNetwork{
    while (hubFlag) {
        usleep(100000);
    }
}

#pragma mark - search delegate
-(void)goSearch{
    searchbar.hidden=!searchbar.hidden;
    if(searchbar.hidden)
        [searchbar resignFirstResponder];
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
        
        NSString *phoneNumber=[item objectForKey:@"user_msisdn"];
        NSString *groupName=[item objectForKey:@"grp_name"];
        
        NSRange range1=[groupName rangeOfString:searchText];
        if(range1.location!= NSNotFound)
            [tmpArray addObject:item];
        
        NSRange range2=[phoneNumber rangeOfString:searchText];
        if(range2.location!= NSNotFound)
            [tmpArray addObject:item];
    }
    
    tableArray=tmpArray;
    [self refreshTableView];
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
-(void)loadDataWithPage:(int)pagesTotal indexWithPage:(int)index{
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    [bDict setObject:self.user.userMobile forKey:@"mobile"];
    [bDict setObject:[NSNumber numberWithInt:self.user.userEnterprise] forKey:@"enterprise"];
    [bDict setObject:[NSNumber numberWithInt:self.user.userID] forKey:@"user_id"];
    [bDict setObject:[NSNumber numberWithInt:self.user.userLvl] forKey:@"user_lvl"];
//    NSString *queryMonth=[self getPriousorLaterDateFromDate:[NSDate date] withMonth:-1];
    [bDict setObject:queryMonth forKey:@"time_id"];

    [bDict setObject:[NSNumber numberWithInt:pagesTotal] forKey:@"pageNum"];
    [bDict setObject:[NSNumber numberWithInt:index] forKey:@"start"];

    [NetworkHandling sendPackageWithUrl:@"gprwarn/grpUserList" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        if(!error){
            NSLog(@"sign in success");
            NSArray *tmpArray =[result objectForKey:@"Response"];
            
            if([tmpArray count]==PAGE_ROW_COUNT){
                pageNO++;
                [self performSelectorOnMainThread:@selector(setupRefresh) withObject:nil waitUntilDone:YES];
                //                [self setupRefresh];
            }
            else{
                [personalTableView removeFooter];
            }
            for (NSDictionary *item in tmpArray) {
                [fullArray addObject:item];
            }
            tableArray=fullArray;

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
-(void)refreshTableView{
    if(tableArray && [tableArray count] > 0){
        personalTableView.hidden=NO;
        [personalTableView reloadData];
        [personalTableView footerEndRefreshing];
    }
    else
        personalTableView.hidden=YES;
}
-(void)showMessage:(NSString*)infomation{
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"信息提示" message:infomation delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
    [myAlertView show];
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
    if([segue.identifier isEqualToString:@"CustomersWarningWithPersonalIndicatorsSegue"]){
        CustomersWarningWithPersonalIndicatorsViewController *controller=segue.destinationViewController;
        controller.user=self.user;
        controller.cuestomerDict=selectedDict;
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
    CustomersWarningWithPersonalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CustomersWarningWithPersonalTableViewCell" forIndexPath:indexPath];
    
    NSDictionary *dict=[tableArray objectAtIndex:indexPath.row];
    cell.itemName.text=@"预警客户";
    cell.itemPhone.text=[dict objectForKey:@"user_msisdn"];
    cell.itemGroupName.text=[dict objectForKey:@"grp_name"];
    NSArray *thresholds=[dict objectForKey:@"thresholds"];
    if([thresholds count]>0)
        cell.itemImageView.hidden=NO;
    else
        cell.itemImageView.hidden=YES;
    return cell;
}
//{
//    arpu = "99.60";
//    "arpu_per" = "51.59";
//    "baodi_end_date" = 20141231;
//    "disc_name" = "\U52a8\U611f\U5730\U5e26\U4e0a\U7f51\U5957\U991038\U5143\U5957\U9910\U4f18\U60e0";
//    dou = "244.30";
//    "dou_per" = "22.55";
//    "gprs_disc_name" = "\U52a8\U611f\U5730\U5e26\U4e0a\U7f51\U5957\U991038\U5143\U5957\U9910\U4f18\U60e0";
//    "grp_code" = 7311000158;
//    "grp_name" = "\U6e56\U5357\U65e5\U62a5\U793e\U5370\U5237\U5382";
//    "is_4g_card" = "\U5426";
//    "is_4g_disc" = "\U5426";
//    "is_4g_term" = "\U5426";
//    "is_baodi" = "\U662f";
//    "photo_arpu" = "65.70";
//    rank = 1;
//    "term_standard" = GSM;
//    thresholds =     (
//    );
//    "time_id" = 201409;
//    "user_msisdn" = 18874238126;
//    "user_stat" = "\U5f00\U901a";
//    "user_type" = "201408\U6708BOSS\U5173\U952e\U4eba";
//    "vip_mngr_id" = A1KZZQ36;
//    "vip_mngr_msisdn" = 15073111492;
//    "vip_mngr_name" = "\U5f90\U9759";
//}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    selectedDict=[tableArray objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"CustomersWarningWithPersonalIndicatorsSegue" sender:self];
}
/**
 *  集成刷新控件
 */
#pragma mark - 集成刷新控件
- (void)setupRefresh
{
    [personalTableView addFooterWithTarget:self action:@selector(footerRereshing)];
    personalTableView.footerPullToRefreshText = @"上拉加载更多数据";
    personalTableView.footerReleaseToRefreshText = @"松开加载更多数据";
    personalTableView.footerRefreshingText = @"加载中,请稍后...";
}

#pragma mark 开始进入刷新状态

- (void)footerRereshing
{
    [self loadDataWithPage:PAGE_ROW_COUNT indexWithPage:pageNO];
    
}
#pragma mark - 月份筛选
- (IBAction)nextMonthButtonOnclick:(id)sender {
    queryPreMonthNumber++;
    queryMonth=[self getPriousorLaterDateFromDate:[NSDate date] withMonth:queryPreMonthNumber];
    lbMonth.text=[NSString stringWithFormat:@"%@%@",[[queryMonth substringToIndex:4] stringByAppendingString:@"年"],[[queryMonth substringFromIndex:4] stringByAppendingString:@"月"]];

    pageNO=0;
    [fullArray removeAllObjects];
    
    hubFlag=YES;
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"数据查询中，请稍后...";
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
    [self loadDataWithPage:PAGE_ROW_COUNT indexWithPage:pageNO];
    
}
- (IBAction)lastMonthButtonOnclick:(id)sender {
    queryPreMonthNumber--;
    queryMonth=[self getPriousorLaterDateFromDate:[NSDate date] withMonth:queryPreMonthNumber];
    lbMonth.text=[NSString stringWithFormat:@"%@%@",[[queryMonth substringToIndex:4] stringByAppendingString:@"年"],[[queryMonth substringFromIndex:4] stringByAppendingString:@"月"]];
    
    pageNO=0;
    [fullArray removeAllObjects];
    
    hubFlag=YES;
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"数据查询中，请稍后...";
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
    [self loadDataWithPage:PAGE_ROW_COUNT indexWithPage:pageNO];
}

@end
