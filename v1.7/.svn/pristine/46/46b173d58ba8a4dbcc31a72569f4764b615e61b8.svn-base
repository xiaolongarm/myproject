//
//  ChagangMonitorWarningAreaAllUserTableViewController.m
//  CMCCMarketing
//
//  Created by talkweb on 15-4-13.
//  Copyright (c) 2015年 talkweb. All rights reserved.
//

#import "ChagangMonitorWarningAreaAllUserTableViewController.h"
#import "NetworkHandling.h"
#import "MBProgressHUD.h"
#import "ChagangMonitorWarningAreaInformationTableViewCell.h"

@interface ChagangMonitorWarningAreaAllUserTableViewController ()<MBProgressHUDDelegate>{
    BOOL hubFlag;
    NSArray *tableArray;
}

@end

@implementation ChagangMonitorWarningAreaAllUserTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    hubFlag=YES;
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"数据查询中，请稍后...";
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
    [self loadTableData];
    
}
-(void)connectToNetwork{
    while (hubFlag) {
        usleep(100000);
    }
}
-(void)loadTableData{
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    [bDict setObject:[NSNumber numberWithInt:self.user.userID] forKey:@"userID"];
    [bDict setObject:[NSNumber numberWithInt:self.user.userEnterprise] forKey:@"enterprise"];
    
    [NetworkHandling sendPackageWithUrl:@"monitor/GetAllVipWarning" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        if(!error){
            NSLog(@"sign in success");
            tableArray=[result objectForKey:@"Response"];
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
    [self.tableView reloadData];
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
-(void)hudWasHidden:(MBProgressHUD *)hud{
    [hud removeFromSuperview];
    hud=nil;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [tableArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary *dict=[tableArray objectAtIndex:section];
    NSArray *array=[dict objectForKey:@"warningDetail"];
    return [array count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return .1f;
}
//-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    return nil;
//}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSDictionary *dict=[tableArray objectAtIndex:section];
    return [NSString stringWithFormat:@"%@ %@",[dict objectForKey:@"user_name"],[dict objectForKey:@"mobile"]];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChagangMonitorWarningAreaInformationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChagangMonitorWarningAreaInformationTableViewCell" forIndexPath:indexPath];
    
    NSDictionary *secDict=[tableArray objectAtIndex:indexPath.section];
    NSArray *array=[secDict objectForKey:@"warningDetail"];
    
    NSDictionary *dict=[array objectAtIndex:indexPath.row];
    cell.itemDate.text=[dict objectForKey:@"start_time"];
    
    int during_sec=[[dict objectForKey:@"during_sec"] intValue];
    NSString *secString=@"";
    if(during_sec > 60){
        int min=during_sec/60;
        int ss=during_sec%60;
        secString=[NSString stringWithFormat:@"%d分 %d秒",min,ss];
    }
    if(during_sec > 3600){
        int hh=during_sec/3600;
        int hh_m=during_sec%3600;
        
        int min=hh_m/60;
        int ss=hh_m%60;
        secString=[NSString stringWithFormat:@"%d时 %d分 %d秒",hh,min,ss];
    }
    
    cell.itemDuringSec.text=secString;
    
    BOOL is_back;
    if([dict objectForKey:@"is_back"] == [NSNull null])
        is_back=NO;
    else
        is_back =[[dict objectForKey:@"is_back"] boolValue];
    if(is_back){
        cell.itemState.text=@"已回归";
        cell.itemState.textColor=[UIColor greenColor];
    }
    else{
        cell.itemState.text=@"未回归";
        cell.itemState.textColor=[UIColor redColor];
    }
    
    int gps_sta =[[dict objectForKey:@"gps_sta"] intValue];
    switch (gps_sta) {
        case 0:
            cell.itemTerminalState.text=@"正常";
            break;
        case 1:
            cell.itemTerminalState.text=@"未开启gps上报";
            break;
        case 2:
            cell.itemTerminalState.text=@"无网络";
            break;
        case 3:
            cell.itemTerminalState.text=@"未登录";
            break;
            
        default:
            break;
    }
    
//    BOOL check_state=[[dict objectForKey:@"check_state"] boolValue];
//    int row_id=[[dict objectForKey:@"row_id"] intValue];
//    if(!check_state)
//        rowId=[rowId stringByAppendingFormat:@"%d,",row_id];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
