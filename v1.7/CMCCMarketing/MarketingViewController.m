//
//  MarketingViewController.m
//  CMCCMarketing
//
//  Created by talkweb on 14-9-3.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import "MarketingViewController.h"
#import "MarketingGroupTableViewCell.h"
#import "NetworkHandling.h"
#import "Customer.h"
#import "MarketingCustomersViewController.h"
#import "Group.h"
#import "MarketingGroupCustomersViewController.h"
#import "MarketingCustomersWithSYViewController.h"
#import <MessageUI/MessageUI.h>
#import "CustomerListTableViewController.h"

@interface MarketingViewController ()
<MBProgressHUDDelegate,MFMessageComposeViewControllerDelegate>{
    BOOL hudFlag;
    BOOL validateFlag;
    
//    NSArray *tableArray;
    Customer *customer;
//    NSDictionary *customerDict;
    
    Group *selectedGroup;
    NSArray *groupUserList;
    UIView *thridView;
    UITextField *oldNumber;
    UITextField *newNumber;
    UIButton *sentButton;
    UIButton *hisButton;

}

@end

@implementation MarketingViewController

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
    
    UIImageView *inputImageView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"空白（输入框占位）"]];
    txtQueryContent.leftViewMode=UITextFieldViewModeAlways;
    txtQueryContent.leftView=inputImageView;
    
    if(IOS7)
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"320X64"] forBarMetrics:UIBarMetricsDefault];
    else
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"320X44"] forBarMetrics:UIBarMetricsDefault];
    
    UINavigationBar *navBar=[[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, 320, 64)];
    UINavigationItem *navItem=[[UINavigationItem alloc] initWithTitle:@"精准营销"];

    UIBarButtonItem *leftButton=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回1"] style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    [leftButton setTintColor:[UIColor whiteColor]];
    
    [navItem setLeftBarButtonItem:leftButton];
    [navBar pushNavigationItem:navItem animated:NO];
    
    if(IOS7)
        [navBar setBackgroundImage:[UIImage imageNamed:@"320X64"] forBarMetrics:UIBarMetricsDefault];
    else
        [navBar setBackgroundImage:[UIImage imageNamed:@"320X44"] forBarMetrics:UIBarMetricsDefault];

    [self.view addSubview:navBar];
    
    UIColor * color = [UIColor whiteColor];
    NSDictionary * dict=[NSDictionary dictionaryWithObject:color forKey:UITextAttributeTextColor];
    [navBar setTitleTextAttributes:dict];
    
    individualQueryView.hidden=NO;
    groupQueryTableView.hidden=YES;
    thridView.hidden=YES;
    groupQueryTableView.dataSource=self;
    groupQueryTableView.delegate=self;
//    tableArray=[[NSArray alloc] initWithObjects:@"湖南拓维信息有限公司", @"湖南集成通讯公公司",@"湖南九天工程有限公司",nil];
    
//    txtQueryContent.text=@"18207408116";
    
//    txtQueryContent.text=@"18207391967";
    
    
    //13407391735 个人
    //7313900190 集团
    
    //marketing/grpuserList

//空白（输入框占位）
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
//    NSLog(@"prepare for segue..");
    if([segue.identifier isEqualToString:@"IndividualCustomersSegue"]){
        MarketingCustomersViewController *controller=segue.destinationViewController;
        controller.customer=customer;
//        controller.customerDict=customerDict;
        controller.user=self.user;
        
        controller.dicFlow = self.dicFlow;
        controller.dicTerm = self.dicTerm;
        controller.dicBind = self.dicBind;
        
        
    }
    //GroupCustomersSegue
    if([segue.identifier isEqualToString:@"GroupCustomersSegue"]){
        MarketingGroupCustomersViewController *groupViewController=segue.destinationViewController;
//        groupViewController.group=selectedGroup;
        groupViewController.group=selectedGroup;
        groupViewController.user=self.user;
        
    }
    
    if([segue.identifier isEqualToString:@"customerlistSegue"]){
        CustomerListTableViewController *controller=segue.destinationViewController;
        //        groupViewController.group=selectedGroup;
        controller.recipeOldNum=oldNumber.text;
        controller.recipeNewNum=newNumber.text;
        controller.user=self.user;
        
    }

//    NSLog(@"end prepare for segue");
}

-(void)goBack{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES];
}
- (IBAction)individualCustomersQueryOnclick:(id)sender {
    individualQueryView.hidden=NO;
    groupQueryTableView.hidden=YES;
    [self HidThridViewContronller];
//黄色按钮 灰色按钮
    [individualCustomersQueryButton setBackgroundImage:[UIImage imageNamed:@"switch_chen1"] forState:UIControlStateNormal];
    [thridButton setBackgroundImage:[UIImage imageNamed:@"switch_hui1"] forState:UIControlStateNormal];
    [groupCustomersQueryButton setBackgroundImage:[UIImage imageNamed:@"switch_hui2"] forState:UIControlStateNormal];
    
    [individualCustomersQueryButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
     [thridButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [groupCustomersQueryButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
}

- (IBAction)groupCustomersQueryOnclick:(id)sender {
    individualQueryView.hidden=YES;
    groupQueryTableView.hidden=NO;
   // thridView.hidden=YES;
    [self HidThridViewContronller];
    [individualCustomersQueryButton setBackgroundImage:[UIImage imageNamed:@"switch_hui1"] forState:UIControlStateNormal];
     [thridButton setBackgroundImage:[UIImage imageNamed:@"switch_hui1"] forState:UIControlStateNormal];
    [groupCustomersQueryButton setBackgroundImage:[UIImage imageNamed:@"switch_chen2"] forState:UIControlStateNormal];
    
    [individualCustomersQueryButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
     [thridButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [groupCustomersQueryButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}
- (IBAction)ThridButtonOnclick:(id)sender {
    individualQueryView.hidden=YES;
    groupQueryTableView.hidden=YES;
    thridView.hidden=NO;
    [individualCustomersQueryButton setBackgroundImage:[UIImage imageNamed:@"switch_hui1"] forState:UIControlStateNormal];
    [groupCustomersQueryButton setBackgroundImage:[UIImage imageNamed:@"switch_hui1"] forState:UIControlStateNormal];
    [thridButton setBackgroundImage:[UIImage imageNamed:@"switch_chen2"] forState:UIControlStateNormal];
    
       
    [individualCustomersQueryButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [groupCustomersQueryButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [thridButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self SetThridView];
}
-(void)HidThridViewContronller{
    oldNumber.hidden=YES;
      newNumber.hidden=YES;
      sentButton.hidden=YES;
      hisButton.hidden=YES;
    
}
-(void)SetThridView{
    
    oldNumber=[[UITextField alloc]initWithFrame:CGRectMake(42, 136, 237, 40)];
    oldNumber.placeholder=@"请输入原异网号码";
    
    oldNumber.font=[UIFont systemFontOfSize:14];
    oldNumber.textAlignment=NSTextAlignmentCenter;
     oldNumber.keyboardType=UIKeyboardTypeNumberPad;
    [oldNumber setBackground:[UIImage imageNamed:@"查询框.png"]];
//    oldNumber.layer.cornerRadius=8.0f;
//    oldNumber.layer.masksToBounds=YES;
   //oldNumber.layer.borderWidth = 0.5f;
  // oldNumber.layer.borderColor= [[UIColor blackColor]CGColor];
    //[thridView addSubview: oldNumber];
   newNumber=[[UITextField alloc]initWithFrame:CGRectMake(42, 186, 237, 40)];
    newNumber.placeholder=@"输入新移动号码";
     newNumber.font=[UIFont systemFontOfSize:14];
    newNumber.textAlignment=NSTextAlignmentCenter;
    newNumber.keyboardType=UIKeyboardTypeNumberPad;
    [newNumber setBackground:[UIImage imageNamed:@"查询框.png"]];
    
    sentButton=[[UIButton alloc]initWithFrame:CGRectMake(42, 236, 110, 30)];
    [sentButton setBackgroundImage:[UIImage imageNamed:@"蓝色按钮-平面.png"] forState:UIControlStateNormal];
  //  UIButton *addButtonView=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
        [sentButton addTarget:self action:@selector(SendMessage) forControlEvents:UIControlEventTouchUpInside];
        // NSString *remindString=@"填写未在列表的陪同人员";
        [sentButton setTitle:@"发送" forState:UIControlStateNormal];
        [sentButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    hisButton=[[UIButton alloc]initWithFrame:CGRectMake(167, 236, 110, 30)];
    [hisButton setBackgroundImage:[UIImage imageNamed:@"蓝色按钮-平面.png"] forState:UIControlStateNormal];
    //  UIButton *addButtonView=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    [hisButton addTarget:self action:@selector(goHisRecode) forControlEvents:UIControlEventTouchUpInside];
    // NSString *remindString=@"填写未在列表的陪同人员";
    [hisButton setTitle:@"历史记录" forState:UIControlStateNormal];
    [hisButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    //thridView=[[UIView alloc]initWithFrame:CGRectMake(0, 121, 320, 200)];

    [self.view addSubview:oldNumber];
    [self.view addSubview:newNumber];
    [self.view addSubview:sentButton];
    [self.view addSubview:hisButton];

}
#pragma mark  查看历史记录
-(void)goHisRecode{
    [self performSegueWithIdentifier:@"customerlistSegue" sender:self];
    //[self performSegueWithIdentifier:@"IndividualCustomersSegue" sender:self];
}
#pragma mark  发送短信
-(void)SendMessage{
    Class messageClass = (NSClassFromString(@"MFMessageComposeViewController"));
    
    if (messageClass != nil) {
        // Check whether the current device is configured for sending SMS messages
        if ([messageClass canSendText]) {
            [self displaySMSComposerSheet];
        }
        else {
            UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"设备没有短信功能" delegate:nil cancelButtonTitle:nil  otherButtonTitles:@"确定", nil];
            [myAlertView show];
            
        }
    }
    else {
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"iOS版本过低,iOS4.0以上才支持程序内发送短信" delegate:nil cancelButtonTitle:nil  otherButtonTitles:@"确定", nil];
        [myAlertView show];
    }
}
-(void)displaySMSComposerSheet{
    MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
    picker.messageComposeDelegate = self;
    
  NSMutableArray  *sendcontactArray=[[NSMutableArray alloc] init];
    
    [picker setEditing:YES];
    
    [sendcontactArray addObject:@"10086122"];
    // SString *string = [array componentsJoinedByString:@","];
    //联系人的电话
    picker.recipients=sendcontactArray;
    // NSString *cname=[VariableStore getCustomerManagerName];
    //发送的内容
    picker.body=[NSString stringWithFormat:@"%@#%@",oldNumber.text,newNumber.text];
    
    validateFlag=YES;
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"正在组织短信发送数据...";
    [HUD showWhileExecuting:@selector(idleForSegue) onTarget:self withObject:nil animated:YES];
    
    [self presentViewController:picker animated:YES completion:^{
        validateFlag=NO;
    }];
}

-(void)idleForSegue{
    while (validateFlag) {
        usleep(100000);
    }
}
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller
                 didFinishWithResult:(MessageComposeResult)result {
    UIAlertView *myAlertView;
    switch (result)
    {
        case MessageComposeResultCancelled:
            NSLog(@"Result: SMS sending canceled");
            break;
        case MessageComposeResultSent:
            NSLog(@"Result: SMS sent");
            [self SetSvcodeFlag];
            break;
        case MessageComposeResultFailed:
            myAlertView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"短信发送失败!" delegate:nil cancelButtonTitle:nil  otherButtonTitles:@"关闭", nil];
            [myAlertView show];
            break;
        default:
            NSLog(@"Result: SMS not sent");
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 上传电话号码状态
-(void)SetSvcodeFlag{
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
    [bDict setObject:[NSNumber numberWithInt:self.user.userID] forKey:@"user_id"];
   
    
    [bDict setObject:oldNumber.text forKey:@"diff_svc_code"];
     [bDict setObject:newNumber.text forKey:@"svc_code"];
    
    [NetworkHandling sendPackageWithUrl:@"marketing/inserdiffinfo" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        if(!error){
            NSLog(@"sign in success");
            //tableviewArray =[result objectForKey:@"smsuser"];
            
            //刷新表格，插入一条判别选中cell的数据
            //            for (id object in tableviewArray) {
            //
            //                [object setValue:@"NO" forKey:@"checked"];
            //            }
            
            // [self performSelectorOnMainThread:@selector(goShowMessage) withObject:nil waitUntilDone:YES];
            
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
-(void)goShowMessage{
    NSLog(@"send message success");
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.user.groupInfo count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SettingTableViewCell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    MarketingGroupTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MarketingGroupTableViewCell"];
    Group *group=[self.user.groupInfo objectAtIndex:indexPath.row];
    cell.itemName.text = group.groupName;

    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    selectedGroup=[self.user.groupInfo objectAtIndex:indexPath.row];

    [self performSegueWithIdentifier:@"GroupCustomersSegue" sender:self];
}
- (IBAction)IndividualCustomersQuery:(id)sender {
    
//    hudFlag=YES;
//    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
//    [self.view addSubview:HUD];
//    HUD.delegate=self;
//    HUD.labelText=@"数据查询中，请稍后...";
//    [HUD showWhileExecuting:@selector(requestCustomerQuery) onTarget:self withObject:nil animated:YES];

    [txtQueryContent endEditing:YES];
    
    hudFlag=YES;
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"数据查询中，请稍后...";
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
    [self requestCustomerQuery];
}
-(void)connectToNetwork{
    while (hudFlag) {
//        usleep(100000);
        sleep(1);
    }
}

-(void)requestCustomerQuery{
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    [bDict setValue:txtQueryContent.text forKeyPath:@"svc_code"];
    
    [NetworkHandling sendPackageWithUrl:@"marketing/userList" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        if(!error){
            NSLog(@"sign in success");
            NSDictionary *customerObject=[result objectForKey:@"user"];
            
            if(!customerObject || (NSNull*)customerObject == [NSNull null]){
//                NSLog(@"error:%d info:%@",errorCode,errorInfo);
                NSString *errorInfo=@"查询的用户不存在！";
                [self performSelectorOnMainThread:@selector(showMessage:) withObject:errorInfo waitUntilDone:YES];
            }
            else{
                customer=[[Customer alloc] initWithDictionary:customerObject];

                NSArray *aryFlow = [result objectForKey:@"flow"];
                if (aryFlow && aryFlow.count > 0) {
                    
                    self.dicFlow = [aryFlow objectAtIndex:0];
                }else{
                    ;
                    
                }
                
                NSArray *aryTerm = [result objectForKey:@"term"];
                if (aryTerm && aryTerm.count > 0) {
                    
                    self.dicTerm = [aryTerm objectAtIndex:0];
                }else{
                    ;
                    
                }
                
                NSArray *aryBind = [result objectForKey:@"bind"];
                if (aryBind && aryBind.count > 0) {
                    
                    self.dicBind = [aryBind objectAtIndex:0];
                }else{
                    ;
                    
                }
                
                
                [self performSelectorOnMainThread:@selector(goIndividualCustomer) withObject:nil waitUntilDone:NO];
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
        hudFlag=NO;
    }];
}
-(void)goIndividualCustomer{
    
    
#if (defined MANAGER_CS_VERSION) || (defined STANDARD_CS_VERSION)
[self performSegueWithIdentifier:@"IndividualCustomersSegue" sender:self];
#endif
  
#if (defined MANAGER_SY_VERSION)|| (defined STANDARD_SY_VERSION)
    MarketingCustomersWithSYViewController *controller=[[MarketingCustomersWithSYViewController alloc] initWithNibName:@"MarketingCustomersWithSYViewController" bundle:nil];
    controller.customer=customer;
    controller.user=self.user;
    
    controller.dicFlow = self.dicFlow;
    controller.dicTerm = self.dicTerm;
    controller.dicBind = self.dicBind;
    
    [self.navigationController pushViewController:controller animated:YES];
#endif
}
-(void)showMessage:(NSString*)infomation{
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"信息提示" message:infomation delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
    [myAlertView show];
}

-(void)hudWasHidden:(MBProgressHUD *)hud{
    [hud removeFromSuperview];
    hud=nil;
}

@end
