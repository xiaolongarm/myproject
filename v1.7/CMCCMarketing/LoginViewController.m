//
//  LoginViewController.m
//  CMCCMarketing
//
//  Created by talkweb on 14-9-1.
//  Copyright (c) 2014年 talkweb. All rights reserved.
// -fno-objc-arc

#import "LoginViewController.h"
#import "NetworkHandling.h"
#import "SVHTTPClient.h"
#import "Base64codeFunc.h"
#import "TipsViewController.h"
#import "SendBoxHandling.h"
#import "VariableStore.h"
#import "MainViewController.h"
#import "XGPush.h"
#import "XGSetting.h"
#import "DocumentHandling.h"
#import "BMKLocationService.h"
#import "KeyboardExtendHandling.h"
#import "SDiPhoneVersion.h"

@implementation UIView (FindFirstResponder)

@end

@interface LoginViewController ()<UIAlertViewDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>{
    NSDictionary *loginPackage;
    BOOL validateFlag;
    NSString *updateUrl;
    
    BMKLocationService *_locService;
    BMKGeoCodeSearch *geoSearch;
    BOOL hubFlag;
    KeyboardExtendHandling *keyboardExtendhandling;
}

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self checkUpdate];
    

    
    // Do any additional setup after loading the view.
    UIImageView *userImageView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"登录头像图标_14"]];
    txtUserName.leftViewMode=UITextFieldViewModeAlways;
    txtUserName.leftView=userImageView;
    
    UIImageView *passImageView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"登录锁图标_13"]];
    txtPassword.leftViewMode=UITextFieldViewModeAlways;
    txtPassword.leftView=passImageView;
    keyboardExtendhandling=[[KeyboardExtendHandling alloc]initKeyboardHangling:self.view];
    
//#if (defined MANAGER_CS_VERSION) || (defined MANAGER_SY_VERSION)
////    //公司服务器
//    txtUserName.text=@"13467657275";
//    txtPassword.text=@"111111";
//    
//    //长沙移动服务器
//    //13407313106
////    txtUserName.text=@"15308482995";
////    txtPassword.text=@"111111";
//    
//    //邵阳服务器
//    //18207391967
////    txtUserName.text=@"15308482995";
////    txtPassword.text=@"111111";
//    
////    主管端：13467657275 密码：111111
////    经理端：13973177816 密码：111111
//    
//#endif
//    
////#ifdef STANDARD_CS_VERSION
//    #if (defined STANDARD_CS_VERSION) || (defined STANDARD_SY_VERSION)
////    //公司服务器 13973177816 15073111492
//    txtUserName.text=@"13973177816";
//    //Ab123456 111111
//    txtPassword.text=@"111111";
//    
//    //长沙移动服务器
//    //15073111287 13973177816
////    txtUserName.text=@"13973177816";
////    txtPassword.text=@"111111";
//    
//    //邵阳服务器
//    //13517428473
////    txtUserName.text=@"13973177816";
////    txtPassword.text=@"111111";
//    
//#endif
    
 

    
    //登录背景.png 邵阳－登陆页 邵阳－登陆页（营销经理端）.png 邵阳－登陆页（主管端）.png
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *buildVersionString = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    
    lbVersion.text=[NSString stringWithFormat:@"-v%@",buildVersionString];
#ifdef MANAGER_SY_VERSION
    lbTitle.text=@"和营销 (主管端)";
#endif
    
   
#ifdef STANDARD_SY_VERSION
    lbTitle.text=@"和营销 (营销经理端)";
#endif
    
    
    
    
   // validateFlag=YES;
    
    txtUserName.delegate=self;
    txtPassword.delegate=self;
    
    //默认自动登录有效
//    btAutoLogin.selected=YES;
    [btAutoLogin setBackgroundImage:[UIImage imageNamed:@"勾选"] forState:UIControlStateSelected];
    [btAutoLogin setBackgroundImage:[UIImage imageNamed:@"未勾选"] forState:UIControlStateNormal];
    NSDictionary *userDict=[DocumentHandling readUser];
    
    txtUserName.text = [userDict objectForKey:@"name"];
    txtPassword.text = [userDict objectForKey:@"pass"];
    BOOL isAuto = [[userDict objectForKey:@"isauto"] boolValue];
    
    btAutoLogin.selected=isAuto;
    NSLog(@"%@ login autoLogin is :%@",txtUserName.text,isAuto?@"YES":@"NO");
    
    if(btAutoLogin.selected){
        [self loginButtonOnclick:nil];
    }
    
    [VariableStore sharedInstance].city = [userDict objectForKey:@"city"];
    [VariableStore sharedInstance].coord = CLLocationCoordinate2DMake([[userDict objectForKey:@"latitude"] doubleValue], [[userDict objectForKey:@"longitude"] doubleValue]);

    if(![VariableStore sharedInstance].city || [VariableStore sharedInstance].city.length < 1){
        
        // cy 111.471874,27.236554 长沙 112.998325,28.213987
        
#if (defined MANAGER_CS_VERSION) || (defined STANDARD_CS_VERSION)
       [VariableStore sharedInstance].city=@"长沙";
        [VariableStore sharedInstance].coord = CLLocationCoordinate2DMake(28.213987, 112.998325);
#endif

#if (defined MANAGER_SY_VERSION)|| (defined STANDARD_SY_VERSION)
       [VariableStore sharedInstance].city=@"邵阳";
        [VariableStore sharedInstance].coord = CLLocationCoordinate2DMake(27.236554, 111.471874);
#endif
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSDictionary *userDict=[loginPackage objectForKey:@"Response"];
    User *userObject=[[User alloc] initWithDictionary:userDict];

    if([segue.identifier isEqualToString:@"loginSegue"]){
        btLoginButton.enabled=YES;
        TipsViewController *controller=segue.destinationViewController;
                controller.user=userObject;
    }
    if([segue.identifier isEqualToString:@"loginToMainSegue"]){
        btLoginButton.enabled=YES;
        MainViewController *controller=[segue destinationViewController];
        controller.user=userObject;
    }
}
- (IBAction)loginButtonOnclick:(id)sender {
    
     validateFlag=YES;
    btLoginButton.enabled=NO;
    
    if(![NetworkHandling GetCurrentNet]){
        MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:HUD];
        HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
        HUD.mode = MBProgressHUDModeCustomView;
        HUD.delegate = self;
        HUD.labelText = @"当前没有检测到网络连接，无法登录！";
        [HUD show:YES];
        [HUD hide:YES afterDelay:3];
        btLoginButton.enabled=YES;
        return;
    }
    
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"正在登录，请您稍后...";
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
    
    [self validateIdentity:sender];
    //btLoginButton.enabled=YES;
}
-(void)connectToNetwork{
    while (validateFlag) {
       usleep(100000);
   //     sleep(2);
    }
    
}

//13508476471 Ab123456
-(void)validateIdentity:(id)sender{
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    
    [bDict setValue:txtUserName.text forKey:@"mobile"];
    NSString *pass=[Base64codeFunc md5:txtPassword.text];
    [bDict setValue:pass forKey:@"password"];
    [bDict setValue:[[UIDevice currentDevice].identifierForVendor UUIDString] forKey:@"deviceID"];
    
    //    {"iosId":"设备序列号","brand":"apple","model":"iphone几","sdk":"nil","appVersion":"CFBundleShortVersionString","release":"CFBundleVersion"}
    NSMutableDictionary *deviceDict=[NSMutableDictionary new];
    //设备的UUID
    NSString* iosIdparam =[[UIDevice currentDevice].identifierForVendor UUIDString];
    [deviceDict setObject:iosIdparam forKey:@"iosId"];
    //设备的厂商
    [deviceDict setObject:@"apple" forKey:@"brand"];
    //当前为iphone型号model
    NSString *modelparam=@"iphone";
    modelparam =[self getAppleDeviceName];
  //  DeviceVersion version= [SDiPhoneVersion deviceVersion];
//        switch (version) {
//            case iPhone4:
//                modelparam=@"iPhone4";
//                break;
//            case iPhone4S:
//                modelparam=@"iPhone4S";
//                break;
//            case iPhone5:
//                modelparam=@"iPhone5";
//                break;
//            case iPhone5S:
//                modelparam=@"iPhone5S";
//                break;
//            case iPhone6:
//                modelparam=@"iPhone6";
//                break;
//            case iPhone6Plus:
//                modelparam=@"iPhone6Plus";
//                break;
//            case Simulator:
//                modelparam=@"Simulator";
//                break;
//
//            default:
//                break;
//        }
    NSLog(@"iphone 的型号：%@",modelparam);
    [deviceDict setObject:modelparam forKey:@"model"];
    //sdk版本
    [deviceDict setObject:@"" forKey:@"sdk"];
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    //app版本号
    NSString *appVersionparam = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    [deviceDict setObject:appVersionparam forKey:@"appVersion"];
    // app build版本
    NSString *appBuildparam = [infoDictionary objectForKey:@"CFBundleVersion"];
    [deviceDict setObject:appBuildparam forKey:@"release"];
    
    
    [bDict setObject:deviceDict forKey:@"deviceInfo"];
#if (defined MANAGER_CS_VERSION) || (defined MANAGER_SY_VERSION)
         [bDict setValue:@"1" forKey:@"client"];
#endif

#if (defined STANDARD_CS_VERSION) || (defined STANDARD_SY_VERSION)
         [bDict setValue:@"0" forKey:@"client"];
#endif
    [bDict setValue:@"ios" forKey:@"OS"];
    
    [NetworkHandling sendPackageWithUrl:@"login/Login" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        NSDictionary *resultDict=[result valueForKey:@"Response"];
        validateFlag=NO;
        if(!error && resultDict){
            loginPackage=result;
            [self performSelectorOnMainThread:@selector(goOn:) withObject:sender waitUntilDone:YES];
        }
        else{
            NSString *errorinf=[result objectForKey:@"errorinf"];
            if(!errorinf)
                errorinf=@"登录失败，请联系管理员！";
            [self performSelectorOnMainThread:@selector(showErrorMessage:) withObject:errorinf waitUntilDone:YES];
                   }
    }];
    
}
-(void)goOn:(id)sender{
    NSUserDefaults * userDefaults= [NSUserDefaults  standardUserDefaults];
    [userDefaults setObject:txtUserName.text forKey:@"loginName"];
    //[userDefaults setObject:self.loginPass.text forKey:@"userPass"];
    [userDefaults synchronize];
    

#if (defined STANDARD_CS_VERSION) || (defined STANDARD_SY_VERSION)

    NSDictionary *userDict=[loginPackage objectForKey:@"Response"];
    BOOL gps_sta = [[userDict objectForKey:@"gps_sta"] boolValue];
    [VariableStore sharedInstance].isStopGPSReport=gps_sta?NO:YES;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)),dispatch_get_global_queue(0, 0), ^{
        if([VariableStore sharedInstance].isStopGPSReport)
            return;
        
        if(![VariableStore sharedInstance].locationDataAcquisition){
            [VariableStore sharedInstance].locationDataAcquisition=[[LocationDataAcquisition alloc] init];
        }
        
        NSDictionary *userDict=[loginPackage objectForKey:@"Response"];
        User *userObject=[[User alloc] initWithDictionary:userDict];
        [VariableStore sharedInstance].locationDataAcquisition.user=userObject;
        [[VariableStore sharedInstance].locationDataAcquisition startLocationDataAcquisition];
    });

    
#endif
    [self registerXG];
    
    [DocumentHandling writeUser:txtUserName.text withPass:txtPassword.text withFlag:btAutoLogin.selected];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        hubFlag=YES;
        MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:HUD];
        HUD.delegate=self;
        HUD.labelText=@"正在获取位置信息，请稍后...";
        [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];

    dispatch_async(dispatch_get_main_queue(), ^{
            [self performSegueWithIdentifier:@"loginToMainSegue" sender:self];
        });
    });
}
-(void)registerXG{
    if(![VariableStore sharedInstance].deviceToken)
        return;
    [XGPush setAccount:txtUserName.text];
    NSString * deviceTokenStr = [XGPush registerDevice:[VariableStore sharedInstance].deviceToken];
    
    void (^successBlock)(void) = ^(void){
        //成功之后的处理
        NSLog(@"[XGPush]register successBlock ,deviceToken: %@",deviceTokenStr);
    };
    
    void (^errorBlock)(void) = ^(void){
        //失败之后的处理
        NSLog(@"[XGPush]register errorBlock");
    };
    
    [[XGSetting getInstance] setChannel:@"cmmc"];
    [[XGSetting getInstance] setGameServer:@"kite"];
    [XGPush registerDevice:[VariableStore sharedInstance].deviceToken successCallback:successBlock errorCallback:errorBlock];
}
-(void)showErrorMessage:(NSString*)msg{
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.delegate = self;
    HUD.labelText=msg;
    [HUD show:YES];
    [HUD hide:YES afterDelay:3];
    //当登陆失败时，登陆button为可点击状态
    btLoginButton.enabled=YES;

    
}
-(void)hudWasHidden:(MBProgressHUD *)hud{
    [hud removeFromSuperview];
    hud = nil;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    [self loginButtonOnclick:nil];
    return YES;
}

-(void)checkUpdate{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        updateUrl=[NetworkHandling getUpdateUrl];

        
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
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertView *alertview=[[UIAlertView alloc] initWithTitle:@"更新提示" message:@"当前检测到一个应用更新,开始更新应用吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                alertview.tag=20;
                [alertview show];
            });
        }
    });
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(alertView.tag == 20 && buttonIndex == 1){
        
        NSLog(@"current is sure to update app...");
        NSString *urlString=@"itms-services://?action=download-manifest&url=";
        urlString=[urlString stringByAppendingString:updateUrl];
        NSLog(@"open url:%@",urlString);
        NSURL *url=[NSURL URLWithString:urlString];
        [[UIApplication sharedApplication] openURL:url];
    }
}
- (IBAction)autoLoginSetting:(id)sender {
    UIButton *button = sender;
    if(button.selected)
        button.selected=NO;
    else
        button.selected=YES;
}

-(NSString*)getAppleDeviceName
{
    NSString *deviceString;
    // Check for iphone model
//    iPhone4 = 3,
//    iPhone4S = 4,
//    iPhone5 = 5,
//    iPhone5C = 6,
//    iPhone5S = 7,
//    iPhone6 = 8,
//    iPhone6Plus = 9,
    if ([SDiPhoneVersion deviceVersion] == iPhone4)
    {
        NSLog(@"You got the new iPhone4 Nice!");
        deviceString=@"iPhone4";
    }
    
   else if ([SDiPhoneVersion deviceVersion] == iPhone4S)
    {
        NSLog(@"You got the new iPhone4S Nice!");
        deviceString=@"iPhone4S";
    }
   else if ([SDiPhoneVersion deviceVersion] == iPhone5)
    {
        NSLog(@"You got the new iPhone5 Nice!");
        deviceString=@"iPhone5";
    }
   else if ([SDiPhoneVersion deviceVersion] == iPhone5C)
    {
        NSLog(@"You got the new iPhone5C Nice!");
        deviceString=@"iPhone5C";
    }
   else if ([SDiPhoneVersion deviceVersion] == iPhone5S)
    {
        NSLog(@"You got the new iPhone5S Nice!");
        deviceString=@"iPhone5S";
    }
   else if ([SDiPhoneVersion deviceVersion] == iPhone6)
    {
        NSLog(@"You got the new iPhone6 Nice!");
        deviceString=@"iPhone6";
    }
   else if ([SDiPhoneVersion deviceVersion] == iPhone6Plus)
    {
        NSLog(@"You got the new iPhone6Plus Nice!");
        deviceString=@"iPhone6Plus";
    }
    // Check for ipad model
//    iPad1 = 10,
//    iPad2 = 11,
//    iPadMini = 12,
//    iPad3 = 13,
//    iPad4 = 14,
//    iPadAir = 15,
//    iPadMini2 = 16,
//    iPadAir2 = 17,
//    iPadMini3 = 18,
    if ([SDiPhoneVersion deviceVersion] == iPad1)
    {
        NSLog(@"You got the new iPad1 Nice!");
        deviceString=@"iPad1";
    }
    
    else if ([SDiPhoneVersion deviceVersion] == iPad2)
    {
        NSLog(@"You got the new iPad2 Nice!");
        deviceString=@"iPad2";
    }
    else if ([SDiPhoneVersion deviceVersion] == iPadMini)
    {
        NSLog(@"You got the new iPadMini Nice!");
        deviceString=@"iPadMini";
    }
    else if ([SDiPhoneVersion deviceVersion] == iPad3)
    {
        NSLog(@"You got the new iPad3 Nice!");
        deviceString=@"iPad3";
    }
    else if ([SDiPhoneVersion deviceVersion] == iPad4)
    {
        NSLog(@"You got the new iPad4 Nice!");
        deviceString=@"iPad4";
    }
    else if ([SDiPhoneVersion deviceVersion] == iPadAir)
    {
        NSLog(@"You got the new iPadAir Nice!");
        deviceString=@"iPadAir";
    }
    else if ([SDiPhoneVersion deviceVersion] == iPadMini2)
    {
        NSLog(@"You got the new iPadMini2 Nice!");
        deviceString=@"iPadMini2";
    }
    else if ([SDiPhoneVersion deviceVersion] == iPadAir2)
    {
        NSLog(@"You got the new iPadAir2 Nice!");
        deviceString=@"iPadAir2";
    }
    else if ([SDiPhoneVersion deviceVersion] == iPadMini3)
    {
        NSLog(@"You got the new iPadMini3 Nice!");
        deviceString=@"iPadMini3";
    }
    // Check for Simulator
//    Simulator = 0
    if ([SDiPhoneVersion deviceVersion] == Simulator) {
        NSLog(@"You got the new Simulator Nice!");
        deviceString=@"Simulator";
    }
    return deviceString;
}

@end
