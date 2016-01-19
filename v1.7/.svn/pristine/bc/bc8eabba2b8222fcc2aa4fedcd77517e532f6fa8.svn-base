//
//  OtherRegressManagerContactTableViewController.m
//  CMCCMarketing
//
//  Created by talkweb on 15-1-13.
//  Copyright (c) 2015年 talkweb. All rights reserved.
//

#import "OtherRegressManagerContactTableViewController.h"
#import "OtherRegressCustomerTableViewCell.h"
#import "NetworkHandling.h"
#import "MBProgressHUD.h"

@interface OtherRegressManagerContactTableViewController ()<MBProgressHUDDelegate>{
    BOOL hubFlag;
    NSArray *tableArray;
}

@end

@implementation OtherRegressManagerContactTableViewController

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
    lbName.text=[self.diffUserDict objectForKey:@"diff_user_name"];
    lbPhone.text=[self.diffUserDict objectForKey:@"diff_svc_code"];
    
    NSString *isHighUser=[self.diffUserDict objectForKey:@"is_high_user"];
    lbIsHighUser.hidden=![isHighUser isEqualToString:@"是"];
    
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
    [bDict setObject:[NSNumber numberWithInt:self.user.userID] forKey:@"user_id"];
    [bDict setObject:[NSNumber numberWithInt:self.user.userEnterprise] forKey:@"enterprise"];
    [bDict setObject:[self.diffUserDict objectForKey:@"diff_svc_code"] forKey:@"diff_svc_code"];
//    [bDict setObject:2 forKey:@"user_id"];
//    [bDict setObject:2 forKey:@"enterprise"];
//    [bDict setObject:@"18674881683" forKey:@"diff_svc_code"];
    
    [NetworkHandling sendPackageWithUrl:@"diffuserback/leadlinkList" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        if(!error){
            NSLog(@"sign in success");
            tableArray =[result objectForKey:@"link"];
            
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
    OtherRegressCustomerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OtherRegressCustomerTableViewCell" forIndexPath:indexPath];
    
    NSDictionary *dict=[tableArray objectAtIndex:indexPath.row];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *linkDate=[dateFormatter dateFromString:[dict objectForKey:@"link_date"]];
    
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    [dateFormatter1 setDateFormat:@"yy-MM-dd"];
    
    cell.itemDate.text=[dateFormatter1 stringFromDate:linkDate];
    
    cell.itemContent.text=[dict objectForKey:@"link_remark"];
    BOOL linkType=[[dict objectForKey:@"link_type"] boolValue]; //0:短信/1;电话
    if(linkType)
        cell.itemTypeImage.image=[UIImage imageNamed:@"电话"];
    else
        cell.itemTypeImage.image=[UIImage imageNamed:@"短信"];
    
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
