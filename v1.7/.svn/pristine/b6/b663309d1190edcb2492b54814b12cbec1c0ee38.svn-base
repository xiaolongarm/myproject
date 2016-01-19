//
//  VisitedListTableViewController.m
//  CMCCMarketing
//
//  Created by kevin on 15/8/7.
//  Copyright (c) 2015年 talkweb. All rights reserved.
//

#import "VisitedListTableViewController.h"
#import "VisitedListTableViewControllerTableViewCell.h"
#import "MBProgressHUD.h"
#import "NetworkHandling.h"
#import "W_VisitPlanDetailsViewController.h"

@interface VisitedListTableViewController ()<MBProgressHUDDelegate>{
    BOOL hudFlag;
    NSArray *tableviewArray;
}

@end

@implementation VisitedListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    if(IOS7)
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"320X64"] forBarMetrics:UIBarMetricsDefault];
    else
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"320X44"] forBarMetrics:UIBarMetricsDefault];
    
    self.navigationItem.title = @"已完成计划";
    UIBarButtonItem *leftButton=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回1"] style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    [leftButton setTintColor:[UIColor whiteColor]];
    [self.navigationItem setLeftBarButtonItem:leftButton];
    
    UIColor * color = [UIColor whiteColor];
    NSDictionary * dict=[NSDictionary dictionaryWithObject:color forKey:UITextAttributeTextColor];
    [self.navigationController.navigationBar setTitleTextAttributes:dict];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self loadVisitedlist];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
}

-(void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 81;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * identifier = @"VisitedListTableViewControllerTableViewCell";
    VisitedListTableViewControllerTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"VisitedListTableViewControllerTableViewCell" owner:nil options:nil]lastObject];
    }
    //去掉选中效果
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSUInteger row = [indexPath row];
    //  NSMutableDictionary *dic = [tableviewArray objectAtIndex:row];
    
    if ([tableviewArray count]==0) {
        return nil;
    }
    cell.customer.text=[[tableviewArray objectAtIndex:row]objectForKey:@"visit_grp_name"];
    cell.time.text=[[tableviewArray objectAtIndex:row]objectForKey:@"visit_statr_time"];
    cell.address.text=[[tableviewArray objectAtIndex:row]objectForKey:@"visit_grp_add"];
    cell.expiain.text=[[tableviewArray objectAtIndex:row]objectForKey:@"visit_content"];
    cell.pictuerNumber.text=[[tableviewArray objectAtIndex:row]objectForKey:@"image_cnt"];
        return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    W_VisitPlanDetailsViewController *vc = [[W_VisitPlanDetailsViewController alloc] initWithNibName:@"W_VisitPlanDetailsViewController" bundle:nil];
    vc.dicSelectVisitPlanDetail = [tableviewArray objectAtIndex:indexPath.row];
    vc.user = self.user;
    [self.navigationController pushViewController:vc animated:YES];

    }


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [tableviewArray count];
}

#pragma mark -网络API相关
-(void)loadVisitedlist{
    hudFlag=YES;
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"数据查询中，请稍后...";
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
    
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    [bDict setObject:[NSNumber numberWithInt:self.user.userLvl] forKey:@"user_lvl"];
    [bDict setObject:[NSNumber numberWithInt:self.user.userID] forKey:@"user_id"];
    [bDict setObject:[NSNumber numberWithInt:self.user.userEnterprise] forKey:@"enterprise"];
    
    [bDict setObject:[_FromVisitedlist objectForKey:@"vip_mngr_msisdn"]forKey:@"user_msisdn"];
      [bDict setObject:[_FromVisitedlist objectForKey:@"time"] forKey:@"visit_statr_time"];
    [bDict setObject:[_FromVisitedlist objectForKey:@"time"] forKey:@"visit_end_time"];
    [bDict setObject:@"2" forKey:@"visit_sta"];
//    
    
    [NetworkHandling sendPackageWithUrl:@"visitplan/visitplanlist" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        if(!error){
            NSLog(@"sign in success");
            tableviewArray =[result objectForKey:@"visit"];
            if([tableviewArray count] > 0){
                [self performSelectorOnMainThread:@selector(refreshTable) withObject:nil waitUntilDone:YES];
            }else{
                
                return ;
            }
            
        }else{
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

-(void)refreshTable{
    [self.tableView reloadData];
    
}

-(void)connectToNetwork{
    while (hudFlag) {
        usleep(100000);
    }
}
-(void)showMessage:(NSString*)infomation{
    
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"信息提示" message:infomation delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
    [myAlertView show];
}




/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/


@end
