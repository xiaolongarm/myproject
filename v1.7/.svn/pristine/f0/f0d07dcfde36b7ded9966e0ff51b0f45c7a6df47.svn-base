//
//  OtherRegressManagerCustomerListViewController.m
//  CMCCMarketing
//
//  Created by talkweb on 15-1-13.
//  Copyright (c) 2015年 talkweb. All rights reserved.
//

#import "OtherRegressManagerCustomerListViewController.h"
#import "OtherRegressManagerCustomerListTableViewCell.h"
#import "Group.h"
#import "MBProgressHUD.h"
#import "NetworkHandling.h"
#import "MJRefresh.h"
#import "OtherRegressCustomerDetailsTableViewController.h"

#define PAGE_ROW_COUNT 20

@interface OtherRegressManagerCustomerListViewController ()<UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate>{
    BOOL hubFlag;
    NSMutableArray *tableArray;
    
      int pageNO;
    NSDictionary *selectDict;
}

@end

@implementation OtherRegressManagerCustomerListViewController

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
    
#if (defined MANAGER_CS_VERSION) || (defined STANDARD_CS_VERSION)
    lbCustomerManagerNameTitle.text=@"客户经理";
#endif
    
#if (defined MANAGER_SY_VERSION) || (defined STANDARD_SY_VERSION)
    lbCustomerManagerNameTitle.text=@"营销经理";
#endif
    
    customerTableView.delegate=self;
    customerTableView.dataSource=self;
    lbCustomerManagerName.text=self.customerManager.vip_mngr_name;
    lbCustomerManagerPhone.text=self.customerManager.vip_mngr_msisdn;
    btNotRegress.selected=YES;
    btRegress.selected=NO;
    
    tableArray=[[NSMutableArray alloc] init];
    
    hubFlag=YES;
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"数据查询中，请稍后...";
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
//    [self loadTableData];
    [self loadRecordWithPage:PAGE_ROW_COUNT indexWithPage:pageNO];
}
-(void)connectToNetwork{
    while (hubFlag) {
        usleep(100000);
    }
}



-(void)loadRecordWithPage:(int)pagesTotal indexWithPage:(int)index{
//enterprise: 2
//grp_svc_code: "15073111287"
//is_back: "\u5426"
//pageNum: 20
//start: 0
//user_id: 2
    
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    [bDict setObject:self.customerManager.vip_mngr_msisdn forKey:@"grp_svc_code"];
    [bDict setObject:[NSNumber numberWithInt:self.user.userEnterprise] forKey:@"enterprise"];
    [bDict setObject:btRegress.selected?@"是":@"否" forKey:@"is_back"];
    [bDict setObject:[NSNumber numberWithInt:self.user.userID] forKey:@"user_id"];
    [bDict setObject:[NSNumber numberWithInt:pagesTotal] forKey:@"pageNum"];
    [bDict setObject:[NSNumber numberWithInt:index] forKey:@"start"];
    
    [NetworkHandling sendPackageWithUrl:@"diffuserback/leaddiffuserList" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        if(!error){
            NSLog(@"sign in success");
            NSArray *tmpArray =[result objectForKey:@"diffUser"];
            
            if([tmpArray count]==PAGE_ROW_COUNT){
                pageNO++;
                [self performSelectorOnMainThread:@selector(setupRefresh) withObject:nil waitUntilDone:YES];
            }
            else{
                [customerTableView removeFooter];
            }
            for (NSDictionary *item in tmpArray)
                [tableArray addObject:item];
            
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
    [customerTableView reloadData];
    [customerTableView footerEndRefreshing];
}

-(void)showMessage:(NSString*)infomation{
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"信息提示" message:infomation delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
    [myAlertView show];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)notRegressOnclick:(id)sender {
    btNotRegress.selected=YES;
    btRegress.selected=NO;
    
    [tableArray removeAllObjects];
    
    hubFlag=YES;
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"数据查询中，请稍后...";
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
    pageNO=0;
    
    [self loadRecordWithPage:PAGE_ROW_COUNT indexWithPage:pageNO];
}
- (IBAction)regressOnclick:(id)sender {
    btNotRegress.selected=NO;
    btRegress.selected=YES;
    
    [tableArray removeAllObjects];
    
    hubFlag=YES;
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"数据查询中，请稍后...";
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
    pageNO=0;
    
    [self loadRecordWithPage:PAGE_ROW_COUNT indexWithPage:pageNO];
}
-(void)hudWasHidden:(MBProgressHUD *)hud{
    [hud removeFromSuperview];
    hud=nil;
}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"OtherRegressCustomerManagerDetailsSegue"]){
        OtherRegressCustomerDetailsTableViewController *detialsController=segue.destinationViewController;
        detialsController.user=self.user;
        detialsController.diffUserDict=selectDict;
        detialsController.isManager=YES;
        detialsController.customerManager=self.customerManager;
        detialsController.isNotRegress=btNotRegress.selected;
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

//{
//    "diff_svc_code" = 18900785200;
//    "diff_type" = "\U7535\U4fe1";
//    "diff_user_name" = "\U7a0b\U5fb7";
//    "grp_user_name" = "\U5f90\U9759";
//    "is_back" = "\U662f";
//    "is_high_user" = "\U662f";
//    "is_school_user" = "\U5426";
//    "is_sensitive_user" = 0;
//    "user_type" = "\U5e02\U533a";
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OtherRegressManagerCustomerListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OtherRegressManagerCustomerListTableViewCell" forIndexPath:indexPath];
    
    NSDictionary *dict=[tableArray objectAtIndex:indexPath.row];
    
//    cell.itemName.text=group.groupContactname;
//    cell.itemPhone.text=group.groupContactPhone;
    
    cell.itemName.text=[dict objectForKey:@"diff_user_name"];
    cell.itemPhone.text=[dict objectForKey:@"diff_svc_code"];
//    cell.itemLvl.text=@"";
    
    cell.itemType.text=@"";
    NSString *isHighUser=[dict objectForKey:@"is_high_user"];
    if([isHighUser isEqualToString:@"是"]){
        cell.itemType.text=@"高端用户";
        cell.itemType.textColor=[UIColor colorWithRed:55/255.0 green:132/255.0 blue:173/255.0 alpha:1];
    }
    
    BOOL isSensitiveUserFlag=[[dict objectForKey:@"is_sensitive_user"] boolValue];
    if(isSensitiveUserFlag){
        cell.itemType.text=@"敏感";
        cell.itemType.textColor=[UIColor orangeColor];
    }

    NSString *diff_type=[dict objectForKey:@"diff_type"];
    if((NSNull*)diff_type != [NSNull null])
        cell.itemImageView.image=[UIImage imageNamed:diff_type];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    selectDict=[tableArray objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"OtherRegressCustomerManagerDetailsSegue" sender:self];
}

/**
 *  集成刷新控件
 */
#pragma mark - 集成刷新控件
- (void)setupRefresh
{
    [customerTableView addFooterWithTarget:self action:@selector(footerRereshing)];
    customerTableView.footerPullToRefreshText = @"上拉加载更多数据";
    customerTableView.footerReleaseToRefreshText = @"松开加载更多数据";
    customerTableView.footerRefreshingText = @"加载中,请稍后...";
}

#pragma mark 开始进入刷新状态

- (void)footerRereshing
{
    [self loadRecordWithPage:PAGE_ROW_COUNT indexWithPage:pageNO];
}
@end
