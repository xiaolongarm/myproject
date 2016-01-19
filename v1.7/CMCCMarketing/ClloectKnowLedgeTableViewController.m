//
//  ClloectKnowLedgeTableViewController.m
//  CMCCMarketing
//
//  Created by kevin on 15/9/28.
//  Copyright © 2015年 talkweb. All rights reserved.
//

#import "ClloectKnowLedgeTableViewController.h"
#import "KnowledgeBaseSecondaryDetailsViewController.h"
#import "KnowledgeBaseWithBusinessDetailsViewController.h"
#import "MBProgressHUD.h"
#import "NetworkHandling.h"
@interface ClloectKnowLedgeTableViewController ()<MBProgressHUDDelegate>
{
    BOOL hudFlag;
    NSMutableArray *tableviewArray;
     NSDictionary *selectDict;
}


@end

@implementation ClloectKnowLedgeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    //[self InitControl];
    [self InitLoadData];
}
//#pragma mark - 初始化页面控件
//-(void)InitControl{
//    
//    _smsTableview.dataSource=self;
//    _smsTableview.delegate=self;
//}

#pragma mark - 初始化数据
-(void)InitLoadData{
    /**
     *  查看收藏夹记录
     changsha\v1_8\collect\selcollectList
     必传参数
     user_id 用户id
     返回参数
     row_id 行号
     user_id 用户id
     menu_name 菜单名称
     menu_para  参数
     type 类型 1:业务知识，2:最新优惠活动
     */
    hudFlag=YES;
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"数据查询中，请稍后...";
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
    
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
//    //客户经理归宿县市id
//    [bDict setObject:self.user.userCntyID forKey:@"cnty_id"];
    //   user_id 客户经理id
    [bDict setObject:[NSNumber numberWithInt:self.user.userID] forKey:@"user_id"];
//    //客户经理手机号码
//    [bDict setObject:self.user.userMobile forKey:@"vip_mngr_msisdn"];
    
    [NetworkHandling sendPackageWithUrl:@"collect/selcollectList" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        if(!error){
            NSLog(@"sign in success");
            tableviewArray =[result objectForKey:@"result"];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ClloectKnowLedgeTableViewCell" forIndexPath:indexPath];
    cell.textLabel.text=[[tableviewArray objectAtIndex:indexPath.row]objectForKey:@"menu_name"];
    // Configure the cell...
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    selectDict = [tableviewArray objectAtIndex:indexPath.row];
    if ([[selectDict objectForKey:@"type"]intValue] ==2) {
        UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"KnowledgeBase" bundle:nil];
        KnowledgeBaseSecondaryDetailsViewController *controller=[storyboard instantiateViewControllerWithIdentifier:@"KnowledgeBaseSecondaryDetailsID"];
        controller.user=self.user;
        controller.apiDict=selectDict;
        controller.fromFlag=@"fromsetting";
        [self.navigationController pushViewController:controller animated:YES];
    }
    if ([[selectDict objectForKey:@"type"]intValue]==1) {
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"KnowledgeBase" bundle:nil];
    KnowledgeBaseWithBusinessDetailsViewController *controller=[storyboard instantiateViewControllerWithIdentifier:@"KnowledgeBaseWithBusinessDetailsViewControllerID"];
    
    controller.user=self.user;
    controller.apiDict=selectDict;
    controller.fromFlag=@"fromsetting";
    [self.navigationController pushViewController:controller animated:YES];
    }

//    [self performSegueWithIdentifier:@"" sender:self];
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
     return UITableViewCellEditingStyleDelete;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
     NSDictionary *dict=[tableviewArray objectAtIndex:indexPath.row];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self DelCollectKnowledge:dict];
        // Delete the row from the data source
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
  //      else if (editingStyle == UITableViewCellEditingStyleInsert) {
//        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//    }   
}
-(void)DelCollectKnowledge:(NSDictionary*)reDict{
    /**
     、删除收藏夹记录
     changsha\v1_8\collect\delcollect
     必传参数
     row_id 收藏记录id
     返回参数
     flag  true/false
     */
    hudFlag=YES;
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"数据提交中，请稍后...";
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
    
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    //    //客户经理归宿县市id
    //    [bDict setObject:self.user.userCntyID forKey:@"cnty_id"];
    //   task_id
    [bDict setObject:[reDict objectForKey:@"row_id"] forKey:@"row_id"];
    
    [NetworkHandling sendPackageWithUrl:@"collect/delcollect" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        if(!error){
            NSLog(@"sign in success");
            //tableviewArray =[result objectForKey:@"smsuser"];
            
            //刷新表格，插入一条判别选中cell的数据
            //            for (id object in tableviewArray) {
            //
            //                [object setValue:@"NO" forKey:@"checked"];
            //            }
            
            [self performSelectorOnMainThread:@selector(submitSuccess:) withObject:reDict waitUntilDone:YES];
            
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
-(void)submitSuccess:(NSDictionary*)dict{
    [tableviewArray removeObject:dict];
    [self.tableView reloadData];
}
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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    KnowledgeBaseSecondaryDetailsViewController *viewController=segue.destinationViewController;
    viewController.title=self.title;
    viewController.detailsDict=selectDict;
    viewController.user=self.user;

}


@end
