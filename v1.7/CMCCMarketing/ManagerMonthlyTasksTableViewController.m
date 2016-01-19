//
//  ManagerMonthlyTasksTableViewController.m
//  CMCCMarketing
//
//  Created by talkweb on 14-12-18.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import "ManagerMonthlyTasksTableViewController.h"
#import "ManagerMonthlyTasksTableViewCell.h"
#import "NetworkHandling.h"
#import "MBProgressHUD.h"
#import "ManagerMonthlyTasksRankViewController.h"

@interface ManagerMonthlyTasksTableViewController ()<MBProgressHUDDelegate>{
    NSArray *tableArray;
//    NSString *selectTitle;
    NSDictionary *selectDict;
    BOOL hubFlag;
}

@end

@implementation ManagerMonthlyTasksTableViewController

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
//    tableArray=[[NSArray alloc] initWithObjects:@"集团客户新增流量包",@"集团TD职能终端销售", nil];
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
    
    [NetworkHandling sendPackageWithUrl:@"monthlyplay/getDimBussTask" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        if(!error){
            NSLog(@"sign in success");
            tableArray =[result objectForKey:@"task"];
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
    [self.tableView reloadData];
}
-(void)showMessage:(NSString*)infomation{
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"信息提示" message:infomation delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
    [myAlertView show];
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ManagerMonthlyTasksTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ManagerMonthlyTasksTableViewCell" forIndexPath:indexPath];
    
    NSDictionary *dict=[tableArray objectAtIndex:indexPath.row];
    cell.itemTitle.text=[dict objectForKey:@"type_name"];
    //type_id
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    selectDict=[tableArray objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"ManagerMonthlyTasksRankSegue" sender:self];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"ManagerMonthlyTasksRankSegue"]){
        ManagerMonthlyTasksRankViewController *controller=segue.destinationViewController;
        controller.title=[selectDict objectForKey:@"type_name"];
        controller.typeName=[selectDict objectForKey:@"type_name"];
        controller.typeId=[[selectDict objectForKey:@"type_id"] intValue];
        controller.user=self.user;
    }
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

@end
