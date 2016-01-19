//
//  CustomersWarningViewController.m
//  CMCCMarketing
//
//  Created by talkweb on 14-9-23.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//
#import "CustomersWarningTableViewCell.h"
#import "CustomersWarningViewController.h"
#import "CustomersWarningWithGroupViewController.h"
#import "CustomersWarningWithPersonalViewController.h"

#import "MBProgressHUD.h"
#import "NetworkHandling.h"

#import "CustomersWarningMessageTableViewController.h"
#import "CustomersWarningWithGroupViewController.h"
#import "CustomersWarningWithPersonalViewController.h"

@interface CustomersWarningViewController ()<MBProgressHUDDelegate>{
    NSArray *tableArray;
    BOOL hubFlag;
    
    NSArray *remindTableArray;
}

@end

@implementation CustomersWarningViewController

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
    
    mainTableView.dataSource=self;
    mainTableView.delegate=self;
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
    
    tableArray=[[NSArray alloc] initWithObjects:@"集团单位预警",@"重要成员预警", nil];
    
    UIBarButtonItem *rightButton=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"喇叭"] style:UIBarButtonItemStylePlain target:self action:@selector(goMessageCenter)];
    [rightButton setTintColor:[UIColor whiteColor]];
    
    [self.navigationItem setRightBarButtonItem:rightButton];
    
    remindButton.hidden=YES;
    
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
    [bDict setObject:self.user.userMobile forKey:@"mobile"];
    [bDict setObject:[NSNumber numberWithInt:self.user.userEnterprise] forKey:@"enterprise"];

    [NetworkHandling sendPackageWithUrl:@"gprwarn/remindList" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
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
//enterprise
//user_id
//
//row_id
-(void)updateRemindData{
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    [bDict setObject:[NSNumber numberWithInt:self.user.userID] forKey:@"user_id"];
    [bDict setObject:[NSNumber numberWithInt:self.user.userEnterprise] forKey:@"enterprise"];
    
    NSString *rowString=@"";
    for (NSDictionary *dict in remindTableArray) {
        rowString=[rowString stringByAppendingFormat:@"%d,",[[dict objectForKey:@"row_id"] intValue]];
    }
    rowString=[rowString substringToIndex:[rowString length]-1];
    [bDict setObject:rowString forKey:@"row_id"];
    
    [NetworkHandling sendPackageWithUrl:@"gprwarn/updremindsta" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
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
-(void)goMessageCenter{
    [self performSegueWithIdentifier:@"CustomersWarningMessageSegue" sender:self];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"CustomersWarningMessageSegue"]){
        CustomersWarningMessageTableViewController *messageViewController=segue.destinationViewController;
        messageViewController.user=self.user;
    }
    if([segue.identifier isEqualToString:@"CustomersWarningWithGroupSegue"]){
        CustomersWarningWithGroupViewController *groupController=segue.destinationViewController;
        groupController.user=self.user;
    }
    if ([segue.identifier isEqualToString:@"CustomersWarningWithPersonalSegue"]) {
        CustomersWarningWithPersonalViewController *persionalController=segue.destinationViewController;
        persionalController.user=self.user;
    }
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


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomersWarningTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CustomersWarningTableViewCell" forIndexPath:indexPath];
    cell.itemName.text=[tableArray objectAtIndex:indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row == 0)
        [self performSegueWithIdentifier:@"CustomersWarningWithGroupSegue" sender:self];
    if(indexPath.row == 1)
        [self performSegueWithIdentifier:@"CustomersWarningWithPersonalSegue" sender:self];
}
@end
