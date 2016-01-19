//
//  GroupBroadbandRecordViewController.m
//  CMCCMarketing
//
//  Created by talkweb on 14-9-19.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//
#import "GroupBroadbandRecordTableViewCell.h"
#import "GroupBroadbandRecordViewController.h"
#import "MBProgressHUD.h"
#import "NetworkHandling.h"
#import "MJRefresh.h"

#define PAGE_ROW_COUNT 20

@interface GroupBroadbandRecordViewController ()<MBProgressHUDDelegate>{
    BOOL hubFlag;
    NSMutableArray *tableArray;
    int pageNO;
    NSString *currentState;
}

@end

@implementation GroupBroadbandRecordViewController

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
    recordTableView.delegate=self;
    recordTableView.dataSource=self;
    tableArray=[[NSMutableArray alloc] init];
    hubFlag=YES;
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"数据查询中，请稍后...";
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
    
    pageNO=0;
    NotAcceptedOrderButton.selected=YES;
    currentState=@"0";
    [self loadRecordWithState:currentState numberWithPage:PAGE_ROW_COUNT indexWithPage:pageNO];
    
}
-(void)connectToNetwork{
    while (hubFlag) {
        usleep(100000);
    }
}

-(void)loadRecordWithState:(NSString*)state numberWithPage:(int)pagesTotal indexWithPage:(int)index{
    NSLog(@"load data with index:%d",index);
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    [bDict setObject:[NSNumber numberWithInt:self.user.userID] forKey:@"customerManagerId"];
    [bDict setObject:[NSNumber numberWithInt:self.user.userEnterprise] forKey:@"customerManagerEnterprise"];
    [bDict setObject:state forKey:@"state"]; //“state”:办理状态,“0”已提交/”1”受理成功/”2”受理失败/”3”逻辑删除
    [bDict setObject:[NSNumber numberWithInt:pagesTotal] forKey:@"pageNum"];
    [bDict setObject:[NSNumber numberWithInt:index] forKey:@"start"];
    [bDict setObject:@"" forKey:@"whereVal"];
    [bDict setObject:@"1" forKey:@"type"];  //合约类型，"0"查询三个月到期/"1"否
    
    [NetworkHandling sendPackageWithUrl:@"broadband/CheckBroadBand" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
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
    return 100;
}
//{
//    bandWidth = 1000;
//    bussID = 87;
//    charge = "5000.5";
//    contactPeriod = 24;
//    customerManagerEnterprise = 2;
//    "customerManagerId " = 4;
//    dealDate = "<null>";
//    endDate = "2015-10-27";
//    failDesc = "<null>";
//    groupID = 7313A43314;
//    groupName = "\U957f\U6c99\U5e02\U5f00\U798f\U533a\U51ef\U5229\U901a\U8baf\U884c";
//    indbDate = "2014-10-27";
//    serviceCode = 3113102695753873;
//    specialLinePro = "\U4e92\U8054\U7f51";
//    specialLineProID = 1;
//    startDate = "2013-11-27";
//}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GroupBroadbandRecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GroupBroadbandRecordTableViewCell" forIndexPath:indexPath];

    NSDictionary *dict=[tableArray objectAtIndex:indexPath.row];
    cell.itemGroup.text=[dict objectForKey:@"groupName"];
    cell.itemProduct.text=[dict objectForKey:@"specialLinePro"];
    cell.itemBroadband.text=[NSString stringWithFormat:@"%dM",[[dict objectForKey:@"bandWidth"] intValue]];
    cell.itemDeadline.text=[NSString stringWithFormat:@"%@\n至\n%@",[dict objectForKey:@"startDate"],[dict objectForKey:@"endDate"]];
    cell.itemDate.text=[dict objectForKey:@"indbDate"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (IBAction)notAcceptedOrderButtonOnclick:(id)sender {
    NotAcceptedOrderButton.selected=YES;
    AcceptedSuccessOrderButton.selected=NO;
    AcceptedFailureOrderButton.selected=NO;
    
    pageNO=0;
    [tableArray removeAllObjects];
    currentState=@"0";
    [self loadRecordWithState:currentState numberWithPage:PAGE_ROW_COUNT indexWithPage:pageNO];
}
- (IBAction)acceptedSuccessOrderButtonOnclick:(id)sender {
    NotAcceptedOrderButton.selected=NO;
    AcceptedSuccessOrderButton.selected=YES;
    AcceptedFailureOrderButton.selected=NO;
    
    pageNO=0;
    [tableArray removeAllObjects];
    currentState=@"1";
    [self loadRecordWithState:currentState numberWithPage:PAGE_ROW_COUNT indexWithPage:pageNO];
}
- (IBAction)acceptedFailureOrderButtonOnclick:(id)sender {
    NotAcceptedOrderButton.selected=NO;
    AcceptedSuccessOrderButton.selected=NO;
    AcceptedFailureOrderButton.selected=YES;
    
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
