//
//  DataAcquisitionClientServerSegueTableViewController.m
//  CMCCMarketing
//
//  Created by gmj on 14-12-18.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import "DataAcquisitionClientServerSegueTableViewController.h"
#import "DataAcquisitionClientServerSegueTableViewCell.h"

#import "NetworkHandling.h"
#import "MBProgressHUD.h"

@interface DataAcquisitionClientServerSegueTableViewController ()<MBProgressHUDDelegate>{
    
    BOOL hubFlag;
    
    UIView *backView;
    PreferentialPurchaseSelectDateTimeViewController *selectDateTimeViewController;
    UIButton *selectDateBtn;
}

@end

@implementation DataAcquisitionClientServerSegueTableViewController

#pragma mark - PreferentialPurchaseSelectDateTimeViewControll delegate

-(void)preferentialPurchaseSelectDateTimeViewControllerDidCancel{
    
    [backView removeFromSuperview];
    [selectDateTimeViewController.view removeFromSuperview];
    
    backView=nil;
    selectDateTimeViewController=nil;
}

-(void)preferentialPurchaseSelectDateTimeViewControllerDidFinished:(PreferentialPurchaseSelectDateTimeViewController *)controller{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString=[dateFormatter stringFromDate:controller.datetimePicker.date];
    if (selectDateBtn == self.btn_plan_time) {
        
        [self.btn_plan_time setTitle:dateString forState:UIControlStateNormal];
        
    } else {
        
        [self.btn_complaint_time setTitle:dateString forState:UIControlStateNormal];

        
    }
    
    [self preferentialPurchaseSelectDateTimeViewControllerDidCancel];
}

- (IBAction)selectDate:(id)sender{
    
    selectDateBtn = sender;
    
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"BusinessProcess" bundle:nil];
    selectDateTimeViewController=[storyboard instantiateViewControllerWithIdentifier:@"PreferentialPurchaseSelectDateTimeViewControllerId"];
    selectDateTimeViewController.delegate=self;
//    selectDateTimeViewController.modeDateAndTime=0;//设置模式为日期和时间显示
    CGRect rect=selectDateTimeViewController.view.frame;
    
    rect.origin.x=0;
    rect.origin.y=[[UIScreen mainScreen] bounds].size.height - 300;
    rect.size.width=320;
    rect.size.height=300;
    
    selectDateTimeViewController.view.frame=rect;
    selectDateTimeViewController.view.layer.borderWidth=1;
    selectDateTimeViewController.view.layer.borderColor=[UIColor colorWithRed:55/255.0 green:132/255.0 blue:173/255.0 alpha:1.0].CGColor;
    selectDateTimeViewController.view.layer.shadowOffset = CGSizeMake(2, 2);
    selectDateTimeViewController.view.layer.shadowOpacity = 0.80;
    
    backView=[[UIView alloc] init];
    backView.backgroundColor=[UIColor blackColor];
    backView.alpha=0.1;
    
    backView.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [self.view addSubview:backView];
    [self.view addSubview:selectDateTimeViewController.view];
    
}


#pragma mark - UITextField delegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}


-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    CGRect rect=self.view.frame;
    rect.origin.y-=200;
    self.view.frame=rect;
    return YES;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    
    CGRect rect=self.view.frame;
    rect.origin.y+=200;
    self.view.frame=rect;
    return YES;
}

//
//#pragma mark - UITextView delegate
//
//- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
//    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
//        //在这里做你响应return键的代码
//        //        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
//        [textView resignFirstResponder];
//        return NO;
//    }
//    
//    return YES;
//}
//
//-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
//    
//    CGRect rect=self.view.frame;
//    rect.origin.y-=200;
//    self.view.frame=rect;
//    return YES;
//    
//}
//
//-(BOOL)textViewShouldEndEditing:(UITextView *)textView{
//    
//    CGRect rect=self.view.frame;
//    rect.origin.y+=200;
//    self.view.frame=rect;
//    return YES;
//    
//}


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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self initSubView];
}

-(void)initSubView{
    
    UIBarButtonItem *rightButton=[[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(submitData)];
    [rightButton setTintColor:[UIColor whiteColor]];
    [self.navigationItem setRightBarButtonItem:rightButton];
    
    self.txt_is_score.delegate = self;

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 750;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"DataAcquisitionClientServerSegueTableViewCell";
    DataAcquisitionClientServerSegueTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
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
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
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

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

#pragma mark - visitPlanAddSelectGroupTableViewController delegate

-(void)visitPlanAddSelectGroupTableViewControllerDidFinished:(W_VisitPlanAddSelectGroupTableViewController *)controller{
    
    self.selectGroup = controller.selectGroup;
    
    [self.btnGroupName setTitle:self.selectGroup.groupName forState:UIControlStateNormal];
}

- (IBAction)btnGroupNameOnClick:(id)sender {//归属集团
    
    W_VisitPlanAddSelectGroupTableViewController *controller=[[W_VisitPlanAddSelectGroupTableViewController alloc] initWithNibName:@"W_VisitPlanAddSelectGroupTableViewController" bundle:nil];
    controller.delegate=self;
    controller.user = self.user;
    controller.tableArray=self.user.groupInfo;
    controller.selectGroup=self.selectGroup;
    
    [self.navigationController pushViewController:controller animated:YES];
    
}

- (IBAction)btn_plan_timeOnClick:(id)sender {//关键人最近拜访时间
    
    [self selectDate:sender];
}

- (IBAction)btn_add_val_sev_typeOnClick:(id)sender {//参与增值服务类型
    
    self.selectedButton = sender;
    
    UIActionSheet *actionSheet=[[UIActionSheet alloc] initWithTitle:@"增值服务类型" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"生日祝福" otherButtonTitles:@"礼品", nil];
    actionSheet.tag=1;
    [actionSheet showInView:self.view];
    self.selectedButton=sender;
    
}

- (IBAction)btn_complaint_timeOnClick:(id)sender {//最近投诉时间

    [self selectDate:sender];
}


-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (self.selectedButton == self.btn_add_val_sev_type) {///参与增值服务类型
        
        if(buttonIndex == 0){
            
            [self.selectedButton setTitle:@"生日祝福" forState:UIControlStateNormal];
        }
        else if(buttonIndex == 1){
            
            [self.selectedButton setTitle:@"礼品" forState:UIControlStateNormal];
        }
        
    }

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

-(void)submitData{
    NSString *alertMes = nil;
    if(!self.selectGroup){
        alertMes = @"请选择归属集团";
    }
    else if ([self.txt_user_name.text length] == 0) {
        alertMes = @"请输入客户姓名";
    }
    else if ([self.txt_user_msisdn.text length] == 0) {
        alertMes = @"请输入客户号码";
    }
    else if (self.switch_is_survey.on && [self.txt_is_score.text length] == 0) {
        alertMes = @"请输入满意度调查评分";
    }
    if (alertMes) {
        [[[UIAlertView alloc] initWithTitle:@"提示"
                                    message:alertMes
                                   delegate:nil
                          cancelButtonTitle:@"确定"
                          otherButtonTitles: nil] show];
        return;
    }
    
    hubFlag=YES;
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"数据提交中，请稍后...";
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
    
    
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    
    NSString *client_os = @"ios";
    [bDict setObject:client_os forKey:@"client_os"];
    
    int uid = self.user.userID;
    NSString *reply_user_id = [NSString stringWithFormat:@"%d",uid];
    [bDict setObject:reply_user_id forKey:@"user_id"];
    
    [bDict setObject:[NSNumber numberWithInt:self.user.userEnterprise] forKey:@"enterprise"];
    
    NSString *vp_id = self.visit_id;
    vp_id = vp_id?vp_id:@"";
    [bDict setObject:vp_id forKey:@"visit_id"];
    
    NSString *vip_mngr_name = self.user.userName;
    [bDict setObject:vip_mngr_name forKey:@"vip_mngr_name"];
    
    NSString *vip_mngr_msisdn = self.user.userMobile;
    [bDict setObject:vip_mngr_msisdn forKey:@"vip_mngr_msisdn"];
    
    NSString *user_name = self.txt_user_name.text;
    [bDict setObject:user_name forKey:@"user_name"];
    
    NSString *user_msisdn = self.txt_user_msisdn.text;
    [bDict setObject:user_msisdn forKey:@"user_msisdn"];
    
    NSString *grp_code = self.selectGroup.groupId;
    [bDict setObject:grp_code forKey:@"grp_code"];
    
    NSString *grp_name = self.selectGroup.groupName;
    [bDict setObject:grp_name forKey:@"grp_name"];
    
    NSString *grp_lvl = self.selectGroup.groupLvl;
    [bDict setObject:grp_lvl forKey:@"grp_lvl"];
    
    NSString *is_linkman = @"否";
    if (self.switch_is_linkman.on) {
        
        is_linkman = @"是";
        
    } else {
        
        is_linkman = @"否";
        
    }
    [bDict setObject:is_linkman forKey:@"is_linkman"];
    
    NSString *is_m_plan = @"否";
    if (self.switch_is_m_plan.on) {
        
        is_m_plan = @"是";
        
    } else {
        
        is_m_plan = @"否";
        
    }
    [bDict setObject:is_m_plan forKey:@"is_m_plan"];
    
    NSString *plan_time = self.btn_plan_time.titleLabel.text;
    [bDict setObject:plan_time forKey:@"plan_time"];
    
    NSString *is_act_part = @"否";
    if (self.switch_is_act_part.on) {
        
        is_act_part = @"是";
        
    } else {
        
        is_act_part = @"否";
        
    }
    [bDict setObject:is_act_part forKey:@"is_act_part"];
    
    NSString *is_add_val_sev = @"否";
    if (self.switch_is_add_val_sev.on) {
        
        is_add_val_sev = @"是";
        
    } else {
        
        is_add_val_sev = @"否";
        
    }
    [bDict setObject:is_add_val_sev forKey:@"is_add_val_sev"];
    
    NSString *add_val_sev_type = self.btn_add_val_sev_type.titleLabel.text;
    [bDict setObject:add_val_sev_type forKey:@"add_val_sev_type"];
    
    NSString *is_survey = @"否";
    if (self.switch_is_survey.on) {
        
        is_survey = @"是";
        
    } else {
        
        is_survey = @"否";
        
    }
    [bDict setObject:is_survey forKey:@"is_survey"];
    
    NSString *is_score = self.txt_is_score.text;
    [bDict setObject:is_score forKey:@"is_score"];
    
    NSString *complaint_time = self.btn_complaint_time.titleLabel.text;
    [bDict setObject:complaint_time forKey:@"complaint_time"];
    
    
    NSString *is_repair = @"否";
    if (self.switch_is_repair.on) {
        
        is_repair = @"是";
        
    } else {
        
        is_repair = @"否";
        
    }
    [bDict setObject:is_repair forKey:@"is_repair"];

    
    [NetworkHandling sendPackageWithUrl:@"datacollect/visistUserServiceInfo" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        hubFlag=NO;
        if(!error){
            
            NSLog(@"sign in success");
            id r = [result  objectForKey:@"Response"];
            NSString *f = [r objectForKey:@"returnFlag"];
            
            Boolean flag=[f boolValue];
            if(flag){
                
                [self performSelectorOnMainThread:@selector(showMessage:) withObject:@"提交成功！" waitUntilDone:YES];
                
            }else{
                
                [self performSelectorOnMainThread:@selector(showMessage:) withObject:@"提交失败！" waitUntilDone:YES];
            }
            
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



@end
