//
//  ManagerWorkRecordViewController.m
//  CMCCMarketing
//
//  Created by gmj on 15-1-20.
//  Copyright (c) 2015年 talkweb. All rights reserved.
//

#import "ManagerWorkRecordViewController.h"

#import "NetworkHandling.h"
#import "MBProgressHUD.h"

#import "BusinessHandling.h"
#import "ManagerWorkRecordDetailViewController.h"
#import "ManagerWorkRecordTableCellButton.h"
#import "ManagerWorkRecordSearchViewController.h"
@interface ManagerWorkRecordViewController ()<MBProgressHUDDelegate>{

    BOOL hubFlag;
    NSDate *now;
}

@end

@implementation ManagerWorkRecordViewController

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if([segue.identifier isEqualToString:@"ManagerWorkRecordDetailViewControllerSegue"]){
        ManagerWorkRecordDetailViewController *controller=segue.destinationViewController;
        controller.user=self.user;
        controller.selectedWorkRecord = self.selectedWorkRecord;
        controller.selectDate=self.selectedCellDate;
    }
    if([segue.identifier isEqualToString:@"ManagerWorkRecordQueryViewControllerSegue"]){
        ManagerWorkRecordSearchViewController *controller=segue.destinationViewController;
        controller.user=self.user;
    }
}

-(void)cellButtonOnclick:(id)sender{
    ManagerWorkRecordTableCellButton *button=sender;
    NSArray *list=[[self.tbList objectAtIndex:button.section] objectForKey:@"dailys"];
    self.selectedWorkRecord=[list objectAtIndex:button.tag-1];
    self.selectedCellDate=button.date;
    [self performSegueWithIdentifier:@"ManagerWorkRecordDetailViewControllerSegue" sender:nil];
}

#pragma mark - end ManagerWorkRecordViewControllerCellDelegate


-(void)showMessage:(NSString*)infomation{
    
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"信息提示" message:infomation delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
    [myAlertView show];
}

-(void)refreshTableView{
    
    [self.tbView reloadData];
}

-(void)connectToNetwork{
    
    while (hubFlag) {
        usleep(100000);
    }
}


-(void)loadWorkRecordData{
    
    hubFlag=YES;
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"数据查询中，请稍后...";
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
    
    /*
    //主管查看工作日报
    shaoyang\v1_4\daily\leaderdeldaily
    user_lvl用户级别
    user_id用户ID
    start_date开始日期
    end_date结束日期
     */
    
    NSMutableDictionary *bDict = [[NSMutableDictionary alloc] init];
    
    NSArray *dateArray=[BusinessHandling calculateWeekOfBeginDateAndEndDate:now];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *mondayString=[dateFormatter stringFromDate:[dateArray objectAtIndex:0]];
    NSString *sundayString=[dateFormatter stringFromDate:[dateArray objectAtIndex:1]];
    [bDict setObject:mondayString forKey:@"start_date"];
    [bDict setObject:sundayString forKey:@"end_date"];
    
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    [dateFormatter1 setDateFormat:@"MM-dd"];
    NSString *mondayShortString=[dateFormatter1 stringFromDate:[dateArray objectAtIndex:0]];
    NSString *sundayShortString=[dateFormatter1 stringFromDate:[dateArray objectAtIndex:1]];
    self.lblDate.text = [NSString stringWithFormat:@"%@ - %@",mondayShortString,sundayShortString];

    [bDict setObject:[NSNumber numberWithInt:self.user.userLvl] forKey:@"user_lvl"];
    [bDict setObject:[NSNumber numberWithInt:self.user.userID] forKey:@"user_id"];
    [NetworkHandling sendPackageWithUrl:@"daily/leaderdeldaily" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
    
        hubFlag=NO;
        
        if(!error){
            NSLog(@"sign in success");
            self.tbList =[result objectForKey:@"dailys"];
            [self performSelectorOnMainThread:@selector(refreshTableView) withObject:nil waitUntilDone:YES];
            
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
    // Do any additional setup after loading the view.
    
    self.tbView.delegate = self;
    self.tbView.dataSource = self;
    now=[NSDate date];
    [self loadWorkRecordData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark - Table view data source

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{

    NSDictionary *obj=[self.tbList objectAtIndex:section];
    return [obj objectForKey:@"daily_name"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 25;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.tbList count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ManagerWorkRecordViewControllerCell";
    ManagerWorkRecordViewControllerCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:CellIdentifier owner:self options:nil] objectAtIndex:0];
    }
    
    //清空按钮
    for (int i = 1; i < 8; i ++) {
        
        UIButton *button=(UIButton*)[cell.contentView viewWithTag:i];
        [button setTitle:@"0" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [button removeTarget:self action:@selector(cellButtonOnclick:) forControlEvents:UIControlEventTouchUpInside];
        
        UIImageView *imgView=(UIImageView*)[cell.contentView viewWithTag:i+100];
        imgView.hidden=YES;
    }

    
    NSDictionary *dict=[self.tbList objectAtIndex:indexPath.section];
    NSArray *dailys=[dict objectForKey:@"dailys"];
    for (NSDictionary *item in dailys) {
        if(item && ([NSNull null] != (NSNull*)item)){
            int week_day=[[item objectForKey:@"week_day"] intValue];
            ManagerWorkRecordTableCellButton *button=(ManagerWorkRecordTableCellButton*)[cell.contentView viewWithTag:week_day];
            
            //计算当前的日期
            NSArray *dateArray=[BusinessHandling calculateWeekOfBeginDateAndEndDate:now];
            NSDate *monday=[dateArray firstObject];
            NSTimeInterval weekInterval = (week_day - 1) * 24 * 60 * 60;
            NSDate *currentDate = [monday dateByAddingTimeInterval: weekInterval];
            
            button.date=currentDate;
            button.section=indexPath.section;
            [button setTitle:@"1" forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(cellButtonOnclick:) forControlEvents:UIControlEventTouchUpInside];
            
            BOOL rplFlag=[[item objectForKey:@"daily_sta"] boolValue];
            if(rplFlag){
                UIImageView *imgView=(UIImageView*)[cell.contentView viewWithTag:week_day+100];
                imgView.hidden=NO;
            }
                
        }
    }
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
 
}

- (IBAction)bntNextWeekOnclick:(id)sender {
    
    NSTimeInterval weekInterval = 7 * 24 * 60 * 60;
    now = [now dateByAddingTimeInterval: weekInterval];
    [self loadWorkRecordData];
    
}

- (IBAction)btnPreWeekOnclick:(id)sender {
    
    NSTimeInterval weekInterval = 7 * 24 * 60 * 60;
    now = [now dateByAddingTimeInterval: -weekInterval];
    [self loadWorkRecordData];
    
}
- (IBAction)goSearch:(id)sender {
    [self performSegueWithIdentifier:@"ManagerWorkRecordQueryViewControllerSegue" sender:self];
}

@end
