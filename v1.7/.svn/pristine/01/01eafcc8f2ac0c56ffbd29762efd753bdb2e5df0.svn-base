//
//  W_VisitPlanSearchViewController.m
//  CMCCMarketing
//
//  Created by gmj on 14-12-12.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import "W_VisitPlanSearchViewController.h"
#import "W_VisitPlanAddSelectGroupTableViewController.h"
#import "PreferentialPurchaseSelectDateTimeViewController.h"

#import "NetworkHandling.h"
#import "MBProgressHUD.h"
#import "VariableStore.h"

@interface W_VisitPlanSearchViewController ()<MBProgressHUDDelegate,VisitPlanAddSelectGroupTableViewControllerDelegate,PreferentialPurchaseSelectDateTimeViewControllerDelegate>{
    
    BOOL hubFlag;
    
    Group *selectGroup;
    CustomerManager *selectCustomerManager;
    
    UIView *backView;
    PreferentialPurchaseSelectDateTimeViewController *selectDateTimeViewController;
    UIButton *selectDateBtn;
    
}

@end

@implementation W_VisitPlanSearchViewController

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
    
    [self initSubView];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initSubView{
    
    self.navigationItem.title = @"搜索";
    UIBarButtonItem *rightButton=[[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(searchVisitPlan)];
    [rightButton setTintColor:[UIColor whiteColor]];
    [self.navigationItem setRightBarButtonItem:rightButton];
    
    self.lblCustomerManagerTitle.text=[NSString stringWithFormat:@"%@：",[VariableStore getCustomerManagerName]];
    
#if (defined STANDARD_CS_VERSION) || (defined STANDARD_SY_VERSION)
    self.lblCustomerManager.hidden=YES;
    self.lblCustomerManagerTitle.hidden=YES;
    self.btnCustomerManager.hidden=YES;
    
    lblGroupTitleConstraint.constant=8;
    lblGroupConstraint.constant=8;
    btnGroupConstraint.constant=-1;
#endif
    
}

-(void)searchVisitPlan{
    
    [self loadVisitPlanListData:@"9"];//9,all
}

- (IBAction)btnStartDateOnClick:(id)sender {
    
    [self selectDate:sender];
}

- (IBAction)btnEndDateOnClick:(id)sender {
    
    [self selectDate:sender];
    
}

- (IBAction)btnGroupOnClick:(id)sender {
    
    W_VisitPlanAddSelectGroupTableViewController *controller=[[W_VisitPlanAddSelectGroupTableViewController alloc] initWithNibName:@"W_VisitPlanAddSelectGroupTableViewController" bundle:nil];
    controller.user = self.user;
    controller.delegate=self;

   
    
#if (defined MANAGER_CS_VERSION) || (defined MANAGER_SY_VERSION)
////    NSMutableArray *tmpArray=[[NSMutableArray alloc] init];
////    for (CustomerManager *manager in self.user.customerManagerInfo)
////        for (Group *group in manager.groupList)
////            [tmpArray addObject:group];
////    controller.tableArray=tmpArray;
//        controller.listType=1;
//    controller.tableArray=self.user.customerManagerInfo;
    if(!selectCustomerManager){
        
        NSString *msg=[NSString stringWithFormat:@"您还没有选择%@！",[VariableStore getCustomerManagerName]];
        [self showMessage:msg];
        return;
    }
    
       controller.tableArray=selectCustomerManager.groupList;
#endif
//
#if (defined STANDARD_CS_VERSION) || (defined STANDARD_SY_VERSION)
    controller.tableArray=self.user.groupInfo;
#endif
    
    controller.selectGroup=selectGroup;
    controller.selectedCustomerManager=selectCustomerManager;
    [self.navigationController pushViewController:controller animated:YES];
    
}
- (IBAction)btnCustomerManagerOnClick:(id)sender {
    W_VisitPlanAddSelectGroupTableViewController *controller=[[W_VisitPlanAddSelectGroupTableViewController alloc] initWithNibName:@"W_VisitPlanAddSelectGroupTableViewController" bundle:nil];
    controller.user = self.user;
    controller.delegate=self;
    controller.listType=1;
    controller.tableArray=self.user.customerManagerInfo;
    controller.selectedCustomerManager=selectCustomerManager;
    [self.navigationController pushViewController:controller animated:YES];
}
#pragma mark - button select delegate

-(void)visitPlanAddSelectGroupTableViewControllerDidFinished:(W_VisitPlanAddSelectGroupTableViewController *)controller{
    
    if(controller.listType == 1){
        selectCustomerManager=controller.selectedCustomerManager;
        self.lblCustomerManager.text=selectCustomerManager.vip_mngr_name;
    }
    if(controller.listType == 0){
        selectGroup=controller.selectGroup;
        self.lblGroup.text=selectGroup.groupName;
    }
    
    
}

#pragma mark - PreferentialPurchaseSelectDateTimeViewControll delegate

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
    if (selectDateBtn == self.btnStartDate) {
        
        self.lblStartDate.text = dateString;
        
    } else {
        
        self.lblEndDate.text = dateString;
        
    }
    
    [self preferentialPurchaseSelectDateTimeViewControllerDidCancel];
}

- (IBAction)selectDate:(id)sender{
    
    selectDateBtn = sender;
    
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"BusinessProcess" bundle:nil];
    selectDateTimeViewController=[storyboard instantiateViewControllerWithIdentifier:@"PreferentialPurchaseSelectDateTimeViewControllerId"];
    selectDateTimeViewController.delegate=self;
    selectDateTimeViewController.modeDateAndTime=0;//设置模式为日期和时间显示
    CGRect rect=selectDateTimeViewController.view.frame;
    
    rect.origin.x=0;
    rect.origin.y=[[UIScreen mainScreen] bounds].size.height - 300;
    rect.size.width=320;
    rect.size.height=300;
    
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
    
}



-(void)showMessage:(NSString*)infomation{
    
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"信息提示" message:infomation delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
    [myAlertView show];
}

-(void)refreshvisitPlanTableView{
    
    [self.delegate W_VisitPlanSearchViewControllerDidFinished:self];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)connectToNetwork{
    
    while (hubFlag) {
        usleep(100000);
    }
}

-(void)loadVisitPlanListData:(NSString *)visit_sta{
    
    hubFlag=YES;
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"数据查询中，请稍后...";
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];

//    user_msisdn 客户经理电话号码
//    grp_code 集团编码ID
//    visit_start_time 开始日期
//    visit_end_time 结束日期
    
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    [bDict setObject:[NSNumber numberWithInt:self.user.userLvl] forKey:@"user_lvl"];
    [bDict setObject:[NSNumber numberWithInt:self.user.userID] forKey:@"user_id"];
    [bDict setObject:self.user.userMobile forKey:@"user_msisdn"];
    NSString *grp_code = selectGroup.groupId;
    if(grp_code)
        [bDict setObject:grp_code forKey:@"grp_code"];
    if(selectCustomerManager)
        [bDict setObject:selectCustomerManager.vip_mngr_msisdn forKey:@"user_msisdn"];
    [bDict setObject:[NSNumber numberWithInt:self.user.userEnterprise] forKey:@"enterprise"];
    
    NSString *visit_start_time = self.lblStartDate.text;
    [bDict setObject:visit_start_time forKey:@"visit_start_time"];
    NSString *visit_end_time = self.lblEndDate.text;
    [bDict setObject:visit_end_time forKey:@"visit_end_time"];
    
    [NetworkHandling sendPackageWithUrl:@"visitplan/visitplanlist" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        if(!error){
            
            hubFlag=NO;
            NSLog(@"sign in success");
            self.visitplanlist =[result objectForKey:@"visit"];
            if([self.visitplanlist count] > 0){
                
                for (NSDictionary * dicObj in self.visitplanlist) {
                    
                    NSString *t_visit_sta = [dicObj objectForKey:@"visit_sta"];
                    if ((NSNull *)t_visit_sta == [NSNull null]) {
                        
                        t_visit_sta = @"";
                    }
                    
                    t_visit_sta = t_visit_sta?t_visit_sta : @"";
                    t_visit_sta = [NSString stringWithFormat:@"%@",t_visit_sta];
                    
                    NSLog(@"t_visit_sta = %@",t_visit_sta);
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
                    
                    
                }
                
//                NSArray *array=[[self.keyValues allKeys] sortedArrayUsingSelector:@selector(compare:)];
//                self.keys=[[NSMutableArray alloc] initWithArray:array];
                NSArray *array = [[self.keyValues allKeys] sortedArrayUsingComparator:^NSComparisonResult(NSString* key1, NSString* key2) {
                    
                    NSComparisonResult result = [key1 compare:key2];
                    return result == NSOrderedAscending;
                }];
                self.keys=[[NSMutableArray alloc] initWithArray:array];
                
                [self performSelectorOnMainThread:@selector(refreshvisitPlanTableView) withObject:nil waitUntilDone:YES];
                
            }else{
                
                [self performSelectorOnMainThread:@selector(showMessage:) withObject:@"没有符合条件的数据." waitUntilDone:YES];
            }
            
            [self performSelectorOnMainThread:@selector(refreshvisitPlanTableView) withObject:nil waitUntilDone:YES];
            
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
