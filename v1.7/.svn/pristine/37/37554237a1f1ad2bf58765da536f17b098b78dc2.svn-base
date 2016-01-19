//
//  CustomerManagerBodyViewController.m
//  CMCCMarketing
//
//  Created by talkweb on 14-9-22.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import "CustomerManagerBodyViewController.h"
#import "CustomerManagerBaseInfoViewController.h"
#import "CustomerManagerContactsViewController.h"
#import "CustomerManagerMapViewController.h"
#import "CustomerManagerContactsDetailsViewController.h"
#import "CustomerManagerContactsEditViewController.h"
#import "W_VisitPlanAddSelectAddressController.h"
#import "AddLittleGrounpViewController.h"
#import "AddSigleLittleGrounpViewController.h"
#import "CustomerManagerGroupContactVerifyViewController.h"
#import "VerifyAddressViewController.h"
#import "ContrantListTableViewController.h"

#define BODY_VIEW_SIZE_WIDTH 320
#define BODY_VIEW_SIZE_HEIGHT 367
#define BODY_VIEW_SIZE_HEIGHT_FULL 455

#import "MBProgressHUD.h"
#import "NetworkHandling.h"

@interface CustomerManagerBodyViewController ()<MBProgressHUDDelegate,CustomerManagerContactsViewControllerDelegate,W_VisitPlanAddSelectAddressControllerDelegate,CustomerManagerContactsDetailsViewControllerDelegate,CustomerManagerBaseInfoViewControllerDelegate>{
    CustomerManagerBaseInfoViewController *baseInforViewController;
    CustomerManagerContactsViewController *contactsViewController;
    CustomerManagerMapViewController *mapViewController;
    NSString *manOrGrounp;
    BOOL hubFlag;
  NSArray *userListtableArray;
    NSDictionary *selectContactsDict;
    NSDictionary *editContactDict;
    NSMutableDictionary *selectBaseInfo;
}

@end

@implementation CustomerManagerBodyViewController

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
    
    
//listTyp为邵阳端使用判别为集团信息还是渠道信息
    
    CustomerManager *selectCustomerManager;
    if(self.group && self.listType == 0){
        for (CustomerManager *customerManager in self.user.customerManagerInfo) {
            for (Group *g in customerManager.groupList) {
                if([g.groupId isEqualToString:self.group.groupId]){
                    selectCustomerManager=customerManager;
                    break;
                }
            }
        }
    }
    
    baseInforViewController=[[self storyboard] instantiateViewControllerWithIdentifier:@"CustomerManagerBaseInfoId"];
    contactsViewController=[[self storyboard] instantiateViewControllerWithIdentifier:@"CustomerManagerContactsId"];
    mapViewController=[[self storyboard] instantiateViewControllerWithIdentifier:@"CustomerManagerMapId"];
    //listTyp为邵阳端使用判别为集团信息还是渠道信息
    baseInforViewController.listType=self.listType;
    mapViewController.listType=self.listType;
    contactsViewController.listType=self.listType;
    if(self.listType == 0){
        
        baseInforViewController.group=self.group;
        baseInforViewController.customerManager=selectCustomerManager;
        /**
         *  设置CustomerManagerBaseInfoViewController的代理方法(否则不调用CustomerManagerBaseInforDidfinished方法)必须写在该位置
         */
        baseInforViewController.baseInfodelegate=self;
        contactsViewController.delegate=self;
        contactsViewController.user=self.user;
        mapViewController.group=self.group;
        mapViewController.user=self.user;
    }
    else if(self.listType == 1){
        baseInforViewController.customerManager=selectCustomerManager;
         baseInforViewController.channels=self.channels;
        contactsViewController.delegate=self;
        contactsViewController.user=self.user;
        mapViewController.group=self.group;
        mapViewController.user=self.user;
        mapViewController.channels=self.channels;
       
        [contactButton setTitle:@"渠道老板" forState:UIControlStateNormal];
    }
    else if(self.listType == 2){
        //中小集团
        baseInforViewController.customerManager=selectCustomerManager;
         baseInforViewController.littleDict=self.reDict;
        contactsViewController.delegate=self;
        contactsViewController.user=self.user;
        mapViewController.group=self.group;
        mapViewController.user=self.user;
        mapViewController.littleDict=self.reDict;
      
        [contactButton setTitle:@"关键人" forState:UIControlStateNormal];
        #if (defined MANAGER_CS_VERSION) 
        if([[self.reDict objectForKey:@"state"] isEqualToString:@"0" ]){
           
        UIBarButtonItem *rightButton=[[UIBarButtonItem alloc]initWithTitle:@"审核" style:UIBarButtonItemStylePlain target:self action:@selector(goCheckLittleGrounp)];
        [rightButton setTintColor:[UIColor whiteColor]];
        [self.navigationItem setRightBarButtonItem:rightButton];
             }
      #endif
        
#if (defined STANDARD_CS_VERSION)
        //设置编辑按钮
        UIBarButtonItem *rightButton=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"编辑1"] style:UIBarButtonItemStylePlain target:self action:@selector(goEditLittleGrounp)];
        [rightButton setTintColor:[UIColor whiteColor]];
        
        [self.navigationItem setRightBarButtonItem:rightButton];
#endif

        
    }

    
    [bodyView addSubview:baseInforViewController.view];
    if(IS_IPHONE4)
        baseInforViewController.view.frame=CGRectMake(0, 0,BODY_VIEW_SIZE_WIDTH,BODY_VIEW_SIZE_HEIGHT);
    else
        baseInforViewController.view.frame=CGRectMake(0, 0,BODY_VIEW_SIZE_WIDTH,BODY_VIEW_SIZE_HEIGHT_FULL);
    [bodyView addSubview:contactsViewController.view];
    contactsViewController.view.frame=baseInforViewController.view.frame;
    [bodyView addSubview:mapViewController.view];
    mapViewController.view.frame=baseInforViewController.view.frame;
    
    [bodyView bringSubviewToFront:baseInforViewController.view];
    
//#if (defined STANDARD_CS_VERSION) || (defined STANDARD_SY_VERSION)
//    [self addBarButtonWithAddCustomer]
//#endif
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    editContactDict=nil;
    
    hubFlag=YES;
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"数据查询中，请稍后...";
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
    
    if (self.listType == 0) {
        [self loadGroupInfoListData];
    }
    else if(self.listType == 1){
        [self loadChnInfoListData];
    }
    else if(self.listType == 2){
        [self loadLittleListData];
    }

}
-(void)connectToNetwork{
    while (hubFlag) {
        usleep(100000);
    }
}
-(void)addBarButtonWithAddCustomer{
    UIBarButtonItem *rightButton=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"加号"] style:UIBarButtonItemStylePlain target:self action:@selector(goEdit)];
    [rightButton setTintColor:[UIColor whiteColor]];
    [self.navigationItem setRightBarButtonItem:rightButton];
}

-(void)loadLittleListData{
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    [bDict setObject:[self.reDict objectForKey:@"grp_code"] forKey:@"grp_code"];
    [NetworkHandling sendPackageWithUrl:@"msgrpuserlink/getUserInfoList" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        if(!error){
          
            contactsViewController.userList=[result objectForKey:@"Response"];
            userListtableArray=[result objectForKey:@"Response"];
            [self performSelectorOnMainThread:@selector(refreshContactsViewControllerTableView) withObject:nil waitUntilDone:YES];
          
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
-(void)loadGroupInfoListData{
    
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    [bDict setObject:self.group.groupId forKey:@"grp_code"];
    [bDict setObject:[NSNumber numberWithInt:self.user.userEnterprise] forKey:@"enterprise"];
    
    [NetworkHandling sendPackageWithUrl:@"grpuserlink/getUserInfoList" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        if(!error){
             userListtableArray=[result objectForKey:@"Response"];
            contactsViewController.userList=[result objectForKey:@"Response"];
            //            [contactsViewController refreshTableView];
            [self performSelectorOnMainThread:@selector(refreshContactsViewControllerTableView) withObject:nil waitUntilDone:YES];
            //            [self performSelectorOnMainThread:@selector(refreshRemindButton) withObject:nil waitUntilDone:YES];
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

//“grp_code”:集团编码  [必传参数],
//“enterprise”:企业编码  [必传参数]
//“user_info”:联系人姓名或者手机号码
-(void)loadChnInfoListData{
  
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    [bDict setObject:self.channels.chnl_code forKey:@"chnl_code"];
    [bDict setObject:[NSNumber numberWithInt:self.user.userEnterprise] forKey:@"enterprise"];
    
    [NetworkHandling sendPackageWithUrl:@"grpuserlink/getChnlBossInfoList" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        if(!error){
             userListtableArray=[result objectForKey:@"Response"];
            contactsViewController.userList=[result objectForKey:@"Response"];
            [self performSelectorOnMainThread:@selector(refreshContactsViewControllerTableView) withObject:nil waitUntilDone:YES];
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
//{
//    chinamobile = "";
//    depart = "";
//    flag = 1;
//    "is_birthday_remind" = 0;
//    "is_diff_key" = "";
//    "is_first" = "";
//    job = "";
//    "key_type" = "";
//    linkman = "-1";
//    "linkman_birthday" = "";
//    "linkman_msisdn" = "-1";
//    "linkman_sex" = 0;
//    "linkman_tel" = "";
//    "linkman_tel_bak" = "";
//    remark = "";
//    "row_id" = "-999";
//    userimg = "";
//    "vip_mngr_msisdn" = 15073111492;
//    "vip_mngr_name" = "\U5f90\U9759";
//}
-(void)refreshContactsViewControllerTableView{
    [contactsViewController refreshTableView];
}
-(void)showMessage:(NSString*)infomation{
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"信息提示" message:infomation delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
    [myAlertView show];
}
-(void)hudWasHidden:(MBProgressHUD *)hud{
    [hud removeFromSuperview];
    hud=nil;
}

-(void)goEdit{
    if (self.listType == 2) {
    [self performSegueWithIdentifier:@"AddLittleGrounpsegue" sender:self];
       
    }
    else{
        [self performSegueWithIdentifier:@"CustomerManagerContactsEditId" sender:self];
    }
    
}
-(void)goEditLittleGrounp{
   [self performSegueWithIdentifier:@"editLittleGrounpsegue" sender:self];
}
-(void)goCheckLittleGrounp{
    /**
     *  审核中小集团
     */
    manOrGrounp=@"grounp";
    [self performSegueWithIdentifier:@"checkLittleGrounp" sender:self];
}
-(void)goCheckLittleGrounpPostion{
    /**
     *  审核中小集团的位置，共用之前的接口
     */
   
    [self performSegueWithIdentifier:@"checkLittleGrounpPostionsegue" sender:self];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)customerManagerContactsViewControllerDidfinished:(NSDictionary *)contactsDict{
     if (self.listType==2) {
        if ([[contactsDict objectForKey:@"state"] isEqualToString:@"0"]) {
            #if (defined STANDARD_CS_VERSION)
            selectContactsDict=contactsDict;
            [self performSegueWithIdentifier:@"CustomerManagerContactsDetailsSegue" sender:self];
          #endif
              #if (defined MANAGER_CS_VERSION)
            manOrGrounp=@"man";
            selectContactsDict=contactsDict;
            [self performSegueWithIdentifier:@"checkLittleGrounp" sender:self];
            #endif
//            cell.wheterCheck.text=@"待审核";
        }
        else{
            selectContactsDict=contactsDict;
            [self performSegueWithIdentifier:@"CustomerManagerContactsDetailsSegue" sender:self];
        }
               
    } else {
        selectContactsDict=contactsDict;
        [self performSegueWithIdentifier:@"CustomerManagerContactsDetailsSegue" sender:self];
    }

    
}
-(void)CustomerManagerBaseInforDidfinished:(NSMutableDictionary *)baseInfoDict{
    
       selectBaseInfo = baseInfoDict;
    [self performSegueWithIdentifier:@"ContrantListSegue" sender:self];
  

}
-(void)customerManagerContactsDetailsViewGoEdit:(NSDictionary *)contactDict{
    
    editContactDict = contactDict;
    [self performSegueWithIdentifier:@"CustomerManagerContactsEditId" sender:self];
}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"CustomerManagerContactsDetailsSegue"]){
        CustomerManagerContactsDetailsViewController *controller=segue.destinationViewController;
        controller.contactsDict = selectContactsDict;
        controller.user = self.user;
        controller.channels = self.channels;
        controller.group = self.group;
        controller.listType = self.listType;
        controller.delegate = self;
    }
    if([segue.identifier isEqualToString:@"CustomerManagerContactsEditId"]){
        CustomerManagerContactsEditViewController *controler=segue.destinationViewController;
        controler.user=self.user;
        controler.group=self.group;
        controler.channels = self.channels;
        controler.listType = self.listType;
        if(!editContactDict){
            controler.isEdit=NO;
        }
        else{
            controler.isEdit = YES;
            controler.contactDict=editContactDict;
            [controler setEditData];
        }
            
    }
    if([segue.identifier isEqualToString:@"AddLittleGrounpsegue"]){
        AddLittleGrounpViewController *controler=segue.destinationViewController;
       controler.user=self.user;
     controler.listType = self.listType;
        controler.whereFrom=8;
        controler.Dict=self.reDict;
    }
    
    if([segue.identifier isEqualToString:@"editLittleGrounpsegue"]){
        AddSigleLittleGrounpViewController *controler=segue.destinationViewController;
        controler.user=self.user;
        controler.listType = self.listType;
        controler.whereFrom=8;
        controler.Dict=self.reDict;
    }
    if([segue.identifier isEqualToString:@"checkLittleGrounp"]){
        CustomerManagerGroupContactVerifyViewController *controler=segue.destinationViewController;
        controler.user=self.user;
      controler.listType = self.listType;
        if ([manOrGrounp isEqualToString:@"man"]) {
            controler.msgDict=selectContactsDict;
        }
        if ([manOrGrounp isEqualToString:@"grounp"]) {
            controler.msgDict=self.reDict;
        }
        controler.whichtype=manOrGrounp;
           }
    if ([segue.identifier isEqualToString:@"checkLittleGrounpPostionsegue"]) {
        VerifyAddressViewController *controler=segue.destinationViewController;
         controler.user=self.user;
        controler.addrmsgDict=self.reDict;
    }
   if ([segue.identifier isEqualToString:@"ContrantListSegue"]) {
       ContrantListTableViewController *controler=segue.destinationViewController;
//       controller.contactsDict = selectContactsDict;
//       controller.user = self.user;
     controler.group = self.group;
       controler.rDcit = selectBaseInfo;
       
//       controller.listType = self.listType;
      //controller.bas = self;
    }

}

- (IBAction)baseInfoButtonOnclick:(id)sender {
    [baseInformationButton setBackgroundImage:[UIImage imageNamed:@"按钮带框"] forState:UIControlStateNormal];
    [contactButton setBackgroundImage:[UIImage imageNamed:@"按钮框（无）"] forState:UIControlStateNormal];
    [mapButton setBackgroundImage:[UIImage imageNamed:@"按钮框（无）"] forState:UIControlStateNormal];
    
    [bodyView bringSubviewToFront:baseInforViewController.view];
    if (self.listType==2) {
#if (defined MANAGER_CS_VERSION)
        if([[self.reDict objectForKey:@"state"] isEqualToString:@"0" ]){
            
            UIBarButtonItem *rightButton=[[UIBarButtonItem alloc]initWithTitle:@"审核" style:UIBarButtonItemStylePlain target:self action:@selector(goCheckLittleGrounp)];
            [rightButton setTintColor:[UIColor whiteColor]];
            [self.navigationItem setRightBarButtonItem:rightButton];
        }

#endif
        
#if (defined STANDARD_CS_VERSION)
        //设置编辑按钮
        UIBarButtonItem *rightButton=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"编辑1"] style:UIBarButtonItemStylePlain target:self action:@selector(goEditLittleGrounp)];
        [rightButton setTintColor:[UIColor whiteColor]];
        
        [self.navigationItem setRightBarButtonItem:rightButton];
#endif

    } else {
         [self removeRightBarItem];
    }
   
}

- (IBAction)contactsButtonOnclick:(id)sender {
    //无联系人时
    if ([userListtableArray count] ==0) {
        MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
        
        [self.view addSubview:HUD];
        
        HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
        
        HUD.mode = MBProgressHUDModeCustomView;
        
        HUD.delegate = self;
        
        HUD.labelText = @"暂无联系人！";
        
        [HUD show:YES];
        
        [HUD hide:YES afterDelay:2];
    }

    [baseInformationButton setBackgroundImage:[UIImage imageNamed:@"按钮框（无）"] forState:UIControlStateNormal];
    [contactButton setBackgroundImage:[UIImage imageNamed:@"按钮带框"] forState:UIControlStateNormal];
    [mapButton setBackgroundImage:[UIImage imageNamed:@"按钮框（无）"] forState:UIControlStateNormal];
    
    [bodyView bringSubviewToFront:contactsViewController.view];
    [self removeRightBarItem];
    
#if (defined STANDARD_CS_VERSION) || (defined STANDARD_SY_VERSION)
    [self addBarButtonWithAddCustomer];
#endif
    

}

- (IBAction)mapButtonOnclick:(id)sender {
    //先消除
    [self removeRightBarItem];
        [baseInformationButton setBackgroundImage:[UIImage imageNamed:@"按钮框（无）"] forState:UIControlStateNormal];
    [contactButton setBackgroundImage:[UIImage imageNamed:@"按钮框（无）"] forState:UIControlStateNormal];
    [mapButton setBackgroundImage:[UIImage imageNamed:@"按钮带框"] forState:UIControlStateNormal];
    
    [bodyView bringSubviewToFront:mapViewController.view];
    if (self.listType==2) {
#if (defined MANAGER_CS_VERSION)
        if([[self.reDict objectForKey:@"flag"] isEqualToString:@"0" ]){
            UIBarButtonItem *rightButton=[[UIBarButtonItem alloc]initWithTitle:@"审核" style:UIBarButtonItemStylePlain target:self action:@selector(goCheckLittleGrounpPostion)];
            [rightButton setTintColor:[UIColor whiteColor]];
            [self.navigationItem setRightBarButtonItem:rightButton];
        }
#endif
        
        
    } else {
        [self removeRightBarItem];
    }
    

    
    
#if (defined STANDARD_CS_VERSION) || (defined STANDARD_SY_VERSION)
    [self addRightBarItem];
#endif
    
    switch (mapViewController.addressType) {
        case 1:
            [self submitFinished:@"该位置来自上一次提交位置"];
            break;
        case 2:
            [self submitFinished:@"该位置来自百度定位"];
            break;
        case 3:
            [self submitFinished:@"该位置来自手机GPS定位！"];
            break;
        case 4:
            [self submitFinished:@"检索地理位置失败！"];
            break;
        default:
            break;
    }
    
}

-(void)addRightBarItem{
    UIBarButtonItem *rightButton=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"坐标灰点"] style:UIBarButtonItemStylePlain target:self action:@selector(goEditUserLocation)];
    [rightButton setTintColor:[UIColor whiteColor]];
    
    [self.navigationItem setRightBarButtonItem:rightButton];
}
-(void)removeRightBarItem{
    [self.navigationItem setRightBarButtonItem:nil];
}
-(void)goEditUserLocation{
    W_VisitPlanAddSelectAddressController *controller = [[W_VisitPlanAddSelectAddressController alloc] initWithNibName:@"W_VisitPlanAddSelectAddressController" bundle:nil];
    controller.user = self.user;
    controller.group=self.group;
    controller.rDict=_reDict;
    controller.listType=self.listType;
    controller.delegate=self;
    
#if (defined MANAGER_CS_VERSION) || (defined STANDARD_CS_VERSION)
    controller.layoutSearchBar=YES;
#endif
    
    [self.navigationController pushViewController:controller animated:YES];
}
-(void)w_visitPlanAddSelectAddressControllerDidFinished:(CLLocationCoordinate2D)coord selectWithAddress:(NSString *)address{

//    NSLog(@"address:%@",address);
    
//    self.group.groupAddress=address;
//    self.group.groupLatitude=coord.latitude;
//    self.group.groupLongitude=coord.longitude;
//    self.group.groupBaiduLatitude=coord.latitude;
//    self.group.groupBaiduLongitude=coord.longitude;
//    
//    [baseInforViewController refreshViewData];
    
    [self submitLocation:coord withAddress:address];
}

//-(void)customerManagerMapViewControllerDidSubmitSuccess:(CLLocationCoordinate2D)coordinate withAddress:(NSString *)address{
//    
//    self.group.groupAddress=address;
//    self.group.groupLatitude=coordinate.latitude;
//    self.group.groupLongitude=coordinate.longitude;
//    self.group.groupBaiduLatitude=coordinate.latitude;
//    self.group.groupBaiduLongitude=coordinate.longitude;
//    
//    [baseInforViewController refreshViewData];
//}

- (void)submitLocation:(CLLocationCoordinate2D)coordinate withAddress:(NSString*)address{
    
    hubFlag=YES;
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"正提交位置信息，请稍后...";
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
    
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    if (self.listType==2) {
        [bDict setValue:[_reDict objectForKey:@"grp_code"] forKey:@"grp_code"];
        
    } else {
        [bDict setValue:self.group.groupId forKey:@"grp_code"];
        
    }
    
    [bDict setValue:[NSNumber numberWithInt:self.user.userEnterprise] forKey:@"enterprise"];
    [bDict setValue:[NSNumber numberWithDouble:coordinate.longitude] forKey:@"longtitude"];
    [bDict setValue:[NSNumber numberWithDouble:coordinate.latitude] forKey:@"latitude"];
    [bDict setValue:[NSNumber numberWithDouble:coordinate.longitude] forKey:@"baidu_longtitude"];
    [bDict setValue:[NSNumber numberWithDouble:coordinate.latitude] forKey:@"baidu_latitude"];
    [bDict setValue:address forKey:@"address"];
    [bDict setValue:[NSNumber numberWithInt:self.user.userID] forKey:@"user_id"];
    [bDict setValue:self.user.userName forKey:@"user_name"];
    [bDict setValue:self.user.userMobile forKey:@"mobile"];
    [bDict setValue:@"ios" forKey:@"client_os"];
    
    [NetworkHandling sendPackageWithUrl:@"grpuserlink/labelGrpAdd" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        BOOL flag=[[result objectForKey:@"flag"] boolValue];
        if(!error && flag){
            NSLog(@"sign in success");
            [self performSelectorOnMainThread:@selector(submitSuccess:) withObject:bDict waitUntilDone:YES];
        }
        else{
            int errorCode=[[result valueForKey:@"errorcode"] intValue];
            NSString *errorInfo=[result valueForKey:@"errorinf"];
            NSLog(@"error:%d info:%@",errorCode,errorInfo);
            if(!errorInfo || errorInfo.length < 1)
                errorInfo=@"位置信息提交失败！";
            [self performSelectorOnMainThread:@selector(submitFinished:) withObject:errorInfo waitUntilDone:YES];
        }
        hubFlag=NO;
    }];
}
-(void)submitSuccess:(NSDictionary*)dict{
    [self submitFinished:@"位置信息提交成功！"];
    
//    CLLocationCoordinate2D coord;
//    coord.latitude=[[dict objectForKey:@"latitude"] doubleValue];
//    coord.longitude=[[dict objectForKey:@"longtitude"] doubleValue];
//    
//      self.group.groupAddress=[dict objectForKey:@"address"];
//    self.group.groupLatitude=coord.latitude;
//    self.group.groupLongitude=coord.longitude;
//    self.group.groupBaiduLatitude=coord.latitude;
//    self.group.groupBaiduLongitude=coord.longitude;
//
//    [mapViewController refreshUserLocaton];
    [mapViewController forBackMap:dict];
    [baseInforViewController refreshViewData];
}
-(void)submitFinished:(NSString*)msg{
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.delegate = self;
    HUD.labelText = msg;
    [HUD show:YES];
    [HUD hide:YES afterDelay:1];
}
@end
