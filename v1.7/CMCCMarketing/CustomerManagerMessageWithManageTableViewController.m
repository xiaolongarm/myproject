//
//  CustomerManagerMessageWithManageTableViewController.m
//  CMCCMarketing
//
//  Created by talkweb on 15-4-29.
//  Copyright (c) 2015年 talkweb. All rights reserved.
//

#import "CustomerManagerMessageWithManageTableViewController.h"
#import "NetworkHandling.h"
#import "MBProgressHUD.h"
#import "CustomerManagerMessageWithManageTableViewCell.h"

#import "CustomerManagerGroupAddressVerifyViewController.h"
#import "CustomerManagerGroupContactVerifyViewController.h"

@interface CustomerManagerMessageWithManageTableViewController ()<MBProgressHUDDelegate>{
    BOOL hubFlag;
    NSArray *remindTableArray;
    NSArray *remindWithGroupAddressTableArray;
    NSArray *remindWithLinkManTableArray;
    NSDictionary *selectDict;
}

@end

@implementation CustomerManagerMessageWithManageTableViewController

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
    //客户管理审核界面(最新消息过来的，作废)

    [super viewDidLoad];
   }

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
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

-(void)loadRemindData{
    
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    [bDict setObject:[NSNumber numberWithInt:self.user.userID] forKey:@"user_id"];
    [bDict setObject:self.user.userMobile forKey:@"mobile"];
    [bDict setObject:[NSNumber numberWithInt:self.user.userEnterprise] forKey:@"enterprise"];
    
    NSString *url=@"grpuserlink/leaderReminder";

    [NetworkHandling sendPackageWithUrl:url sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        if(!error){
            NSLog(@"sign in success");
            
            remindTableArray =[result objectForKey:@"birthday"];
            remindWithGroupAddressTableArray=[result objectForKey:@"grp_add"];
            remindWithLinkManTableArray=[result objectForKey:@"linkman"];

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
    if([remindWithGroupAddressTableArray count] == 0 && [remindWithLinkManTableArray count] == 0){
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    int count = 0;
    count = [remindWithGroupAddressTableArray count] > 0 ? 1 : 0;
    count = [remindWithLinkManTableArray count] > 0 ? count+1 : count;
    return count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([remindWithGroupAddressTableArray count] && !section)
        return [remindWithGroupAddressTableArray count];
    return [remindWithLinkManTableArray count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return .1f;
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if([remindWithGroupAddressTableArray count] && !section)
        return @"集团地理位置审核";
    return @"新增关键人审核";
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomerManagerMessageWithManageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CustomerManagerMessageWithManageTableViewCell" forIndexPath:indexPath];

    NSDictionary *dict;
    if([remindWithGroupAddressTableArray count] && !indexPath.section)
        dict =[remindWithGroupAddressTableArray objectAtIndex:indexPath.row];
    else
        dict =[remindWithLinkManTableArray objectAtIndex:indexPath.row];

    cell.itemName.text = [dict objectForKey:@"grp_name"];
    cell.itemUser.text = [dict objectForKey:@"vip_mngr_name"];
    cell.itemTime.text = [dict objectForKey:@"op_date"];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if([remindWithGroupAddressTableArray count] && !indexPath.section){
        selectDict =[remindWithGroupAddressTableArray objectAtIndex:indexPath.row];
        [self performSegueWithIdentifier:@"CustomerManagerGroupAddressVerifySegue" sender:self];
    }
    else{
        selectDict =[remindWithLinkManTableArray objectAtIndex:indexPath.row];
        [self performSegueWithIdentifier:@"CustomerManagerGroupContactVerifySegue" sender:self];
    }
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"CustomerManagerGroupAddressVerifySegue"]){
        CustomerManagerGroupAddressVerifyViewController *controller = segue.destinationViewController;
        controller.addrmsgDict=selectDict;
        controller.user=self.user;
    }
    if([segue.identifier isEqualToString:@"CustomerManagerGroupContactVerifySegue"]){
        CustomerManagerGroupContactVerifyViewController *controller = segue.destinationViewController;
        controller.msgDict=selectDict;
        controller.user=self.user;
    }
}


@end
