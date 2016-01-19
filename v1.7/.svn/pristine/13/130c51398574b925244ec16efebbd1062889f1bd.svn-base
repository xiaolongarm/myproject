//
//  WorkRecordListViewController.m
//  CMCCMarketing
//
//  Created by talkweb on 15-1-30.
//  Copyright (c) 2015年 talkweb. All rights reserved.
//

#import "WorkRecordListViewController.h"
#import "NetworkHandling.h"
#import "MBProgressHUD.h"
#import "BusinessHandling.h"
#import "WorkRecordDetailViewController.h"

@interface WorkRecordListViewController ()<MBProgressHUDDelegate>{
    BOOL hubFlag;
    NSArray *tableArray;
    NSArray *allWeekDay;
    NSDate *now;
}

@end

@implementation WorkRecordListViewController

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
    lbWeekRange.layer.borderColor=[UIColor lightGrayColor].CGColor;
    lbWeekRange.layer.borderWidth=1;
    vwTopBackground.layer.borderColor=[UIColor lightGrayColor].CGColor;
    vwTopBackground.layer.borderWidth=1;
    
    now=[NSDate date];
    [self loadWorkRecordData:now];
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
    
    if([segue.identifier isEqualToString:@"toWorkRecordDetailFromListSegue"]){
        
        UIButton *button=sender;
        NSDictionary *dict=[tableArray objectAtIndex:button.tag-1];
        int daily_id=[[dict objectForKey:@"daily_id"] intValue];
         int weekday=[[dict objectForKey:@"week_day"] intValue]-1;
        NSDictionary *selectDict;
        for (NSDictionary *item in self.tbList) {
            int did=[[item objectForKey:@"daily_id"] intValue];
            if(did == daily_id){
                selectDict=item;
                break;
            }
        }
        
        WorkRecordDetailViewController *vc = segue.destinationViewController;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];

        vc.recipeDateString=[dateFormatter stringFromDate:[allWeekDay objectAtIndex:weekday]];
        vc.recipeListDict = dict;
          vc.whereFrom=22;
    }
}

-(void)goDetail:(id)sender{
    [self performSegueWithIdentifier:@"toWorkRecordDetailFromListSegue" sender:sender];
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
-(void)hudWasHidden:(MBProgressHUD *)hud{
    [hud removeFromSuperview];
    hud=nil;
}
-(void)refreshTableView{
        UIView *bodyView=[self.view viewWithTag:100];
    for (int i=1; i<8; i++) {
          UIButton *button = (UIButton*)[bodyView viewWithTag:i];
        [button setTitle:@"0" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [button removeTarget:self action:@selector(goDetail:) forControlEvents:UIControlEventTouchUpInside];

    }
    

//    [self.tbView reloadData];
    for (NSDictionary *dict in tableArray) {
        if(dict && (NSNull*)dict != [NSNull null]){
            int week_day=[[dict objectForKey:@"week_day"] intValue];
            UIButton *button = (UIButton*)[bodyView viewWithTag:week_day];
            [button setTitle:@"1" forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(goDetail:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
}

-(void)loadWorkRecordData:(NSDate*)date{
    
    /*
     一周日报列表接口
     shaoyang\v1_4\daily\dailylist
     必传参数
     user_lvl 用户级别
     user_id 用户id
     start_date 开始日期
     end_date 结束日期
     */
    
    hubFlag=YES;
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"数据查询中，请稍后...";
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
    
    
    NSMutableDictionary *bDict = [[NSMutableDictionary alloc] init];
    [bDict setObject:[NSString stringWithFormat:@"%d",self.user.userID] forKey:@"user_id"];
    [bDict setObject:[NSString stringWithFormat:@"%d",self.user.userLvl] forKey:@"user_lvl"];
    NSArray *dateArray=[BusinessHandling calculateWeekOfBeginDateAndEndDate:date];
    allWeekDay=[BusinessHandling calculateWeekOfAllDate:date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    [dateFormatter1 setDateFormat:@"MM-dd"];
    
    NSString *mondayString=[dateFormatter stringFromDate:[dateArray objectAtIndex:0]];
    NSString *sundayString=[dateFormatter stringFromDate:[dateArray objectAtIndex:1]];
    
    NSString *mondayShortString=[dateFormatter1 stringFromDate:[dateArray objectAtIndex:0]];
    NSString *sundayShortString=[dateFormatter1 stringFromDate:[dateArray objectAtIndex:1]];
    
    lbWeekRange.text=[NSString stringWithFormat:@"%@ - %@",mondayShortString,sundayShortString];
    
    [bDict setObject:mondayString forKey:@"start_date"];
    [bDict setObject:sundayString forKey:@"end_date"];
    
    
//    [NetworkHandling sendPackageWithUrl:@"HamstrerServlet/shaoyang/v1_4/daily/dailylist" sendBody:bDict sendWithPostType:0 processHandler:^(NSDictionary *result, NSError *error) {
    [NetworkHandling sendPackageWithUrl:@"daily/dailylist" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        hubFlag=NO;
        if(!error){
            tableArray=nil;
            NSArray *tmp=[result objectForKey:@"dailys"];
            if(tmp && [tmp count]>0){
                tableArray=[[tmp objectAtIndex:0] objectForKey:@"dailys"];
            }
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
- (IBAction)forwordWeekOnclick:(id)sender {
    
    NSTimeInterval weekInterval = 7 * 24 * 60 * 60;
    now = [now dateByAddingTimeInterval: -weekInterval];
    [self loadWorkRecordData:now];
}
- (IBAction)backwordsWeekOnclick:(id)sender {
    
    NSTimeInterval weekInterval = 7 * 24 * 60 * 60;
    now = [now dateByAddingTimeInterval: weekInterval];
    [self loadWorkRecordData:now];
}

@end
