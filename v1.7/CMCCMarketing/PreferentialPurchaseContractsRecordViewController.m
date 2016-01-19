//
//  PreferentialPurchaseContractsRecordViewController.m
//  CMCCMarketing
//
//  Created by talkweb on 14-9-18.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import "PreferentialPurchaseContractsRecordViewController.h"
#import "PreferentialPurchaseContractsRecordTableViewCell.h"
#import "PreferentialPurchaseContractsRecordWithBareTableViewCell.h"
#import "MBProgressHUD.h"
#import "NetworkHandling.h"
#import "MJRefresh.h"

#define PAGE_ROW_COUNT 20

@interface PreferentialPurchaseContractsRecordViewController ()<MBProgressHUDDelegate>{
    BOOL hubFlag;
    NSMutableArray *tableArray;
    int pageNO;
    NSString *currentState;
}
@end

@implementation PreferentialPurchaseContractsRecordViewController

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
    contractsRecordTableView.dataSource=self;
    contractsRecordTableView.delegate=self;

    currentState=@"0";
    NotAcceptedOrderButton.selected=true;
    
    tableArray=[[NSMutableArray alloc] init];
    if([self.type isEqualToString:@"1"]){
        self.title=@"裸机购机受理记录";
        cellTitleView.hidden=NO;
    }
    else{
        self.title=@"合约机购机受理记录";
        cellTitleView.hidden=YES;
    }
    
    //    [self setupRefresh];
    
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
    NSLog(@"load data with index:%d",index);
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    [bDict setObject:[NSNumber numberWithInt:self.user.userID] forKey:@"customerManagerId"];
    [bDict setObject:[NSNumber numberWithInt:self.user.userEnterprise] forKey:@"customerManagerEnterprise"];
    [bDict setObject:state forKey:@"state"]; //“state”:办理状态,“0”已提交/”1”受理成功/”2”受理失败/”3”逻辑删除
    [bDict setObject:[NSNumber numberWithInt:pagesTotal] forKey:@"pageNum"];
    [bDict setObject:[NSNumber numberWithInt:index] forKey:@"start"];
    [bDict setObject:@"" forKey:@"whereVal"];
    [bDict setObject:self.type forKey:@"type"];  //type //合约类型，"0"合约机/"1"裸机
    
    [NetworkHandling sendPackageWithUrl:@"sale/CheckOffSale" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        if(!error){
            NSLog(@"sign in success");
            NSArray *tmpArray =[result objectForKey:@"Response"];
            
            if([tmpArray count]==PAGE_ROW_COUNT){
                pageNO++;
                [self performSelectorOnMainThread:@selector(setupRefresh) withObject:nil waitUntilDone:YES];
                //                [self setupRefresh];
            }
            else{
                [contractsRecordTableView removeFooter];
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
    [contractsRecordTableView reloadData];
    [contractsRecordTableView footerEndRefreshing];
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
//    bussID = 117;
//    contactInfo =     {
//        contactEndDate = "2015-5-5";
//        contactPeriod = 357;
//        contactStartDate = "2014-5-5";
//        monthEndReturn = 578;
//        monthLowest = 567;
//        monthReturn = 357;
//        payMoney = 100;
//        payMonths = 24;
//        prestoreMoney = 468;
//        remark = "\U9014\U5f84\U9632\U8150\U5242";
//    };
//    customerManagerEnterprise = 2;
//    "customerManagerId " = 4;
//    dealDate = "<null>";
//    failDesc = "<null>";
//    groupInfo =     {
//        groupID = 7313A43314;
//        groupName = "\U957f\U6c99\U5e02\U5f00\U798f\U533a\U51ef\U5229\U901a\U8baf\U884c";
//    };
//    indbDate = "2014-10-23";
//    phoneInfo =     {
//        brandType = "\U8054\U60f3gjkk";
//        charge = "<null>";
//        imeiCode = "<null>";
//    };
//    userInfo =     {
//        customerIdCard = 2689;
//        customerIdCardPics = "http://192.168.146.167:8080/kite/uploadImage/OrderBusiness/sale/4/20141023155024574.jpghttp://192.168.146.167:8080/kite/uploadImage/OrderBusiness/sale/4/20141023155024869.jpg,";
//        customerName = "\U6613\U5efa\U8054";
//        customerPhone = 42578;
//        lat = "<null>";
//        lng = "<null>";
//        servicePwd = "<null>";
//    };
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    NSDictionary *dict=[tableArray objectAtIndex:indexPath.row];
    if([self.type isEqualToString:@"0"]){
        PreferentialPurchaseContractsRecordTableViewCell *cell1 = (PreferentialPurchaseContractsRecordTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"PreferentialPurchaseContractsRecordTableViewCell" forIndexPath:indexPath];
        NSDictionary *groupInfo=[dict objectForKey:@"groupInfo"];
        cell1.itemGroup.text=[groupInfo objectForKey:@"groupName"];
        
        NSDictionary *userInfo=[dict objectForKey:@"userInfo"];
        cell1.itemCustomer.text=[NSString stringWithFormat:@"%@\n%@",[userInfo objectForKey:@"customerName"],[userInfo objectForKey:@"customerPhone"]];
        NSDictionary *phoneInfo=[dict objectForKey:@"phoneInfo"];
        cell1.itemPhone.text=[NSString stringWithFormat:@"%@\n%@\n%@",[phoneInfo objectForKey:@"brandType"],[phoneInfo objectForKey:@"charge"],[phoneInfo objectForKey:@"imeiCode"]];
        NSDictionary *contactInfo=[dict objectForKey:@"contactInfo"];
        cell1.itemContracts.text=[NSString stringWithFormat:@"月保底消费：%@ \n 合约期：%@",[contactInfo objectForKey:@"monthLowest"],[contactInfo objectForKey:@"payMonths"]];
        
        cell1.itemDate.text=[dict objectForKey:@"indbDate"];
        
        cell=cell1;
    }
    else{
        PreferentialPurchaseContractsRecordWithBareTableViewCell *cell2 = (PreferentialPurchaseContractsRecordWithBareTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"PreferentialPurchaseContractsRecordWithBareTableViewCell" forIndexPath:indexPath];
        
        NSDictionary *groupInfo=[dict objectForKey:@"groupInfo"];
        cell2.itemGroup.text=[groupInfo objectForKey:@"groupName"];
        
        NSDictionary *userInfo=[dict objectForKey:@"userInfo"];
        cell2.itemCustomer.text=[NSString stringWithFormat:@"%@\n%@",[userInfo objectForKey:@"customerName"],[userInfo objectForKey:@"customerPhone"]];
        NSDictionary *phoneInfo=[dict objectForKey:@"phoneInfo"];
        cell2.itemPhone.text=[NSString stringWithFormat:@"%@\n%@\n%@",[phoneInfo objectForKey:@"brandType"],[phoneInfo objectForKey:@"charge"],[phoneInfo objectForKey:@"imeiCode"]];
        
        cell2.itemDate.text=[dict objectForKey:@"indbDate"];
        
        cell=cell2;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}
/**
 *  集成刷新控件
 */
#pragma mark - 集成刷新控件
- (void)setupRefresh
{
    [contractsRecordTableView addFooterWithTarget:self action:@selector(footerRereshing)];
    contractsRecordTableView.footerPullToRefreshText = @"上拉加载更多数据";
    contractsRecordTableView.footerReleaseToRefreshText = @"松开加载更多数据";
    contractsRecordTableView.footerRefreshingText = @"加载中,请稍后...";
}

#pragma mark 开始进入刷新状态

- (void)footerRereshing
{
    [self loadRecordWithState:currentState numberWithPage:PAGE_ROW_COUNT indexWithPage:pageNO];
    
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
- (IBAction)acceptedFailureOrderButton:(id)sender {
    NotAcceptedOrderButton.selected=NO;
    AcceptedSuccessOrderButton.selected=NO;
    AcceptedFailureOrderButton.selected=YES;
    
    pageNO=0;
    [tableArray removeAllObjects];
    currentState=@"2";
    [self loadRecordWithState:currentState numberWithPage:PAGE_ROW_COUNT indexWithPage:pageNO];
}


@end
