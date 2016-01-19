//
//  AlreadyVisitPlanListViewController.m
//  CMCCMarketing
//
//  Created by kevin on 15/8/5.
//  Copyright (c) 2015年 talkweb. All rights reserved.
//

#import "AlreadyVisitPlanListViewController.h"
#import "PreferentialPurchaseSelectDateTimeViewController.h"
#import "MBProgressHUD.h"
#import "NetworkHandling.h"
#import "AlreadyVisitPlanListViewTableViewCell.h"
#import "ManagerWorkRecordDetailViewController.h"
#import "VisitedListTableViewController.h"

@interface AlreadyVisitPlanListViewController ()<PreferentialPurchaseSelectDateTimeViewControllerDelegate,MBProgressHUDDelegate,UITableViewDataSource,UITableViewDelegate>
{
    BOOL hudFlag;
    NSArray *tableviewArray;
    NSDictionary *passDict;
    //datapicker
    PreferentialPurchaseSelectDateTimeViewController *selectDateTimeViewController;
    UIView *backView;
    UIButton *selectDateWithButton;
}

@end

@implementation AlreadyVisitPlanListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initSubPage];
    [self loadPlanlist];
    // Do any additional setup after loading the view from its nib.
}

- (void) initSubPage{
    
    if(IOS7)
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"320X64"] forBarMetrics:UIBarMetricsDefault];
    else
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"320X44"] forBarMetrics:UIBarMetricsDefault];
    
    self.navigationItem.title = @"工作日报日志";
    UIBarButtonItem *leftButton=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回1"] style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    [leftButton setTintColor:[UIColor whiteColor]];
    [self.navigationItem setLeftBarButtonItem:leftButton];
    
    UIColor * color = [UIColor whiteColor];
    NSDictionary * dict=[NSDictionary dictionaryWithObject:color forKey:UITextAttributeTextColor];
    [self.navigationController.navigationBar setTitleTextAttributes:dict];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    
    UIBarButtonItem *rightButton=[[UIBarButtonItem alloc]initWithTitle:@"查询" style:UIBarButtonItemStylePlain target:self action:@selector(loadPlanlist)];
    [rightButton setTintColor:[UIColor whiteColor]];
    [self.navigationItem setRightBarButtonItem:rightButton];
    /**
     *  选择时间的button
     */
    [self.startTime  addTarget:self action:@selector(itemSupplyTimeButtonOnclick:) forControlEvents:UIControlEventTouchUpInside];
   }


-(void)loadPlanlist{
    hudFlag=YES;
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"数据查询中，请稍后...";
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
    /**
     接口地址：
     changsha\v1_6\visitplan\visitlistcnt
     必传参数：
     user_lvl 用户级别
     user_id用户id
     visit_start_time开始时间
     visit_end_time结束时间
     回传参数
     vip_mngr_msisdn 客户经理手机号码
     vip_mngr_name  客户经理姓名
     visit_cnt 已完成拜访计划数
     */
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
  
    [bDict setObject:[NSNumber numberWithInt:self.user.userLvl] forKey:@"user_lvl"];
    [bDict setObject:[NSNumber numberWithInt:self.user.userID] forKey:@"user_id"];
    //开始时间
    NSString *startTimeString=self.startTime.titleLabel.text;
    if ([startTimeString isEqualToString:@"选择时间"]) {
        //获取当前时间
        NSDate *  senddate=[NSDate date];
        NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
        [dateformatter setDateFormat:@"YYYY-MM-dd"];
        startTimeString=[dateformatter stringFromDate:senddate];
    }
//    //结束时间
//    NSString *endTimeString=self.endTime.titleLabel.text;
//    if ([endTimeString isEqualToString:@"结束时间"]) {
//        //获取当前时间
//        NSDate *  senddate=[NSDate date];
//        NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
//        [dateformatter setDateFormat:@"YYYY-MM-dd"];
//        endTimeString=[dateformatter stringFromDate:senddate];
//    }
    
    [bDict setObject:startTimeString forKey:@"time"];
//    [bDict setObject:endTimeString forKey:@"visit_end_time"];
    [NetworkHandling sendPackageWithUrl:@"visitplan/visitlistcnt" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        if(!error){
            NSLog(@"sign in success");
            tableviewArray =[result objectForKey:@"visit"];
            //刷新表格，装入数据
            [self performSelectorOnMainThread:@selector(refreshTableView) withObject:nil waitUntilDone:YES];
            
            
        }else{
            int errorCode=[[result valueForKey:@"errorcode"] intValue];
            NSString *errorInfo=[result valueForKey:@"errorinf"];
            if(!errorInfo)
                errorInfo=@"提交数据出错了！";
            NSLog(@"error:%d info:%@",errorCode,errorInfo);
            [self performSelectorOnMainThread:@selector(showMessage:) withObject:errorInfo waitUntilDone:YES];
        }
        hudFlag=NO;
    }];

    
}

-(void)refreshTableView{
    [self.visitPlanList reloadData];
    
}

-(void)goBack{
   [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * identifier = @"AlreadyVisitPlanListViewTableViewCell";
    AlreadyVisitPlanListViewTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"AlreadyVisitPlanListViewTableViewCell" owner:nil options:nil]lastObject];
    }
    //去掉选中效果
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSUInteger row = [indexPath row];
  //  NSMutableDictionary *dic = [tableviewArray objectAtIndex:row];
    
    if ([tableviewArray count]==0) {
        return nil;
    }
    cell.NameLabel.text=[[tableviewArray objectAtIndex:row]objectForKey:@"vip_mngr_name"];
    NSString *dailycnt =[[[tableviewArray objectAtIndex:row]objectForKey:@"daily_cnt"]stringValue];
    NSString *displayDailycnt;
    if ([dailycnt isEqualToString:@"0"]  ) {
        displayDailycnt=@"否";
    } else {
         displayDailycnt=@"是";
    }
    [cell.buttonDailyReport setTitle:displayDailycnt forState:UIControlStateNormal];
    
    cell.buttonDailyReport.tag=indexPath.row;
    [cell.buttonDailyReport addTarget:self action:@selector(clickDaliyReportBton:) forControlEvents:UIControlEventTouchUpInside];
    
    NSString *Visitcnt =[[[tableviewArray objectAtIndex:row]objectForKey:@"visit_cnt"]stringValue];
    [cell.bottonVisit setTitle:Visitcnt forState:UIControlStateNormal];
    cell.bottonVisit.tag=indexPath.row;
    [cell.bottonVisit addTarget:self action:@selector(clickVisitListBton:)  forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableviewArray count];
}
#pragma 选日志按钮
-(void)clickDaliyReportBton:(UIButton*)button{
    NSLog(@"index=%d",button.tag);
    
    NSInteger index=button.tag;
      NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:1]; //匹配坐标点
     NSString *whether =[[[tableviewArray objectAtIndex:indexPath.row]objectForKey:@"daily_cnt"]stringValue];
    if ([whether isEqualToString:@"0"]) {
        return;
    }
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"Manager.WorkRecord" bundle:nil];
    ManagerWorkRecordDetailViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"ManagerWorkRecordDetailViewControllerId"];
    vc.FromVisitlist =[tableviewArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma 选拜访计划按钮
-(void)clickVisitListBton:(UIButton*)button{
    NSInteger index=button.tag;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:1]; //匹配坐标点
    NSString *whether =[[[tableviewArray objectAtIndex:indexPath.row]objectForKey:@"visit_cnt"]stringValue];
    if ([whether isEqualToString:@"0"]) {
        return;
    }
    VisitedListTableViewController *vc = [[VisitedListTableViewController alloc] initWithNibName:@"VisitedListTableViewController" bundle:nil];
    vc.user = self.user;
   vc.FromVisitedlist =[tableviewArray objectAtIndex:indexPath.row];
    //vc.title=@"拜访计划";
    [self.navigationController pushViewController:vc animated:YES];


}

#pragma mark - 选择时间控制器
-(void)itemSupplyTimeButtonOnclick:(id)sender{
    //关闭当前所有键盘
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"BusinessProcess" bundle:nil];
    selectDateTimeViewController=[storyboard instantiateViewControllerWithIdentifier:@"PreferentialPurchaseSelectDateTimeViewControllerId"];
    selectDateTimeViewController.delegate=self;
    CGRect rect=selectDateTimeViewController.view.frame;
    selectDateTimeViewController.modeDateAndTime=1;
    rect.origin.x=0;
    rect.origin.y=[[UIScreen mainScreen] bounds].size.height - 260;
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
    
    selectDateWithButton=sender;
    
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
    //    selectDateWithTextField.text=[dateFormatter stringFromDate:controller.datetimePicker.date];
    [selectDateWithButton setTitle:dateString forState:UIControlStateNormal];
    [self preferentialPurchaseSelectDateTimeViewControllerDidCancel];
}

#pragma mark -网络API相关

-(void)connectToNetwork{
    while (hudFlag) {
        usleep(100000);
    }
}
-(void)showMessage:(NSString*)infomation{
    
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"信息提示" message:infomation delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
    [myAlertView show];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
