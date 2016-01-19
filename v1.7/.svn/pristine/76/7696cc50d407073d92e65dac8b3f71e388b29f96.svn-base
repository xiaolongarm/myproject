//
//  MonthlyTasksTableViewController.m
//  CMCCMarketing
//
//  Created by talkweb on 14-10-31.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import "MonthlyTasksTableViewController.h"
#import "MonthlyTasksTableViewCell.h"
#import "MBProgressHUD.h"
#import "NetworkHandling.h"

@interface MonthlyTasksTableViewController ()<MBProgressHUDDelegate>{
    BOOL hubFlag;
    NSArray *tableArray;
    NSString *taskDate;
}

@end

@implementation MonthlyTasksTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
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
    
    hubFlag=YES;
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"数据查询中，请稍后...";
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
    [self loadTasksData];
    
}
-(void)connectToNetwork{
    while (hubFlag) {
        usleep(100000);
    }
}

-(void)loadTasksData{
    
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    [bDict setObject:[NSNumber numberWithInt:self.user.userID] forKey:@"userID"];
    [bDict setObject:[NSNumber numberWithInt:self.user.userEnterprise] forKey:@"enterprise"];
    
    [NetworkHandling sendPackageWithUrl:@"monthlyplay/CheckMonthlyPlay" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        if(!error){
            NSLog(@"sign in success");
            tableArray =[result objectForKey:@"Response"];
            taskDate=[result objectForKey:@"taskDate"];
            [self performSelectorOnMainThread:@selector(refreshTasks) withObject:nil waitUntilDone:YES];
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

-(void)showMessage:(NSString*)infomation{
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"信息提示" message:infomation delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
    [myAlertView show];
}
-(void)refreshTasks{
    self.title=[NSString stringWithFormat:@"月度任务 (%@)",taskDate];
    [self.tableView reloadData];
}
-(void)hudWasHidden:(MBProgressHUD *)hud{
    [hud removeFromSuperview];
    hud=nil;
}
-(void)goBack{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return 300;
}
//{
//    Response =     (
//                    {
//                        completeCNT = 0;
//                        rank = "-";
//                        taskCNT = 15;
//                        typeID = 3;
//                        typeName = "\U96c6\U56e2\U5ba2\U6237\U65b0\U589e\U6d41\U91cf\U5305";
//                        unit = "\U6237";
//                    },
//                    {
//                        completeCNT = 0;
//                        rank = "-";
//                        taskCNT = 0;
//                        typeID = 4;
//                        typeName = "\U96c6\U56e2TD\U667a\U80fd\U7ec8\U7aef\U9500\U552e";
//                        unit = "\U53f0";
//                    }
//                    );
//    head =     {
//        randNum = 823168;
//        tkon = 06b6d32a2516b5b80fe80e07e99cb2d3;
//        ts = 2014103124172421;
//        ver = "1.0";
//    };
//    taskDate = "2014-10";
//}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MonthlyTasksTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MonthlyTasksTableViewCell" forIndexPath:indexPath];

    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    NSDictionary *dict =[tableArray objectAtIndex:indexPath.row];
    
    cell.itemTitle.text=[dict objectForKey:@"typeName"];
    cell.itemRanking.text=[dict objectForKey:@"rank"];
    
    int completecnt=[[dict objectForKey:@"completeCNT"] intValue];
    int tastcnt=[[dict objectForKey:@"taskCNT"] intValue];
    float percentage=tastcnt?(float)completecnt/tastcnt:0;
    
    cell.itemTaskNumber.text=[NSString stringWithFormat:@"%d",tastcnt];
    cell.itemCompleteNumber.text=[NSString stringWithFormat:@"%d",completecnt];
    cell.itemPercentageProgress.text=[NSString stringWithFormat:@"%d%%", (int)(percentage*100)];
    
//    for (NSDictionary *dict in tableArray) {
//        int typeID=[[dict objectForKey:@"typeID"] intValue];
//        int tastcnt=[[dict objectForKey:@"taskCNT"] intValue];
//        int completecnt=[[dict objectForKey:@"completeCNT"] intValue];
//        float percentage=tastcnt?(float)completecnt/tastcnt:0;
//        
//        int rank=[[dict objectForKey:@"rank"] intValue];
//        
//        if(typeID== 3){
//            cell.itemFlowTaskNumber.text=[NSString stringWithFormat:@"%d",tastcnt];
//            cell.itemFlowRank.text=[NSString stringWithFormat:@"%d",rank];
//            cell.itemFlowCompleteNumber.text=[NSString stringWithFormat:@"%d",completecnt];
//            cell.itemFlowPercentageProgress.text=[NSString stringWithFormat:@"%d%%", (int)(percentage*100)] ;
//        }
//        if(typeID== 4){
//            cell.itemDeviceTaskNumber.text=[NSString stringWithFormat:@"%d",tastcnt];
//            cell.itemDeviceRank.text=[NSString stringWithFormat:@"%d",rank];
//            cell.itemDeviceCompleteNumber.text=[NSString stringWithFormat:@"%d",completecnt];
//            cell.itemDevicePercentageProgress.text=[NSString stringWithFormat:@"%d%%", (int)(percentage*100)] ;
//        }
//    }
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
