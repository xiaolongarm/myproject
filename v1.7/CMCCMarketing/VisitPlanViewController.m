//
//  VisitPlanViewController.m
//  CMCCMarketing
//
//  Created by talkweb on 14-9-24.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//
#import "VisitPlanTableViewCell.h"
#import "VisitPlanViewController.h"
#import "MBProgressHUD.h"
#import "NetworkHandling.h"
#import "VisitPlanMessageTableViewController.h"
#import "VisitPlanAddViewController.h"

@interface VisitPlanViewController ()<MBProgressHUDDelegate>{
    BOOL hubFlag;
    NSArray *remindTableArray;
    NSArray *remindHistoryArray;
}

@end

@implementation VisitPlanViewController

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
    visitPlanTableView.dataSource=self;
    visitPlanTableView.delegate=self;
    
    
    
    if(IOS7)
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"320X64"] forBarMetrics:UIBarMetricsDefault];
    else
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"320X44"] forBarMetrics:UIBarMetricsDefault];
    
    UIBarButtonItem *leftButton=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回1"] style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    [leftButton setTintColor:[UIColor whiteColor]];
    
    [self.navigationItem setLeftBarButtonItem:leftButton];
    
    UIColor * color = [UIColor whiteColor];
    NSDictionary * dict=[NSDictionary dictionaryWithObject:color forKey:UITextAttributeTextColor];
    [self.navigationController.navigationBar setTitleTextAttributes:dict];
    
//    UIBarButtonItem *rightButton=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"加号"] style:UIBarButtonItemStylePlain target:self action:@selector(addVisitPlan)];
//    [rightButton setTintColor:[UIColor whiteColor]];
//    [self.navigationItem setRightBarButtonItem:rightButton];

    UIBarButtonItem *rightButton=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"喇叭"] style:UIBarButtonItemStylePlain target:self action:@selector(loadMessageCenterData)];
    [rightButton setTintColor:[UIColor whiteColor]];
    [self.navigationItem setRightBarButtonItem:rightButton];

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
    [bDict setObject:[NSNumber numberWithInt:self.user.userLvl] forKey:@"user_lvl"];
    [bDict setObject:[NSNumber numberWithInt:self.user.userID] forKey:@"user_id"];
    [bDict setObject:self.user.userMobile forKey:@"user_msisdn"];
    [bDict setObject:[NSNumber numberWithInt:self.user.userEnterprise] forKey:@"enterprise"];
    
    [NetworkHandling sendPackageWithUrl:@"visitplan/visitplanremind" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        if(!error){
            NSLog(@"sign in success");
            remindTableArray =[result objectForKey:@"remind"];
            
            [self performSelectorOnMainThread:@selector(refreshRemindButton) withObject:nil waitUntilDone:YES];
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

-(void)loadHistoryRemindData{
    
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    [bDict setObject:[NSNumber numberWithInt:self.user.userLvl] forKey:@"user_lvl"];
    [bDict setObject:[NSNumber numberWithInt:self.user.userID] forKey:@"user_id"];
    [bDict setObject:self.user.userMobile forKey:@"user_msisdn"];
    [bDict setObject:[NSNumber numberWithInt:self.user.userEnterprise] forKey:@"enterprise"];
    
    [NetworkHandling sendPackageWithUrl:@"visitplan/hisvisitplanremind" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        if(!error){
            NSLog(@"sign in success");
            remindHistoryArray =[result objectForKey:@"remind"];
            
            [self performSelectorOnMainThread:@selector(goMessageCenter) withObject:nil waitUntilDone:YES];
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

-(void)updateRemindData{
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
//    [bDict setObject:[NSNumber numberWithInt:self.user.userLvl] forKey:@"user_lvl"];
    [bDict setObject:[NSNumber numberWithInt:self.user.userID] forKey:@"user_id"];
//    [bDict setObject:self.user.userMobile forKey:@"user_msisdn"];
    [bDict setObject:[NSNumber numberWithInt:self.user.userEnterprise] forKey:@"enterprise"];
    
    NSString *rowString=@"";
    for (NSDictionary *dict in remindTableArray) {
        rowString=[rowString stringByAppendingFormat:@"%d,",[[dict objectForKey:@"row_id"] intValue]];
    }
    rowString=[rowString substringToIndex:[rowString length]-1];
    [bDict setObject:rowString forKey:@"row_id"];
    
    [NetworkHandling sendPackageWithUrl:@"visitplan/updremind" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        if(!error){
            NSLog(@"sign in success");
            //            remindTableArray =[result objectForKey:@"remindUser"];
            BOOL flag=[[result objectForKey:@"flag"] boolValue];
            if(flag)
                [self performSelectorOnMainThread:@selector(remindLoadFinished) withObject:nil waitUntilDone:YES];
            else
                [self performSelectorOnMainThread:@selector(showMessage:) withObject:@"状态变更失败！" waitUntilDone:YES];
            
        }
        else{
            int errorCode=[[result valueForKey:@"errorcode"] intValue];
            NSString *errorInfo=[result valueForKey:@"errorinf"];
            if(!errorInfo)
                errorInfo=@"提交数据出错了！";
            NSLog(@"error:%d info:%@",errorCode,errorInfo);
            [self performSelectorOnMainThread:@selector(showMessage:) withObject:errorInfo waitUntilDone:YES];
        }
        //        hubFlag=NO;
    }];
}

-(void)showMessage:(NSString*)infomation{
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"信息提示" message:infomation delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
    [myAlertView show];
}
-(void)refreshRemindButton{
    int count = (int)[remindTableArray count];
    if(count>0){
        remindButton.hidden=NO;
        NSString *remindString=[NSString stringWithFormat:@"您有%d条新消息",count];
        [remindButton setTitle:remindString forState:UIControlStateNormal];
    }
    else{
        remindButton.hidden=YES;
    }
}
-(void)loadMessageCenterData{
    hubFlag=YES;
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"数据查询中，请稍后...";
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
    [self loadHistoryRemindData];

}
-(void)hudWasHidden:(MBProgressHUD *)hud{
    [hud removeFromSuperview];
    hud=nil;
}
-(void)remindLoadFinished{
    remindButton.hidden=YES;
    remindTableArray=nil;
    [self goMessageCenter];
}
- (IBAction)remingButtonOnclick:(id)sender {
    [self updateRemindData];
}


-(void)goBack{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)addVisitPlan{
    [self performSegueWithIdentifier:@"VisitPlanAddSegue" sender:self];
}
- (IBAction)addVisitPlan:(id)sender {
    [self performSegueWithIdentifier:@"VisitPlanAddSegue" sender:self];
}

-(void)goMessageCenter{
    [self performSegueWithIdentifier:@"VisitPlanMessageSegue" sender:self];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //VisitPlanMessageSegue
    if([segue.identifier isEqualToString:@"VisitPlanMessageSegue"]){
        VisitPlanMessageTableViewController *controller=segue.destinationViewController;
        controller.tableArray=remindHistoryArray;
    }
    if([segue.identifier isEqualToString:@"VisitPlanAddSegue"]){
        VisitPlanAddViewController *controller=segue.destinationViewController;
        controller.user=self.user;
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

// 设置section的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 30;
    }
    return 20;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *v = nil;
    v = [[UIView alloc] initWithFrame:CGRectMake(0, -10, 300, 20)];
//    if(section>0)
//        v.frame=CGRectMake(0, -10, 300, 20);
//    else
//        v.frame=CGRectMake(0, 20, 300, 20);
    [v setBackgroundColor:[UIColor clearColor]];
    
    UILabel *labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 0.0f, 200.0f, 20.0f)];
    [labelTitle setBackgroundColor:[UIColor clearColor]];
    labelTitle.textAlignment = NSTextAlignmentLeft;
    labelTitle.textColor=[UIColor darkGrayColor];
    labelTitle.font=[UIFont systemFontOfSize:14];
    
    if (section == 0) {
        labelTitle.text = @"今天 星期五";
    }
    else{
        labelTitle.text = @"2014年08月25日 星期四";
    }
    [v addSubview:labelTitle];
    return v;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VisitPlanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VisitPlanTableViewCell" forIndexPath:indexPath];
//    cell.itemName.text=[tableArray objectAtIndex:indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    if(indexPath.row == 0)
//        [self performSegueWithIdentifier:@"CustomersWarningWithGroupSegue" sender:self];
//    if(indexPath.row == 1)
//        [self performSegueWithIdentifier:@"CustomersWarningWithPersonalSegue" sender:self];
}
@end
