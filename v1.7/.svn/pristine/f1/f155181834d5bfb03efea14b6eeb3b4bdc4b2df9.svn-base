//
//  W_VisitPlanAddViewController.m
//  CMCCMarketing
//
//  Created by gmj on 14-11-19.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import "W_VisitPlanAddViewController.h"

#import "MBProgressHUD.h"
#import "NetworkHandling.h"

#import "W_VisitPlanAddSelectGroupTableViewController.h"
#import "W_VisitPlanAddSelectGroupContactUserTableViewController.h"
#import "W_VisitPlanAddSelectAccompanyUserController.h"
#import "W_VisitPlanAddSelectAddressController.h"
#import "Group.h"

#import "PreferentialPurchaseSelectDateTimeViewController.h"
#import "VariableStore.h"
#import "CustomerManager.h"
#import "W_VisitPlanAddSelectCustomerManagerTableViewController.h"
#import "W_VisitPlanAddSelectGroupContactUserViewController.h"

@interface W_VisitPlanAddViewController () <MBProgressHUDDelegate,UITextViewDelegate,VisitPlanAddSelectGroupTableViewControllerDelegate,VisitPlanAddSelectGroupContactUserTableViewControllerDelegate,VisitPlanAddSelectAccompanyUserControllerDelegate,W_VisitPlanAddSelectCustomerManagerTableViewControllerDelegate,
    PreferentialPurchaseSelectDateTimeViewControllerDelegate,W_VisitPlanAddSelectAddressControllerDelegate,VisitPlanAddSelectGroupContactUserViewControllerDelegate>{
    
    BOOL hubFlag;
    Group *selectGroup;
    NSArray *groupContactUserList;
//    NSDictionary *selectGroupContactUserDict;
    
    NSArray *accompanyUserList;
//    NSDictionary *selectAccompanyUserDic;
    NSMutableArray *selectAccompanyUserArr;//选择陪同人员
        //用于记录已经手动输入陪同人员的列表
        NSMutableArray *recordAccompanyUserArr;
        
        NSMutableArray *selectGroupContactUserArray;
    NSString *t_visit_remind;//提醒选项
        
    UIView *backView;
    PreferentialPurchaseSelectDateTimeViewController *selectDateTimeViewController;
    UIButton *selectDateBtn;
        
    CustomerManager *seletCustomerManager;
        
        NSDate *selectedStartDateTime;
        NSDate *selectedEndDateTime;
}

@end

@implementation W_VisitPlanAddViewController

#pragma mark - UITextView delegate

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    
    CGRect rect=self.view.frame;
    rect.origin.y-=200;
    self.view.frame=rect;
    return YES;
}

-(BOOL)textViewShouldEndEditing:(UITextView *)textView{
    
    CGRect rect=self.view.frame;
    rect.origin.y+=200;
    self.view.frame=rect;
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}

#pragma mark - PreferentialPurchaseSelectDateTimeViewControll delegate

-(void)preferentialPurchaseSelectDateTimeViewControllerDidCancel{
    
    [backView removeFromSuperview];
    [selectDateTimeViewController.view removeFromSuperview];
    
    backView=nil;
    selectDateTimeViewController=nil;
}

-(void)preferentialPurchaseSelectDateTimeViewControllerDidFinished:(PreferentialPurchaseSelectDateTimeViewController *)controller{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *dateString=[dateFormatter stringFromDate:controller.datetimePicker.date];
    if (selectDateBtn == self.btStartTime) {
        selectedStartDateTime=controller.datetimePicker.date;
        self.lbStartTime.text = dateString;
        
    } else {
        
        NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
        [dateFormatter1 setDateFormat:@"yyyy-MM-dd"];
        
        NSString *stimeString=[dateFormatter1 stringFromDate:selectedStartDateTime];
        NSString *etimeString= [dateFormatter1 stringFromDate:controller.datetimePicker.date];
        
        if(![stimeString isEqualToString:etimeString]){
            [self showErrorMessage:@"开始，结束时间必须是同一天！"];
            return;
        }
        
        NSTimeInterval timeInterval = [selectedStartDateTime timeIntervalSinceDate:controller.datetimePicker.date];
        
        if(timeInterval > -60){
            [self showErrorMessage:@"结束时间必须大于开始时间！"];
            return;
        }
        
        
        
        selectedEndDateTime=controller.datetimePicker.date;
        self.lbEndTime.text = dateString;
        
    }
    
    [self preferentialPurchaseSelectDateTimeViewControllerDidCancel];
}

- (IBAction)selectDate:(id)sender{
    
    selectDateBtn = sender;
    
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"BusinessProcess" bundle:nil];
    selectDateTimeViewController=[storyboard instantiateViewControllerWithIdentifier:@"PreferentialPurchaseSelectDateTimeViewControllerId"];
    selectDateTimeViewController.delegate=self;
    selectDateTimeViewController.modeDateAndTime=0;//设置模式为日期和时间显示
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

#pragma mark - controller delegate

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
    //初始化用于记录已经手动输入陪同人员的列表selectGroupContactUserArray
    
    selectGroupContactUserArray= [NSMutableArray new];
    [self initSubView];
    if (self.dicSelectVisitPlanDetail) {//编辑模式
        hubFlag=YES;
        MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:HUD];
        HUD.delegate=self;
        HUD.labelText=@"数据查询中，请稍后...";
        [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
        [self loadAccompanyUserWithInitEdit];
        
        [self setVisitPlanData];
    }
    
//    self.lbGroup.adjustsFontSizeToFitWidth=YES;
    self.lbContactAddress.font= [UIFont systemFontOfSize:12];
    self.lbContactAddress.numberOfLines=2;
    self.lbContactAddress.adjustsFontSizeToFitWidth=YES;
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
//    NSString *t_address = [self.selectVisitAddressDic objectForKey:@"visit_grp_add"];
//    t_address = t_address == nil? @"": t_address;
//    self.lbContactAddress.text = t_address;
}

- (void)initSubView{
    
    self.navigationItem.title = @"新增计划";
    
    //为长沙时****增加拜访类型************
    #if (defined STANDARD_CS_VERSION) || (defined MANAGER_CS_VERSION)
         self.lbVisitType.text=@"驻点";
    #endif
    
    #if (defined STANDARD_SY_VERSION) || (defined MANAGER_SY_VERSION)
    //不为长沙时隐藏拜访类型相关
    self.lbVisitType.hidden=YES;
    self.disp_visittype.hidden=YES;
    self.visitTypeButton.hidden=YES;
   //************************************
    #endif
//    self.lbUserName.text=self.user.userName;
    self.lbUserName.text = [NSString stringWithFormat:@"%@ %@",self.user.userName,self.user.userMobile];
    
    //#ifdef MANAGER_VERSION
    
#if (defined STANDARD_SY_VERSION) || (defined MANAGER_SY_VERSION)
    self.lblUserNameTitle.text = @"营销经理:";
#endif
    
#if (defined STANDARD_CS_VERSION) || (defined MANAGER_CS_VERSION)
    self.lblUserNameTitle.text = @"客户经理:";
#endif
    
#if (defined MANAGER_CS_VERSION) || (defined MANAGER_SY_VERSION)
    
//    self.lblUserNameTitle.text = [NSString stringWithFormat:@"%@:",[VariableStore getCustomerManagerName]];
    self.lbUserName.text = @"";
    self.btnUserName.hidden = NO;
    
#endif
  
    
    UIBarButtonItem *rightButton=[[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(addVisitPlan)];
    [rightButton setTintColor:[UIColor whiteColor]];
    [self.navigationItem setRightBarButtonItem:rightButton];
    
    self.txtContent.placeholder=@"填写拜访目标、内容、提醒事项";
    self.txtContent.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.txtContent.layer.borderWidth=1;
    self.txtContent.layer.cornerRadius=3;
    self.txtContent.layer.masksToBounds=YES;
    self.txtContent.delegate=self;

}

//编辑模式，设置拜访拜访数据
-(void)setVisitPlanData{
    
    NSDictionary *dicVisitPlan = self.dicSelectVisitPlanDetail;
    
    self.lbGroup.text = [dicVisitPlan objectForKey:@"visit_grp_name"];//集团客户,不能修改
//    self.lbContactUser.text = [dicVisitPlan objectForKey:@"linkman"];//联系人
    NSString *linkman = [dicVisitPlan objectForKey:@"linkman"];
    if(linkman && (NSNull*)linkman != [NSNull null] && linkman.length > 0){
        NSArray *contactArray=[linkman componentsSeparatedByString:@","];
         NSArray *contactMobileArray=[[dicVisitPlan objectForKey:@"linkman_msisdn"] componentsSeparatedByString:@","];
        self.lbContactUser.text=[NSString stringWithFormat:@"选择了%d个联系人",[contactArray count]];
        //在编辑模式下，从dicSelectVisitPlanDetail中获取联系人的数据整合成一个数组字典

            for (int i = 0; i<contactArray.count; i++){
           
                NSMutableDictionary *newDict =[NSMutableDictionary new];
                [newDict setValue:[contactArray objectAtIndex:i] forKey:@"linkman"];
                [newDict setValue:[contactMobileArray objectAtIndex:i] forKey:@"linkman_msisdn"];
                [selectGroupContactUserArray addObject:newDict];
            }
        

        
        
    }
    
    
    self.lbContactAddress.text = [dicVisitPlan objectForKey:@"visit_grp_add"];//拜访地址
    self.lbStartTime.text = [dicVisitPlan objectForKey:@"visit_statr_time"];
    self.lbEndTime.text = [dicVisitPlan objectForKey:@"visit_end_time"];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    selectedStartDateTime=[dateFormatter dateFromString:self.lbStartTime.text];
    selectedEndDateTime=[dateFormatter dateFromString:self.lbEndTime.text];
    
    self.txtContent.text = [dicVisitPlan objectForKey:@"visit_content"];//拜访内容
    NSArray *accmanAry = [dicVisitPlan objectForKey:@"accman"];//陪同人员
    NSString *acount = [NSString stringWithFormat:@"%d",accmanAry.count];
    
    if(!selectAccompanyUserArr)
        selectAccompanyUserArr=[NSMutableArray new];
    
    for (NSDictionary *dict in accmanAry) {
        NSMutableDictionary *newDict =[NSMutableDictionary new];
        [newDict setObject:[dict objectForKey:@"msisdn"] forKey:@"vip_mngr_msisdn"];
        [newDict setObject:[dict objectForKey:@"name"] forKey:@"vip_mngr_name"];
        [selectAccompanyUserArr addObject:newDict];
    }
    
    self.lbAccompanyUser.text = [NSString stringWithFormat:@"选择了%@个陪同人员",acount];
    
    NSString *remind = [dicVisitPlan objectForKey:@"visit_remind"];//提醒状态
    remind = [NSString stringWithFormat:@"%@",remind];
    if ([@"1" isEqualToString:remind]) {
        
        [self btnRemindOneOnClick:nil];
        
    } else if ([@"2" isEqualToString:remind]) {
        
        [self btnRemindTwoOnClick:nil];
        
    } else if ([@"3" isEqualToString:remind]) {
        
        [self btnRemindThreeOnClick:nil];
        
    } else if ([@"0" isEqualToString:remind]) {
        
        [self btnRemindFourOnClick:nil];
        
    }
    
    
//    controller.tableArray=self.user.groupInfo;
//    
//    //#ifdef MANAGER_VERSION
//#if (defined MANAGER_CS_VERSION) || (defined MANAGER_SY_VERSION)
//    
//    controller.tableArray=seletCustomerManager.groupList;
//    
//#endif
    
    NSArray *tmpGroupArray;
    tmpGroupArray=self.user.groupInfo;
    
#if (defined MANAGER_CS_VERSION) || (defined MANAGER_SY_VERSION)
    NSString *vip_mngr_msisdn = [self.dicSelectVisitPlanDetail objectForKey:@"vip_mngr_msisdn"];
    for (CustomerManager *customer in self.user.customerManagerInfo) {
        if([vip_mngr_msisdn isEqualToString:customer.vip_mngr_msisdn]){
            seletCustomerManager=customer;
            break;
        }
    }
    tmpGroupArray=seletCustomerManager.groupList;
#endif
    
    NSString *visit_grp_code =[self.dicSelectVisitPlanDetail objectForKey:@"visit_grp_code"];
    for (Group *group in tmpGroupArray) {
        if([visit_grp_code isEqualToString:group.groupId]){
            selectGroup =group;
            break;
        }
    }
    
}

-(void)connectToNetwork{
    
    while (hubFlag) {
        usleep(100000);
    }
}

-(void)addVisitPlan{
    
    if (self.dicSelectVisitPlanDetail) {
        
        [self editData];
    }else{
        
        [self postData];
    }
    
    
}

-(void)editData{
    
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    //为长沙主管，经理 加入拜访类型参数********
    #if (defined STANDARD_CS_VERSION) || (defined MANAGER_CS_VERSION)
    NSString *VisitTypeString=self.lbVisitType.text;
    [bDict setObject:VisitTypeString forKey:@"visit_type"];
#endif
    //***************
    NSString *t_client_os = @"ios";
    [bDict setObject:t_client_os forKey:@"client_os"];
    
    NSString *t_visit_statr_time = self.lbStartTime.text;
//    t_visit_statr_time = [t_visit_statr_time stringByAppendingString:@":00"];
    t_visit_statr_time = t_visit_statr_time?t_visit_statr_time:@"";
    [bDict setObject:t_visit_statr_time forKey:@"visit_statr_time"];
    
    NSString *t_visit_end_time = self.lbEndTime.text;
//    t_visit_end_time = [t_visit_end_time stringByAppendingString:@":00"];
    t_visit_end_time = t_visit_end_time?t_visit_end_time:@"";
    [bDict setObject:t_visit_end_time forKey:@"visit_end_time"];
    
    
    if (self.selectVisitAddressDic) {
        
        NSString *t_visit_grp_add = [self.selectVisitAddressDic objectForKey:@"visit_grp_add"];
        [bDict setObject:t_visit_grp_add forKey:@"visit_grp_add"];
        
        NSString *t_longitude = [self.selectVisitAddressDic objectForKey:@"baidu_longitude"];
        [bDict setObject:t_longitude forKey:@"longitude"];
        
        NSString *t_latitude = [self.selectVisitAddressDic objectForKey:@"baidu_latitude"];
        [bDict setObject:t_latitude forKey:@"latitude"];
        
        NSString *t_baidu_latitude = [self.selectVisitAddressDic objectForKey:@"baidu_latitude"];
        [bDict setObject:t_baidu_latitude forKey:@"baidu_latitude"];
        
        NSString *t_baidu_longitude = [self.selectVisitAddressDic objectForKey:@"baidu_longitude"];
        [bDict setObject:t_baidu_longitude forKey:@"baidu_longitude"];
        
    }
    
    
    if (selectGroupContactUserArray) {//联系人
        NSString *t_linkman=@"";
        NSString *t_linkman_msisdn=@"";
        for (NSDictionary *dict in selectGroupContactUserArray) {
            t_linkman = [t_linkman stringByAppendingFormat:@"%@,",[dict objectForKey:@"linkman"]];
            t_linkman_msisdn = [t_linkman_msisdn stringByAppendingFormat:@"%@,",[dict objectForKey:@"linkman_msisdn"]];
        }
        t_linkman=[t_linkman substringToIndex:t_linkman.length -1];
        t_linkman_msisdn=[t_linkman_msisdn substringToIndex:t_linkman_msisdn.length -1];
        //联系人，被拜访人员名字
        [bDict setObject:t_linkman forKey:@"linkman"];
        

        [bDict setObject:t_linkman_msisdn forKey:@"linkman_msisdn"];
        
    }else{
        
        NSString *t_linkman = [self.dicSelectVisitPlanDetail objectForKey:@"linkman"];//联系人，被拜访人员名字
        [bDict setObject:t_linkman forKey:@"linkman"];
        
        NSString *t_linkman_msisdn = [self.dicSelectVisitPlanDetail objectForKey:@"linkman_msisdn"];
        [bDict setObject:t_linkman_msisdn forKey:@"linkman_msisdn"];
    }
    
    
    NSString *t_vip_mngr_name = self.user.userName;//客户经理名字
    [bDict setObject:t_vip_mngr_name forKey:@"vip_mngr_name"];
    
    NSString *t_vip_mngr_msisdn = self.user.userMobile;//客户经理电话
    [bDict setObject:t_vip_mngr_msisdn forKey:@"vip_mngr_msisdn"];

    NSString *t_user_id = [NSString stringWithFormat:@"%d",self.user.userID ];
    [bDict setObject:t_user_id forKey:@"user_id"];
    
    NSString *t_enterprise = [NSString stringWithFormat:@"%d",self.user.userEnterprise];
    [bDict setObject:t_enterprise forKey:@"enterprise"];
    
    
    
    NSString *t_visit_content = self.txtContent.text;
    [bDict setObject:t_visit_content forKey:@"visit_content"];
    
    t_visit_remind = t_visit_remind?t_visit_remind:@"0";//拜访提醒
    [bDict setObject:t_visit_remind forKey:@"visit_remind"];
    
    
    if (selectAccompanyUserArr) {
        
        NSString *t_accman = @"";
        for (int k=0; k<selectAccompanyUserArr.count; k++) {
            
            NSDictionary *dicAccman = [selectAccompanyUserArr objectAtIndex:k];
            NSString *aname = [dicAccman objectForKey:@"vip_mngr_name"];
            aname = [NSString stringWithFormat:@"%@,",aname];
            t_accman = [t_accman stringByAppendingString:aname];
        }
        t_accman = [t_accman substringToIndex:t_accman.length-1];
        [bDict setObject:t_accman forKey:@"accman"];
        
        NSString *t_accman_msisdn = @"";
        for (int k=0; k<selectAccompanyUserArr.count; k++) {
            
            NSDictionary *dicAccman = [selectAccompanyUserArr objectAtIndex:k];
            NSString *avip_mngr_msisdn = [dicAccman objectForKey:@"vip_mngr_msisdn"];
            avip_mngr_msisdn = [NSString stringWithFormat:@"%@,",avip_mngr_msisdn];
            t_accman_msisdn = [t_accman_msisdn stringByAppendingString:avip_mngr_msisdn];
        }
        t_accman_msisdn = [t_accman_msisdn substringToIndex:t_accman_msisdn.length-1];
        [bDict setObject:t_accman_msisdn forKey:@"accman_msisdn"];
        
    }
    
    
    NSString *rId = [self.dicSelectVisitPlanDetail objectForKey:@"row_id"];
    rId = [NSString stringWithFormat:@"%@",rId];
    [bDict setObject:rId forKey:@"visit_id"];
    
    hubFlag=YES;
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"数据提交中，请稍后...";
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
    
    [NetworkHandling sendPackageWithUrl:@"visitplan/updvisitplan" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        hubFlag=NO;
        if(!error){
            NSLog(@"sign in success");
            //            remindTableArray =[result objectForKey:@"remindUser"];
            BOOL flag=[[result objectForKey:@"flag"] boolValue];
            if(flag){
                
                [self performSelectorOnMainThread:@selector(showErrorMessage:) withObject:@"编辑计划成功！" waitUntilDone:YES];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                    [self.navigationController popToRootViewControllerAnimated:YES];
                    [self.navigationController popToRootViewControllerAnimated:YES];
                    });
            }else{
                
                [self performSelectorOnMainThread:@selector(showMessage:) withObject:@"编辑计划失败！" waitUntilDone:YES];
            }
            
            
        }
        else{
            
            int errorCode=[[result valueForKey:@"errorcode"] intValue];
            NSString *errorInfo=[result valueForKey:@"errorinf"];
            if(!errorInfo)
                errorInfo=@"提交数据出错了！";
            NSLog(@"error:%d info:%@",errorCode,errorInfo);
            [self performSelectorOnMainThread:@selector(showMessage:) withObject:errorInfo waitUntilDone:YES];
        }
        
    }];
}

-(void)showErrorMessage:(NSString *)title{
    
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.delegate = self;
    HUD.labelText = title;
    [HUD show:YES];
    [HUD hide:YES afterDelay:2];
}

-(void)postData{
    
    /*
     
     v1_4\visitplan\addvisitplan
     必须传入参数
     visit_type 拜访类型
     visit_grp_code 集团编码
     client_os 系统类型:ios
     visit_grp_name 集团名称
     visit_statr_time 拜访开始时间
     visit_end_time 拜访结束时间
     group_type_name 集团单位类别
     visit_grp_add 拜访地址
     linkman 联系人 格式"名字1,名字2" 最多三个三个关键联系人
     linkman_msisdn 联系人电话 联系人电话 格式与联系人一致
     vip_mngr_name 集团经理
     vip_mngr_msisdn 集团经理电话
     user_id 用户编码
     enterprise 企业编码
     longitude 经度
     latitude 维度
     baidu_latitude 百度维度
     baidu_longitude 百度经度
     非必传
     accman 陪同人 格式"名字1,名字2" 最多三个陪同人
     accman_msisdn 陪同人电话 格式与陪同人一致
     返回参数
     flag:true/false 成功或失败
     
    
    
    if(!selectAccompanyUserArr){
        
        [self showErrorMessage:@"请选择陪同人员"];
        return;
        
    }else if(!selectGroup){
        
        [self showErrorMessage:@"请选择集团客户"];
        return;
        
    }else if(!selectGroupContactUserDict){
        
        [self showErrorMessage:@"请选择联系人"];
        return;
        
    }else if(!self.selectVisitAddressDic){
        
        [self showErrorMessage:@"请选择地址"];
        return;
        
    }else if(!self.lbStartTime.text.length > 0){
        
        [self showErrorMessage:@"请选择开始时间"];
        return;
        
    }else if(!self.lbEndTime.text.length > 0){
        
        [self showErrorMessage:@"请选择结束时间"];
        return;
        
    }
     
     */
    
    
    if(!selectGroup){
        
        [self showErrorMessage:@"请选择拜访对象"];
        return;
        
    }else if(!self.selectVisitAddressDic){
        
        [self showErrorMessage:@"请选择地址"];
        return;
        
    }else if(!self.lbStartTime.text.length > 0){
        
        [self showErrorMessage:@"请选择开始时间"];
        return;
        
    }else if(!self.lbEndTime.text.length > 0){
        
        [self showErrorMessage:@"请选择结束时间"];
        return;
        
    }
    
    NSString *sd = self.lbStartTime.text;
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *startDate = [format dateFromString:sd];
    NSString *ed = self.lbEndTime.text;
    NSDate *endDate = [format dateFromString:ed];
    NSTimeInterval result = [endDate timeIntervalSinceDate:startDate];
    
    if (result <= 0) {
        
        [self showErrorMessage:@"结束时间要晚于开始时间"];
    }
    
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    
    NSString *t_visit_grp_code = selectGroup.groupId;
    [bDict setObject:t_visit_grp_code forKey:@"visit_grp_code"];
    
    NSString *t_client_os = @"ios";
    [bDict setObject:t_client_os forKey:@"client_os"];
    
    
    NSString *t_visit_grp_name = selectGroup.groupName;
    [bDict setObject:t_visit_grp_name forKey:@"visit_grp_name"];
    
    
    NSString *t_visit_statr_time = self.lbStartTime.text;
    t_visit_statr_time = [t_visit_statr_time stringByAppendingString:@":00"];
    t_visit_statr_time = t_visit_statr_time?t_visit_statr_time:@"";
    [bDict setObject:t_visit_statr_time forKey:@"visit_statr_time"];
    
    NSString *t_visit_end_time = self.lbEndTime.text;
    t_visit_end_time = [t_visit_end_time stringByAppendingString:@":00"];
    t_visit_end_time = t_visit_end_time?t_visit_end_time:@"";
    [bDict setObject:t_visit_end_time forKey:@"visit_end_time"];
    
    NSString *t_group_type_name = selectGroup.groupLvl;
    [bDict setObject:t_group_type_name forKey:@"group_type_name"];
    
    NSString *t_visit_grp_add = [self.selectVisitAddressDic objectForKey:@"visit_grp_add"];
    [bDict setObject:t_visit_grp_add forKey:@"visit_grp_add"];
    
    NSString *t_longitude = [self.selectVisitAddressDic objectForKey:@"baidu_longitude"];
    [bDict setObject:t_longitude forKey:@"longitude"];
    
    NSString *t_latitude = [self.selectVisitAddressDic objectForKey:@"baidu_latitude"];
    [bDict setObject:t_latitude forKey:@"latitude"];
    
    NSString *t_baidu_latitude = [self.selectVisitAddressDic objectForKey:@"baidu_latitude"];
    [bDict setObject:t_baidu_latitude forKey:@"baidu_latitude"];
    
    NSString *t_baidu_longitude = [self.selectVisitAddressDic objectForKey:@"baidu_longitude"];
    [bDict setObject:t_baidu_longitude forKey:@"baidu_longitude"];
    
//    NSString *t_linkman = [selectGroupContactUserDict objectForKey:@"linkman"];//联系人，被拜访人员名字
//    t_linkman = t_linkman?t_linkman:@"";
//    [bDict setObject:t_linkman forKey:@"linkman"];
//    
//    NSString *t_linkman_msisdn = [selectGroupContactUserDict objectForKey:@"linkman_msisdn"];
//    t_linkman_msisdn = t_linkman_msisdn?t_linkman_msisdn:@"";
//    [bDict setObject:t_linkman_msisdn forKey:@"linkman_msisdn"];
    
    NSString *t_linkman=@"";
    NSString *t_linkman_msisdn=@"";
    for (NSDictionary *dict in selectGroupContactUserArray) {
        t_linkman = [t_linkman stringByAppendingFormat:@"%@,",[dict objectForKey:@"linkman"]];
        t_linkman_msisdn = [t_linkman_msisdn stringByAppendingFormat:@"%@,",[dict objectForKey:@"linkman_msisdn"]];
    }
    if(t_linkman.length > 0)
        t_linkman=[t_linkman substringToIndex:t_linkman.length -1];
    if(t_linkman_msisdn.length > 0)
        t_linkman_msisdn=[t_linkman_msisdn substringToIndex:t_linkman_msisdn.length -1];

    [bDict setObject:t_linkman forKey:@"linkman"];
    [bDict setObject:t_linkman_msisdn forKey:@"linkman_msisdn"];

    
    //////
    NSString *t_vip_mngr_name = self.user.userName;//客户经理名字
    [bDict setObject:t_vip_mngr_name forKey:@"vip_mngr_name"];
    
    NSString *t_vip_mngr_msisdn = self.user.userMobile;//客户经理电话
    [bDict setObject:t_vip_mngr_msisdn forKey:@"vip_mngr_msisdn"];
    
    NSString *t_visit_sta = @"1";
    [bDict setObject:t_visit_sta forKey:@"visit_sta"];
    
    //为长沙主管，经理 加入拜访类型参数********
#if (defined STANDARD_CS_VERSION) || (defined MANAGER_CS_VERSION)
    NSString *VisitTypeString=self.lbVisitType.text;
    [bDict setObject:VisitTypeString forKey:@"visit_type"];
#endif
    //***************
    
    //#ifdef MANAGER_VERSION
#if (defined MANAGER_CS_VERSION) || (defined MANAGER_SY_VERSION)
    
    t_vip_mngr_name = seletCustomerManager.vip_mngr_name;//客户经理名字
    [bDict setObject:t_vip_mngr_name forKey:@"vip_mngr_name"];
    
    t_vip_mngr_msisdn = seletCustomerManager.vip_mngr_msisdn;//客户经理电话
    [bDict setObject:t_vip_mngr_msisdn forKey:@"vip_mngr_msisdn"];
    
    t_visit_sta = @"4";
    [bDict setObject:t_visit_sta forKey:@"visit_sta"];
    
#endif
    
    
    NSString *t_user_id = [NSString stringWithFormat:@"%d",self.user.userID ];
    [bDict setObject:t_user_id forKey:@"user_id"];
    
    NSString *t_enterprise = [NSString stringWithFormat:@"%d",self.user.userEnterprise];
    [bDict setObject:t_enterprise forKey:@"enterprise"];
    
    NSString *t_visit_content = self.txtContent.text;
    [bDict setObject:t_visit_content forKey:@"visit_content"];
    
    
    
    t_visit_remind = t_visit_remind?t_visit_remind:@"0";//拜访提醒
    [bDict setObject:t_visit_remind forKey:@"visit_remind"];
    
    if(selectAccompanyUserArr && selectAccompanyUserArr.count>0){
        
        NSString *t_accman = @"";
        for (int k=0; k<selectAccompanyUserArr.count; k++) {
            
            NSDictionary *dicAccman = [selectAccompanyUserArr objectAtIndex:k];
            NSString *aname = [dicAccman objectForKey:@"vip_mngr_name"];
            aname = [NSString stringWithFormat:@"%@,",aname];
            t_accman = [t_accman stringByAppendingString:aname];
        }
        t_accman = [t_accman substringToIndex:t_accman.length-1];
        [bDict setObject:t_accman forKey:@"accman"];
        
        NSString *t_accman_msisdn = @"";
        for (int k=0; k<selectAccompanyUserArr.count; k++) {
            
            NSDictionary *dicAccman = [selectAccompanyUserArr objectAtIndex:k];
            NSString *avip_mngr_msisdn = [dicAccman objectForKey:@"vip_mngr_msisdn"];
            avip_mngr_msisdn = [NSString stringWithFormat:@"%@,",avip_mngr_msisdn];
            t_accman_msisdn = [t_accman_msisdn stringByAppendingString:avip_mngr_msisdn];
        }
        t_accman_msisdn = [t_accman_msisdn substringToIndex:t_accman_msisdn.length-1];
        [bDict setObject:t_accman_msisdn forKey:@"accman_msisdn"];
        
    }else{
        
        [bDict setObject:@"" forKey:@"accman"];
        [bDict setObject:@"" forKey:@"accman_msisdn"];
    }
    
    
    hubFlag=YES;
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"数据查询中，请稍后...";
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];

    [NetworkHandling sendPackageWithUrl:@"visitplan/addvisitplan" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        hubFlag=NO;
        if(!error){
            NSLog(@"sign in success");
            //            remindTableArray =[result objectForKey:@"remindUser"];
            BOOL flag=[[result objectForKey:@"flag"] boolValue];
            if(flag){
                
//                [self performSelectorOnMainThread:@selector(showMessage:) withObject:@"添加计划成功！" waitUntilDone:YES];
//                [self performSelectorOnMainThread:@selector(toVisitPlanList) withObject:nil waitUntilDone:YES];
                
                [self performSelectorOnMainThread:@selector(showErrorMessage:) withObject:@"添加计划成功！" waitUntilDone:YES];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                    [self.navigationController popToRootViewControllerAnimated:YES];
                    [self.navigationController popViewControllerAnimated:YES];
                });
                
            }else{
                
                [self performSelectorOnMainThread:@selector(showMessage:) withObject:@"添加计划失败！" waitUntilDone:YES];
            }

            
        }
        else{
            
            int errorCode=[[result valueForKey:@"errorcode"] intValue];
            NSString *errorInfo=[result valueForKey:@"errorinf"];
            if(!errorInfo)
                errorInfo=@"提交数据出错了！";
            NSLog(@"error:%d info:%@",errorCode,errorInfo);
            [self performSelectorOnMainThread:@selector(showMessage:) withObject:errorInfo waitUntilDone:YES];
        }
        
    }];
}

-(void)toVisitPlanList{
    
    [self.navigationController popViewControllerAnimated:YES];
    
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

#pragma mark 选择拜访对象的类型方法
- (IBAction)selectGroupOnclick:(id)sender {
    
    if (self.dicSelectVisitPlanDetail) {
        [self showErrorMessage:@"拜访对象无法修改!"];
        return;
    }
    
    UIAlertView *selectGroupTypeAlert = [[UIAlertView alloc]initWithTitle:@"选择拜访类型" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"集团客户",@"中小集团", nil];
    selectGroupTypeAlert.tag=22;
    [selectGroupTypeAlert show];
    
//    W_VisitPlanAddSelectGroupTableViewController *controller=[[W_VisitPlanAddSelectGroupTableViewController alloc] initWithNibName:@"W_VisitPlanAddSelectGroupTableViewController" bundle:nil];
//    controller.delegate=self;
//    controller.tableArray=self.user.groupInfo;
//    controller.selectGroup=selectGroup;
//    
//    controller.user = self.user;//
//    
//    //#ifdef MANAGER_VERSION
//#if (defined MANAGER_CS_VERSION) || (defined MANAGER_SY_VERSION)
//    
//    controller.tableArray=seletCustomerManager.groupList;
//    
//#endif
//    
//    
//    [self.navigationController pushViewController:controller animated:YES];
}
#pragma mark - 选择联系人
- (IBAction)selectGroupContactUserOnclick:(id)sender {

    if(!selectGroup)
        return;
    
//    if(selectGroupContactUserDict){
//        [self performSegueWithIdentifier:@"VisitPlanAddSelectGroupContactUserSegue" sender:self];
//        return;
//    }
    
    hubFlag=YES;
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"数据查询中，请稍后...";
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
    
    [self loadGroupContactUser];
    //    [self performSegueWithIdentifier:@"VisitPlanAddSelectGroupContactUserSegue" sender:self];
    
}

-(void)loadGroupContactUser{
    
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    [bDict setObject:selectGroup.groupId forKey:@"grp_code"];
    [bDict setObject:[NSNumber numberWithInt:self.user.userEnterprise] forKey:@"enterprise"];
    
    [NetworkHandling sendPackageWithUrl:@"grpuserlink/getUserInfoList" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        hubFlag=NO;
        if(!error){
            NSLog(@"sign in success");
            
            groupContactUserList =[result objectForKey:@"Response"];
            
            [self performSelectorOnMainThread:@selector(pushW_VisitPlanAddSelectGroupContactUserTableViewController) withObject:nil waitUntilDone:YES];

        }
        else{
            int errorCode=[[result valueForKey:@"errorcode"] intValue];
            NSString *errorInfo=[result valueForKey:@"errorinf"];
            if(!errorInfo)
                errorInfo=@"提交数据出错了！";
            NSLog(@"error:%d info:%@",errorCode,errorInfo);
            [self performSelectorOnMainThread:@selector(showMessage:) withObject:errorInfo waitUntilDone:YES];
        }
        
    }];
    
}

-(void) pushW_VisitPlanAddSelectGroupContactUserTableViewController{
    
//    W_VisitPlanAddSelectGroupContactUserTableViewController *controller = [[W_VisitPlanAddSelectGroupContactUserTableViewController alloc] initWithNibName:@"W_VisitPlanAddSelectGroupContactUserTableViewController" bundle:nil];
//    controller.tableArray=groupContactUserList;
////    controller.selectUserDict=selectGroupContactUserDict;
    
  W_VisitPlanAddSelectGroupContactUserViewController *controller=[[W_VisitPlanAddSelectGroupContactUserViewController alloc] initWithNibName:@"W_VisitPlanAddSelectGroupContactUserViewController" bundle:nil];    
    controller.tableArray=groupContactUserList;
    
    /**
     *  @brief  如果是编辑模式，需要把已选的联系人找出来添加到选择数组里。
     */
    NSString *linkman_msisdn=[self.dicSelectVisitPlanDetail objectForKey:@"linkman_msisdn"];
    if(self.dicSelectVisitPlanDetail && !selectGroupContactUserArray && linkman_msisdn && (NSNull*)linkman_msisdn != [NSNull null] && linkman_msisdn.length > 0){
        
        if(!selectGroupContactUserArray)
            selectGroupContactUserArray=[NSMutableArray new];
        
        NSArray *contactArray=[linkman_msisdn componentsSeparatedByString:@","];
        for (NSString *msisdn in contactArray) {
            for (NSDictionary *dict in groupContactUserList) {
                NSString *ms =[dict objectForKey:@"linkman_msisdn"];
                if([ms isEqualToString:msisdn]){
                    [selectGroupContactUserArray addObject:dict];
                    continue;
                }
            }
        }
    }
    
    
    controller.selectedArray=selectGroupContactUserArray;
    controller.group=selectGroup;
    controller.delegate=self;
    controller.selectType = 2;
    [self.navigationController pushViewController:controller animated:YES];
    
}
#pragma mark - 选择陪同人员
- (IBAction)selectAccompanyUserOnclick:(id)sender {
    
#if (defined MANAGER_CS_VERSION) || (defined MANAGER_SY_VERSION)
    if(!seletCustomerManager){
        [self showErrorMessage:@"您还没有选择客户经理!"];
        return;
    }
#endif
    
    hubFlag=YES;
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"数据查询中，请稍后...";
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
    
    [self loadAccompanyUser];
    
}
- (void)loadAccompanyUserWithInitEdit{
    
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    [bDict setObject:self.user.userMobile forKey:@"vip_mngr_msisdn"];
    [bDict setObject:[NSNumber numberWithInt:self.user.userEnterprise] forKey:@"enterprise"];
    
    [NetworkHandling sendPackageWithUrl:@"visitplan/getmanageruserlist" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        hubFlag=NO;
        if(!error){
            NSLog(@"sign in success");
            
            accompanyUserList =[result objectForKey:@"vip_mngr_list"];
            
            [self performSelectorOnMainThread:@selector(initEidtData) withObject:nil waitUntilDone:YES];
            
        }
        else{
            int errorCode=[[result valueForKey:@"errorcode"] intValue];
            NSString *errorInfo=[result valueForKey:@"errorinf"];
            if(!errorInfo)
                errorInfo=@"提交数据出错了！";
            NSLog(@"error:%d info:%@",errorCode,errorInfo);
            [self performSelectorOnMainThread:@selector(showMessage:) withObject:errorInfo waitUntilDone:YES];
        }
        
    }];
    
}
-(void)initEidtData{

}
- (void)loadAccompanyUser{
    
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    [bDict setObject:self.user.userMobile forKey:@"vip_mngr_msisdn"];
    [bDict setObject:[NSNumber numberWithInt:self.user.userEnterprise] forKey:@"enterprise"];
    
    [NetworkHandling sendPackageWithUrl:@"visitplan/getmanageruserlist" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        hubFlag=NO;
        if(!error){
            NSLog(@"sign in success");
            
            accompanyUserList =[result objectForKey:@"vip_mngr_list"];

            [self performSelectorOnMainThread:@selector(pushW_VisitPlanAddSelectAccompanyUserController) withObject:nil waitUntilDone:YES];
            
        }
        else{
            int errorCode=[[result valueForKey:@"errorcode"] intValue];
            NSString *errorInfo=[result valueForKey:@"errorinf"];
            if(!errorInfo)
                errorInfo=@"提交数据出错了！";
            NSLog(@"error:%d info:%@",errorCode,errorInfo);
            [self performSelectorOnMainThread:@selector(showMessage:) withObject:errorInfo waitUntilDone:YES];
        }
        
    }];
    
}

-(void)pushW_VisitPlanAddSelectAccompanyUserController{
    
    W_VisitPlanAddSelectAccompanyUserController *controller = [[W_VisitPlanAddSelectAccompanyUserController alloc] initWithNibName:@"W_VisitPlanAddSelectAccompanyUserController" bundle:nil];
    controller.tableArray=accompanyUserList;
    controller.recordArray=recordAccompanyUserArr;
    
//    controller.selectAccompanyUserDic=selectAccompanyUserDic;
    controller.selectAccompanyUserArr = selectAccompanyUserArr;//陪同人员
    controller.delegate=self;
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)selectAddressOnclick:(id)sender {
    
    if(selectGroup.groupLatitude > 1){
        return;
    }
    
    W_VisitPlanAddSelectAddressController *controller = [[W_VisitPlanAddSelectAddressController alloc] initWithNibName:@"W_VisitPlanAddSelectAddressController" bundle:nil];
    controller.user = self.user;
    controller.delegate=self;
//    controller.vc = self;
    [self.navigationController pushViewController:controller animated:YES];
}
-(void)w_visitPlanAddSelectAddressControllerDidFinished:(CLLocationCoordinate2D)coord selectWithAddress:(NSString *)address{
    NSMutableDictionary *dicAdd = [[NSMutableDictionary alloc] init];
    double lat = coord.latitude;
    double log = coord.longitude;
    [dicAdd setObject:[NSNumber numberWithDouble:lat] forKey:@"baidu_latitude"];
    [dicAdd setObject:[NSNumber numberWithDouble:log] forKey:@"baidu_longitude"];
    [dicAdd setObject:address forKey:@"visit_grp_add"];
    self.selectVisitAddressDic = dicAdd;
    //自己选地图
    self.lbContactAddress.text = address;
}

- (IBAction)selectStartTimeOnclick:(id)sender {
    
    [self selectDate:sender];
}

- (IBAction)selectEndTimeOnclick:(id)sender {
    
    [self selectDate:sender];

}

//拜访提醒 0不提醒 1提前一小时提醒 2提前两小时提醒 3提前一天提醒
- (IBAction)btnRemindOneOnClick:(id)sender {
    
    t_visit_remind = @"1";
    [self.btnRemindOne setBackgroundImage:[UIImage imageNamed:@"勾选.png"] forState:UIControlStateNormal];
    [self.btnRemindTwo setBackgroundImage:[UIImage imageNamed:@"未勾选.png"] forState:UIControlStateNormal];
    [self.btnRemindThree setBackgroundImage:[UIImage imageNamed:@"未勾选.png"] forState:UIControlStateNormal];
    [self.btnRemindFour setBackgroundImage:[UIImage imageNamed:@"未勾选.png"] forState:UIControlStateNormal];
}

- (IBAction)btnRemindTwoOnClick:(id)sender {
    
    t_visit_remind = @"2";
    [self.btnRemindOne setBackgroundImage:[UIImage imageNamed:@"未勾选.png"] forState:UIControlStateNormal];
    [self.btnRemindTwo setBackgroundImage:[UIImage imageNamed:@"勾选.png"] forState:UIControlStateNormal];
    [self.btnRemindThree setBackgroundImage:[UIImage imageNamed:@"未勾选.png"] forState:UIControlStateNormal];
    [self.btnRemindFour setBackgroundImage:[UIImage imageNamed:@"未勾选.png"] forState:UIControlStateNormal];
}

- (IBAction)btnRemindThreeOnClick:(id)sender {
    
    t_visit_remind = @"3";
    [self.btnRemindOne setBackgroundImage:[UIImage imageNamed:@"未勾选.png"] forState:UIControlStateNormal];
    [self.btnRemindTwo setBackgroundImage:[UIImage imageNamed:@"未勾选.png"] forState:UIControlStateNormal];
    [self.btnRemindThree setBackgroundImage:[UIImage imageNamed:@"勾选.png"] forState:UIControlStateNormal];
    [self.btnRemindFour setBackgroundImage:[UIImage imageNamed:@"未勾选.png"] forState:UIControlStateNormal];
}

- (IBAction)btnRemindFourOnClick:(id)sender {
    
    t_visit_remind = @"0";
    [self.btnRemindOne setBackgroundImage:[UIImage imageNamed:@"未勾选.png"] forState:UIControlStateNormal];
    [self.btnRemindTwo setBackgroundImage:[UIImage imageNamed:@"未勾选.png"] forState:UIControlStateNormal];
    [self.btnRemindThree setBackgroundImage:[UIImage imageNamed:@"未勾选.png"] forState:UIControlStateNormal];
    [self.btnRemindFour setBackgroundImage:[UIImage imageNamed:@"勾选.png"] forState:UIControlStateNormal];
}
#pragma mark - 选择中小集团对象后的返回代理

-(void)visitPlanAddSelectLittleGroupTableViewControllerDidFinished:(NSDictionary *)dcit {
     //如果选择新的拜访对象，要清楚地址的label
    self.lbContactAddress.text=@"";

    self.lbGroup.text =[dcit objectForKey:@"grp_name"];
    if(![[dcit objectForKey:@"longtitude"] isEqualToString:@""]){
        
     NSMutableDictionary *dicAdd = [[NSMutableDictionary alloc] init];
        [dicAdd setObject:[dcit objectForKey:@"longtitude"]forKey:@"baidu_longitude"];
         [dicAdd setObject:[dcit objectForKey:@"latitude"]forKey:@"baidu_latitude"];
        self.selectVisitAddressDic = dicAdd;
        self.lbContactAddress.text =[dcit objectForKey:@"grp_addr"];
    }
}
#pragma mark -选择集团对象后的返回代理

-(void)visitPlanAddSelectGroupTableViewControllerDidFinished:(W_VisitPlanAddSelectGroupTableViewController *)controller{
    
    //如果选择新的要清楚掉选择的联系人数组
    if(![selectGroup.groupId isEqualToString:controller.selectGroup.groupId] && selectGroupContactUserArray)
        selectGroupContactUserArray=nil;
    selectGroup=controller.selectGroup;
    self.lbGroup.text=selectGroup.groupName;
   self.lbContactAddress.text=@"";
    
    if(selectGroup.groupLatitude > 1){
        NSMutableDictionary *dicAdd = [[NSMutableDictionary alloc] init];
        double lat = selectGroup.groupLatitude;
        double log = selectGroup.groupLongitude;
        [dicAdd setObject:[NSNumber numberWithDouble:lat] forKey:@"baidu_latitude"];
        [dicAdd setObject:[NSNumber numberWithDouble:log] forKey:@"baidu_longitude"];
        [dicAdd setObject:selectGroup.groupAddress forKey:@"visit_grp_add"];
        self.selectVisitAddressDic = dicAdd;
        self.lbContactAddress.text = selectGroup.groupAddress;
    }
    //不需要调用该API
//    if(selectGroup.groupLatitude < 1 && selectGroup.groupDiduType == 1){
//        [self getGroupAddress];
//    }
    
}
-(void)getGroupAddress{
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    [bDict setObject:selectGroup.groupAddress forKey:@"grp_addr"];
    
    [NetworkHandling sendPackageWithUrl:@"grpuserlink/getgrpAddr" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        if(!error){
            NSLog(@"sign in success");
            BOOL flag=[[result objectForKey:@"is_null"] boolValue];
            if(flag){
                [self performSelectorOnMainThread:@selector(refreshGroupAddress:) withObject:result waitUntilDone:YES];
            }
           
        }
        hubFlag=NO;
    }];
}
-(void)refreshGroupAddress:(NSDictionary*)dict{
    NSString *latitude=[dict objectForKey:@"latitude"];
    NSString *longitude=[dict objectForKey:@"longtitude"];
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(latitude.doubleValue, longitude.doubleValue);
    
    NSMutableDictionary *dicAdd = [[NSMutableDictionary alloc] init];
    double lat = coord.latitude;
    double log = coord.longitude;
    [dicAdd setObject:[NSNumber numberWithDouble:lat] forKey:@"baidu_latitude"];
    [dicAdd setObject:[NSNumber numberWithDouble:log] forKey:@"baidu_longitude"];
    [dicAdd setObject:selectGroup.groupAddress forKey:@"visit_grp_add"];
    self.selectVisitAddressDic = dicAdd;
    self.lbContactAddress.text = selectGroup.groupAddress;
}
-(void)visitPlanAddSelectGroupContactUserTableViewControllerDidFinished:(W_VisitPlanAddSelectGroupContactUserTableViewController *)controller{
    selectGroupContactUserArray=controller.selectedArray;
//    selectGroupContactUserDict=controller.selectUserDict;
//    self.lbContactUser.text=[selectGroupContactUserDict objectForKey:@"linkman"];
    self.lbContactUser.text=[NSString stringWithFormat:@"选择了%d个联系人",[selectGroupContactUserArray count]];

}
-(void)visitPlanAddSelectGroupContactUserViewControllerDidFinished:(W_VisitPlanAddSelectGroupContactUserViewController *)controller{
    selectGroupContactUserArray=controller.selectedArray;
    self.lbContactUser.text=[NSString stringWithFormat:@"选择了%d个联系人",[selectGroupContactUserArray count]];
}
//-(void)visitPlanAddSelectGroupContactUserTableViewControllerDidCanceled{
//    selectGroupContactUserArray=nil;
//    self.lbContactUser.text=@"";
//}

-(void)VisitPlanAddSelectAccompanyUserControllerDidFinished:(W_VisitPlanAddSelectAccompanyUserController *)controller{
    //接收传递记录数组
    recordAccompanyUserArr=controller.recordArray;
    
    selectAccompanyUserArr = controller.selectAccompanyUserArr;
    NSInteger c = selectAccompanyUserArr.count;
    self.lbAccompanyUser.text=[NSString stringWithFormat:@"选择了%d个陪同人员",c];

}

-(void)w_VisitPlanAddSelectCustomerManagerTableViewControllerDidFinished:(W_VisitPlanAddSelectCustomerManagerTableViewController *)controller{
    
    seletCustomerManager= controller.selectCustomerManager;
    NSString *t_customerName = seletCustomerManager.vip_mngr_name;
    
    self.lbUserName.text=[NSString stringWithFormat:@"%@",t_customerName];
    
}

- (IBAction)btnUserNameOnClick:(id)sender {
    
    W_VisitPlanAddSelectCustomerManagerTableViewController *controller=[[W_VisitPlanAddSelectCustomerManagerTableViewController alloc] init];
    controller.delegate=self;
    controller.tableArray=self.user.customerManagerInfo;//
    controller.selectCustomerManager=seletCustomerManager;
    
    [self.navigationController pushViewController:controller animated:YES];
    
}



#pragma mark 选择拜访类型方法
- (IBAction)selectVisitType:(id)sender {
    UIAlertView *selectVisitTypeAlert = [[UIAlertView alloc]initWithTitle:@"选择拜访类型" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"驻点",@"日常拜访",@"首席拜访",@"信息化", nil];
    selectVisitTypeAlert.tag=11;
    [selectVisitTypeAlert show];
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex

{
    
    NSString *msg = [[NSString alloc] initWithFormat:@"您点击的是第%d个按钮!",buttonIndex];
    
    NSLog(@"msg:%@",msg);
    if (alertView.tag==11) {
    
    if (buttonIndex == 0) {
        
        NSLog(@"取消。。。。。。");
        
    }else if(buttonIndex == 1){
        self.lbVisitType.text=@"驻点";
        
    }
    else if(buttonIndex == 2){
        self.lbVisitType.text=@"日常拜访";
    }
    else if(buttonIndex == 3){
        self.lbVisitType.text=@"首席拜访";
    }
    else if(buttonIndex == 4){
        self.lbVisitType.text=@"信息化";
    }
        }

    if (alertView.tag==22) {
        if (buttonIndex == 0) {
            
            NSLog(@"取消。。。。。。");
            
        }else if(buttonIndex == 1){
              //选择集团客户
            W_VisitPlanAddSelectGroupTableViewController *controller=[[W_VisitPlanAddSelectGroupTableViewController alloc] initWithNibName:@"W_VisitPlanAddSelectGroupTableViewController" bundle:nil];
            controller.delegate=self;
            controller.tableArray=self.user.groupInfo;
            controller.selectGroup=selectGroup;
            
            controller.user = self.user;//
            
            //#ifdef MANAGER_VERSION
#if (defined MANAGER_CS_VERSION) || (defined MANAGER_SY_VERSION)
            
            controller.tableArray=seletCustomerManager.groupList;
            
#endif
            
            
            [self.navigationController pushViewController:controller animated:YES];
            
        }
        else if(buttonIndex == 2){
            W_VisitPlanAddSelectGroupTableViewController *controller=[[W_VisitPlanAddSelectGroupTableViewController alloc] initWithNibName:@"W_VisitPlanAddSelectGroupTableViewController" bundle:nil];
            controller.delegate=self;
           // controller.tableArray=self.user.groupInfo;
            //controller.selectGroup=selectGroup;
            controller.user = self.user;
            controller.listType = 33;

            [self.navigationController pushViewController:controller animated:YES];
            
//
            //选择中小集团客户
           // self.lbVisitType.text=@"日常拜访";
        }

        
    }
    
}


@end
