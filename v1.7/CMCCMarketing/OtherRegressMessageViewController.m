//
//  OtherRegressMessageViewController.m
//  CMCCMarketing
//
//  Created by talkweb on 14-9-19.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//
#import "OtherRegressMessageTableViewCell.h"
#import "OtherRegressMessageViewController.h"
#import "MBProgressHUD.h"
#import "NetworkHandling.h"

#import "OtherRegressCustomerViewController.h"

@interface OtherRegressMessageViewController ()<MBProgressHUDDelegate>{
    BOOL hubFlag;
    NSArray *tableArray;
    
    NSDictionary *selectDict;
}

@end

@implementation OtherRegressMessageViewController

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
    messageTableView.dataSource=self;
    messageTableView.delegate=self;
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
    [bDict setObject:self.user.userMobile forKey:@"grp_svc_code"];
    [bDict setObject:[NSNumber numberWithInt:self.user.userEnterprise] forKey:@"enterprise"];
    
    [NetworkHandling sendPackageWithUrl:@"diffuserback/hisremindList" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        if(!error){
            NSLog(@"sign in success");
            tableArray =[result objectForKey:@"remindUser"];
            
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
    [messageTableView reloadData];
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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"OtherRegressCustomerFromMessageSegue"]){
        OtherRegressCustomerViewController *controller=segue.destinationViewController;
        controller.diffUserDict=selectDict;
        controller.user=self.user;
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
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
//                  {
//                      "diff_svc_code" = 13307319379;
//                      "diff_type" = "\U7535\U4fe1";
//                      "diff_user_name" = "\U9ec4\U6587";
//                      "is_back" = "\U662f";
//                      "link_date" = "2014-10-28T08:05:48+0000";
//                      "link_remark" = "\U4e0b\U4e00\U6b21\U518d\U8054\U7cfb";
//                      "link_type" = 0;
//                      "week_day" = "\U661f\U671f\U4e00";
//                  }

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OtherRegressMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OtherRegressMessageTableViewCell" forIndexPath:indexPath];
    NSDictionary *dict=[tableArray objectAtIndex:indexPath.row];
    cell.itemName.text=[dict objectForKey:@"diff_user_name"];
    cell.itemPhone.text=[dict objectForKey:@"diff_svc_code"];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *linkDate=[dateFormatter dateFromString:[dict objectForKey:@"link_date"]];
    
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    [dateFormatter1 setDateFormat:@"yy-MM-dd"];

    cell.itemContactDate.text=[dateFormatter1 stringFromDate:linkDate];
    cell.itemMainImageView.image=[UIImage imageNamed:[dict objectForKey:@"diff_type"]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     selectDict = [tableArray objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"OtherRegressCustomerFromMessageSegue" sender:self];
}

@end
