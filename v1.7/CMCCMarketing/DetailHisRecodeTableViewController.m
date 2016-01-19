//
//  DetailHisRecodeTableViewController.m
//  CMCCMarketing
//
//  Created by kevin on 15/9/22.
//  Copyright © 2015年 talkweb. All rights reserved.
//

#import "DetailHisRecodeTableViewController.h"
#import "MBProgressHUD.h"
#import "NetworkHandling.h"
#import "DetailHisRecodeTableViewCell.h"
@interface DetailHisRecodeTableViewController ()<MBProgressHUDDelegate>
{
    BOOL hudFlag;
    NSArray *tableviewArray;
}


@end

@implementation DetailHisRecodeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=[NSString stringWithFormat:@"%@年%@月录入详情",[_recipeMonth substringToIndex:4],[_recipeMonth substringFromIndex:4]];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self InitLoadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -加载数据
-(void)InitLoadData{
//    三、获取每月异网用户录入信息列表
    //changsha\v1_8\marketing\getdiffinfolist
//    必传参数
//    user_id 用户id
//    month 月份
//    返回参数
//    diff_svc_code 原异网号码
//    svc_code 新移动号码
//    date 录入时间
    hudFlag=YES;
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"数据查询中，请稍后...";
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
    
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    //   user_id 客户经理id
    [bDict setObject:[NSNumber numberWithInt:self.user.userID] forKey:@"user_id"];
    [bDict setObject:_recipeMonth forKey:@"month"];
    
    [NetworkHandling sendPackageWithUrl:@"marketing/getdiffinfolist" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        if(!error){
            NSLog(@"sign in success");
            tableviewArray =[result objectForKey:@"list"];
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
    [self.tableView reloadData];
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return [tableviewArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 69;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailHisRecodeTableViewCell *cell = (DetailHisRecodeTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"DetailHisRecodeTableViewCell" forIndexPath:indexPath];
    
    cell.time.text=[[tableviewArray objectAtIndex:indexPath.row]objectForKey:@"date"];
    cell.oldcode.text=[[tableviewArray objectAtIndex:indexPath.row]objectForKey:@"diff_svc_code"];
     cell.newcode.text=[[tableviewArray objectAtIndex:indexPath.row]objectForKey:@"svc_code"];
    
    return cell;
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
