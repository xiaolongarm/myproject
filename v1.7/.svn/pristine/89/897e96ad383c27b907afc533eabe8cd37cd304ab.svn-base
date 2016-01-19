//
//  GroupBroadbandViewController.m
//  CMCCMarketing
//
//  Created by talkweb on 14-9-15.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//
#define BODY_TAB_VIEW_SIZE_WIDTH 300
#define BODY_TAB_VIEW_SIZE_HEIGHT 320
#import "GroupBroadbandCreaterViewController.h"
#import "GroupBroadbandRenewalViewController.h"
#import "GroupBroadbandViewController.h"
#import "GroupBroadbandRecordViewController.h"

#import "PreferentialPurchaseSelectGroupViewController.h"
#import "MBProgressHUD.h"
#import "SendBoxHandling.h"

#import "PreferentialPurchaseSelectDateTimeViewController.h"

@interface GroupBroadbandViewController ()<GroupBroadbandCreaterViewControllerDelegate,PreferentialPurchaseSelectGroupViewControllerDelegate,PreferentialPurchaseSelectDateTimeViewControllerDelegate,GroupBroadbandRenewalViewControllerDelegate>{
    GroupBroadbandCreaterViewController *greaterViewController;
    GroupBroadbandRenewalViewController *renewalViewController;
    
    PreferentialPurchaseSelectGroupViewController *filterController;
    UIView *backView;
    Group *selectedGroup;
    
    PreferentialPurchaseSelectDateTimeViewController *selectDateTimeViewController;
    UIButton *selectDateWithButton;
    
    
}

@end

@implementation GroupBroadbandViewController

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
    
    greaterViewController=[[self storyboard] instantiateViewControllerWithIdentifier:@"GroupBroadbandCreaterId"];
    renewalViewController=[[self storyboard] instantiateViewControllerWithIdentifier:@"GroupBroadbandRenewalId"];
    renewalViewController.user=self.user;
    renewalViewController.delegate=self;
    
    [bodyView addSubview:greaterViewController.view];
    [bodyView addSubview:renewalViewController.view];
    
    greaterViewController.delegate=self;
    
    greaterViewController.view.frame=CGRectMake(0, 0,BODY_TAB_VIEW_SIZE_WIDTH,BODY_TAB_VIEW_SIZE_HEIGHT);
    renewalViewController.view.frame=CGRectMake(0, 0,BODY_TAB_VIEW_SIZE_WIDTH,BODY_TAB_VIEW_SIZE_HEIGHT);
    
    [bodyView bringSubviewToFront:greaterViewController.view];
    
    UIBarButtonItem *rightButton=[[UIBarButtonItem alloc]initWithTitle:@"发件箱" style:UIBarButtonItemStylePlain target:self action:@selector(goSendBox)];
    [rightButton setTintColor:[UIColor whiteColor]];
    [self.navigationItem setRightBarButtonItem:rightButton];
    
    
}
-(void)goSendBox{
    [self performSegueWithIdentifier:@"GroupBroadbandSendboxSegue" sender:self];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"GroupBroadbandRecordSegue"]){
        GroupBroadbandRecordViewController *controller=segue.destinationViewController;
        controller.user=self.user;
    }
}

- (IBAction)createAccountButtonOnclick:(id)sender {
    [createAccountButton setBackgroundImage:[UIImage imageNamed:@"switch_chen1"] forState:UIControlStateNormal];
    [renewalButton setBackgroundImage:[UIImage imageNamed:@"switch_hui2"] forState:UIControlStateNormal];
    
    [createAccountButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [renewalButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    
    [bodyView bringSubviewToFront:greaterViewController.view];
}
- (IBAction)renewalButtonOnclick:(id)sender {
    [createAccountButton setBackgroundImage:[UIImage imageNamed:@"switch_hui1"] forState:UIControlStateNormal];
    [renewalButton setBackgroundImage:[UIImage imageNamed:@"switch_chen2"] forState:UIControlStateNormal];
    
    [createAccountButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [renewalButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    [bodyView bringSubviewToFront:renewalViewController.view];
}

-(void)selectGroup{
    filterController=[self.storyboard instantiateViewControllerWithIdentifier:@"MarketingGroupUserFilterViewControllerId"];
    filterController.delegate=self;
    filterController.user=self.user;
    filterController.group=selectedGroup;
    CGRect rect=filterController.view.frame;
    
    rect.origin.x=10;
    rect.origin.y=80;
    rect.size.width=300;
    rect.size.height=340;
    
    filterController.view.frame=rect;
    filterController.view.layer.borderWidth=1;
    filterController.view.layer.borderColor=[UIColor colorWithRed:55/255.0 green:132/255.0 blue:173/255.0 alpha:1.0].CGColor;
    filterController.view.layer.shadowOffset = CGSizeMake(2, 2);
    filterController.view.layer.shadowOpacity = 0.80;
    
    backView=[[UIView alloc] init];
    backView.backgroundColor=[UIColor blackColor];
    backView.alpha=0.1;
    
    backView.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [self.view addSubview:backView];
    
    [self.view addSubview:filterController.view];
}
-(void)preferentialPurchaseSelectGroupViewControllerDidCanceled{
    [backView removeFromSuperview];
    [filterController.view removeFromSuperview];
    
    backView=nil;
    filterController=nil;
}
-(void)preferentialPurchaseSelectGroupViewControllerDidFinished:(PreferentialPurchaseSelectGroupViewController *)controller{
    selectedGroup=controller.group;
    [greaterViewController.btGroupName setTitle:controller.group.groupName forState:UIControlStateNormal];
    greaterViewController.txtGroupId.text=selectedGroup.groupId;
    greaterViewController.txtGroupNo.text=[NSString stringWithFormat:@"%.0f",selectedGroup.groupserviceCode];
    [self preferentialPurchaseSelectGroupViewControllerDidCanceled];
}
-(void)beginEdit{
    CGRect rect=self.view.frame;
    rect.origin.y-=160;
    self.view.frame=rect;
}
-(void)endEdit{
    CGRect rect=self.view.frame;
    rect.origin.y+=160;
    self.view.frame=rect;
}
-(void)selectDate:(id)sender{
    selectDateTimeViewController=[self.storyboard instantiateViewControllerWithIdentifier:@"PreferentialPurchaseSelectDateTimeViewControllerId"];
    selectDateTimeViewController.delegate=self;
    
    CGRect rect=selectDateTimeViewController.view.frame;
    
    rect.origin.x=0;
    rect.origin.y=[[UIScreen mainScreen] bounds].size.height - 200;
    rect.size.width=320;
    rect.size.height=200;
    
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
    
    selectDateWithButton=sender;
    
}
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
    //    selectDateWithTextField.text=[dateFormatter stringFromDate:controller.datetimePicker.date];
    [selectDateWithButton setTitle:dateString forState:UIControlStateNormal];
    [self preferentialPurchaseSelectDateTimeViewControllerDidCancel];
}
- (IBAction)goSendBox:(id)sender {
    if(greaterViewController.txtGroupId.text.length==0 || greaterViewController.txtBroadband.text.length==0 || greaterViewController.txtContract.text.length==0){
        UIAlertView *alertview=[[UIAlertView alloc] initWithTitle:@"警 告" message:@"业务受理信息没有填写完整！" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确 定", nil];
        [alertview show];
        return;
    }
    
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    long long datetime = (long long)time;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString=[dateFormatter stringFromDate:[NSDate date]];
    
    NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
    [dict setObject:[NSNumber numberWithInt:self.user.userID] forKey:@"customerManagerId"];
    [dict setObject:[NSNumber numberWithInt:self.user.userEnterprise] forKey:@"customerManagerEnterprise"];
    [dict setObject:[NSNumber numberWithLongLong:datetime] forKey:@"time"];
    [dict setObject:[NSNumber numberWithInt:0] forKey:@"lng"];
    [dict setObject:[NSNumber numberWithInt:0] forKey:@"lat"];
    [dict setObject:@"123" forKey:@"deviceID"];
    [dict setObject:greaterViewController.txtFee.text forKey:@"charge"];
    [dict setObject:greaterViewController.txtGroupId.text forKey:@"groupID"];
    [dict setObject:greaterViewController.btGroupName.titleLabel.text forKey:@"groupName"];
    [dict setObject:greaterViewController.txtGroupNo.text forKey:@"serviceCode"];
    [dict setObject:[NSNumber numberWithInt:[greaterViewController.txtContract.text intValue]] forKey:@"contactPeriod"];
    [dict setObject:greaterViewController.btStartDate.titleLabel.text forKey:@"contactStartDate"];
    [dict setObject:greaterViewController.btEndDate.titleLabel.text forKey:@"contactEndDate"];
    [dict setObject:[NSNumber numberWithInt:greaterViewController.speciaLinePro] forKey:@"specialLinePro"];
    [dict setObject:greaterViewController.speciaLineProText forKey:@"specialLineProText"];

    [dict setObject:[NSNumber numberWithInt:[greaterViewController.txtBroadband.text intValue]] forKey:@"bandWidth"];
    [dict setObject:dateString forKey:@"saveDate"];
    [dict setObject:@"3" forKey:@"bussID"];
    [dict setObject:[NSNumber numberWithBool:NO] forKey:@"upload"];
    
    BOOL flag=[SendBoxHandling setSendMessage:dict dataWithModule:kSendBoxModuleWithGroupBrodadband];
    if(flag){
        [self performSegueWithIdentifier:@"GroupBroadbandSendboxSegue" sender:self];
//        greaterViewController.btGroupName.titleLabel.text=@"请选择";
//        greaterViewController.txtGroupId.text=@"";
//        greaterViewController.txtGroupNo.text=@"";
//        
//        greaterViewController.txtBroadband.text=@"";
//        greaterViewController.txtContract.text=@"";
//        greaterViewController.btStartDate.titleLabel.text=@"请选择";
//        greaterViewController.btEndDate.titleLabel.text=@"请选择";
//        greaterViewController.txtFee.text=@"";
    }
    else{
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"警告" message:@"保存到发件箱失败！" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"关闭", nil];
        alertView.tag=12;
        [alertView show];
    }
}

//{
//    bandWidth = 1000;
//    bussID = 87;
//    charge = "5000.5";
//    contactPeriod = 24;
//    customerManagerEnterprise = 2;
//    "customerManagerId " = 4;
//    dealDate = "<null>";
//    endDate = "2015-10-27";
//    failDesc = "<null>";
//    groupID = 7313A43314;
//    groupName = "\U957f\U6c99\U5e02\U5f00\U798f\U533a\U51ef\U5229\U901a\U8baf\U884c";
//    indbDate = "2014-10-27";
//    serviceCode = 3113102695753873;
//    specialLinePro = "\U4e92\U8054\U7f51";
//    specialLineProID = 1;
//    startDate = "2013-11-27";
//}

-(void)groupBroadbandRenewalViewControllerDidFinished:(GroupBroadbandRenewalViewController *)controller{
    [self createAccountButtonOnclick:nil];
    
//    NSString *groupId=[controller.selectRenewalDict objectForKey:@"groupID"];
//    
//    for (Group *group in self.user.groupInfo) {
//        if([group.groupId isEqualToString:groupId]){
//            selectedGroup=group;
//            break;
//        }
//    }
    
//    [greaterViewController.btGroupName setTitle:selectedGroup.groupName forState:UIControlStateNormal];
//    greaterViewController.txtGroupId.text=selectedGroup.groupId;
//    greaterViewController.txtGroupNo.text=[NSString stringWithFormat:@"%.0f",selectedGroup.groupserviceCode];
    
    [greaterViewController.btGroupName setTitle:[controller.selectRenewalDict objectForKey:@"groupName"] forState:UIControlStateNormal];
    greaterViewController.txtGroupId.text=[controller.selectRenewalDict objectForKey:@"groupID"];
    greaterViewController.txtGroupNo.text=[controller.selectRenewalDict objectForKey:@"serviceCode"];
    
    greaterViewController.txtBroadband.text=[NSString stringWithFormat:@"%d",[[controller.selectRenewalDict objectForKey:@"bandWidth"] intValue]];
    int contactPeriod=[[controller.selectRenewalDict objectForKey:@"contactPeriod"] intValue];
    greaterViewController.txtContract.text=[NSString stringWithFormat:@"%d",contactPeriod];
    
    NSString *edateString=[controller.selectRenewalDict objectForKey:@"endDate"];
    [greaterViewController.btStartDate setTitle:edateString forState:UIControlStateNormal];
    
    if(contactPeriod>0){
        NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *sdate=[dateFormatter dateFromString:edateString];
        
        NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
        [offsetComponents setMonth:contactPeriod];
        NSDate *edate = [gregorian dateByAddingComponents:offsetComponents toDate:sdate options:0];
        NSString *newContactDate=[dateFormatter stringFromDate:edate];
        [greaterViewController.btEndDate setTitle:newContactDate forState:UIControlStateNormal];
    }
    
    int specialLineProID=[[controller.selectRenewalDict objectForKey:@"specialLineProID"] intValue];
    [greaterViewController setBroadbandType:specialLineProID];
    
    greaterViewController.txtFee.text=[NSString stringWithFormat:@"%.2f",[[controller.selectRenewalDict objectForKey:@"charge"] floatValue]];

    
}
@end
