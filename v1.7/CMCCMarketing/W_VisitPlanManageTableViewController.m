//
//  W_VisitPlanManageTableViewController.m
//  CMCCMarketing
//
//  Created by gmj on 14-11-25.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import "W_VisitPlanManageTableViewController.h"
#import "W_VisitPlanDetailsViewController.h"
#import "W_VisistPlanFailureViewController.h"
#import "W_VisistPlanSummaryViewController.h"
#import "W_VisitPlanSignTableViewController.h"
#import "W_VisitPlanSignoutTableViewController.h"
#import "W_VisitPlanSignoutTableViewController.h"
#import "DataAcquisitionTableViewController.h"
#import "W_VisitPlanAddViewController.h"

#import "NetworkHandling.h"
#import "MBProgressHUD.h"

@interface W_VisitPlanManageTableViewController ()<MBProgressHUDDelegate>{
    NSString *signInFlag;
    NSString *signOutFlag;
    BOOL hubFlag;
    
}

@end

@implementation W_VisitPlanManageTableViewController

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

    //签到的通知(完成计划和签退需要判断状态)
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(UpdateSignInStauts:) name:@"SignInNotification" object:nil];
[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(UpdateSignOutStauts:) name:@"SignOutNotification" object:nil];
    
    self.tbView.dataSource = self;
    self.tbView.delegate = self;
    
    [self initSubView];
}

-(void)initSubView{
    
    self.navigationItem.title = @"拜访计划";
    UIBarButtonItem *rightButton=[[UIBarButtonItem alloc]initWithTitle:@"失访" style:UIBarButtonItemStylePlain target:self action:@selector(failureVisit)];
    [rightButton setTintColor:[UIColor whiteColor]];
    [self.navigationItem setRightBarButtonItem:rightButton];
    
    self.tableArray=[[NSArray alloc] initWithObjects:@"到达签到",@"拜访总结",@"离开签退",@"数据采集", nil];
    [self.tbView reloadData];
    
    self.lblVisit_grp_name.text = [self.dicSelectVisitPlanDetail objectForKey:@"visit_grp_name"];
    self.lblLinkman.text = [self.dicSelectVisitPlanDetail objectForKey:@"linkman"];
    self.lblVip_mngr_name.text = [self.dicSelectVisitPlanDetail objectForKey:@"vip_mngr_name"];
    self.lblVip_mngr_msisdn.text = [self.dicSelectVisitPlanDetail objectForKey:@"linkman_msisdn"];//联系人电话
    self.lblVisit_grp_add.text = [self.dicSelectVisitPlanDetail objectForKey:@"visit_grp_add"];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)toVisitPlanDetailOnClick:(id)sender {
    
    W_VisitPlanDetailsViewController *vc = [[W_VisitPlanDetailsViewController alloc] initWithNibName:@"W_VisitPlanDetailsViewController" bundle:nil];
    vc.dicSelectVisitPlanDetail = self.dicSelectVisitPlanDetail;
    vc.user = self.user;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)submitVisitPlan:(id)sender {
    //判断是否签到
    if([[self.dicSelectVisitPlanDetail objectForKey:@"signin_addr0"] isEqualToString:@""])
       
    {
        if(![signInFlag isEqualToString:@"1"])
        {
        MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:HUD];
        HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
        HUD.mode = MBProgressHUDModeCustomView;
        HUD.delegate = self;
        HUD.labelText=@"您还未签到,请先完成签到";
        [HUD show:YES];
        [HUD hide:YES afterDelay:3];
    
       return;
        }
    }
    //为驻点拜访时，判断是否签退
    if([[self.dicSelectVisitPlanDetail objectForKey:@"visit_type"] isEqualToString:@"驻点"])
    {
    if([[self.dicSelectVisitPlanDetail objectForKey:@"signin_addr1"] isEqualToString:@""])
        
    {
        if(![signOutFlag isEqualToString:@"1"])
        {
            MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
            [self.view addSubview:HUD];
            HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
            HUD.mode = MBProgressHUDModeCustomView;
            HUD.delegate = self;
            HUD.labelText=@"驻点拜访请完成签退";
            [HUD show:YES];
            [HUD hide:YES afterDelay:3];
            
            return;
        }
    }
   }

    
    [self updateVisitPlanState];
}

- (IBAction)btnEditVisitPlanOnClick:(id)sender {
    
    W_VisitPlanAddViewController *vc = [[W_VisitPlanAddViewController alloc] initWithNibName:@"W_VisitPlanAddViewController" bundle:nil];
    vc.user=self.user;
    vc.dicSelectVisitPlanDetail = self.dicSelectVisitPlanDetail;//
    [self.navigationController pushViewController:vc animated:YES];
    
}


-(void)showMessage:(NSString*)infomation{
    
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"信息提示" message:infomation delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
    [myAlertView show];
}

-(void)connectToNetwork{
    
    while (hubFlag) {
        usleep(100000);
    }
}

-(void)updateVisitPlanState{
    
    hubFlag=YES;
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"数据提交中，请稍后...";
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
    
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    [bDict setObject:[NSNumber numberWithInt:self.user.userLvl] forKey:@"user_lvl"];
    [bDict setObject:[NSNumber numberWithInt:self.user.userID] forKey:@"user_id"];
    [bDict setObject:self.user.userMobile forKey:@"user_msisdn"];
    [bDict setObject:[NSNumber numberWithInt:self.user.userEnterprise] forKey:@"enterprise"];
    
    NSString *row_id = [self.dicSelectVisitPlanDetail objectForKey:@"row_id"];
    [bDict setObject:row_id forKey:@"visit_id"];
    [bDict setObject:@"2" forKey:@"visit_sta"];
    
    
    [NetworkHandling sendPackageWithUrl:@"visitplan/updvisitplansta" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        hubFlag=NO;
        if(!error){
            
            NSLog(@"sign in success");
            BOOL flag=[[result objectForKey:@"flag"] boolValue];
            if(flag){
                
                [self performSelectorOnMainThread:@selector(submitSuccess) withObject:nil waitUntilDone:YES];
                
            }else{
                
                [self performSelectorOnMainThread:@selector(showMessage:) withObject:@"提交失败！" waitUntilDone:YES];
            }
            
        }else{
            
            int errorCode=[[result valueForKey:@"errorcode"] intValue];
            NSString *errorInfo=[result valueForKey:@"errorinf"];
            if(!errorInfo)
                errorInfo=@"提交数据出错了！";
            NSLog(@"error:%d info:%@",errorCode,errorInfo);
            [self performSelectorOnMainThread:@selector(showMessage:) withObject:errorInfo waitUntilDone:YES];
        }
        
    }];
}
-(void)submitSuccess{
    [self.navigationController popViewControllerAnimated:YES];
//     [self.navigationController popToRootViewControllerAnimated:YES];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.tableArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"W_VisitPlanManageTableViewControllerCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:CellIdentifier owner:self options:nil] objectAtIndex:0];
    }
    
    UILabel *titile = (UILabel *)[cell viewWithTag:100];
    titile.text = [self.tableArray objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger r =indexPath.row;
    if (r == 0) {
        
        W_VisitPlanSignTableViewController *vc = [[W_VisitPlanSignTableViewController alloc] initWithNibName:@"W_VisitPlanSignTableViewController" bundle:nil];
        vc.user = self.user;
        vc.dicSelectVisitPlanDetail = self.dicSelectVisitPlanDetail;
        [self.navigationController pushViewController:vc animated:YES];
        
    } else if (r == 1){
        
        W_VisistPlanSummaryViewController *vc = [[W_VisistPlanSummaryViewController alloc] initWithNibName:@"W_VisistPlanSummaryViewController" bundle:nil];
        vc.user = self.user;
        vc.dicSelectVisitPlanDetail = self.dicSelectVisitPlanDetail;
        [self.navigationController pushViewController:vc animated:YES];
        
    } else if (r == 2){
        //判断是否签到
        if([[self.dicSelectVisitPlanDetail objectForKey:@"signin_addr0"] isEqualToString:@""])
        {
        if (![signInFlag isEqualToString:@"1"]) {
            MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
            [self.view addSubview:HUD];
            HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
            HUD.mode = MBProgressHUDModeCustomView;
            HUD.delegate = self;
            HUD.labelText=@"您还未签到,请先完成签到";
            [HUD show:YES];
            [HUD hide:YES afterDelay:3];
            return;
                   }
        }
        
            W_VisitPlanSignoutTableViewController *vc = [[W_VisitPlanSignoutTableViewController alloc] initWithNibName:@"W_VisitPlanSignoutTableViewController" bundle:nil];
            vc.user = self.user;
            vc.dicSelectVisitPlanDetail = self.dicSelectVisitPlanDetail;
            [self.navigationController pushViewController:vc animated:YES];


    } else if (r == 3){
        
        UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"DataAcquisition" bundle:nil];
        UINavigationController *controller=[storyboard instantiateViewControllerWithIdentifier:@"DataAcquisitionTableViewControllerId"];
        DataAcquisitionTableViewController *dataAcquisitionController = [controller.viewControllers objectAtIndex:0];
        dataAcquisitionController.user=self.user;
        [self presentViewController:controller animated:YES completion:nil];
        
    }
    
    

    
}

-(void)failureVisit{
    
    W_VisistPlanFailureViewController *vc = [[W_VisistPlanFailureViewController alloc] initWithNibName:@"W_VisistPlanFailureViewController" bundle:nil];
    vc.user = self.user;
    vc.dicSelectVisitPlanDetail = self.dicSelectVisitPlanDetail;
    [self.navigationController pushViewController:vc animated:YES];
    
}


#pragma 通知方法
-(void)UpdateSignInStauts:(NSNotification*)aNotification{
    
    signInFlag=[aNotification object];
    
}
-(void)UpdateSignOutStauts:(NSNotification*)aNotification{
    
    signOutFlag=[aNotification object];
    
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
