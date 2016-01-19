//
//  AppDelegate.m
//  CMCCMarketing
//
//  Created by talkweb on 14-9-1.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import "AppDelegate.h"
#import "VariableStore.h"

#import "XGPush.h"
#import "XGSetting.h"

#import "NetworkHandling.h"

#define _IPHONE80_ 80000

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    NSLog(@"didFinishLaunchingWithOptions");

    //针对IOS8定位服务
    locationManager = [[CLLocationManager alloc] init];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        //调用了这句,就会弹出允许框了.
        //[locationManager requestWhenInUseAuthorization];
        [locationManager requestAlwaysAuthorization];
    }
      [locationManager startUpdatingLocation];
    
    
    [self performSelector:@selector(registerDefaultsFromSettingsBundle)];
    _mapManager = [[BMKMapManager alloc]init];
    NSString *mapKey;
    
    
    
#ifdef MANAGER_CS_VERSION
    mapKey=@"eGISc1SSkYbTlYzMRa40XsN1";
     [XGPush startApp:2200076715 appKey:@"ITCW22867PYP"];
#endif
    
#ifdef STANDARD_CS_VERSION
    mapKey=@"Q9HBbRLP0kPmMi32UzXmgnYK";
     [XGPush startApp:2200066077 appKey:@"IH62J7EUU57F"];
#endif
    
#ifdef MANAGER_SY_VERSION
    mapKey=@"CjGOUCIRhNWC3heUAEAH27Um";
    [XGPush startApp:2200084433 appKey:@"IL9H9WM141XK"];
#endif
    
#ifdef STANDARD_SY_VERSION
    mapKey=@"b4DPKDzBvTxKVz0yclALdnGy";
    [XGPush startApp:2200084432 appKey:@"IJ67XK41N1PK"];
#endif
    
    BOOL ret = [_mapManager start:mapKey  generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    
    
    
//    [XGPush startApp:2200066077 appKey:@"IH62J7EUU57F"];
    
    //注销之后需要再次注册前的准备
    void (^successCallback)(void) = ^(void){
        //如果变成需要注册状态
        if(![XGPush isUnRegisterStatus])
        {
            //iOS8注册push方法
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= _IPHONE80_
            
            float sysVer = [[[UIDevice currentDevice] systemVersion] floatValue];
            if(sysVer < 8){
                [self registerPush];
            }
            else{
                [self registerPushForIOS8];
            }
#else
            //iOS8之前注册push方法
            //注册Push服务，注册后才能收到推送
            [self registerPush];
#endif
        }
    };
    [XGPush initForReregister:successCallback];
    
    //推送反馈回调版本示例
    void (^successBlock)(void) = ^(void){
        //成功之后的处理
        NSLog(@"[XGPush]handleLaunching's successBlock");
    };
    
    void (^errorBlock)(void) = ^(void){
        //失败之后的处理
        NSLog(@"[XGPush]handleLaunching's errorBlock");
    };
    
    //角标清0
//    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    [XGPush handleLaunching:launchOptions successCallback:successBlock errorCallback:errorBlock];
    if(launchOptions){
        NSLog(@"launch app process...");
        [[NSNotificationCenter defaultCenter] postNotificationName:@"remoteNotification" object:@"launch options"];
//        [UIApplication sharedApplication].applicationIconBadgeNumber++;
    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
     NSLog(@"applicationDidEnterBackground");
//    __block UIBackgroundTaskIdentifier background_task;
//    
//    background_task = [application beginBackgroundTaskWithExpirationHandler:^ {
//        [application endBackgroundTask: background_task];
//        background_task = UIBackgroundTaskInvalid;
//    }];
//    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        while(TRUE)
//        {
//            [NSThread sleepForTimeInterval:1];
//            
//            //编写执行任务代码
//            NSLog(@"background thread...");
//            
//        }
//        
//        [application endBackgroundTask: background_task];
//        background_task = UIBackgroundTaskInvalid;
//    });
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    
    NSLog(@"applicationWillEnterForeground");
    [self startloction];
    
    
    
}
- (void)applicationDidBecomeActive:(UIApplication *)application
{
    
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    NSLog(@"applicationWillTerminate");
}

- (void)application:(UIApplication *)application handleEventsForBackgroundURLSession:(NSString *)identifier
  completionHandler:(void (^)())completionHandler {
    self.backgroundSessionCompletionHandler = completionHandler;
}

-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    //notification是发送推送时传入的字典信息
    [XGPush localNotificationAtFrontEnd:notification userInfoKey:@"clockID" userInfoValue:@"myid"];
    
    //删除推送列表中的这一条
    [XGPush delLocalNotification:notification];
    //[XGPush delLocalNotification:@"clockID" userInfoValue:@"myid"];
    
    //清空推送列表
    //[XGPush clearLocalNotifications];
}

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= _IPHONE80_

//注册UserNotification成功的回调
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    //用户已经允许接收以下类型的推送
    UIUserNotificationType allowedTypes = [notificationSettings types];
    
}

//按钮点击事件回调
- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void (^)())completionHandler{
    if([identifier isEqualToString:@"ACCEPT_IDENTIFIER"]){
        NSLog(@"ACCEPT_IDENTIFIER is clicked");
    }
    
    completionHandler();
}

#endif

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [VariableStore sharedInstance].deviceToken=deviceToken;
    
//    [XGPush setAccount:@"13707318888"];
//    NSString * deviceTokenStr = [XGPush registerDevice:deviceToken];
////    NSString * deviceTokenStr=[[NSString alloc] initWithData:deviceToken encoding:NSUTF8StringEncoding];
//    
//    void (^successBlock)(void) = ^(void){
//        //成功之后的处理
//        NSLog(@"[XGPush]register successBlock ,deviceToken: %@",deviceTokenStr);
//    };
//    
//    void (^errorBlock)(void) = ^(void){
//        //失败之后的处理
//        NSLog(@"[XGPush]register errorBlock");
//    };
//    
//    //注册设备
////    [[XGSetting getInstance] setChannel:@"appstore"];
////    [[XGSetting getInstance] setGameServer:@"巨神峰"];
//    [[XGSetting getInstance] setChannel:@"cmmc"];
//    [[XGSetting getInstance] setGameServer:@"kite"];
//    [XGPush registerDevice:deviceToken successCallback:successBlock errorCallback:errorBlock];
    
    //打印获取的deviceToken的字符串
//    NSLog(@"deviceTokenStr is %@",deviceTokenStr);
}

//如果deviceToken获取不到会进入此事件
- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err {
    
    NSString *str = [NSString stringWithFormat: @"Error: %@",err];
    
    NSLog(@"%@",str);
    
}

- (void)application:(UIApplication*)application didReceiveRemoteNotification:(NSDictionary*)userInfo
{
    NSLog(@"fore process...");
    //推送反馈(app运行时)
    [XGPush handleReceiveNotification:userInfo];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"remoteNotification" object:@"fore process"];
}

//- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler；
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
    NSLog(@"back process...");
    [XGPush handleReceiveNotification:userInfo];
//    NSDictionary *aps=[userInfo objectForKey:@"aps"];
//    NSString *alert=[aps objectForKey:@"alert"];
    NSString *alert=[userInfo objectForKey:@"content"];
    
    NSError *error = nil;
    NSDictionary *alertJson =
    [NSJSONSerialization JSONObjectWithData: [alert dataUsingEncoding:NSUTF8StringEncoding]
                                    options: NSJSONReadingMutableContainers
                                      error: &error];
    if(!alertJson)
        return;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"remoteNotification" object:alertJson];
    

}
- (void)registerPushForIOS8{
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= _IPHONE80_
    
    //Types
    UIUserNotificationType types = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
    
    //Actions
    UIMutableUserNotificationAction *acceptAction = [[UIMutableUserNotificationAction alloc] init];
    
    acceptAction.identifier = @"ACCEPT_IDENTIFIER";
    acceptAction.title = @"Accept";
    
    acceptAction.activationMode = UIUserNotificationActivationModeForeground;
    acceptAction.destructive = NO;
    acceptAction.authenticationRequired = NO;
    
    //Categories
    UIMutableUserNotificationCategory *inviteCategory = [[UIMutableUserNotificationCategory alloc] init];
    
    inviteCategory.identifier = @"INVITE_CATEGORY";
    
    [inviteCategory setActions:@[acceptAction] forContext:UIUserNotificationActionContextDefault];
    
    [inviteCategory setActions:@[acceptAction] forContext:UIUserNotificationActionContextMinimal];
    
    NSSet *categories = [NSSet setWithObjects:inviteCategory, nil];
    
    
    UIUserNotificationSettings *mySettings = [UIUserNotificationSettings settingsForTypes:types categories:categories];
    
    [[UIApplication sharedApplication] registerUserNotificationSettings:mySettings];
    
    
    [[UIApplication sharedApplication] registerForRemoteNotifications];
#endif
}

- (void)registerPush{
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)];
}
- (void)registerDefaultsFromSettingsBundle {
    NSString *settingsBundle = [[NSBundle mainBundle] pathForResource:@"Settings" ofType:@"bundle"];
    if(!settingsBundle) {
        NSLog(@"Could not find Settings.bundle");
        return;
    }
    
    NSDictionary *settings = [NSDictionary dictionaryWithContentsOfFile:[settingsBundle stringByAppendingPathComponent:@"Root.plist"]];
    NSArray *preferences = [settings objectForKey:@"PreferenceSpecifiers"];
    
    NSMutableDictionary *defaultsToRegister = [[NSMutableDictionary alloc] initWithCapacity:[preferences count]];
    for(NSDictionary *prefSpecification in preferences) {
        NSString *key = [prefSpecification objectForKey:@"Key"];
        if(key&&![[NSUserDefaults standardUserDefaults] stringForKey:key]) {
            [defaultsToRegister setObject:[prefSpecification objectForKey:@"DefaultValue"] forKey:key];
            NSLog(@"regist key:%@",key);
        }
    }
    [[NSUserDefaults standardUserDefaults] registerDefaults:defaultsToRegister];
    NSLog(@"Register Defaults From Settings Bundle.");
}

#pragma mark -gps地理位置更新

-(void)startloction{
    bmkgeocodeSearch=[[BMKGeoCodeSearch alloc] init];
    bmkgeocodeSearch.delegate=self;
    bmklocService = [[BMKLocationService alloc]init];
    bmklocService.delegate = self;
    
    [bmklocService startUserLocationService];
    
}

//处理位置坐标更新(2.7sdk方法名)
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    bmklocationUpdatecount++;
    if(bmklocationUpdatecount < 5)
        return;
    
    [bmklocService stopUserLocationService];
    bmklocationUpdatecount=0;
    [VariableStore sharedInstance].coord=userLocation.location.coordinate;
    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    reverseGeocodeSearchOption.reverseGeoPoint = userLocation.location.coordinate;
    
    BOOL flag = [bmkgeocodeSearch reverseGeoCode:reverseGeocodeSearchOption];
    if(flag)
    {
        NSLog(@"进入前台反geo检索发送成功");
    }
    else
    {
        NSLog(@"进入前台反geo检索发送失败");
    }
    
}

-(void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error{
    if (error == BMK_SEARCH_NO_ERROR) {
        //在此处理正常结果
        NSMutableDictionary *paramDict=[NSMutableDictionary dictionary];
        //读取当前登陆名称
        NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
        NSString * loginmobile = [userDefaults stringForKey:@"loginName"];
        if (loginmobile==nil) {
            NSLog(@"登陆电话号码为空");
            return;
        }
        paramDict[@"mobile"]=loginmobile;
        //读取当前详细的地址名称
        NSString *paramAddress =result.address;
        NSLog(@"当前地址信息:%@",result.address);
        paramDict[@"op_address"]=paramAddress;
        if ([paramAddress isEqualToString:@""]) {
            NSLog(@"读取当前详细的地址名称为空");
            return;
        }
        
        [NetworkHandling sendPackageWithUrl:@"login/actSys" sendBody:paramDict processHandler:^(NSDictionary *resultdict, NSError *error) {
           // NSDictionary *dict= [NSDictionary]
            NSString *flag=resultdict[@"flag"];
            if(flag){
                NSLog(@"login/actSys调用成功。。。。");
            }
            else{
                NSLog(@"login/actSys调用失败。。。。");
            }
        }];
        
    }
    else {
        NSLog(@"抱歉，未定位到当前的地址信息");
    }
}


@end
