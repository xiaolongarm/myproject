//
//  MarketingGroupCustomersViewController.m
//  CMCCMarketing
//
//  Created by talkweb on 14-9-9.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//
#import "GroupCustomersTableViewCell.h"
#import "MarketingGroupCustomersViewController.h"
#import "NetworkHandling.h"
#import "MBProgressHUD.h"
#import "Customer.h"
#import "MarketingCustomerDetailsTableViewController.h"
#import "MarketingGroupUserFilterViewController.h"
#import "MarketingGroupDetailsViewController.h"
#import "MarketingCustomersViewController.h"
#import "MarketingCustomersWithSYViewController.h"

#import "MJRefresh.h"

#define PAGE_ROW_COUNT 20

@interface MarketingGroupCustomersViewController ()<UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate,MarketingGroupUserFilterViewControllerDelegate,GroupCustomersTableViewCellDelegate>{
//    NSArray *tableArray;
    BOOL hudFlag;
    Customer *customer;
//    int selectedSwitch;
    
    MarketingGroupUserFilterViewController *filterController;
    UIView *backView;
    
    NSMutableArray *groupUserList;
    
    int pageNO;
}

@end

@implementation MarketingGroupCustomersViewController

/**
 *  集成刷新控件
 */
#pragma mark - 集成刷新控件
- (void)setupRefresh
{
    [groupCustomersTableView addFooterWithTarget:self action:@selector(footerRereshing)];
    groupCustomersTableView.footerPullToRefreshText = @"上拉加载更多数据";
    groupCustomersTableView.footerReleaseToRefreshText = @"松开加载更多数据";
    groupCustomersTableView.footerRefreshingText = @"加载中,请稍后...";
}

#pragma mark 开始进入刷新状态

- (void)footerRereshing
{
    [self loadGroupData:nil pagesTotal:PAGE_ROW_COUNT indexWithPage:pageNO];
    
}

-(void)refreshTableViewData{
    
    [groupCustomersTableView reloadData];
    [groupCustomersTableView footerEndRefreshing];
}

-(void)loadGroupData:(NSDictionary*)bDict pagesTotal:(int)pagesTotal indexWithPage:(int)index{
    
    NSMutableDictionary *mdic = [[NSMutableDictionary alloc] initWithDictionary:self.dicPostPara];
    [mdic setObject:[NSNumber numberWithInt:pagesTotal] forKey:@"pageNum"];
    [mdic setObject:[NSNumber numberWithInt:index] forKey:@"start"];
    
    
    selectAllImage.image=[UIImage imageNamed:@"未勾选"];
    selectAllImage.tag=0;
    
    [NetworkHandling sendPackageWithUrl:@"marketing/grpuserList" sendBody:mdic processHandler:^(NSDictionary *result, NSError *error) {
        hudFlag=NO;
        if(!error){
            [groupUserList removeAllObjects];
            
            NSArray *tmpArray = [result objectForKey:@"grp_user"];
            for (NSDictionary *dict in tmpArray) {
                NSMutableDictionary *item = [[NSMutableDictionary alloc] init];
                [item setObject:[dict objectForKey:@"svc_code"] forKey:@"svc_code"];
                [item setObject:[NSNumber numberWithBool:NO] forKey:@"selected"];
                [groupUserList addObject:item];
            }
            
            if([tmpArray count]==PAGE_ROW_COUNT){
                pageNO++;
                [self performSelectorOnMainThread:@selector(setupRefresh) withObject:nil waitUntilDone:YES];

            }
            else{
                [groupCustomersTableView removeFooter];
            }
            
            
            [self performSelectorOnMainThread:@selector(refreshTableViewData) withObject:nil waitUntilDone:YES];
        }
        else{
            int errorCode=[[result valueForKey:@"errorcode"] intValue];
            NSString *errorInfo=[result valueForKey:@"errorinf"];
            if(!errorInfo)
                errorInfo=@"提交数据出错了！";
            NSLog(@"error:%d info:%@",errorCode,errorInfo);
            [self performSelectorOnMainThread:@selector(showMessage:) withObject:errorInfo waitUntilDone:YES];
        }
        
    }];
    
}


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
    [self.navigationController setNavigationBarHidden:NO];
    
    self.title = self.group.groupName;
    groupCustomersTableView.dataSource=self;
    groupCustomersTableView.delegate=self;
    
    groupUserList=[[NSMutableArray alloc] init];
    
    UIBarButtonItem *rightButton=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"详细"] style:UIBarButtonItemStylePlain target:self action:@selector(goGroupDetails)];
    [rightButton setTintColor:[UIColor whiteColor]];
    [self.navigationItem setRightBarButtonItem:rightButton];
    
    //add filtercontroller
    filterController=[self.storyboard instantiateViewControllerWithIdentifier:@"MarketingGroupUserFilterViewControllerId"];
    filterController.delegate=self;
    CGRect rect=filterController.view.frame;
    
    rect.origin.x=30;
    rect.origin.y=120;
    rect.size.width=260;
    rect.size.height=360;
    
    filterController.view.frame=rect;
    filterController.view.layer.borderWidth=1;
    filterController.view.layer.borderColor=[UIColor colorWithRed:55/255.0 green:132/255.0 blue:173/255.0 alpha:1.0].CGColor;
    filterController.view.layer.shadowOffset = CGSizeMake(2, 2);
    filterController.view.layer.shadowOpacity = 0.80;
    
    backView=[[UIView alloc] init];
    backView.backgroundColor=[UIColor blackColor];
    backView.alpha=0.1;
    
    backView.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [self.view addSubview:backView];
    [self.view addSubview:filterController.view];
    backView.hidden=YES;
    filterController.view.hidden=YES;

//    hudFlag=YES;
//    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
//    [self.view addSubview:HUD];
//    HUD.delegate=self;
//    HUD.labelText=@"数据查询中，请稍后...";
//    
    NSDictionary *bDict=[self getPrarmWhere:@"" marketingFlag:0];
//    [HUD showWhileExecuting:@selector(loadGroupData:) onTarget:self withObject:bDict animated:YES];
    
    
    hudFlag=YES;
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"数据查询中，请稍后...";
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
    
    pageNO=0;
    self.dicPostPara = bDict;
    [self loadGroupData:nil pagesTotal:PAGE_ROW_COUNT indexWithPage:pageNO];//
    
}
-(void)connectToNetwork{
    while (hudFlag) {
        //        usleep(100000);
        sleep(1);
    }
}

-(NSDictionary*)getPrarmWhere:(NSString*)strWhere marketingFlag:(int)number{

    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    [bDict setValue:self.group.groupId forKey:@"grp_code"];
    [bDict setValue:strWhere forKey:@"str_where"];
    [bDict setValue:[NSNumber numberWithInt:number] forKey:@"marketing_flag"];
    
    return bDict;
}
-(void)goGroupDetails{
    [self performSegueWithIdentifier:@"MarketingGroupDetailsSegue" sender:self];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"MarketingCustomerDetailsFromGroupSegue"]){
        MarketingCustomerDetailsTableViewController *controller=segue.destinationViewController;
        controller.customer=customer;
    }
    if([segue.identifier isEqualToString:@"MarketingGroupDetailsSegue"]){
        MarketingGroupDetailsViewController *controller=segue.destinationViewController;
        controller.group=self.group;
    }
    if([segue.identifier isEqualToString:@"MarketingGroupMarketingSegue"]){
        MarketingCustomersViewController *controller=segue.destinationViewController;
        controller.groupUserList=groupUserList;
        controller.isGroup=YES;
        controller.user=self.user;
        controller.group=self.group;
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return [tableArray count];
    return [groupUserList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SettingTableViewCell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    GroupCustomersTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GroupCustomersTableViewCell"];
    cell.delegate=self;
    NSDictionary *item=[groupUserList objectAtIndex:indexPath.row];
    cell.itemRow=indexPath.row;
    cell.itemName.text=[NSString stringWithFormat:@"用户 %d",indexPath.row+1];
    cell.itemTelephone.text=[item objectForKey:@"svc_code"];
    BOOL selected=[[item objectForKey:@"selected"] boolValue];
    if(selected)
        [cell.itemSelected setImage:[UIImage imageNamed:@"勾选"] forState:UIControlStateNormal];
    else
        [cell.itemSelected setImage:[UIImage imageNamed:@"未勾选"] forState:UIControlStateNormal];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *item=[groupUserList objectAtIndex:indexPath.row];
    NSString *tel=[item objectForKey:@"svc_code"];
    
//    hudFlag=YES;
//    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
//    [self.view addSubview:HUD];
//    HUD.delegate=self;
//    HUD.labelText=@"数据查询中，请稍后...";
//    [HUD showWhileExecuting:@selector(requestCustomerQuery:) onTarget:self withObject:tel animated:YES];
    
    hudFlag=YES;
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"数据查询中，请稍后...";
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
    [self requestCustomerQuery:tel];
}

-(void)requestCustomerQuery:(NSString*)svcCode{
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    [bDict setValue:svcCode forKeyPath:@"svc_code"];
    
    [NetworkHandling sendPackageWithUrl:@"marketing/userList" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        if(!error){
            NSLog(@"sign in success");
            NSDictionary *customerObject=[result objectForKey:@"user"];
            
            if(!customerObject || (NSNull*)customerObject == [NSNull null]){
                //                NSLog(@"error:%d info:%@",errorCode,errorInfo);
                NSString *errorInfo=@"查询的用户不存在！";
                [self performSelectorOnMainThread:@selector(showMessage:) withObject:errorInfo waitUntilDone:YES];
            }
            else{
                customer=[[Customer alloc] initWithDictionary:customerObject];
                hudFlag=NO;
                [self performSelectorOnMainThread:@selector(goIndividualCustomer) withObject:nil waitUntilDone:NO];
            }
            
        }
        else{
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
-(void)goIndividualCustomer{
    [self performSegueWithIdentifier:@"MarketingCustomerDetailsFromGroupSegue" sender:self];
}
-(void)showMessage:(NSString*)infomation{
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"信息提示" message:infomation delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
    [myAlertView show];
}

- (IBAction)userFilterButtonOnclick:(id)sender {
    backView.hidden=NO;
    filterController.view.hidden=NO;
}
-(void)marketingGroupUserFilterViewControllerDidCanceled{
//    [backView removeFromSuperview];
//    [filterController.view removeFromSuperview];
//    
//    backView=nil;
//    filterController=nil;
    
    backView.hidden=YES;
    filterController.view.hidden=YES;
}
-(void)marketingGroupUserFilterViewControllerDidFinished:(MarketingGroupUserFilterViewController *)controller{
    NSLog(@"filter array count:%d",[controller._filterArray count]);
    
    hudFlag=YES;
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"数据查询中，请稍后...";
    
    NSString *query=@"";

    //按类型分成多个数组
    NSString *previousType=@"";
    NSMutableArray *fullArray=[NSMutableArray new];
    NSMutableArray *tmpArray;
    for (NSDictionary *dict in controller._filterArray) {
        BOOL flag=[[dict objectForKey:@"selected"] boolValue];
        if(flag){
            NSString *type=[dict objectForKey:@"type"];
            if(![type isEqualToString:previousType]){
                if([tmpArray count]>0)
                    [fullArray addObject:tmpArray];
                tmpArray=[NSMutableArray new];
            }
            [tmpArray addObject:dict];
            previousType=type;
            
        }
    }
    
    if([tmpArray count] > 0)
        [fullArray addObject:tmpArray];
    
    //收入标签类型多选拼接【or】流量标签类型拼接【or】其余语句拼接and
    for (NSArray *arr in fullArray) {
        NSDictionary *dict=[arr firstObject];
        NSString *type=[dict objectForKey:@"type"];
        if([type isEqualToString:@"incm"] || [type isEqualToString:@"use_vol"]){
            NSString *tmpString=@"";
            for (NSDictionary *d in arr) {
                NSString *key=[d objectForKey:@"key"];
                tmpString=[tmpString stringByAppendingFormat:@"%@ or ",key];
            }
            tmpString=[tmpString substringToIndex:tmpString.length-3];
            query = [query stringByAppendingFormat:@"and (%@) ",tmpString];

        }
        else{
            for (NSDictionary *d in arr) {
                NSString *key=[d objectForKey:@"key"];
                query = [query stringByAppendingFormat:@"and %@ ",key];
            }
        }
    }
    
    NSDictionary *bDict=[self getPrarmWhere:query marketingFlag:controller.filterOfTimePeriod];
//    [HUD showWhileExecuting:@selector(loadGroupData:) onTarget:self withObject:bDict animated:YES];
    
    self.dicPostPara = bDict;
    [HUD showWhileExecuting:@selector(loadGroupDataBridge:) onTarget:self withObject:nil animated:YES];
    
    [self marketingGroupUserFilterViewControllerDidCanceled];
}

-(void)loadGroupDataBridge:(id)para{
    
    [self loadGroupData:nil pagesTotal:PAGE_ROW_COUNT indexWithPage:pageNO];//
}


- (IBAction)selectedAllButtonOnclick:(id)sender {
    if(!selectAllImage.tag){
        selectAllImage.image=[UIImage imageNamed:@"勾选"];
        selectAllImage.tag=1;
        
        for (NSMutableDictionary *item in groupUserList) {
            [item setObject:[NSNumber numberWithBool:YES] forKey:@"selected"];
        }
        [groupCustomersTableView reloadData];
    }
    else{
        selectAllImage.image=[UIImage imageNamed:@"未勾选"];
        selectAllImage.tag=0;

        for (NSMutableDictionary *item in groupUserList) {
            [item setObject:[NSNumber numberWithBool:NO] forKey:@"selected"];
        }
        [groupCustomersTableView reloadData];

    }
}
-(void)groupCustomersTableViewCellSelectButtonOnclick:(GroupCustomersTableViewCell *)controller{
    NSMutableDictionary *dict=[groupUserList objectAtIndex:controller.itemRow];
    BOOL selected=[[dict objectForKey:@"selected"] boolValue];
    if(selected){
        [controller.itemSelected setImage:[UIImage imageNamed:@"未勾选"] forState:UIControlStateNormal];
    }
    else{
        [controller.itemSelected setImage:[UIImage imageNamed:@"勾选"] forState:UIControlStateNormal];
    }
    [dict setObject:[NSNumber numberWithBool:!selected] forKey:@"selected"];
}

-(void)hudWasHidden:(MBProgressHUD *)hud{
    [hud removeFromSuperview];
    hud=nil;
}
- (IBAction)goMarketing:(id)sender {
    BOOL state =NO;
    for (NSDictionary *dict in groupUserList) {
        BOOL selected=[[dict objectForKey:@"selected"] boolValue];
        if(selected){
            state=YES;
            break;
        }
    }
    if(state){
//        [self performSegueWithIdentifier:@"MarketingGroupMarketingSegue" sender:self];
        
#if (defined MANAGER_CS_VERSION) || (defined STANDARD_CS_VERSION)
        [self performSegueWithIdentifier:@"MarketingGroupMarketingSegue" sender:self];
#endif
        
#if (defined MANAGER_SY_VERSION)|| (defined STANDARD_SY_VERSION)
        MarketingCustomersWithSYViewController *controller=[[MarketingCustomersWithSYViewController alloc] initWithNibName:@"MarketingCustomersWithSYViewController" bundle:nil];
        controller.groupUserList=groupUserList;
        controller.isGroup=YES;
        controller.user=self.user;
        controller.group=self.group;
        
        [self.navigationController pushViewController:controller animated:YES];
#endif
    }
    else{
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"您还没有选择发送用户！" delegate:nil cancelButtonTitle:nil  otherButtonTitles:@"确定", nil];
        [myAlertView show];
    }
        
}

@end
