//
//  ContrantListTableViewController.m
//  CMCCMarketing
//
//  Created by kevin on 15/9/16.
//  Copyright (c) 2015年 talkweb. All rights reserved.
//

#import "ContrantListTableViewController.h"
#import "CustomerManagerViewController.h"
#import "MBProgressHUD.h"
#import "NetworkHandling.h"
#import "DeatailContrantTableViewController.h"
@interface ContrantListTableViewController ()<MBProgressHUDDelegate>{
      BOOL hubFlag;
    NSArray *tableArray;
    NSDictionary *selectDict;
}

@end

@implementation ContrantListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    
    self.title = @"集团合约";
    [self GetAllContrantList];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark -navigationController

-(void)goBack{
   // [self dismissViewControllerAnimated:YES completion:nil];
    for (UIViewController *temp in self.navigationController.viewControllers) {
        if ([temp isKindOfClass:[CustomerManagerViewController class]]) {
            [self.navigationController popToViewController:temp animated:YES];
        }
    }
//    CustomerManagerViewController *temp=[[CustomerManagerViewController alloc]init];
//[self.navigationController popToViewController:temp animated:YES];
    
}
#pragma mark -获取合约列表
-(void)GetAllContrantList{
    /**
     合同管理查询接口地址
     changsha\v1_7\contract\getcontractinfo
     必传参数
     grp_code 集团编码
     返回参数
     `cnty_id`    '区县编码',
     `cnty_name`    '区县名称',
     `grp_code`    '集团编码',
     `grp_name`    '集团名称',
     `contract_code`    '合同编码',
     `contract_name`    '合同名称',
     `contract_type`    '合同类型',
     `start_date`  '合同开始时间',
     `end_date`  '合同结束时间',
     `linkman`    '项目实施人',
     `contract_fee`    '合同金额',
     `pay_time`  '合同缴费时间',
     `cycle_time`    '合同缴费周期',
     `use_flag`    '合同启用标志(是/否)',
     `grp_prod_code`    '产品编码',
     `grp_prod_name`    '产品名称',
     `grp_prod_fee`    '合同上月实际消费金额',
     `contract_word`    '合同附件',
     */
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"正在提交数据，请稍后...";
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
    
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    [bDict setObject:[_rDcit objectForKey:@"grp_code"] forKey:@"grp_code"];
    //    [bDict setObject:[NSNumber numberWithInt:self.user.userEnterprise] forKey:@"enterprise"];
    //    [bDict setValue:[NSNumber numberWithInt:self.user.userID] forKey:@"userID"];
    //
    [NetworkHandling sendPackageWithUrl:@"contract/getcontractinfo" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        if(!error){
            NSLog(@"sign in success");
            tableArray =[result objectForKey:@"contract"];
            //使用fullArray作为备份数据用搜索后的恢复显示数据
            //fullArray=tableArray;
            [self performSelectorOnMainThread:@selector(refreshTableview) withObject:nil waitUntilDone:YES];
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
#pragma mark -网络API相关

-(void)connectToNetwork{
    while (hubFlag) {
        usleep(100000);
    }
}
-(void)showMessage:(NSString*)infomation{
    
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"信息提示" message:infomation delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
    [myAlertView show];
}

-(void)refreshTableview
{
    
    [self.tableView reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [tableArray count];
  }


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ContrantListTableViewCell" forIndexPath:indexPath];
    
    cell.textLabel.text=[[tableArray objectAtIndex:indexPath.row]objectForKey:@"contract_name"];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    selectDict=[tableArray objectAtIndex:indexPath.row];
    [self  performSegueWithIdentifier:@"detailcontrantsegue" sender:self];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"detailcontrantsegue"]){
        DeatailContrantTableViewController *controller=segue.destinationViewController;
               //controller.user=self.user;
        controller.rDict=selectDict;
    }
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
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
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
