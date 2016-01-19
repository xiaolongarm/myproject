//
//  SettingViewController.m
//  CMCCMarketing
//
//  Created by talkweb on 14-9-4.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingTableViewCell.h"

#import "SettingCommentsAndFeedbackViewController.h"
#import "MBProgressHUD.h"
#import "NetworkHandling.h"
#import "SettingPasswordViewController.h"
#import "SettingHelpTableViewController.h"
#import "SettingInformationViewController.h"
#import <MessageUI/MessageUI.h>
@interface SettingViewController ()<UIAlertViewDelegate,MBProgressHUDDelegate,UIAlertViewDelegate,SettingInformationViewControllerDelegate,MFMessageComposeViewControllerDelegate>{
    NSArray *tableArray;
    BOOL hubFlag;
    BOOL validateFlag;
    NSString *updateUrl;
  
}

@end

@implementation SettingViewController

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
    if(IOS7)
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"320X64"] forBarMetrics:UIBarMetricsDefault];
    else
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"320X44"] forBarMetrics:UIBarMetricsDefault];
    
    UINavigationBar *navBar=[[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, 320, 64)];
    UINavigationItem *navItem=[[UINavigationItem alloc] initWithTitle:@"设置"];
    
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
    
    tableview.delegate=self;
    tableview.dataSource=self;
    
    tableArray=[[NSArray alloc] initWithObjects:@"个人信息",@"我的收藏",@"邀请同事",@"修改密码",@"帮助",@"检查新版本",@"意见与反馈", nil];
//     tableArray=[[NSArray alloc] initWithObjects:@"个人信息",@"新消息提醒",@"帮助",@"检查新版本",@"意见与反馈", nil];
    
    if(self.goInformation)
        [self performSegueWithIdentifier:@"settingInformationSegue"sender:self];
}
-(void)goBack{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES];
}
-(void)viewWillDisappear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)loginOut:(id)sender {
    UIAlertView *alertview=[[UIAlertView alloc] initWithTitle:@"警 告" message:@"您确定要退出登录吗？" delegate:self cancelButtonTitle:@"取 消" otherButtonTitles:@"确 定", nil];
    alertview.tag=10;
    [alertview show];
    
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(alertView.tag == 10 && buttonIndex == 1)
//        [self.presentingViewController.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    
    //删除了tipsViewController
    [self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    
    if(alertView.tag == 20 && buttonIndex == 1){
        
        NSLog(@"current is sure to update app...");
        NSString *urlString=@"itms-services://?action=download-manifest&url=";
        urlString=[urlString stringByAppendingString:updateUrl];
        NSLog(@"open url:%@",urlString);
        NSURL *url=[NSURL URLWithString:urlString];
        [[UIApplication sharedApplication] openURL:url];
    }
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"settingInformationSegue"]){
        SettingInformationViewController *controller =segue.destinationViewController;
        controller.user=self.user;
        controller.delegate=self;
    }
    if([segue.identifier isEqualToString:@"settingCommAndFeedbackSegue"]){
        SettingCommentsAndFeedbackViewController *controller=segue.destinationViewController;
        controller.user=self.user;
    }
    if([segue.identifier isEqualToString:@"SettingPasswordSegue"]){
        SettingPasswordViewController *controller=segue.destinationViewController;
        controller.user=self.user;
    }
    if([segue.identifier isEqualToString:@"SettingHelpTableSegue"]){
        SettingHelpTableViewController *controller=segue.destinationViewController;
        controller.user=self.user;
    }
    if([segue.identifier isEqualToString:@"collectknownledgeSegue"]){
        SettingHelpTableViewController *controller=segue.destinationViewController;
        controller.user=self.user;
    }

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
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SettingTableViewCell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    SettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SettingTableViewCell"];
    
    cell.itemName.text = [tableArray objectAtIndex:indexPath.row];
    NSString *imageName=[NSString stringWithFormat:@"设置（首页-图标%d）",indexPath.row+1];
    cell.itemImage.image = [UIImage imageNamed:imageName];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        [self performSegueWithIdentifier:@"settingInformationSegue"sender:self];
    }
    if(indexPath.row ==1){
        [self performSegueWithIdentifier:@"collectknownledgeSegue"sender:self];
    }

     if(indexPath.row == 2){
         [self sendMessageToFriend];
     }
    if(indexPath.row == 3){
        [self performSegueWithIdentifier:@"SettingPasswordSegue" sender:self];
    }
    if(indexPath.row == 4){
        [self performSegueWithIdentifier:@"SettingHelpTableSegue" sender:self];
    }
    if(indexPath.row == 5){
        hubFlag=YES;
        MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:HUD];
        HUD.delegate=self;
        HUD.labelText=@"正在检查新版本...";
        [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
        [self checkUpdate];
    }
    if(indexPath.row == 6){
        [self performSegueWithIdentifier:@"settingCommAndFeedbackSegue" sender:self];
    }
}
#pragma mark  发送短信
-(void)sendMessageToFriend{

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
        
      //  NSMutableArray  *sendcontactArray=[[NSMutableArray alloc] init];
        
        [picker setEditing:YES];
        
      //  [sendcontactArray addObject:@"10086122"];
        // SString *string = [array componentsJoinedByString:@","];
        //联系人的电话
        //picker.recipients=sendcontactArray;
        // NSString *cname=[VariableStore getCustomerManagerName];
        //发送的内容
        picker.body=[NSString stringWithFormat:@"最近我安装了一线营销工具,它带有客户拜访管理、工作日志、精准营销、客户预警等。让我联系和管理客户方便多了，您也来试试吧！安卓下载地址：安卓客户经理端 http://111.22.14.166:8080/kite/load/kite-manager-mobile_v1.0.0_zipalign.apk 安卓客户主管端 http://111.22.14.166:8080/kite/load/kite-manager-mobile_v1.0.0_zipalign.apk 苹果下载地址： https://mpc.mtalkweb.com/marketing/cs/ "];
        
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
            //[self SetSvcodeFlag];
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

-(void)checkUpdate{
    
    updateUrl=[NetworkHandling getUpdateUrl];
    
//    https://mpc.mtalkweb.com/marketing/cs/
    
#ifdef MANAGER_CS_VERSION
    updateUrl=[updateUrl stringByAppendingString:@"cs/marketing-pro.plist"];
#endif
    
    
#ifdef STANDARD_CS_VERSION
    updateUrl=[updateUrl stringByAppendingString:@"cs/marketing.plist"];
#endif
    
#ifdef MANAGER_SY_VERSION
    updateUrl=[updateUrl stringByAppendingString:@"sy/marketing-pro.plist"];
#endif
    
    
#ifdef STANDARD_SY_VERSION
    updateUrl=[updateUrl stringByAppendingString:@"sy/marketing.plist"];
#endif
    
//    updateUrl=[updateUrl stringByAppendingString:@"PadConferenceSystem.plist"];
    NSLog(@"request url:%@",updateUrl);
    NSURL *url=[NSURL URLWithString:updateUrl];
    NSData *plistData=[NSData dataWithContentsOfURL:url];
    if(!plistData){
//        isRequestUpdate=NO;
        NSLog(@"request update plist is error...");
        hubFlag=NO;
        
        MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:HUD];
        HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
        HUD.mode = MBProgressHUDModeCustomView;
        HUD.delegate = self;
        HUD.labelText = @"请确定服务器连接是否正常！";
        [HUD show:YES];
        [HUD hide:YES afterDelay:2];
        
        return;
    }
    //获取应用程序沙盒的Documents目录
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,NSUserDomainMask,YES);
    NSString *plistPath1 = [paths objectAtIndex:0];
    
    //得到完整的文件名
    NSString *filename=[plistPath1 stringByAppendingPathComponent:@"v.plist"];
    //输入写入
    [plistData writeToFile:filename atomically:YES];
    NSDictionary *data1 = [[NSDictionary alloc] initWithContentsOfFile:filename];
    NSLog(@"%@", data1);
    
    NSArray *items=[data1 objectForKey:@"items"];
    NSDictionary *itemsDict=[items objectAtIndex:0];
    NSDictionary *metadata=[itemsDict objectForKey:@"metadata"];
    NSString *serverBundleVersionString=[metadata objectForKey:@"bundle-version"];
    NSLog(@"server version %@",serverBundleVersionString);
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *buildVersionString = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSLog(@"Local device app version is %@",buildVersionString);
    if(![serverBundleVersionString isEqualToString:buildVersionString]){
        NSLog(@"Is not exist new version for the app now...");
        
        UIAlertView *alertview=[[UIAlertView alloc] initWithTitle:@"更新提示" message:@"当前检测到一个应用更新,开始更新应用吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alertview.tag=20;
        [alertview show];
        
    }
    else{
        MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:HUD];
        HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
        HUD.mode = MBProgressHUDModeCustomView;
        HUD.delegate = self;
        HUD.labelText = @"您当前使用的是最新版本。";
        [HUD show:YES];
        [HUD hide:YES afterDelay:2];

    }

    hubFlag=NO;
}
-(void)hudWasHidden:(MBProgressHUD *)hud{
    [hud removeFromSuperview];
    hud=nil;
}
-(void)connectToNetwork{
    while (hubFlag) {
        usleep(100000);
    }
}
-(void)updatePersonImageDidFinished{
    [self.delegate settingViewControllerUpdatePersonImageDidFinished];
}

@end
