//
//  CustomersWarningWithPersonalIndicatorsViewController.m
//  CMCCMarketing
//
//  Created by talkweb on 14-9-24.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//
#import "CustomersWarningWithPersonalIndicatorsTableViewCell.h"
#import "CustomersWarningWithPersonalIndicatorsViewController.h"
#import "CustomersWarningFollowUpViewController.h"
#import "CustomersWarningFollowUpHistoryTableViewController.h"
#import "MBProgressHUD.h"
#import "NetworkHandling.h"
#import "Customer.h"
#import "MarketingCustomerDetailsTableViewController.h"

@interface CustomersWarningWithPersonalIndicatorsViewController ()<MBProgressHUDDelegate>{
    BOOL hudFlag;
    Customer *customer;
}

@end

@implementation CustomersWarningWithPersonalIndicatorsViewController

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
    indicatorsTableView.dataSource=self;
    indicatorsTableView.delegate=self;
    indicatorsTableView.separatorStyle=UITableViewCellSeparatorStyleNone;

//    UIBarButtonItem *rightButton=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"详细信息"] style:UIBarButtonItemStylePlain target:self action:@selector(goGroupInformation)];
//    [rightButton setTintColor:[UIColor whiteColor]];
//    [self.navigationItem setRightBarButtonItem:rightButton];
    
#if (defined MANAGER_CS_VERSION) || (defined MANAGER_SY_VERSION)
    btProgressReply.hidden=YES;
#endif
    
    lbGroup.text=[self.cuestomerDict objectForKey:@"grp_name"];
    lbPhone.text=[self.cuestomerDict objectForKey:@"user_msisdn"];
    lbName.text=@"预警客户";
    lbType.text=[self.cuestomerDict objectForKey:@"user_type"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)goGroupInformation{
    hudFlag=YES;
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"正在获取用户相关信息资料...";
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
    [self requestCustomerQuery];
}
-(void)connectToNetwork{
    while (hudFlag) {
        usleep(100000);
    }
}

-(void)requestCustomerQuery{
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    [bDict setValue:[self.cuestomerDict objectForKey:@"user_msisdn"] forKeyPath:@"svc_code"];
    
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
                [self performSelectorOnMainThread:@selector(showDetails) withObject:nil waitUntilDone:NO];
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
-(void)showDetails{
//    [self performSegueWithIdentifier:@"IndividualCustomersSegue" sender:self];
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"Marketing" bundle:nil];
//    UINavigationController *controller=[storyboard instantiateViewControllerWithIdentifier:@"MarketingViewControllerId"];
    MarketingCustomerDetailsTableViewController *controller=[storyboard instantiateViewControllerWithIdentifier:@"MarketingCustomerDetailsTableViewControllerId"];
    controller.customer=customer;
    [self.navigationController pushViewController:controller animated:YES];
}
-(void)showMessage:(NSString*)infomation{
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"信息提示" message:infomation delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
    [myAlertView show];
}

-(void)hudWasHidden:(MBProgressHUD *)hud{
    [hud removeFromSuperview];
    hud=nil;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if([segue.identifier isEqualToString:@"CustomersWarningFollowUpWithPersionSegue"]){
        CustomersWarningFollowUpViewController *controller=segue.destinationViewController;
        controller.user=self.user;
        controller.isPersion=YES;
        controller.customerDict=self.cuestomerDict;
    }
    
    if([segue.identifier isEqualToString:@"CustomersWarningFollowUpHistoryWithPersionSegue"]){
        CustomersWarningFollowUpHistoryTableViewController *controller=segue.destinationViewController;
        controller.user=self.user;
        controller.groupDict=self.cuestomerDict;
    }
}

//- (IBAction)goReply:(id)sender {
//    [self performSegueWithIdentifier:@"CustomersWarningFollowUpWithPersionSegue" sender:self];
//}
//- (IBAction)goHistoryReply:(id)sender {
//    [self performSegueWithIdentifier:@"CustomersWarningFollowUpHistoryWithPersionSegue" sender:self];
//}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 13;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 25;
}
//{
//    arpu = "99.60";
//    "arpu_per" = "51.59";
//    "baodi_end_date" = 20141231;
//    "disc_name" = "\U52a8\U611f\U5730\U5e26\U4e0a\U7f51\U5957\U991038\U5143\U5957\U9910\U4f18\U60e0";
//    dou = "244.30";
//    "dou_per" = "22.55";
//    "gprs_disc_name" = "\U52a8\U611f\U5730\U5e26\U4e0a\U7f51\U5957\U991038\U5143\U5957\U9910\U4f18\U60e0";
//    "grp_code" = 7311000158;
//    "grp_name" = "\U6e56\U5357\U65e5\U62a5\U793e\U5370\U5237\U5382";
//    "is_4g_card" = "\U5426";
//    "is_4g_disc" = "\U5426";
//    "is_4g_term" = "\U5426";
//    "is_baodi" = "\U662f";
//    "photo_arpu" = "65.70";
//    rank = 1;
//    "term_standard" = GSM;
//    thresholds =     (
//    );
//    "time_id" = 201409;
//    "user_msisdn" = 18874238126;
//    "user_stat" = "\U5f00\U901a";
//    "user_type" = "201408\U6708BOSS\U5173\U952e\U4eba";
//    "vip_mngr_id" = A1KZZQ36;
//    "vip_mngr_msisdn" = 15073111492;
//    "vip_mngr_name" = "\U5f90\U9759";
//}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomersWarningWithPersonalIndicatorsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CustomersWarningWithPersonalIndicatorsTableViewCell" forIndexPath:indexPath];

    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    NSArray *thresholds;
    
    if(self.cuestomerDict && [self.cuestomerDict count] > 0)
        thresholds=[self.cuestomerDict objectForKey:@"thresholds"];
    
    switch (indexPath.row) {
        case 0:
            cell.itemTitle.text=@"拍照客户ARPU值:";
            if(self.cuestomerDict && [self.cuestomerDict count] > 0)
                cell.itemValue.text=[self.cuestomerDict objectForKey:@"photo_arpu"];
            else
                cell.itemValue.text=@"-";
            cell.itemImageView.hidden =![thresholds containsObject:@"photo_arpu"];
            break;
            
        case 1:
            cell.itemTitle.text=@"当月ARPU:";
            if(self.cuestomerDict && [self.cuestomerDict count] > 0)
                cell.itemValue.text=[self.cuestomerDict objectForKey:@"arpu"];
            else
                cell.itemValue.text=@"-";
            cell.itemImageView.hidden =![thresholds containsObject:@"arpu"];
            break;
            
        case 2:
            cell.itemTitle.text=@"当月日均收入保持率或ARPU环比:";
            if(self.cuestomerDict && [self.cuestomerDict count] > 0)
                cell.itemValue.text=[self.cuestomerDict objectForKey:@"arpu_per"];
            else
                cell.itemValue.text=@"-";
            cell.itemImageView.hidden =![thresholds containsObject:@"arpu_per"];
            break;
            
        case 3:
            cell.itemTitle.text=@"当月DOU:";
            if(self.cuestomerDict && [self.cuestomerDict count] > 0)
                cell.itemValue.text=[self.cuestomerDict objectForKey:@"dou"];
            else
                cell.itemValue.text=@"-";
            cell.itemImageView.hidden =![thresholds containsObject:@"dou"];
            break;
            
        case 4:
            cell.itemTitle.text=@"DOU环比:";
            if(self.cuestomerDict && [self.cuestomerDict count] > 0)
                cell.itemValue.text=[self.cuestomerDict objectForKey:@"dou_per"];
            else
                cell.itemValue.text=@"-";
            cell.itemImageView.hidden =![thresholds containsObject:@"dou_per"];
            break;
            
        case 5:
            cell.itemTitle.text=@"当前状态:";
            if(self.cuestomerDict && [self.cuestomerDict count] > 0)
                cell.itemValue.text=[self.cuestomerDict objectForKey:@"user_stat"];
            else
                cell.itemValue.text=@"-";
            cell.itemImageView.hidden =![thresholds containsObject:@"user_stat"];
            break;

        case 6:
            cell.itemTitle.text=@"当前使用的终端制式:";
            if(self.cuestomerDict && [self.cuestomerDict count] > 0)
                cell.itemValue.text=[self.cuestomerDict objectForKey:@"term_standard"];
            else
                cell.itemValue.text=@"-";
            cell.itemImageView.hidden =![thresholds containsObject:@"term_standard"];
            break;
        case 7:
            cell.itemTitle.text=@"当前使用的套餐名称:";
            if(self.cuestomerDict && [self.cuestomerDict count] > 0)
                cell.itemValue.text=[self.cuestomerDict objectForKey:@"disc_name"];
            else
                cell.itemValue.text=@"-";
            cell.itemImageView.hidden =![thresholds containsObject:@"disc_name"];
            break;
        case 8:
            cell.itemTitle.text=@"是否4g终端:";
            if(self.cuestomerDict && [self.cuestomerDict count] > 0)
                cell.itemValue.text=[self.cuestomerDict objectForKey:@"is_4g_term"];
            else
                cell.itemValue.text=@"-";
            cell.itemImageView.hidden =![thresholds containsObject:@"is_4g_term"];
            break;
            
        case 9:
            cell.itemTitle.text=@"是否4g换卡:";
            if(self.cuestomerDict && [self.cuestomerDict count] > 0)
                cell.itemValue.text=[self.cuestomerDict objectForKey:@"is_4g_card"];
            else
                cell.itemValue.text=@"-";
            cell.itemImageView.hidden =![thresholds containsObject:@"is_4g_card"];
            break;
            
        case 10:
            cell.itemTitle.text=@"是否4g套餐:";
            if(self.cuestomerDict && [self.cuestomerDict count] > 0)
                cell.itemValue.text=[self.cuestomerDict objectForKey:@"is_4g_disc"];
            else
                cell.itemValue.text=@"-";
            cell.itemImageView.hidden =![thresholds containsObject:@"is_4g_disc"];
            break;

        case 11:
            cell.itemTitle.text=@"是否有保底:";
            if(self.cuestomerDict && [self.cuestomerDict count] > 0)
                cell.itemValue.text=[self.cuestomerDict objectForKey:@"is_baodi"];
            else
                cell.itemValue.text=@"-";
            cell.itemImageView.hidden =![thresholds containsObject:@"is_baodi"];
            break;

        case 12:
            cell.itemTitle.text=@"保底到期日:";
            if(self.cuestomerDict && [self.cuestomerDict count] > 0)
                cell.itemValue.text=[self.cuestomerDict objectForKey:@"baodi_end_date"];
            else
                cell.itemValue.text=@"-";
            cell.itemImageView.hidden =![thresholds containsObject:@"baodi_end_date"];
            break;

            
        default:
            break;
    }
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}

- (IBAction)goReply:(id)sender {
    [self performSegueWithIdentifier:@"CustomersWarningFollowUpWithPersionSegue" sender:self];
}
- (IBAction)goHistoryReply:(id)sender {
    [self performSegueWithIdentifier:@"CustomersWarningFollowUpHistoryWithPersionSegue" sender:self];
}

@end
