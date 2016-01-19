//
//  SMSMarketingMainViewController.m
//  CMCCMarketing
//
//  Created by gmj on 15/6/16.
//  Copyright (c) 2015年 talkweb. All rights reserved.
//

#import "SMSMarketingMainViewController.h"
#import "MBProgressHUD.h"
#import "NetworkHandling.h"
#import "TaskNameViewController.h"

NSIndexPath *sendIndexPath;
@interface SMSMarketingMainViewController ()<MBProgressHUDDelegate>
{
       BOOL hudFlag;
    NSArray *tableviewArray;
}
@property (nonatomic, retain) NSArray *dataList;

@end

@implementation SMSMarketingMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //初始化导航栏
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
    [self InitControl];
    [self InitLoadData];
    
}

-(void)goBack{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 初始化页面控件
-(void)InitControl{
    
    _smsTableview.dataSource=self;
    _smsTableview.delegate=self;
  }

#pragma mark - 初始化数据
-(void)InitLoadData{
    hudFlag=YES;
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"数据查询中，请稍后...";
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
    
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    //客户经理归宿县市id
    [bDict setObject:self.user.userCntyID forKey:@"cnty_id"];
    //   user_id 客户经理id
    [bDict setObject:[NSNumber numberWithInt:self.user.userID] forKey:@"user_id"];
    //客户经理手机号码
    [bDict setObject:self.user.userMobile forKey:@"vip_mngr_msisdn"];
    
    [NetworkHandling sendPackageWithUrl:@"smsmarketing/taskpublishinfolist" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        if(!error){
            NSLog(@"sign in success");
            tableviewArray =[result objectForKey:@"smstask"];
            //刷新表格，装入数据
            [self performSelectorOnMainThread:@selector(goOnReloadData:) withObject:nil waitUntilDone:YES];
            
            
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

-(void)goOnReloadData:(id)sender{
    [self.smsTableview reloadData];
}

#pragma mark -网络API相关

-(void)connectToNetwork{
    while (hudFlag) {
        usleep(100000);
    }
}
-(void)showMessage:(NSString*)infomation{
    
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"信息提示" message:infomation delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
    [myAlertView show];
}

//
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [tableviewArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
static NSString *CellWithIdentifier = @"Cell";
UITableViewCell *cell = [self.smsTableview  dequeueReusableCellWithIdentifier:CellWithIdentifier];
if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellWithIdentifier];
}
NSUInteger row = [indexPath row];
    cell.textLabel.textAlignment=NSTextAlignmentLeft;
    cell.textLabel.textColor=[UIColor darkGrayColor];
    cell.textLabel.text = [[tableviewArray objectAtIndex:row] objectForKey:@"task_name"];

//cell.imageView.image = [UIImage imageNamed:@"green.png"];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
return cell;
  
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //NSInteger se = indexPath.section;
   // NSInteger row = indexPath.row;
    sendIndexPath=indexPath;
            [self performSegueWithIdentifier:@"taskNameSegue" sender:self];

    
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//     Get the new view controller using [segue destinationViewController].
//     Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"taskNameSegue"]) {
        
        TaskNameViewController *taskNameView= segue.destinationViewController;
        taskNameView.passDict=[tableviewArray objectAtIndex:sendIndexPath.row];
        taskNameView.user=self.user;
    }
}


@end
