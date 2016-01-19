//
//  FlowBusinessRecordViewController.m
//  CMCCMarketing
//
//  Created by talkweb on 14-9-16.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//
#import "FlowBusinessRecordTableViewCell.h"
#import "FlowBusinessRecordViewController.h"
#import "MBProgressHUD.h"
#import "NetworkHandling.h"
#import "MJRefresh.h"
#define PAGE_ROW_COUNT 20

@interface FlowBusinessRecordViewController ()<MBProgressHUDDelegate>{
    BOOL hubFlag;
    NSMutableArray *tableArray;
    int pageNO;
    NSString *currentState;
}

@end

@implementation FlowBusinessRecordViewController

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
    
    tableArray=[[NSMutableArray alloc] init];
    recordTableView.delegate=self;
    recordTableView.dataSource=self;
    currentState=@"0";
    recordTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    hubFlag=YES;
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"数据查询中，请稍后...";
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
    [self loadRecordWithState:currentState numberWithPage:PAGE_ROW_COUNT indexWithPage:pageNO];
}
-(void)connectToNetwork{
    while (hubFlag) {
        usleep(100000);
    }
}
-(void)loadRecordWithState:(NSString*)state numberWithPage:(int)pagesTotal indexWithPage:(int)index{
    
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    
    [bDict setObject:state forKey:@"state"]; //“state”:办理状态,“0”已提交/”1”受理成功/”2”受理失败/”3”逻辑删除
    [bDict setObject:[NSNumber numberWithInt:pagesTotal] forKey:@"pageNum"];
    [bDict setObject:[NSNumber numberWithInt:index] forKey:@"start"];
    [bDict setObject:@"" forKey:@"whereVal"];
    
    NSString *url;
    if(self.isShaoYang){
        url=@"bussdisc/CheckBussDisc";
        [bDict setObject:self.bussName forKey:@"buss_name"];
        [bDict setObject:self.bussType forKey:@"buss_type"];
        [bDict setObject:[NSNumber numberWithInt:self.user.userID] forKey:@"manager_id"];
    }
    else{
        url=@"flow/CheckFlowHandling";
        [bDict setObject:[NSNumber numberWithInt:self.user.userID] forKey:@"customerManagerId"];
        [bDict setObject:[NSNumber numberWithInt:self.user.userEnterprise] forKey:@"customerManagerEnterprise"];
    }
    
    [NetworkHandling sendPackageWithUrl:url sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        if(!error){
            NSLog(@"sign in success");
            NSArray *tmpArray =[result objectForKey:@"Response"];
            
            if([tmpArray count]==PAGE_ROW_COUNT){
                pageNO++;
                [self performSelectorOnMainThread:@selector(setupRefresh) withObject:nil waitUntilDone:YES];
//                [self setupRefresh];
            }
            else{
                [recordTableView removeFooter];
            }
            for (NSDictionary *item in tmpArray) {
                [tableArray addObject:item];
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
-(void)refreshTableView{
    [recordTableView reloadData];
    [recordTableView footerEndRefreshing];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableArray count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FlowBusinessRecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FlowBusinessRecordTableViewCell"];
    NSDictionary *dict=[tableArray objectAtIndex:indexPath.row];
    if(self.isShaoYang){
        cell.itemBusinessName.text=[dict objectForKey:@"buss_name"];
        cell.itemCustomerName.text=[dict objectForKey:@"user_name"];
        cell.itemTelephone.text=[dict objectForKey:@"user_mobile"];
        cell.itemDate.text=[dict objectForKey:@"indb_date"];
    }
    else{
        cell.itemBusinessName.text=[dict objectForKey:@"packageInfo"];
        cell.itemCustomerName.text=[dict objectForKey:@"customerName"];
        cell.itemTelephone.text=[dict objectForKey:@"customerPhone"];
        cell.itemDate.text=[dict objectForKey:@"indbDate"];
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}
//按钮框（无）.png
- (IBAction)notAcceptedOrderButtonOnclick:(id)sender {
    [NotAcceptedOrderButton setBackgroundImage:[UIImage imageNamed:@"按钮带框"] forState:UIControlStateNormal];
    [AcceptedSuccessOrderButton setBackgroundImage:[UIImage imageNamed:@"按钮框（无）"] forState:UIControlStateNormal];
    [AcceptedFailureOrderButton setBackgroundImage:[UIImage imageNamed:@"按钮框（无）"] forState:UIControlStateNormal];
    
    hubFlag=YES;
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"数据查询中，请稍后...";
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
    
//    [self loadRecordWithState:@"0" numberWithPage:20 indexWithPage:0];
    pageNO=0;
    [tableArray removeAllObjects];
     currentState=@"0";
    [self loadRecordWithState:currentState numberWithPage:PAGE_ROW_COUNT indexWithPage:pageNO];
}
-(IBAction)AcceptedSuccessOrderButtonOnclick:(id)sender{
    [NotAcceptedOrderButton setBackgroundImage:[UIImage imageNamed:@"按钮框（无）"] forState:UIControlStateNormal];
    [AcceptedSuccessOrderButton setBackgroundImage:[UIImage imageNamed:@"按钮带框"] forState:UIControlStateNormal];
    [AcceptedFailureOrderButton setBackgroundImage:[UIImage imageNamed:@"按钮框（无）"] forState:UIControlStateNormal];
    
    hubFlag=YES;
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"数据查询中，请稍后...";
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
    
//    [self loadRecordWithState:@"1" numberWithPage:20 indexWithPage:0];
    pageNO=0;
    [tableArray removeAllObjects];
     currentState=@"1";
    [self loadRecordWithState:currentState numberWithPage:PAGE_ROW_COUNT indexWithPage:pageNO];
}
-(IBAction)AcceptedFailureOrderButtonOnclick:(id)sender{
    [NotAcceptedOrderButton setBackgroundImage:[UIImage imageNamed:@"按钮框（无）"] forState:UIControlStateNormal];
    [AcceptedSuccessOrderButton setBackgroundImage:[UIImage imageNamed:@"按钮框（无）"] forState:UIControlStateNormal];
    [AcceptedFailureOrderButton setBackgroundImage:[UIImage imageNamed:@"按钮带框"] forState:UIControlStateNormal];
    
    hubFlag=YES;
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"数据查询中，请稍后...";
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
    
//    [self loadRecordWithState:@"2" numberWithPage:20 indexWithPage:0];
    pageNO=0;
    [tableArray removeAllObjects];
     currentState=@"2";
    [self loadRecordWithState:currentState numberWithPage:PAGE_ROW_COUNT indexWithPage:pageNO];
}
/**
 *  集成刷新控件
 */
#pragma mark - 集成刷新控件
- (void)setupRefresh
{
    [recordTableView addFooterWithTarget:self action:@selector(footerRereshing)];
    recordTableView.footerPullToRefreshText = @"上拉加载更多数据";
    recordTableView.footerReleaseToRefreshText = @"松开加载更多数据";
    recordTableView.footerRefreshingText = @"加载中,请稍后...";
}

#pragma mark 开始进入刷新状态

- (void)footerRereshing
{
    [self loadRecordWithState:currentState numberWithPage:PAGE_ROW_COUNT indexWithPage:pageNO];
    
}

@end
