//
//  MainViewController.m
//  CMCCMarketing
//
//  Created by talkweb on 14-9-1.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//
#import "SettingViewController.h"
#import "MainViewController.h"
#import "SignViewController.h"
#import "MarketingViewController.h"
#import "OtherRegressViewController.h"

#import "DataAcquisitionTableViewController.h"
#import "BusinesProcessViewController.h"
#import "CustomerManagerViewController.h"
#import "MonthlyTasksTableViewController.h"
#import "CustomersWarningViewController.h"
#import "KnowledgeBaseTableViewController.h"
#import "VisitPlanViewController.h"
#import "CsAchievementListViewController.h"

#import "W_VisitPlanViewController.h"

#import "SettingInformationViewController.h"
#import "ChagangMonitorViewController.h"
#import "VisitPlanMainListTableViewController.h"
#import "OtherRegressManagerListTableViewController.h"
#import "SMSMarketingMainViewController.h"

#import "RemindHandling.h"
#import "VariableStore.h"

#import "OnlineTestViewController.h"
#import "ResultShowHomepageViewController.h"
#import "BMKLocationService.h"
#import "DocumentHandling.h"
#import "CustomerManagerSYTableViewController.h"
#import "MainCollectionViewCell.h"
#import "CustomerManagerCSTableViewController.h"

/**
 *异网回归
 */
#define kPushDifflink @"difflink"
/**
 * 客户管理
 */
#define kPushCheckAddress @"checkaddress"
/**
 * 客户管理
 */
#define kPushUpdateLinkMan @"updlinkman"
/**
 * 拜访计划
 */
#define kPushVisitPlan @"visit"
/**
 * 月度任务
 */
#define kPushMonthlyTask @"task"
/**
 * 月度任务回复
 */
#define kPushMonthlyTaskReply @"taskReply"
/** 客户预警
 * 来自提醒消息
 */
#define kRemainCustomerWarning @"warning"


@interface MainViewController ()<MBProgressHUDDelegate,SettingViewControllerDelegate,RemindHandlingDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate,UICollectionViewDataSource,UICollectionViewDelegate>{
    BOOL goInformation;
    BMKLocationService *_locService;
    BMKGeoCodeSearch *geoSearch;
    int locationUpdateCount;
    NSMutableArray *listArray;
}

@end

@implementation MainViewController

static NSString * const reuseIdentifier = @"MainCollectionViewCell";

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    RemindHandling *remindHandling=[[RemindHandling alloc] init];
    remindHandling.user=self.user;
    remindHandling.delegate=self;
    [remindHandling getRemindDataWithType:RemaindTypeWithOtherRegress];
    [remindHandling getRemindDataWithType:RemaindTypeWithCustomerManager];
    [remindHandling getRemindDataWithType:RemaindTypeWithCustomerWarning];
    [remindHandling getRemindDataWithType:RemaindTypeWithVisitPlan];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    lbUserName.text=self.user.userName;
    lbUserCode.text=self.user.userCode;
    listArray=[NSMutableArray new];
   
    /// key 用来推送和提醒定位查找
    
#if  (defined STANDARD_SY_VERSION)
    NSMutableDictionary *dict1=[NSMutableDictionary new];
    [dict1 setObject:@"精准营销" forKey:@"title"];
    [dict1 setObject:@"精准营销" forKey:@"image"];
    [dict1 setObject:@"" forKey:@"key"];
    [listArray addObject:dict1];
    
    NSMutableDictionary *dict2=[NSMutableDictionary new];
    [dict2 setObject:@"短信营销" forKey:@"title"];
    [dict2 setObject:@"短信营销" forKey:@"image"];
    [dict2 setObject:@"" forKey:@"key"];
    [listArray addObject:dict2];
    
    NSMutableDictionary *dict3=[NSMutableDictionary new];
    [dict3 setObject:@"业务办理" forKey:@"title"];
    [dict3 setObject:@"业务办理" forKey:@"image"];
    [dict3 setObject:@"" forKey:@"key"];
    [listArray addObject:dict3];
    
    NSMutableDictionary *dict4=[NSMutableDictionary new];
    [dict4 setObject:@"异网回归" forKey:@"title"];
    [dict4 setObject:@"异网回归" forKey:@"image"];
    [dict4 setObject:kPushDifflink forKey:@"key"];
    [listArray addObject:dict4];
    
    NSMutableDictionary *dict5=[NSMutableDictionary new];
    [dict5 setObject:@"客户管理" forKey:@"title"];
    [dict5 setObject:@"客户管理" forKey:@"image"];
    [dict5 setObject:[NSString stringWithFormat:@"%@,%@",kPushCheckAddress,kPushUpdateLinkMan] forKey:@"key"];
    [listArray addObject:dict5];
    
    NSMutableDictionary *dict6=[NSMutableDictionary new];
    [dict6 setObject:@"知识库" forKey:@"title"];
    [dict6 setObject:@"知识库" forKey:@"image"];
    [dict6 setObject:@"" forKey:@"key"];
    [listArray addObject:dict6];
    
    NSMutableDictionary *dict7=[NSMutableDictionary new];
    [dict7 setObject:@"客户预警" forKey:@"title"];
    [dict7 setObject:@"客户预警" forKey:@"image"];
    [dict7 setObject:@"" forKey:@"key"];
    [listArray addObject:dict7];
    /**
     *  修改长沙客户拜访为工作日志
     */
    NSMutableDictionary *dict8=[NSMutableDictionary new];
    [dict8 setObject:@"工作日志" forKey:@"title"];
    [dict8 setObject:@"客户拜访" forKey:@"image"];
    [dict8 setObject:kPushVisitPlan forKey:@"key"];
    [listArray addObject:dict8];
    
    NSMutableDictionary *dict9=[NSMutableDictionary new];
    [dict9 setObject:@"数据采集" forKey:@"title"];
    [dict9 setObject:@"数据采集" forKey:@"image"];
    [dict9 setObject:@"" forKey:@"key"];
    [listArray addObject:dict9];
    
    
#endif
#if (defined STANDARD_CS_VERSION)
    NSMutableDictionary *dict1=[NSMutableDictionary new];
    [dict1 setObject:@"工作日志" forKey:@"title"];
    [dict1 setObject:@"客户拜访" forKey:@"image"];
    [dict1 setObject:kPushVisitPlan forKey:@"key"];
    [listArray addObject:dict1];
    
    NSMutableDictionary *dict2=[NSMutableDictionary new];
    [dict2 setObject:@"精准营销" forKey:@"title"];
    [dict2 setObject:@"精准营销" forKey:@"image"];
    [dict2 setObject:@"" forKey:@"key"];
    [listArray addObject:dict2];
    
    NSMutableDictionary *dict3=[NSMutableDictionary new];
    [dict3 setObject:@"短信营销" forKey:@"title"];
    [dict3 setObject:@"短信营销" forKey:@"image"];
    [dict3 setObject:@"" forKey:@"key"];
    [listArray addObject:dict3];

    NSMutableDictionary *dict4=[NSMutableDictionary new];
    [dict4 setObject:@"客户管理" forKey:@"title"];
    [dict4 setObject:@"客户管理" forKey:@"image"];
    [dict4 setObject:[NSString stringWithFormat:@"%@,%@",kPushCheckAddress,kPushUpdateLinkMan] forKey:@"key"];
    [listArray addObject:dict4];
    
    NSMutableDictionary *dict5=[NSMutableDictionary new];
    [dict5 setObject:@"客户预警" forKey:@"title"];
    [dict5 setObject:@"客户预警" forKey:@"image"];
    [dict5 setObject:@"" forKey:@"key"];
    [listArray addObject:dict5];
    
    NSMutableDictionary *dict6=[NSMutableDictionary new];
    [dict6 setObject:@"业务通报" forKey:@"title"];
    [dict6 setObject:@"业绩通报" forKey:@"image"];
    [dict6 setObject:@"" forKey:@"key"];
    [listArray addObject:dict6];
    
    NSMutableDictionary *dict7=[NSMutableDictionary new];
    [dict7 setObject:@"知识库" forKey:@"title"];
    [dict7 setObject:@"知识库" forKey:@"image"];
    [dict7 setObject:@"" forKey:@"key"];
    [listArray addObject:dict7];
    
    NSMutableDictionary *dict8=[NSMutableDictionary new];
    [dict8 setObject:@"数据采集" forKey:@"title"];
    [dict8 setObject:@"数据采集" forKey:@"image"];
    [dict8 setObject:@"" forKey:@"key"];
    [listArray addObject:dict8];
    
    NSMutableDictionary *dict9=[NSMutableDictionary new];
    [dict9 setObject:@"异网客户" forKey:@"title"];
    [dict9 setObject:@"异网回归" forKey:@"image"];
    [dict9 setObject:kPushDifflink forKey:@"key"];
    [listArray addObject:dict9];

    NSMutableDictionary *dict10=[NSMutableDictionary new];
    [dict10 setObject:@"业务办理" forKey:@"title"];
    [dict10 setObject:@"业务办理" forKey:@"image"];
    [dict10 setObject:@"" forKey:@"key"];
    [listArray addObject:dict10];
#endif
#if (defined MANAGER_CS_VERSION) 
    NSMutableDictionary *dict1=[NSMutableDictionary new];
    [dict1 setObject:@"查岗监控" forKey:@"title"];
    [dict1 setObject:@"主管－查岗监控" forKey:@"image"];
    [dict1 setObject:@"" forKey:@"key"];
    [listArray addObject:dict1];
    
    NSMutableDictionary *dict5=[NSMutableDictionary new];
    [dict5 setObject:@"业绩通报" forKey:@"title"];
    [dict5 setObject:@"主管－业绩通报" forKey:@"image"];
    [dict5 setObject:@"" forKey:@"key"];
    [listArray addObject:dict5];
    
    /**
     *   修改长沙客户拜访为工作日志
     */
    NSMutableDictionary *dict2=[NSMutableDictionary new];
    [dict2 setObject:@"工作日志" forKey:@"title"];
    [dict2 setObject:@"主管－客户拜访" forKey:@"image"];
    [dict2 setObject:kPushVisitPlan forKey:@"key"];
    [listArray addObject:dict2];
    
    NSMutableDictionary *dict4=[NSMutableDictionary new];
    [dict4 setObject:@"客户预警" forKey:@"title"];
    [dict4 setObject:@"主管－客户预警" forKey:@"image"];
    [dict4 setObject:@"" forKey:@"key"];
    [listArray addObject:dict4];
    
    NSMutableDictionary *dict6=[NSMutableDictionary new];
    [dict6 setObject:@"异网回归" forKey:@"title"];
    [dict6 setObject:@"主管－异网回归" forKey:@"image"];
    [dict6 setObject:kPushDifflink forKey:@"key"];
    [listArray addObject:dict6];
    
    NSMutableDictionary *dict3=[NSMutableDictionary new];
    [dict3 setObject:@"客户管理" forKey:@"title"];
    [dict3 setObject:@"主管－客户管理" forKey:@"image"];
    [dict3 setObject:[NSString stringWithFormat:@"%@,%@",kPushCheckAddress,kPushUpdateLinkMan] forKey:@"key"];
    [listArray addObject:dict3];
    
    
    signButton.hidden=YES;
#endif
    
#ifdef STANDARD_SY_VERSION
    //邵阳客户拜访改 工作日志
    NSMutableDictionary *dict111=[listArray objectAtIndex:7];
    [dict111 setObject:@"工作日志" forKey:@"title"];
    
    NSMutableDictionary *dict10=[NSMutableDictionary new];
    [dict10 setObject:@"月度任务" forKey:@"title"];
    [dict10 setObject:@"月度任务" forKey:@"image"];
    [dict10 setObject:[NSString stringWithFormat:@"%@,%@",kPushMonthlyTaskReply,kPushMonthlyTask] forKey:@"key"];
    [listArray addObject:dict10];
    
    NSMutableDictionary *dict11=[NSMutableDictionary new];
    [dict11 setObject:@"在线考试" forKey:@"title"];
    [dict11 setObject:@"在线考试" forKey:@"image"];
    [dict11 setObject:@"" forKey:@"key"];
    [listArray addObject:dict11];
    
    NSMutableDictionary *dict12=[NSMutableDictionary new];
    [dict12 setObject:@"业绩通报" forKey:@"title"];
    [dict12 setObject:@"业绩通报" forKey:@"image"];
    [dict12 setObject:@"" forKey:@"key"];
    [listArray addObject:dict12];
    
    lbTitle.text=@"和营销 (营销经理端)";
#endif
    
#ifdef MANAGER_SY_VERSION
    //邵阳主管

    NSMutableDictionary *dict1=[NSMutableDictionary new];
    [dict1 setObject:@"查岗监控" forKey:@"title"];
    [dict1 setObject:@"主管－查岗监控" forKey:@"image"];
    [dict1 setObject:@"" forKey:@"key"];
    [listArray addObject:dict1];

    NSMutableDictionary *dict6=[NSMutableDictionary new];
    [dict6 setObject:@"异网回归" forKey:@"title"];
    [dict6 setObject:@"主管－异网回归" forKey:@"image"];
    [dict6 setObject:kPushDifflink forKey:@"key"];
    [listArray addObject:dict6];

    NSMutableDictionary *dict3=[NSMutableDictionary new];
    [dict3 setObject:@"客户管理" forKey:@"title"];
    [dict3 setObject:@"主管－客户管理" forKey:@"image"];
    [dict3 setObject:[NSString stringWithFormat:@"%@,%@",kPushCheckAddress,kPushUpdateLinkMan] forKey:@"key"];
    [listArray addObject:dict3];
    
        NSMutableDictionary *dict7=[NSMutableDictionary new];
        [dict7 setObject:@"月度任务" forKey:@"title"];
        [dict7 setObject:@"主管－月度任务" forKey:@"image"];
        [dict7 setObject:[NSString stringWithFormat:@"%@,%@",kPushMonthlyTaskReply,kPushMonthlyTask] forKey:@"key"];
        [listArray addObject:dict7];
    
    NSMutableDictionary *dict10=[NSMutableDictionary new];
    [dict10 setObject:@"知识库" forKey:@"title"];
    [dict10 setObject:@"知识库" forKey:@"image"];
    [dict10 setObject:@"" forKey:@"key"];
    [listArray addObject:dict10];
    
    NSMutableDictionary *dict4=[NSMutableDictionary new];
    [dict4 setObject:@"客户预警" forKey:@"title"];
    [dict4 setObject:@"主管－客户预警" forKey:@"image"];
    [dict4 setObject:@"" forKey:@"key"];
    [listArray addObject:dict4];


    NSMutableDictionary *dict111=[NSMutableDictionary new];
    [dict111 setObject:@"工作日志" forKey:@"title"];
    //长沙为客户拜访，邵阳为工作日志，共用一个图标
    [dict111 setObject:@"客户拜访" forKey:@"image"];
    [dict111 setObject:kPushVisitPlan forKey:@"key"];
    [listArray addObject:dict111];

    
    NSMutableDictionary *dict9=[NSMutableDictionary new];
    [dict9 setObject:@"数据采集" forKey:@"title"];
    [dict9 setObject:@"数据采集" forKey:@"image"];
    [dict9 setObject:@"" forKey:@"key"];
    [listArray addObject:dict9];
    
   
    
    NSMutableDictionary *dict11=[NSMutableDictionary new];
    [dict11 setObject:@"在线考试" forKey:@"title"];
    [dict11 setObject:@"在线考试" forKey:@"image"];
    [dict11 setObject:@"" forKey:@"key"];
    [listArray addObject:dict11];
    
    NSMutableDictionary *dict12=[NSMutableDictionary new];
    [dict12 setObject:@"业绩通报" forKey:@"title"];
    [dict12 setObject:@"业绩通报" forKey:@"image"];
    [dict12 setObject:@"" forKey:@"key"];
    [listArray addObject:dict12];
    
    lbTitle.text=@"和营销 (主管端)";
    signButton.hidden=YES;
#endif

    listView.dataSource=self;
    listView.delegate=self;
    
    [self initUserLocation];
    [self loadUserImage];
    
    [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerFunc) userInfo:nil repeats:YES];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkRemoteNotificationObserver:) name:@"remoteNotification" object:nil];
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *buildVersionString = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    
    lbVersion.text=[NSString stringWithFormat:@"-v%@",buildVersionString];
    
}


-(void)loadUserImage{
    if(![self.user.userImageUrl length])
        return;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSURL *url=[NSURL URLWithString:self.user.userImageUrl];
        NSData *data=[[NSData alloc] initWithContentsOfURL:url];
        UIImage *image=[UIImage imageWithData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            [btUserImage setImage:image forState:UIControlStateNormal];
            btUserImage.layer.cornerRadius=btUserImage.frame.size.width/2;
            btUserImage.layer.masksToBounds=YES;
        });
    });
}
-(void)timerFunc{
    NSDate *date=[NSDate date];
    NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone localTimeZone]];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh-CN"]];
    [formatter setDateFormat:@"MM月dd日 EEEE HH:mm:ss"];
    NSString* strDate = [formatter stringFromDate:date];
    lbDateTime.text=strDate;
}
-(void)checkRemoteNotificationObserver:(NSNotification*)notification{
    
    [self performSelectorOnMainThread:@selector(processPushMsg:) withObject:[notification object] waitUntilDone:YES];
}
-(void)processPushMsg:(NSDictionary*)dict{
    
    NSLog(@"receive remote notification .... \n%@",dict);
    NSString *notice=[dict objectForKey:@"notice"];
    NSString *type=[dict objectForKey:@"type"];
    
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.delegate = self;
    HUD.labelText = notice;
    [HUD show:YES];
    [HUD hide:YES afterDelay:2];
    
    MainCollectionViewCell *cell;
    
    for (NSDictionary *dict in listArray) {
        NSString *key = [dict objectForKey:@"key"];
        NSArray *keys = [key componentsSeparatedByString:@","];
        for (NSString *k in keys) {
            if([k isEqualToString:type]){
                cell = (MainCollectionViewCell*)[listView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:[listArray indexOfObject:dict] inSection:0]];
                break;
            }
        }
    }
    
//    int badgeNumber = [cell.itemBadge.text intValue];
    cell.badgeNumber++;
    cell.itemBadge.text=[NSString stringWithFormat:@"%d",cell.badgeNumber];
    cell.itemBadgeBackgroundView.hidden=NO;
    cell.itemBadge.hidden=NO;
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"settingSegue"]){
        UINavigationController *navController=segue.destinationViewController;
        SettingViewController *settingViewController=[navController.viewControllers objectAtIndex:0];
        settingViewController.user=self.user;
        settingViewController.goInformation=goInformation;
        settingViewController.delegate=self;
        goInformation=NO;
    }
    //signSegue
    if([segue.identifier isEqualToString:@"signSegue"]){
        UINavigationController *navController=segue.destinationViewController;
        SignViewController *controller=[navController.viewControllers objectAtIndex:0];
        controller.user=self.user;
    }
    
}
#pragma mark - 短信营销
- (IBAction)goSMSMarketing:(id)sender {
    // 1.加载需要显示的界面的storyboard名称
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"SMSMarketing" bundle:nil];
    // 2.创建要显示的控制器或者导航栏控制器填入UIStoryboard的ID
    UINavigationController *controller=[sb instantiateViewControllerWithIdentifier:@"SMSNavController"];
    // 3.弹出控制器 (传递参数需将UINavigationController和viewControllers关系在storyboard设置为relateionship)
    SMSMarketingMainViewController * SMSMarketingMainView = [controller.viewControllers objectAtIndex:0];
    SMSMarketingMainView.user=self.user;
    [self presentViewController:controller animated:YES completion:nil];
    
}

#pragma mark - 长沙经理端业绩通报
- (IBAction)goCSAchievment:(id)sender {
    // 1.加载需要显示的界面的storyboard名称
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"CSAchvievementStoryboard" bundle:nil];
    // 2.创建要显示的控制器或者导航栏控制器填入UIStoryboard的ID
   UINavigationController *controller=[sb instantiateViewControllerWithIdentifier:@"CSAchNavController"];
    // 3.弹出控制器 (传递参数需将UINavigationController和viewControllers关系在storyboard设置为relateionship)
    CsAchievementListViewController * CsAchievementListView = [controller.viewControllers objectAtIndex:0];
    CsAchievementListView.user=self.user;
    [self presentViewController:controller animated:YES completion:nil];

}

#pragma mark - 数据采集
- (IBAction)goDataAcquisition:(id)sender {
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"DataAcquisition" bundle:nil];
    UINavigationController *controller=[storyboard instantiateViewControllerWithIdentifier:@"DataAcquisitionTableViewControllerId"];
    DataAcquisitionTableViewController *dataAcquisitionController = [controller.viewControllers objectAtIndex:0];
    dataAcquisitionController.user=self.user;
    [self presentViewController:controller animated:YES completion:nil];
}
#pragma mark - 客户拜访(邵阳端为“工作日志”)
- (IBAction)goVisitPlan:(id)sender {
    UINavigationController *nav = [[UINavigationController alloc] init];
    nav.navigationBar.tintColor=[UIColor whiteColor];
//#if (defined STANDARD_SY_VERSION) || (defined MANAGER_SY_VERSION)
    VisitPlanMainListTableViewController *vlistc=[[VisitPlanMainListTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    vlistc.user=self.user;
    [nav pushViewController:vlistc animated:YES];
//#endif
    /**
     修改长沙端，增加工作日报
     */
//#if (defined STANDARD_CS_VERSION) || (defined MANAGER_CS_VERSION)
//    W_VisitPlanViewController *vc = [[W_VisitPlanViewController alloc] initWithNibName:@"W_VisitPlanViewController" bundle:nil];
//    vc.user = self.user;
//    [nav pushViewController:vc animated:YES];
//#endif
    
    
    [self presentViewController:nav animated:YES completion:nil];
     

    //VisitPlanMainListTableViewController

}
#pragma mark - 客户预警
- (IBAction)goCustomersWarning:(id)sender {
    //CustomersWarningViewControllerId
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"CustomersWarning" bundle:nil];
    UINavigationController *controller=[storyboard instantiateViewControllerWithIdentifier:@"CustomersWarningViewControllerId"];
    CustomersWarningViewController *warningViewController=[controller.viewControllers objectAtIndex:0];
    warningViewController.user=self.user;
    [self presentViewController:controller animated:YES completion:nil];
}
#pragma mark - 知识库
- (IBAction)goKnowledgeBase:(id)sender {
    //KnowledgeBaseTableViewController
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"KnowledgeBase" bundle:nil];
    UINavigationController *controller=[storyboard instantiateViewControllerWithIdentifier:@"KnowledgeBaseTableViewControllerId"];
    KnowledgeBaseTableViewController *knowledgeBaseController=[controller.viewControllers objectAtIndex:0];
    knowledgeBaseController.user=self.user;
    [self presentViewController:controller animated:YES completion:nil];
}
#pragma mark- 月度任务
- (IBAction)goMonthlyTasks:(id)sender {
    //MonthlyTasksViewControllerId
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"MonthlyTasks" bundle:nil];
    UINavigationController *controller=[storyboard instantiateViewControllerWithIdentifier:@"MonthlyTasksViewControllerId"];
    MonthlyTasksTableViewController *monthlyTasksTableViewController=[controller.viewControllers objectAtIndex:0];
    monthlyTasksTableViewController.user=self.user;
    [self presentViewController:controller animated:YES completion:nil];
}
- (IBAction)goManagerMonthlyTasks:(id)sender {
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"Manager.MonthlyTasks" bundle:nil];
    UINavigationController *controller=[storyboard instantiateViewControllerWithIdentifier:@"ManagerMonthlyTasksTableViewControllerId"];
    MonthlyTasksTableViewController *monthlyTasksTableViewController=[controller.viewControllers objectAtIndex:0];
    monthlyTasksTableViewController.user=self.user;
    [self presentViewController:controller animated:YES completion:nil];
}


#pragma mark - 客户管理
- (IBAction)goCustomerManager:(id)sender {

#if (defined STANDARD_SY_VERSION) || (defined MANAGER_SY_VERSION)
    CustomerManagerSYTableViewController *sycontroller=[[CustomerManagerSYTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    sycontroller.user=self.user;
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:sycontroller];
    navi.navigationBar.tintColor=[UIColor whiteColor];
    [self presentViewController:navi animated:YES completion:nil];
#endif
    
#if (defined STANDARD_CS_VERSION) || (defined MANAGER_CS_VERSION)
    CustomerManagerCSTableViewController *sycontroller=[[CustomerManagerCSTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    sycontroller.user=self.user;
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:sycontroller];
    navi.navigationBar.tintColor=[UIColor whiteColor];
    [self presentViewController:navi animated:YES completion:nil];
//    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"CustomerManager" bundle:nil];
//    UINavigationController *controller=[storyboard instantiateViewControllerWithIdentifier:@"CustomerManagerViewControllerId"];
//    CustomerManagerViewController *customerManagerViewController=[controller.viewControllers objectAtIndex:0];
//    customerManagerViewController.user=self.user;
//    [self presentViewController:controller animated:YES completion:nil];
#endif
}
#pragma mark - 异网回归
- (IBAction)goOtherRegress:(id)sender {
    //OtherRegressManagerListTableViewControllerId
#if (defined MANAGER_CS_VERSION) || (defined MANAGER_SY_VERSION)
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"Manager.OtherRegress" bundle:nil];
    UINavigationController *controller=[storyboard instantiateViewControllerWithIdentifier:@"OtherRegressManagerListTableViewControllerId"];
    OtherRegressManagerListTableViewController *otherRegressViewController=[controller.viewControllers objectAtIndex:0];
    otherRegressViewController.user=self.user;
    [self presentViewController:controller animated:YES completion:nil];
#endif
    
    //#ifdef STANDARD_VERSION
#if (defined STANDARD_CS_VERSION) || (defined STANDARD_SY_VERSION)
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"OtherRegress" bundle:nil];
    UINavigationController *controller=[storyboard instantiateViewControllerWithIdentifier:@"OtherRegressViewControllerId"];
    OtherRegressViewController *otherRegressViewController=[controller.viewControllers objectAtIndex:0];
    otherRegressViewController.user=self.user;
    [self presentViewController:controller animated:YES completion:nil];
#endif
}
#pragma mark - 业务办理
- (IBAction)goBusinesProcess:(id)sender {
    //BusinesProcessViewControllerId
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"BusinessProcess" bundle:nil];
    UINavigationController *controller=[storyboard instantiateViewControllerWithIdentifier:@"BusinesProcessViewControllerId"];
    BusinesProcessViewController *businessProecessViewController=[controller.viewControllers objectAtIndex:0];
    businessProecessViewController.user=self.user;
    [self presentViewController:controller animated:YES completion:nil];
}
#pragma mark - 主管业务办理
- (IBAction)goManagerBusinessProcess:(id)sender {

    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.delegate = self;
    HUD.labelText = @"正在建设中...";
    [HUD show:YES];
    [HUD hide:YES afterDelay:2];

}

#pragma mark - 精准营销
- (IBAction)goMarketing:(id)sender {
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"Marketing" bundle:nil];
    UINavigationController *controller=[storyboard instantiateViewControllerWithIdentifier:@"MarketingViewControllerId"];
    MarketingViewController *marketingController=[controller.viewControllers objectAtIndex:0];
    marketingController.user=self.user;
    
    [self presentViewController:controller animated:YES completion:nil];
}
#pragma mark - 查岗监控
- (IBAction)goChagangMonitor:(id)sender {

    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"Manager.ChagangMonitor" bundle:nil];
    UINavigationController *controller=[storyboard instantiateViewControllerWithIdentifier:@"ChagangMonitorViewControllerId"];
    ChagangMonitorViewController *viewController=[controller.viewControllers objectAtIndex:0];
    viewController.user=self.user;
    [self presentViewController:controller animated:YES completion:nil];
    
    
}

#pragma mark - 在线考试
- (IBAction)goOnlineTest:(id)sender {
    
    OnlineTestViewController *vc = [[OnlineTestViewController alloc] initWithNibName:@"OnlineTestViewController" bundle:nil];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:vc];
    navi.navigationBar.tintColor=[UIColor whiteColor];
    vc.user = self.user;
    [self presentViewController:navi animated:YES completion:nil];
    
}
#pragma mark - 在线考试(主管)
- (IBAction)goManagerOnlineTest:(id)sender {
    [self goOnlineTest:sender];
}

#pragma mark - 业绩通报
- (IBAction)goResultReport:(id)sender {
    NSLog(@"业绩通报");
    ResultShowHomepageViewController *vc = [[ResultShowHomepageViewController alloc] initWithNibName:@"ResultShowHomepageViewController" bundle:nil];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:vc];
    navi.navigationBar.tintColor=[UIColor whiteColor];
    [self presentViewController:navi animated:YES completion:nil];
}

#pragma mark - 业绩通报(主管)
- (IBAction)goManagerResultReport:(id)sender {
    NSLog(@"goManagerResultReport");
    ResultShowHomepageViewController *vc = [[ResultShowHomepageViewController alloc] initWithNibName:@"ResultShowHomepageViewController" bundle:nil];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:vc];
    navi.navigationBar.tintColor=[UIColor whiteColor];
    [self presentViewController:navi animated:YES completion:nil];
}

-(int)getNumber:(UILabel*)label{
    if(label.text.length < 1)
        return 0;
    int num = (int)label.text;
    return num;
}
-(void)hudWasHidden:(MBProgressHUD *)hud{
    [hud removeFromSuperview];
    hud = nil;
}
//settingInformationFromMainSegue
- (IBAction)goInformation:(id)sender {
    goInformation=YES;
    [self performSegueWithIdentifier:@"settingSegue"sender:self];
}
-(void)settingViewControllerUpdatePersonImageDidFinished{
    [self loadUserImage];
}
-(void)remindHandlindDidFinished:(int)count withError:(NSError *)error withType:(RemaindType)remaindType{
   dispatch_async(dispatch_get_main_queue(), ^{
    
       NSString *type=@"";
       switch (remaindType) {
           case RemaindTypeWithOtherRegress:
               type=kPushDifflink;
               break;
           case RemaindTypeWithCustomerManager:
               type=kPushCheckAddress;
               break;
           case RemaindTypeWithCustomerWarning:
               type=kRemainCustomerWarning;
               break;
           case RemaindTypeWithVisitPlan:
               type=kPushVisitPlan;
               break;
           default:
               break;
       }
       
       MainCollectionViewCell *cell;
       
       for (NSDictionary *dict in listArray) {
           NSString *key = [dict objectForKey:@"key"];
           NSArray *keys = [key componentsSeparatedByString:@","];
           for (NSString *k in keys) {
               if([k isEqualToString:type]){
                   cell = (MainCollectionViewCell*)[listView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:[listArray indexOfObject:dict] inSection:0]];
                   break;
               }
           }
       }
       
       if(!cell)
           return;

       if(count + cell.badgeNumber){
           cell.itemBadge.text=[NSString stringWithFormat:@"%d",cell.badgeNumber + count];
           cell.itemBadgeBackgroundView.hidden=NO;
           cell.itemBadge.hidden=NO;
       }
       else{
           cell.itemBadge.hidden=YES;
           cell.itemBadgeBackgroundView.hidden=YES;
       }
    
   });
    
}

#pragma mark -gps地理位置更新
//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    locationUpdateCount++;
    if(locationUpdateCount < 5)
        return;

    [_locService stopUserLocationService];
    [VariableStore sharedInstance].coord=userLocation.location.coordinate;
    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    reverseGeocodeSearchOption.reverseGeoPoint = userLocation.location.coordinate;
    
    BOOL flag = [geoSearch reverseGeoCode:reverseGeocodeSearchOption];
    if(flag)
    {
        NSLog(@"反geo检索发送成功");
    }
    else
    {
        NSLog(@"反geo检索发送失败");
    }
    
}
-(void)initUserLocation{
    geoSearch=[[BMKGeoCodeSearch alloc] init];
    geoSearch.delegate=self;
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    
    [_locService startUserLocationService];
    
}

-(void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error{
    
    if (error == BMK_SEARCH_NO_ERROR) {
        [VariableStore sharedInstance].city=result.addressDetail.city;
        CLLocationCoordinate2D coordinate=[VariableStore sharedInstance].coord;
        [DocumentHandling writeUserLocation:result.addressDetail.city withLatitude:[NSNumber numberWithDouble:coordinate.latitude] withLongitude:[NSNumber numberWithDouble:coordinate.longitude]];
        NSLog(@"city:%@",result.addressDetail.city);
        
    }
    else {
        NSLog(@"get city error");
        BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
        reverseGeocodeSearchOption.reverseGeoPoint = [VariableStore sharedInstance].coord;
        [geoSearch reverseGeoCode:reverseGeocodeSearchOption];
        
    }
}

#pragma mark - collectionView delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [listArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
//    MainCollectionViewCell *cell = (MainCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    static NSString *simpleTableIdentifier = @"MainCollectionViewCell";
    MainCollectionViewCell *cell = (MainCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:simpleTableIdentifier forIndexPath:indexPath];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MainCollectionViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }

    
    NSDictionary *dict=[listArray objectAtIndex:indexPath.row];
    cell.itemTitle.text=[dict objectForKey:@"title"];
    [cell.itemButton setImage:[UIImage imageNamed:[dict objectForKey:@"image"]] forState:UIControlStateNormal];
    [self addButtonObserver:cell.itemButton withIndexPath:indexPath];
    
    return cell;
}
-(void)addButtonObserver:(UIButton*)button withIndexPath:(NSIndexPath*)indexPath{
   
    
#if  (defined STANDARD_SY_VERSION)
    switch (indexPath.row) {
        case 0:
            [button addTarget:self action:@selector(goMarketing:) forControlEvents:UIControlEventTouchUpInside];
            break;
        case 1:
            [button addTarget:self action:@selector(goSMSMarketing:) forControlEvents:UIControlEventTouchUpInside];
            break;
        case 2:
            [button addTarget:self action:@selector(goBusinesProcess:) forControlEvents:UIControlEventTouchUpInside];
            break;
        case 3:
            [button addTarget:self action:@selector(goOtherRegress:) forControlEvents:UIControlEventTouchUpInside];
            break;
        case 4:
            [button addTarget:self action:@selector(goCustomerManager:) forControlEvents:UIControlEventTouchUpInside];
            break;
        case 5:
            [button addTarget:self action:@selector(goKnowledgeBase:) forControlEvents:UIControlEventTouchUpInside];
            break;
        case 6:
            [button addTarget:self action:@selector(goCustomersWarning:) forControlEvents:UIControlEventTouchUpInside];
            break;
        case 7:
            [button addTarget:self action:@selector(goVisitPlan:) forControlEvents:UIControlEventTouchUpInside];
            break;
        case 8:
            [button addTarget:self action:@selector(goDataAcquisition:) forControlEvents:UIControlEventTouchUpInside];
            break;
        case 9:
            [button addTarget:self action:@selector(goMonthlyTasks:) forControlEvents:UIControlEventTouchUpInside];
            break;
        case 10:
            [button addTarget:self action:@selector(goOnlineTest:) forControlEvents:UIControlEventTouchUpInside];
            break;
        case 11:
            [button addTarget:self action:@selector(goResultReport:) forControlEvents:UIControlEventTouchUpInside];
            break;
            
        default:
            break;
    }
#endif
    
#if (defined STANDARD_CS_VERSION)
    switch (indexPath.row) {
        case 0:
            [button addTarget:self action:@selector(goVisitPlan:) forControlEvents:UIControlEventTouchUpInside];
            break;
        case 1:
            [button addTarget:self action:@selector(goMarketing:) forControlEvents:UIControlEventTouchUpInside];
            break;
        case 2:
            [button addTarget:self action:@selector(goSMSMarketing:) forControlEvents:UIControlEventTouchUpInside];
            break;
        case 3:
            [button addTarget:self action:@selector(goCustomerManager:) forControlEvents:UIControlEventTouchUpInside];
            break;
        case 4:
            [button addTarget:self action:@selector(goCustomersWarning:) forControlEvents:UIControlEventTouchUpInside];
            break;
        case 5:
            [button addTarget:self action:@selector(goCSAchievment:) forControlEvents:UIControlEventTouchUpInside];
            break;
        case 6:
            [button addTarget:self action:@selector(goKnowledgeBase:) forControlEvents:UIControlEventTouchUpInside];
            break;
        case 7:
            [button addTarget:self action:@selector(goDataAcquisition:) forControlEvents:UIControlEventTouchUpInside];
            break;
        case 8:
            [button addTarget:self action:@selector(goOtherRegress:) forControlEvents:UIControlEventTouchUpInside];
            break;
        case 9:
            [button addTarget:self action:@selector(goBusinesProcess:) forControlEvents:UIControlEventTouchUpInside];
            break;
        default:
            break;
            
    }
    
    #endif

#if (defined MANAGER_CS_VERSION) 
    switch (indexPath.row) {
        case 0:
            [button addTarget:self action:@selector(goChagangMonitor:) forControlEvents:UIControlEventTouchUpInside];
            break;
        case 1:
            [button addTarget:self action:@selector(goManagerResultReport:) forControlEvents:UIControlEventTouchUpInside];
            break;

        case 2:
            [button addTarget:self action:@selector(goVisitPlan:) forControlEvents:UIControlEventTouchUpInside];
            break;
        case 3:
            [button addTarget:self action:@selector(goCustomersWarning:) forControlEvents:UIControlEventTouchUpInside];
            break;
        case 4:
            [button addTarget:self action:@selector(goOtherRegress:) forControlEvents:UIControlEventTouchUpInside];
            break;
        case 5:
            [button addTarget:self action:@selector(goCustomerManager:) forControlEvents:UIControlEventTouchUpInside];
            break;
            
        default:
            break;
    }
#endif
#if (defined MANAGER_SY_VERSION)
            switch (indexPath.row) {
        case 0:
            [button addTarget:self action:@selector(goChagangMonitor:) forControlEvents:UIControlEventTouchUpInside];
            break;
        case 1:
            [button addTarget:self action:@selector(goOtherRegress:) forControlEvents:UIControlEventTouchUpInside];
            break;
        case 2:
            [button addTarget:self action:@selector(goCustomerManager:) forControlEvents:UIControlEventTouchUpInside];
            break;
        case 3:
            [button addTarget:self action:@selector(goManagerMonthlyTasks:) forControlEvents:UIControlEventTouchUpInside];
            break;
        case 4:
            [button addTarget:self action:@selector(goKnowledgeBase:) forControlEvents:UIControlEventTouchUpInside];
            break;
        case 5:
            [button addTarget:self action:@selector(goCustomersWarning:) forControlEvents:UIControlEventTouchUpInside];
            break;
    case 6:
        [button addTarget:self action:@selector(goVisitPlan:) forControlEvents:UIControlEventTouchUpInside];
        break;

        case 7:
            [button addTarget:self action:@selector(goDataAcquisition:) forControlEvents:UIControlEventTouchUpInside];
            break;
                    
        
        case 8:
            [button addTarget:self action:@selector(goManagerOnlineTest:) forControlEvents:UIControlEventTouchUpInside];
            break;
        case 9:
            [button addTarget:self action:@selector(goManagerResultReport:) forControlEvents:UIControlEventTouchUpInside];
            break;

                default:
                    break;
    }

    #endif


}

@end
