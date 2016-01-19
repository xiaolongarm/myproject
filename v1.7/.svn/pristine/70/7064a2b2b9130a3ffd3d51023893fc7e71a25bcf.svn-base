//
//  CustomersWarningFollowUpHistoryTableViewController.m
//  CMCCMarketing
//
//  Created by talkweb on 14-9-24.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//
#import "CustomersWarningFollowUpHistoryTableViewCell.h"
#import "CustomersWarningFollowUpHistoryTableViewController.h"
#import "MBProgressHUD.h"
#import "NetworkHandling.h"

@interface CustomersWarningFollowUpHistoryTableViewController ()<MBProgressHUDDelegate>{
    BOOL hubFlag;
    NSArray *tableArray;
}

@end

@implementation CustomersWarningFollowUpHistoryTableViewController

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
    
    hubFlag=YES;
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"数据查询中，请稍后...";
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
    [self loadRemindData];
    
}
-(void)connectToNetwork{
    while (hubFlag) {
        usleep(100000);
    }
}
//{
//    "grp_code":               集团编码
//    "enterprise":   企业编码
//}
-(void)loadRemindData{
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    [bDict setObject:[self.groupDict objectForKey:@"grp_code"] forKey:@"grp_code"];
    [bDict setObject:[NSNumber numberWithInt:self.user.userEnterprise] forKey:@"enterprise"];

    
    [NetworkHandling sendPackageWithUrl:@"gprwarn/getreplyList" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        if(!error){
            NSLog(@"sign in success");
            tableArray =[result objectForKey:@"Response"];
            
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

-(void)showMessage:(NSString*)infomation{
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"信息提示" message:infomation delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
    [myAlertView show];
}
-(void)refreshTableView{
    [self.tableView reloadData];
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
//    enterprise = 2;
//    "grp_code" = 7311001016;
//    "grp_name" = "\U957f\U6c99\U5e7f\U827a\U5e7f\U544a\U88c5\U9970\U6709\U9650\U516c\U53f8";
//    "indb_date" = "2014-11-05T01:26:19+0000";
//    linkman = "\U592a\U9633\U901b\U901b\U8857";
//    "linkman_msisdn" = 7843687423;
//    "reply_content" = "\U7535\U5f71\U91d1\U50cf\U5956\U5fb7\U56fd v \U4f60";
//    "row_id" = 8;
//    "vip_mngr_msisdn" = 15073111492;
//    "vip_mngr_name" = "\U848b\U679c";
//},
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomersWarningFollowUpHistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CustomersWarningFollowUpHistoryTableViewCell" forIndexPath:indexPath];

    NSDictionary *dict=[tableArray objectAtIndex:indexPath.row];
    cell.itemTelephoneNo.text=[dict objectForKey:@"linkman_msisdn"];
    cell.itemGroup.text=[dict objectForKey:@"grp_name"];
    cell.itemPersonalName.text=[dict objectForKey:@"linkman"];
    cell.itemFollowUpContent.text=[dict objectForKey:@"reply_content"];
    cell.itemDateTime.text=[dict objectForKey:@"indb_date"];
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
