//
//  OnlineTestRecordViewController.m
//  CMCCMarketing
//
//  Created by Talkweb on 15/4/22.
//  Copyright (c) 2015年 talkweb. All rights reserved.
//

#import "OnlineTestRecordViewController.h"

#import "NetworkHandling.h"
#import "MBProgressHUD.h"


@interface OnlineTestRecordViewController ()<MBProgressHUDDelegate>
{
    BOOL hubFlag;
    BOOL reloadFlag;
    MBProgressHUD *HudWait;
}

@end

@implementation OnlineTestRecordViewController

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
    HudWait =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HudWait];
    HudWait.delegate=self;
    HudWait.labelText=nil;
    [self initSubPage];
    [self initCustomTableView];
    // Do any additional setup after loading the view from its nib.
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self refreshRecordableView];
    

}


-(void)refreshRecordableView{
    
    [self.onlineTestTableView reloadData];
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

- (void) initSubPage{
    
    if(IOS7)
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"320X64"] forBarMetrics:UIBarMetricsDefault];
    else
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"320X44"] forBarMetrics:UIBarMetricsDefault];
    
    self.navigationItem.title = @"考试记录";
//    UIBarButtonItem *leftButton=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回1"] style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
//    [leftButton setTintColor:[UIColor whiteColor]];
//    [self.navigationItem setLeftBarButtonItem:leftButton];
    
    UIColor * color = [UIColor whiteColor];
    NSDictionary * dict=[NSDictionary dictionaryWithObject:color forKey:UITextAttributeTextColor];
    [self.navigationController.navigationBar setTitleTextAttributes:dict];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    
}

-(void)initCustomTableView{
    
    self.onlineTestTableView.dataSource=self; //TODO SIZE
    
    self.onlineTestTableView.delegate=self;
}

-(void)goBack{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 30;
//    
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [self.recordList count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"OnlineTestRecordViewControllerCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:CellIdentifier owner:self options:nil] objectAtIndex:0];
    }
    NSUInteger r = [indexPath row];
    NSDictionary *dicObj = [self.recordList objectAtIndex:r];
    
    NSString *record_des = [dicObj objectForKey:@"exam_batch_desc"];
    NSString *record_score = [dicObj objectForKey:@"exam_result"];
    NSString *record_time = [dicObj objectForKey:@"ret_time"];
    
    NSString *record_tempname = [NSString stringWithFormat:@"%@  (%@分)",record_des,record_score];
    UILabel *lbrecord_name = (UILabel*)[cell viewWithTag:100];
    [lbrecord_name setFont:[UIFont fontWithName:@"Helvetica-Bold" size:14]];
    lbrecord_name.text = record_tempname;
    UILabel *lbrecord_time = (UILabel*)[cell viewWithTag:200];
    lbrecord_time.text = record_time;
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:NO];
}

@end
