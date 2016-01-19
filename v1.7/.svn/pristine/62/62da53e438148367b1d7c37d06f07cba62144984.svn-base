//
//  OtherRegressCustomerDetailsTableViewController.m
//  CMCCMarketing
//
//  Created by talkweb on 14-9-19.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import "OtherRegressCustomerDetailsTableViewController.h"
#import "OtherRegresCustomerDetailsTableViewCell.h"
#import "MBProgressHUD.h"
#import "NetworkHandling.h"
#import "OtherRegressManagerContactTableViewController.h"
#import "VariableStore.h"

@interface OtherRegressCustomerDetailsTableViewController ()<MBProgressHUDDelegate>{
    BOOL hubFlag;
    NSArray *tableArray;
    NSDictionary *customerDetials;
}
@end

@implementation OtherRegressCustomerDetailsTableViewController

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
    
    if(self.isManager){
        UIBarButtonItem *rightButton=[[UIBarButtonItem alloc]initWithTitle:@"联系记录" style:UIBarButtonItemStylePlain target:self action:@selector(goRecord)];
        [rightButton setTintColor:[UIColor whiteColor]];
        [self.navigationItem setRightBarButtonItem:rightButton];
    }
        
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    if(self.isNotRegress){
        self.title = @"未回归客户详情";
    }
    else{
        self.title = @"已回归客户详情";
    }
    
    hubFlag=YES;
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"数据查询中，请稍后...";
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
    [self loadDetailsData];
}
-(void)connectToNetwork{
    while (hubFlag) {
        usleep(100000);
    }
}
-(void)loadDetailsData{
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    [bDict setObject:self.user.userMobile forKey:@"grp_svc_code"];
    [bDict setObject:[NSNumber numberWithInt:self.user.userEnterprise] forKey:@"enterprise"];
    [bDict setObject:[self.diffUserDict objectForKey:@"diff_svc_code"] forKey:@"diff_svc_code"];
    
    [NetworkHandling sendPackageWithUrl:@"diffuserback/getUserInfo" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        if(!error){
            NSLog(@"sign in success");
            customerDetials =[result objectForKey:@"userInfo"];
//            NSLog(@"%@",customerDetials);
            [self performSelectorOnMainThread:@selector(refreshDetails) withObject:nil waitUntilDone:YES];
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
-(void)refreshDetails{
    UIImageView *imageView=[[UIImageView alloc] init];
    imageView.frame=CGRectMake([UIScreen mainScreen].bounds.size.width - 120 -20, 10, 120, 77);
    NSString *isBack=[customerDetials objectForKey:@"is_back"];
    if([isBack isEqualToString:@"是"])
        imageView.image=[UIImage imageNamed:@"regress-tag"];
    else
        imageView.image=[UIImage imageNamed:@"unregress-tag"];
    [self.tableView addSubview:imageView];
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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
        return 13;
    else
        return 6;
}
// 设置section的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 30;
    }
    return 20;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *v = nil;
    v = [[UIView alloc] initWithFrame:CGRectMake(0, -10, 300, 20)];
    [v setBackgroundColor:[UIColor clearColor]];
    
    UILabel *labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 0.0f, 200.0f, 20.0f)];
    [labelTitle setBackgroundColor:[UIColor clearColor]];
    labelTitle.textAlignment = NSTextAlignmentLeft;
    labelTitle.textColor=[UIColor darkGrayColor];
    labelTitle.font=[UIFont systemFontOfSize:14];
    
    if (section == 0) {
        labelTitle.text = @"基础信息";
        
    }
    else{
        labelTitle.text = @"通话情况";
    }
    [v addSubview:labelTitle];
    return v;
}
//{
//    ENTERPRISE = 2;
//    "area_name" = "A_\U957f\U6c99";
//    "cnty_name" = "A_\U57ce\U5317";
//    "contact_high_user_cnt" = 41;
//    "contact_user_cnt" = 98;
//    "diff_svc_code" = 13307319379;
//    "diff_type" = "\U7535\U4fe1";
//    "diff_user_name" = "\U9ec4\U6587";
//    "grp_code" = 7311000239;
//    "grp_name" = "\U9526\U6c5f\U9ea6\U5fb7\U9f99\U73b0\U8d2d\U81ea\U8fd0\U6709\U9650\U516c\U53f8\U957f\U6c99\U5f00\U798f\U5206\U90e8";
//    "grp_svc_code" = 15073111492;
//    "grp_user_name" = "\U5f90\U9759";
//    "gsm_cnt" = 653;
//    "gsm_time" = 1393;
//    "indb_date" = "2014-09-25T06:57:23+0000";
//    "indb_key" = 21411461948354;
//    "indb_user_id" = 2;
//    "indb_user_name" = "\U5f20\U5065\U83b9";
//    "init_gsm_cnt" = 390;
//    "init_gsm_time" = 838;
//    "is_back" = "\U662f";
//    "is_deal_c1d6" = "\U5426";
//    "is_high_user" = "\U662f";
//    "is_input" = "\U662f";
//    "is_join_v_net" = "\U662f";
//    "is_look" = 0;
//    "is_new_user" = "\U5426";
//    "is_school_user" = "\U5426";
//    "is_sensitive_user" = 0;
//    "locn_typ_name" = "\U5b98\U6865\U4e61";
//    "open_date" = "2008-07-01T16:00:00+0000";
//    "row_id" = 178;
//    "svc_code" = 13974942010;
//    "town_name" = "\U9547\U5934\U8425\U4e1a\U90e8";
//    "user_type" = "\U5e02\U533a";
//};
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OtherRegresCustomerDetailsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OtherRegresCustomerDetailsTableViewCell" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.selectionStyle=UITableViewCellSelectionStyleNone;

    if(indexPath.section == 0){
        switch (indexPath.row) {
            case 0:
                cell.itemTitle.text=@"手机号码";
                cell.itemContent.text=[customerDetials objectForKey:@"diff_svc_code"];
                break;
            case 1:
                cell.itemTitle.text=@"客户姓名";
                cell.itemContent.text=[customerDetials objectForKey:@"diff_user_name"];
                break;
            case 2:
                cell.itemTitle.text=@"客户属性";
                cell.itemContent.text=[customerDetials objectForKey:@"user_type"];
                break;
            case 3:
                cell.itemTitle.text=@"归属集团编码";
                cell.itemContent.text=[customerDetials objectForKey:@"grp_name"];
                break;
            case 4:
                cell.itemTitle.text=[NSString stringWithFormat:@"归属集团%@",[VariableStore getCustomerManagerName]];
                cell.itemContent.text=[customerDetials objectForKey:@"grp_user_name"];
                break;
            case 5:
                cell.itemTitle.text=@"归属地市";
                cell.itemContent.text=[customerDetials objectForKey:@"area_name"];
                break;
            case 6:
                cell.itemTitle.text=@"归属县市";
                cell.itemContent.text=[customerDetials objectForKey:@"cnty_name"];
                break;
            case 7:
                cell.itemTitle.text=@"归属营业部";
                cell.itemContent.text=[customerDetials objectForKey:@"town_name"];
                break;
            case 8:
                cell.itemTitle.text=@"归属乡镇";
                cell.itemContent.text=[customerDetials objectForKey:@"locn_typ_name"];
                break;
            case 9:
                cell.itemTitle.text=@"是否新开户";
                cell.itemContent.text=[customerDetials objectForKey:@"is_new_user"];
                break;
            case 10:
            {
                cell.itemTitle.text=@"入网时间";
                
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                NSDate *linkDate=[dateFormatter dateFromString:[customerDetials objectForKey:@"open_date"]];
                
                NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
                [dateFormatter1 setDateFormat:@"yyyy-MM-dd"];
                NSString *dateSring=[dateFormatter1 stringFromDate:linkDate];
                cell.itemContent.text=dateSring;
            }
//                cell.itemContent.text=[customerDetials objectForKey:@"open_date"];
                break;
            case 11:
                cell.itemTitle.text=@"是否加入V网";
                cell.itemContent.text=[customerDetials objectForKey:@"is_join_v_net"];
                break;
            case 12:
                cell.itemTitle.text=@"是否办理存一得六";
                cell.itemContent.text=[customerDetials objectForKey:@"is_deal_c1d6"];
                break;
                
            default:
                break;
        }
    }
    else{
        switch (indexPath.row) {
            case 0:
                cell.itemTitle.text=@"通话次数";
                cell.itemContent.text=[NSString stringWithFormat:@"%d次",[[customerDetials objectForKey:@"gsm_cnt"] intValue]];
                break;
            case 1:
                cell.itemTitle.text=@"主叫移动通话次数";
                cell.itemContent.text=[NSString stringWithFormat:@"%d次",[[customerDetials objectForKey:@"init_gsm_cnt"] intValue]];
                break;
            case 2:
                cell.itemTitle.text=@"通话时长";
                cell.itemContent.text=[NSString stringWithFormat:@"%d分钟",[[customerDetials objectForKey:@"gsm_time"] intValue]];
                break;
            case 3:
                cell.itemTitle.text=@"主叫移动通话时长";
                cell.itemContent.text=[NSString stringWithFormat:@"%d分钟",[[customerDetials objectForKey:@"init_gsm_time"] intValue]];
                break;
            case 4:
                cell.itemTitle.text=@"交往圈客户数";
                cell.itemContent.text=[NSString stringWithFormat:@"%d人",[[customerDetials objectForKey:@"contact_user_cnt"] intValue]];
                break;
            case 5:
                cell.itemTitle.text=@"交往圈中中高端客户数";
                cell.itemContent.text=[NSString stringWithFormat:@"%d人",[[customerDetials objectForKey:@"contact_high_user_cnt"] intValue]];
                break;
                
            default:
                break;
        }
    
    }
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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"OtherRegressManagerContactSegue"]){
        OtherRegressManagerContactTableViewController *controller=segue.destinationViewController;
        controller.user=self.user;
        controller.diffUserDict=self.diffUserDict;
        controller.customerManager=self.customerManager;
    }
}

-(void)goRecord{
    [self performSegueWithIdentifier:@"OtherRegressManagerContactSegue" sender:self];
}
@end
