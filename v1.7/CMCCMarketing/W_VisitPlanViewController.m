//
//  W_VisitPlanViewController.m
//  CMCCMarketing
//
//  Created by gmj on 14-11-19.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import "W_VisitPlanViewController.h"
#import "W_VisitPlanAddViewController.h"
#import "W_VisitPlanManageTableViewController.h"
#import "W_VisitPlanMessageTableViewController.h"
#import "W_VisitPlanDetailsViewController.h"
#import "W_VisitPlanSearchViewController.h"

#import "NetworkHandling.h"
#import "MBProgressHUD.h"

@interface W_VisitPlanViewController ()<MBProgressHUDDelegate,W_VisitPlanSearchViewControllerDelegate,W_VisitPlanMessageTableViewControllerDelegate>{
    
    BOOL hubFlag;
     BOOL hubFlag11;
    NSArray *remindTableArray;
    NSArray *remindHistoryArray;
    
//    NSArray *ttt;
    BOOL reloadFlag;
}

@end

@implementation W_VisitPlanViewController

#pragma mark - Control view life cycle

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
    
    self.keyValues = [[NSMutableDictionary alloc] init];
    self.keys= [[NSMutableArray alloc] init];
    
    [self initCustomTableView];
    
#if (defined STANDARD_CS_VERSION) || (defined MANAGER_CS_VERSION)
    [self initSubPage];
#endif

//    [self initSubPage];
    reloadFlag=YES;

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRemindData];
    
    if(reloadFlag){
        [self visitPlanAllOnClick:nil];
    }
    reloadFlag=YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) initSubPage{
    
    if(IOS7)
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"320X64"] forBarMetrics:UIBarMetricsDefault];
    else
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"320X44"] forBarMetrics:UIBarMetricsDefault];
    
    self.navigationItem.title = @"客户拜访";
    UIBarButtonItem *leftButton=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回1"] style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    [leftButton setTintColor:[UIColor whiteColor]];
    [self.navigationItem setLeftBarButtonItem:leftButton];
    
    UIColor * color = [UIColor whiteColor];
    NSDictionary * dict=[NSDictionary dictionaryWithObject:color forKey:UITextAttributeTextColor];
    [self.navigationController.navigationBar setTitleTextAttributes:dict];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    //    UIBarButtonItem *rightButton=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"加号"] style:UIBarButtonItemStylePlain target:self action:@selector(addVisitPlan)];
    //    [rightButton setTintColor:[UIColor whiteColor]];
    //    [self.navigationItem setRightBarButtonItem:rightButton];
    
    UIBarButtonItem *rightButton=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"喇叭"] style:UIBarButtonItemStylePlain target:self action:@selector(loadMessageCenterData)];
    [rightButton setTintColor:[UIColor whiteColor]];
    [self.navigationItem setRightBarButtonItem:rightButton];
    
}

-(void)initCustomTableView{
    
    self.visitPlanTableView.dataSource=self;
    self.visitPlanTableView.delegate=self;
}

-(void)goBack{
    
    //[self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)searchVisitPlan:(id)sender {
    
    W_VisitPlanSearchViewController *vc = [[W_VisitPlanSearchViewController alloc] initWithNibName:@"W_VisitPlanSearchViewController" bundle:nil];
    vc.delegate=self;
    vc.user = self.user;
//    [vc reLayoutView];
    [self.navigationController pushViewController:vc animated:YES];
    
}


#pragma mark - W_VisitPlanSearchViewControllerDelegate

-(void)W_VisitPlanSearchViewControllerDidFinished:(W_VisitPlanSearchViewController *)controller{
    reloadFlag=NO;
    self.keys = controller.keys;
    self.keyValues = controller.keyValues;
    [self.visitPlanTableView reloadData];
}

- (IBAction)addVisitPlan:(id)sender {
    
    W_VisitPlanAddViewController *vc = [[W_VisitPlanAddViewController alloc] initWithNibName:@"W_VisitPlanAddViewController" bundle:nil];
    vc.user=self.user;
    [self.navigationController pushViewController:vc animated:YES];
    
}

//“visit_sta":拜访状态 -1:审核失败 0;未审核 1:未拜访 2:拜访完成 3:拜访失败
- (IBAction)visitPlanAllOnClick:(id)sender {
    
    [self.keys removeAllObjects];
    [self.keyValues removeAllObjects];
    [self loadVisitPlanListData:@"9"];
    [self.btnVisitPlanAll setBackgroundImage:[UIImage imageNamed:@"按钮带框.png"] forState:UIControlStateNormal];
    [self.btnVisitPlanDone setBackgroundImage:nil forState:UIControlStateNormal];
    [self.btnVisitPlanWaitCheck setBackgroundImage:nil forState:UIControlStateNormal];
    [self.btnVisitPlanWill setBackgroundImage:nil forState:UIControlStateNormal];
    
}

- (IBAction)visitPlanWillOnClick:(id)sender {
    
    [self.keys removeAllObjects];
    [self.keyValues removeAllObjects];
    [self loadVisitPlanListData:@"1"];
    
    [self.btnVisitPlanWill setBackgroundImage:[UIImage imageNamed:@"按钮带框.png"] forState:UIControlStateNormal];
    
    [self.btnVisitPlanDone setBackgroundImage:nil forState:UIControlStateNormal];
    [self.btnVisitPlanWaitCheck setBackgroundImage:nil forState:UIControlStateNormal];
    [self.btnVisitPlanAll setBackgroundImage:nil forState:UIControlStateNormal];
}

- (IBAction)visitPlanDoneOnClick:(id)sender {
    
    [self.keys removeAllObjects];
    [self.keyValues removeAllObjects];
    
    [self loadVisitPlanListData:@"2,3"];
    
    
    [self.btnVisitPlanDone setBackgroundImage:[UIImage imageNamed:@"按钮带框.png"] forState:UIControlStateNormal];
    [self.btnVisitPlanWill setBackgroundImage:nil forState:UIControlStateNormal];
    [self.btnVisitPlanWaitCheck setBackgroundImage:nil forState:UIControlStateNormal];
    [self.btnVisitPlanAll setBackgroundImage:nil forState:UIControlStateNormal];
}

- (IBAction)visitPlanWaitCheckOnClick:(id)sender {
    
    [self.keys removeAllObjects];
    [self.keyValues removeAllObjects];
    [self loadVisitPlanListData:@"0"];
    
    [self.btnVisitPlanWaitCheck setBackgroundImage:[UIImage imageNamed:@"按钮带框.png"] forState:UIControlStateNormal];
    
    [self.btnVisitPlanDone setBackgroundImage:nil forState:UIControlStateNormal];
    [self.btnVisitPlanWill setBackgroundImage:nil forState:UIControlStateNormal];
    [self.btnVisitPlanAll setBackgroundImage:nil forState:UIControlStateNormal];
}

- (IBAction)remindButtonOnClick:(id)sender {//查看最新消息
    
    //更新新消息状态
    [self updateRemindData];
//    [self updateRemindDataFinished];
}

-(void)loadMessageCenterData{

    hubFlag=YES;
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"数据查询中，请稍后...";
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
    [self loadHistoryRemindData];
    
}

-(void)loadHistoryRemindData{//历史消息
    
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    [bDict setObject:[NSNumber numberWithInt:self.user.userLvl] forKey:@"user_lvl"];
    [bDict setObject:[NSNumber numberWithInt:self.user.userID] forKey:@"user_id"];
    [bDict setObject:self.user.userMobile forKey:@"user_msisdn"];
    [bDict setObject:[NSNumber numberWithInt:self.user.userEnterprise] forKey:@"enterprise"];
    
    [NetworkHandling sendPackageWithUrl:@"visitplan/hisvisitplanremind" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        if(!error){
            NSLog(@"sign in success");
            remindHistoryArray =[result objectForKey:@"remind"];
            
            [self performSelectorOnMainThread:@selector(goMessageCenter) withObject:nil waitUntilDone:YES];
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

-(void)goMessageCenter{
    
    W_VisitPlanMessageTableViewController *vc = [[W_VisitPlanMessageTableViewController alloc] initWithNibName:@"W_VisitPlanMessageTableViewController" bundle:nil];
   // vc.passDictData=self.;
    vc.user = self.user;
    vc.tableList = remindHistoryArray;//历史消息
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)loadRemindData{
    
    hubFlag11=YES;
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"数据查询中，请稍后...";
//    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
[HUD showWhileExecuting:@selector(connectToNetworkOther) onTarget:self withObject:nil animated:YES];
    
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    [bDict setObject:[NSNumber numberWithInt:self.user.userLvl] forKey:@"user_lvl"];
    [bDict setObject:[NSNumber numberWithInt:self.user.userID] forKey:@"user_id"];
    [bDict setObject:self.user.userMobile forKey:@"user_msisdn"];
    [bDict setObject:[NSNumber numberWithInt:self.user.userEnterprise] forKey:@"enterprise"];
    
    
    [NetworkHandling sendPackageWithUrl:@"visitplan/visitplanremind" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        if(!error){
            NSLog(@"sign in success");
            remindTableArray =[result objectForKey:@"remind"];
            
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
        hubFlag11=NO;
    }];
}

-(void)refreshRemindButton{
    
    int count = (int)[remindTableArray count];
    if(count>0){
        self.remindButton.hidden=NO;
        NSString *remindString=[NSString stringWithFormat:@"您有%d条新消息",count];
        [self.remindButton setTitle:remindString forState:UIControlStateNormal];
    }
    else{
        
        self.remindButton.hidden=YES;
    }
}

-(void)updateRemindData{
    
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    [bDict setObject:[NSNumber numberWithInt:self.user.userID] forKey:@"user_id"];
    [bDict setObject:[NSNumber numberWithInt:self.user.userEnterprise] forKey:@"enterprise"];
    
    NSString *reply_id = @"";
    NSString *visit_id = @"";
    for (NSDictionary *dict in remindTableArray) {
        
        NSString *type = [dict objectForKey:@"type"];
        NSLog(@"type = %@",type);
        
        if ([type isEqualToString:@"examine"]) {
            
            visit_id = [visit_id stringByAppendingFormat:@"%d,",[[dict objectForKey:@"row_id"] intValue]];
            
        } else if([type isEqualToString:@"reply"]){//回复类型
            
            reply_id = [reply_id stringByAppendingFormat:@"%d,",[[dict objectForKey:@"row_id"] intValue]];
            
            
        } else if([type isEqualToString:@"visit"]){
            
            visit_id = [visit_id stringByAppendingFormat:@"%d,",[[dict objectForKey:@"row_id"] intValue]];
            
        }
        
    }
    if (reply_id.length>0) {
        reply_id = [reply_id substringToIndex:[reply_id length] - 1];
    }
    
    if (visit_id.length>0) {
        visit_id = [visit_id substringToIndex:[visit_id length] - 1];
    }
    
    NSLog(@"reply_id = %@",reply_id);
    NSLog(@"visit_id = %@",visit_id);
    [bDict setObject:reply_id forKey:@"reply_id"];
    [bDict setObject:visit_id forKey:@"visit_id"];

    [NetworkHandling sendPackageWithUrl:@"visitplan/updremindsta" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        if(!error){
            NSLog(@"sign in success");

            BOOL flag=[[result objectForKey:@"flag"] boolValue];
            if(flag)
                [self performSelectorOnMainThread:@selector(updateRemindDataFinished) withObject:nil waitUntilDone:YES];
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

-(void)updateRemindDataFinished{
    self.remindButton.hidden=YES;
    W_VisitPlanMessageTableViewController *vc = [[W_VisitPlanMessageTableViewController alloc] initWithNibName:@"W_VisitPlanMessageTableViewController" bundle:nil];
    vc.user = self.user;
    vc.tableList = remindTableArray;
    vc.delegate=self;
    [self.navigationController pushViewController:vc animated:YES];
}
/**
 *  @brief  提醒消息列表回调
 *
 *  @param vistplanId 拜访编号
 */
-(void)w_visitPlanMessageTableViewControllerGoDetails:(int)vistplanId{
    NSDictionary *detailsDict;
    for (NSDictionary *dict in self.visitplanlist) {
        int rid =[[dict objectForKey:@"row_id"] intValue];
        if(rid == vistplanId){
            detailsDict = dict;
            break;
        }
    }
    
    W_VisitPlanDetailsViewController *vc = [[W_VisitPlanDetailsViewController alloc] initWithNibName:@"W_VisitPlanDetailsViewController" bundle:nil];
    vc.dicSelectVisitPlanDetail = detailsDict;
    vc.user = self.user;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Table view data source


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return .1f;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    int c = [self.keys count];
    return c?c:0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *k=[self.keys objectAtIndex:section];
    NSArray *aryObj=[self.keyValues objectForKey:k];
    int c = [aryObj count];
    c = c?c:0;
    return c;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80;
}


//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    
////    NSLog(@"index section...%d", section);
//    UIView *viewSectionHeader = [[[NSBundle mainBundle]loadNibNamed:@"W_VisitPlanViewControllerCell_SectionHeader" owner:self options:nil] objectAtIndex:0];
//    UILabel *lblHeadTitle = (UILabel *)[viewSectionHeader viewWithTag:100];
//    NSString *tit=[self.keys objectAtIndex:section];
//    [lblHeadTitle setText:tit];
//    return  viewSectionHeader;
//    
//}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *title=[self.keys objectAtIndex:section];
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date=[dateFormatter dateFromString:title];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *comps;
    comps = [calendar components:unitFlags fromDate:date];
     NSInteger weekday = [comps weekday];
    switch (weekday) {
        case 1:
            title = [title stringByAppendingString:@" 星期天"];
            break;
        case 2:
            title = [title stringByAppendingString:@" 星期一"];
            break;
        case 3:
            title = [title stringByAppendingString:@" 星期二"];
            break;
        case 4:
            title = [title stringByAppendingString:@" 星期三"];
            break;
        case 5:
            title = [title stringByAppendingString:@" 星期四"];
            break;
        case 6:
            title = [title stringByAppendingString:@" 星期五"];
            break;
        case 7:
            title = [title stringByAppendingString:@" 星期六"];
            break;
        default:
            break;
    }
    
    return title;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if([self.keys count] < 1){
//        [self reloadKesData:@"9"];
//    }
    
    //W_VisitPlanViewManageControllerCell

    NSString *CellIdentifier=@"";
#if (defined MANAGER_CS_VERSION) || (defined MANAGER_SY_VERSION)
   CellIdentifier= @"W_VisitPlanViewManageControllerCell";
#endif
    
#if (defined STANDARD_CS_VERSION) || (defined STANDARD_SY_VERSION)
CellIdentifier= @"W_VisitPlanViewControllerCell";
#endif
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:CellIdentifier owner:self options:nil] objectAtIndex:0];
    }
    
    NSUInteger s = [indexPath section];
    
    NSString *k = [self.keys objectAtIndex:s];
    NSArray *kv = [self.keyValues objectForKey:k];
    NSUInteger r = [indexPath row];
    NSDictionary *dicObj = [kv objectAtIndex:r];
    
    NSString *visit_grp_name = [dicObj objectForKey:@"visit_grp_name"];
    NSString *visit_statr_time = [dicObj objectForKey:@"visit_statr_time"];
    NSString *visit_grp_add = [dicObj objectForKey:@"visit_grp_add"];
    NSString *visit_content = [dicObj objectForKey:@"visit_content"];
    
    NSString *visit_sta = [dicObj objectForKey:@"visit_sta"];
    visit_sta = [NSString stringWithFormat:@"%@",visit_sta];
    NSString *image_cnt = [dicObj objectForKey:@"image_cnt"];
    image_cnt = [NSString stringWithFormat:@"%@",image_cnt];
    NSString *reply_cnt = [dicObj objectForKey:@"reply_cnt"];
    reply_cnt = [NSString stringWithFormat:@"%@",reply_cnt];
    
    UILabel *lblVisit_grp_name = (UILabel*)[cell viewWithTag:100];
    UILabel *lblVisit_statr_time = (UILabel*)[cell viewWithTag:500];
    
#if (defined MANAGER_CS_VERSION) || (defined MANAGER_SY_VERSION)
    //客户经理姓名
    UILabel *lblVisit_customer_name = (UILabel *)[cell viewWithTag:600];
    lblVisit_customer_name.text = [dicObj objectForKey:@"vip_mngr_name"];
    UIImageView *imgCustomer=(UIImageView*)[cell viewWithTag:800];
    
    UIActivityIndicatorView *indicatorView=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicatorView.center=CGPointMake(imgCustomer.frame.size.width/2, imgCustomer.frame.size.height/2);
    [indicatorView startAnimating];
    [imgCustomer addSubview:indicatorView];
    
    NSURL *imgUrl=[NSURL URLWithString:[dicObj objectForKey:@"user_image"]];
    
    dispatch_queue_t queue =dispatch_queue_create("loadImage",NULL);
    dispatch_async(queue, ^{
        NSData *resultData = [NSData dataWithContentsOfURL:imgUrl];
        UIImage *img = [UIImage imageWithData:resultData];
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            imgCustomer.image=img;
            [indicatorView removeFromSuperview];
        });
        
    });
#endif
    
#if (defined STANDARD_CS_VERSION) || (defined STANDARD_SY_VERSION)
    UILabel *lblVisit_grp_add = (UILabel *)[cell viewWithTag:600];
    lblVisit_grp_add.text = visit_grp_add;
#endif
    
    
    
    UILabel *lblVisit_content = (UILabel *)[cell viewWithTag:700];
    
    UILabel *lblVisit_sta = (UILabel*)[cell viewWithTag:200];
    UILabel *lblImage_cnt = (UILabel*)[cell viewWithTag:300];
    UILabel *lblReply_cnt = (UILabel*)[cell viewWithTag:400];
    
    lblVisit_grp_name.text = visit_grp_name;
    lblVisit_statr_time.text = visit_statr_time;
    
    if(visit_content && (NSNull*)visit_content != [NSNull null] && visit_content.length > 0)
        lblVisit_content.text = visit_content;
    else
        lblVisit_content.text =@"无";
    
    //“visit_sta":拜访状态 -1:审核失败 0;未审核 1:未拜访 2:拜访完成 3:拜访失败
    if ([@"-1" isEqualToString:visit_sta]) {
    
        lblVisit_sta.text = @"审核失败";
        
    }else if([@"0" isEqualToString:visit_sta]){
        
        lblVisit_sta.text = @"待审核";
        
    }else if([@"1" isEqualToString:visit_sta]){
        
        lblVisit_sta.text = @"待拜访";
        lblVisit_sta.textColor=[UIColor orangeColor];
        
    }else if([@"2" isEqualToString:visit_sta]){
        
        lblVisit_sta.text = @"已完成";
        lblVisit_sta.textColor=[UIColor greenColor];
    }else if([@"3" isEqualToString:visit_sta]){
        
        lblVisit_sta.text = @"失访";
    }
    
    
    lblImage_cnt.text = image_cnt;
    lblReply_cnt.text = reply_cnt;
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger se = indexPath.section;
    NSInteger row = indexPath.row;
    
    NSString *k = [self.keys objectAtIndex:se];
    NSArray *aryObjs = [self.keyValues objectForKey:k];
    NSDictionary *dicObj = [aryObjs objectAtIndex:row];
    NSString *visit_sta = [dicObj objectForKey:@"visit_sta"];//拜访状态
    if ((NSNull *)visit_sta == [NSNull null]) {
        
        visit_sta = @"";
    }
    
#if (defined MANAGER_CS_VERSION) || (defined MANAGER_SY_VERSION)
    W_VisitPlanDetailsViewController *vc = [[W_VisitPlanDetailsViewController alloc] initWithNibName:@"W_VisitPlanDetailsViewController" bundle:nil];
    vc.dicSelectVisitPlanDetail = dicObj;
    vc.user = self.user;
    [self.navigationController pushViewController:vc animated:YES];
#endif
    
#if (defined STANDARD_CS_VERSION) || (defined STANDARD_SY_VERSION)
    visit_sta = [NSString stringWithFormat:@"%@",visit_sta];
    if ([@"1" isEqualToString:visit_sta]){//待拜访
        
        W_VisitPlanManageTableViewController *vc =[[W_VisitPlanManageTableViewController alloc] initWithNibName:@"W_VisitPlanManageTableViewController" bundle:nil];
        vc.dicSelectVisitPlanDetail = dicObj;
        vc.user = self.user;
        [self.navigationController pushViewController:vc animated:YES];
        
        
    } else{
        
        W_VisitPlanDetailsViewController *vc = [[W_VisitPlanDetailsViewController alloc] initWithNibName:@"W_VisitPlanDetailsViewController" bundle:nil];
        vc.dicSelectVisitPlanDetail = dicObj;
        vc.user = self.user;
        [self.navigationController pushViewController:vc animated:YES];
        
    }

#endif

    
    
    
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSLog(@"%d", indexPath.row);
//        [self.myArray removeObjectAtIndex:[indexPath row]];
//        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationTop];
        
        NSInteger se = indexPath.section;
        NSInteger row = indexPath.row;
        
        NSString *k = [self.keys objectAtIndex:se];
        NSArray *aryObjs = [self.keyValues objectForKey:k];
        NSDictionary *dicObj = [aryObjs objectAtIndex:row];
        NSString *row_id = [dicObj objectForKey:@"row_id"];
        row_id = [NSString stringWithFormat:@"%@",row_id];
        [self delVisitPlan:row_id];
        
    }
    
}

-(void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%d", indexPath.row);
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
#if (defined MANAGER_CS_VERSION) || (defined MANAGER_SY_VERSION)
    return UITableViewCellEditingStyleNone;
#endif
    
#if (defined STANDARD_CS_VERSION) || (defined STANDARD_SY_VERSION)
    NSUInteger s = [indexPath section];
    NSString *k = [self.keys objectAtIndex:s];
    NSArray *kv = [self.keyValues objectForKey:k];
    NSUInteger r = [indexPath row];
    NSDictionary *dicObj = [kv objectAtIndex:r];
    int visit_sta;
    if([dicObj objectForKey:@"visit_sta"] && (NSNull*)[dicObj objectForKey:@"visit_sta"] != [NSNull null])
        visit_sta = [[dicObj objectForKey:@"visit_sta"] intValue];
    
    if(visit_sta==1)
        return UITableViewCellEditingStyleDelete;
    return UITableViewCellEditingStyleNone;
#endif
    
}
-(void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%d", indexPath.row);
}

-(void)showMessage:(NSString*)infomation{
    
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"信息提示" message:infomation delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
    [myAlertView show];
}

-(void)refreshvisitPlanTableView{
    
    [self.visitPlanTableView reloadData];
}

-(void)connectToNetwork{
    while (hubFlag) {
        usleep(100000);
    }
}

-(void)connectToNetworkOther{
    while (hubFlag11) {
        usleep(100000);
    }

}

-(void)loadVisitPlanListData:(NSString *)visit_sta{
    
    hubFlag=YES;
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"数据查询中，请稍后...";
//    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    [bDict setObject:[NSNumber numberWithInt:self.user.userLvl] forKey:@"user_lvl"];
    [bDict setObject:[NSNumber numberWithInt:self.user.userID] forKey:@"user_id"];
    
#if (defined MANAGER_CS_VERSION) || (defined MANAGER_SY_VERSION)
[bDict setObject:@"" forKey:@"user_msisdn"];
#endif
    
#if (defined STANDARD_CS_VERSION) || (defined STANDARD_SY_VERSION)
[bDict setObject:self.user.userMobile forKey:@"user_msisdn"];
#endif
    
//    [bDict setObject:self.user.userMobile forKey:@"user_msisdn"];
    [bDict setObject:[NSNumber numberWithInt:self.user.userEnterprise] forKey:@"enterprise"];
    
    [NetworkHandling sendPackageWithUrl:@"visitplan/visitplanlist" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        if(!error){
            NSLog(@"sign in success");
            self.visitplanlist =[result objectForKey:@"visit"];
            if([self.visitplanlist count] > 0){
                [self performSelectorOnMainThread:@selector(reloadKesData:) withObject:visit_sta waitUntilDone:YES];
               // [self reloadKesData:visit_sta];
                
            }else{
                
                ;
            }
            
        }else{
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
-(void)reloadKesData:(NSString *)visit_sta{
    for (NSDictionary * dicObj in self.visitplanlist) {
        
        NSString *t_visit_sta = [dicObj objectForKey:@"visit_sta"];
        if ((NSNull *)t_visit_sta == [NSNull null]) {
            
            t_visit_sta = @"";
        }
        
        t_visit_sta = t_visit_sta?t_visit_sta : @"";
        t_visit_sta = [NSString stringWithFormat:@"%@",t_visit_sta];
        
        //                    NSLog(@"t_visit_sta = %@",t_visit_sta);
        if([@"9" isEqualToString:visit_sta]){//全部
            
            NSString *t_visit_statr_time = [dicObj objectForKey:@"visit_statr_time"];
            t_visit_statr_time = [t_visit_statr_time substringToIndex:10];
            if ([[self.keyValues allKeys] containsObject:t_visit_statr_time]) {
                
                NSMutableArray *t_maryVisitPlans = [self.keyValues objectForKey:t_visit_statr_time];
                [t_maryVisitPlans addObject:dicObj];
                
                [self.keyValues setValue:t_maryVisitPlans forKey:t_visit_statr_time];
                
            }else{
                
                NSMutableArray *t_maryVisitPlans = [[NSMutableArray alloc] init];
                [t_maryVisitPlans addObject:dicObj];
                [self.keyValues setValue:t_maryVisitPlans forKey:t_visit_statr_time];
            }
            
        }
        
        if (visit_sta.length > 1) {
            
            NSString *a = [visit_sta substringToIndex:1];
            NSString *b = [visit_sta substringFromIndex:2];
            
            if([a isEqualToString:t_visit_sta] || [b isEqualToString:t_visit_sta]){
                
                NSString *t_visit_statr_time = [dicObj objectForKey:@"visit_statr_time"];
                t_visit_statr_time = [t_visit_statr_time substringToIndex:10];
                if ([[self.keyValues allKeys] containsObject:t_visit_statr_time]) {
                    
                    NSMutableArray *t_maryVisitPlans = [self.keyValues objectForKey:t_visit_statr_time];
                    [t_maryVisitPlans addObject:dicObj];
                    
                    [self.keyValues setValue:t_maryVisitPlans forKey:t_visit_statr_time];
                    
                }else{
                    
                    NSMutableArray *t_maryVisitPlans = [[NSMutableArray alloc] init];
                    [t_maryVisitPlans addObject:dicObj];
                    [self.keyValues setValue:t_maryVisitPlans forKey:t_visit_statr_time];
                }
                
            }
            
            
        }else{
            
            if([visit_sta isEqualToString:t_visit_sta]){
                
                NSString *t_visit_statr_time = [dicObj objectForKey:@"visit_statr_time"];
                t_visit_statr_time = [t_visit_statr_time substringToIndex:10];
                if ([[self.keyValues allKeys] containsObject:t_visit_statr_time]) {
                    
                    NSMutableArray *t_maryVisitPlans = [self.keyValues objectForKey:t_visit_statr_time];
                    [t_maryVisitPlans addObject:dicObj];
                    
                    [self.keyValues setValue:t_maryVisitPlans forKey:t_visit_statr_time];
                    
                }else{
                    
                    NSMutableArray *t_maryVisitPlans = [[NSMutableArray alloc] init];
                    [t_maryVisitPlans addObject:dicObj];
                    [self.keyValues setValue:t_maryVisitPlans forKey:t_visit_statr_time];
                }
                
            }
        }
        
        
        
    }
    
    NSArray *array = [[self.keyValues allKeys] sortedArrayUsingComparator:^NSComparisonResult(NSString* key1, NSString* key2) {
        
        NSComparisonResult result = [key1 compare:key2];
        return result == NSOrderedAscending;
    }];
    self.keys=[[NSMutableArray alloc] initWithArray:array];
    
    [self performSelectorOnMainThread:@selector(refreshvisitPlanTableView) withObject:nil waitUntilDone:YES];
}

//-(NSComparisonResult)compareKey:(NSString *)key{
//    //默认按年龄排序
//    NSComparisonResult result = [key compare:self.compKey];//注意:基本数据类型要进行数据转换
//    //如果年龄一样，就按照名字排序
//    if (result == NSOrderedSame) {
//        result = [self.compKey compare:key];
//    }
//    return result;
//}
-(void)delVisitPlan:(NSString *)visitId{
    
    hubFlag=YES;
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"数据删除中，请稍后...";
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
    
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    [bDict setObject:[NSNumber numberWithInt:self.user.userLvl] forKey:@"user_lvl"];
    [bDict setObject:[NSNumber numberWithInt:self.user.userID] forKey:@"user_id"];
    [bDict setObject:self.user.userMobile forKey:@"user_msisdn"];
    [bDict setObject:[NSNumber numberWithInt:self.user.userEnterprise] forKey:@"enterprise"];
    
    [bDict setObject:visitId forKey:@"visit_id"];
    
    
    [NetworkHandling sendPackageWithUrl:@"visitplan/delvisitplan" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        hubFlag=NO;
        if(!error){
            
            NSLog(@"sign in success");
            BOOL flag=[[result objectForKey:@"flag"] boolValue];
            if(flag){
                
                [self performSelectorOnMainThread:@selector(showMessage:) withObject:@"删除成功！" waitUntilDone:YES];
                [self performSelectorOnMainThread:@selector(visitPlanAllOnClick:) withObject:nil waitUntilDone:YES];//重新加载数据
                
            }else{
                
                [self performSelectorOnMainThread:@selector(showMessage:) withObject:@"删除失败！" waitUntilDone:YES];
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
