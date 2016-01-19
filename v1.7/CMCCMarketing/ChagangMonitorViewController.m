//
//  ChagangMonitorViewController.m
//  CMCCMarketing
//
//  Created by talkweb on 14-12-19.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import "ChagangMonitorViewController.h"
#import "MBProgressHUD.h"
#import "NetworkHandling.h"
#import "ChagangMonitorStaffListTableViewController.h"
#import "ChagangMonitorFloatTagViewController.h"
#import "PreferentialPurchaseSelectDateTimeViewController.h"

//#import "MyAnimatedAnnotationView.h"
#import "SignAnnotationView.h"
#import "SignAnnotation.h"
#import "LocusAnnotation.h"
#import "LocusAnnotationView.h"
#import "SignInAnnotation.h"
#import "SignInAnnotationView.h"
#import "ChagangMonitorHelpViewController.h"
#import "ChagangMonitorWarningAreaInformationViewController.h"
#import "ChagangMonitorWarningAreaAllUserTableViewController.h"
#import "VariableStore.h"
#import "UIImageView+WebCache.h"

@interface ChagangMonitorViewController ()<MBProgressHUDDelegate,ChagangMonitorStaffListTableViewControllerDelegate,PreferentialPurchaseSelectDateTimeViewControllerDelegate,ChagangMonitorHelpViewControllerDelegate,ChagangMonitorWarningAreaInformationViewControllerDelegate>{
    
    BOOL hubFlag;
    
    NSString *city;
    NSString *systemTime;
    NSArray *staffList;
    
    ChagangMonitorStaffListTableViewController *staffListViewContoller;
    UIView *staffListBackgroundView;
    ChagangMonitorFloatTagViewController *floatTagViewController;
    
    PreferentialPurchaseSelectDateTimeViewController *selectDateTimeViewController;
    UIView *backView;
    
    NSDate *selectDate;
    
    ChagangMonitorHelpViewController *helpViewController;
    ChagangMonitorWarningAreaInformationViewController *informationViewController;

}

@end

@implementation ChagangMonitorViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    if(IOS7)
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"320X64"] forBarMetrics:UIBarMetricsDefault];
    else
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"320X44"] forBarMetrics:UIBarMetricsDefault];
    
    UIBarButtonItem *leftButton=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回1"] style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    [leftButton setTintColor:[UIColor whiteColor]];
    
    UIBarButtonItem *rightButton=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"人员头像－多个"] style:UIBarButtonItemStylePlain target:self action:@selector(showList)];
    [rightButton setTintColor:[UIColor whiteColor]];
    
    [self.navigationItem setLeftBarButtonItem:leftButton];
    [self.navigationItem setRightBarButtonItem:rightButton];
    UIColor * color = [UIColor whiteColor];
    NSDictionary * dict=[NSDictionary dictionaryWithObject:color forKey:UITextAttributeTextColor];
    [self.navigationController.navigationBar setTitleTextAttributes:dict];

    mapview.delegate=self;
    mapview.centerCoordinate=[VariableStore sharedInstance].coord;
    mapview.zoomLevel=13;
    
    lbTime.layer.cornerRadius=5;
    lbTime.layer.masksToBounds=YES;

    selectDate=[NSDate date];
    
    hubFlag=YES;
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"数据查询中，请稍后...";
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
    [self loadTasksData];
}

-(void)connectToNetwork{
    while (hubFlag) {
        usleep(100000);
    }
}
-(void)loadTasksData{
    
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    [bDict setObject:[NSNumber numberWithInt:self.user.userID] forKey:@"userID"];
    [bDict setObject:[NSNumber numberWithInt:self.user.userEnterprise] forKey:@"enterprise"];
    
    [NetworkHandling sendPackageWithUrl:@"monitor/LeaderPostMonitor" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        if(!error){
            NSLog(@"sign in success");
            NSDictionary *tmpDict=[result objectForKey:@"Response"];
            city=[tmpDict objectForKey:@"city"];
            systemTime=[tmpDict objectForKey:@"systemTime"];
            staffList=[tmpDict objectForKey:@"detail"];
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
#pragma mark - 查询用户轨迹信息
-(void)loadUserLocusDataWithUserId:(int)userId searchDate:(NSString*)date{
    
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    [bDict setObject:[NSNumber numberWithInt:self.user.userID] forKey:@"userID"];
    [bDict setObject:[NSNumber numberWithInt:self.user.userEnterprise] forKey:@"enterprise"];
//    “searchUserID”:搜索下级用户ID,
//    “searchDate”: 搜索日期(yyyy-MM-dd)
    [bDict setObject:[NSNumber numberWithInt:userId] forKey:@"searchUserID"];
    [bDict setObject:date forKey:@"searchDate"];

    [NetworkHandling sendPackageWithUrl:@"monitor/PostMonitorDetil" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        if(!error){
            NSLog(@"sign in success");
            [self performSelectorOnMainThread:@selector(refreshUserLocus:) withObject:[result objectForKey:@"Response"] waitUntilDone:YES];
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
    //draw location
    for (NSDictionary *dict in staffList) {
        NSString *latitude=[dict objectForKey:@"offsetLatitude"];
        NSString *longtitude=[dict objectForKey:@"offsetLongtitude"];
        if((NSNull*)longtitude != [NSNull null] && (NSNull*)latitude != [NSNull null]){
            CLLocationCoordinate2D coor;
            coor.latitude = latitude.doubleValue;
            coor.longitude = longtitude.doubleValue;
            
            SignAnnotation *signAnnotation = [[SignAnnotation alloc]init];
            signAnnotation.coordinate = coor;
            signAnnotation.userDict=dict;
            [mapview addAnnotation:signAnnotation];
        }
    }
    
    //
    if(!staffList || [staffList count]<1)
        return;
    
    staffListViewContoller=[self.storyboard instantiateViewControllerWithIdentifier:@"ChagangMonitorStaffListTableViewControllerId"];
    NSMutableArray *tmpArray=[[NSMutableArray alloc] initWithArray:staffList];
    NSMutableDictionary *dict=[[NSMutableDictionary alloc] initWithDictionary:[staffList objectAtIndex:0]];
    [dict setObject:[NSNumber numberWithInt:-999] forKey:@"userID"];
    [dict setObject:@"全部成员" forKey:@"userName"];
    [tmpArray insertObject:dict atIndex:0];
    staffListViewContoller.staffList=tmpArray;
    staffListViewContoller.user=self.user;
    
    CGFloat h = [UIScreen mainScreen].bounds.size.height;
    CGFloat w = [UIScreen mainScreen].bounds.size.width;

    staffListViewContoller.view.frame=CGRectMake(w-200, 64, 200, h-64-60);
    
    //添加一个背景图片
    staffListBackgroundView=[[UIView alloc] init];
    staffListBackgroundView.frame=CGRectMake(w-120, 64, 120, h-64);
    staffListBackgroundView.backgroundColor=[UIColor darkGrayColor];
    [self.view addSubview:staffListBackgroundView];

    [self.view addSubview:staffListViewContoller.view];
    staffListViewContoller.view.hidden=YES;
    staffListViewContoller.delegate=self;
    staffListBackgroundView.hidden=YES;

    //---------添加帮助按钮－－－－－－－－
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"查看图标帮助" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
    button.titleLabel.font = [UIFont systemFontOfSize:12];
//    [button setImage:[UIImage imageNamed:@"图示说明"] forState:UIControlStateNormal];
    button.frame=CGRectMake(20,h-64-30, 100, 30);
    [staffListBackgroundView addSubview:button];
    [button addTarget:self action:@selector(showHelpWindow) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *iiv=[[UIImageView alloc] init];
    iiv.image=[UIImage imageNamed:@"图示说明"];
    iiv.frame=CGRectMake(5, h-64-22, 15, 15);
    [staffListBackgroundView addSubview:iiv];
    
    //---------添加查看所有消息按钮－－－－－－－－
    UIButton *button2=[UIButton buttonWithType:UIButtonTypeCustom];
    [button2 setTitle:@"所有预警信息" forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
    button2.titleLabel.font = [UIFont systemFontOfSize:12];
    //    [button setImage:[UIImage imageNamed:@"图示说明"] forState:UIControlStateNormal];
    button2.frame=CGRectMake(20,h-64-50, 100, 30);
    [staffListBackgroundView addSubview:button2];
    [button2 addTarget:self action:@selector(showAllWarningList) forControlEvents:UIControlEventTouchUpInside];
       UIImageView *iiv2=[[UIImageView alloc] init];
    iiv2.image=[UIImage imageNamed:@"信封"];
    iiv2.frame=CGRectMake(5, h-64-43, 15, 15);
    [staffListBackgroundView addSubview:iiv2];
    
    //长沙主管时屏蔽改按钮
#if (defined MANAGER_CS_VERSION)
    iiv2.hidden =YES;
    button2.hidden = YES;
#endif
    

    
    floatTagViewController=[self.storyboard instantiateViewControllerWithIdentifier:@"ChagangMonitorFloatTagViewControllerId"];
    floatTagViewController.view.frame=CGRectMake(5, 69, 100, 160);
    [self.view addSubview:floatTagViewController.view];
    [floatTagViewController.flowTagCalendarButton addTarget:self action:@selector(flowTagCalendarButtonOnclick:) forControlEvents:UIControlEventTouchUpInside];
    floatTagViewController.view.hidden=YES;
    [self updateTitleTime];
}
-(void)updateTitleTime{
    NSDate *now=[NSDate date];
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *nowTimeString=[dateFormatter stringFromDate:now];
    lbTime.text=[NSString stringWithFormat:@"更新时间：%@",nowTimeString];
    lbTime.hidden=NO;
    floatTagViewController.timeDate.text=nowTimeString;
}

-(void)showMessage:(NSString*)infomation{
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"信息提示" message:infomation delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
    [myAlertView show];
}
-(void)showHelpWindow{
    if(helpViewController)
        return;
    
    CGFloat h = [UIScreen mainScreen].bounds.size.height;
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    
    helpViewController=[self.storyboard instantiateViewControllerWithIdentifier:@"ChagangMonitorHelpViewController"];
    helpViewController.delegate=self;
    helpViewController.view.frame=CGRectMake((w-300)/2, (h-200)/2, 300, 200);
    helpViewController.view.layer.masksToBounds=YES;
    helpViewController.view.layer.cornerRadius=5.f;
    [self.view addSubview:helpViewController.view];
}
-(void)showAllWarningList{
    [self performSegueWithIdentifier:@"ChagangMonitorWarningAreaAllUserSegue" sender:self];
}
-(void)chagangMonitorHelpViewControllerDidClose{
    [helpViewController.view removeFromSuperview ];
    helpViewController=nil;
}
-(void)hudWasHidden:(MBProgressHUD *)hud{
    [hud removeFromSuperview];
    hud=nil;
}

-(void)goBack{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)showList{
    if(staffListViewContoller){
        staffListViewContoller.view.hidden=!staffListViewContoller.view.hidden;
        staffListBackgroundView.hidden=staffListViewContoller.view.hidden;
    }

}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if([segue.identifier isEqualToString:@"ChagangMonitorWarningAreaAllUserSegue"]){
        ChagangMonitorWarningAreaAllUserTableViewController *controller=segue.destinationViewController;
        controller.user=self.user;
    }
}

#pragma mark - 最后签到位置
-(void)chagangMonitorStaffListTableViewControllerDidSelected:(ChagangMonitorStaffListTableViewController *)controller{
    floatTagViewController.view.hidden=YES;
    lbTime.hidden=NO;
    
    [self clearMap];
    
    NSDictionary *dict=controller.selectDict;
    
    int userId=[[dict objectForKey:@"userID"] intValue];
    if(userId!=-999){
        
        for (NSDictionary *dict in staffList) {
            
            int uid=[[dict objectForKey:@"userID"] intValue];
            NSString *latitude=[dict objectForKey:@"offsetLatitude"];
            NSString *longtitude=[dict objectForKey:@"offsetLongtitude"];

            if(uid == userId && ((NSNull*)longtitude != [NSNull null] && (NSNull*)latitude != [NSNull null])){
                CLLocationCoordinate2D coor;
                coor.latitude = latitude.doubleValue;
                coor.longitude = longtitude.doubleValue;
                
                SignAnnotation *signAnnotation = [[SignAnnotation alloc]init];
                signAnnotation.coordinate = coor;
                signAnnotation.userDict=dict;
                [mapview addAnnotation:signAnnotation];
                mapview.centerCoordinate = coor;
                mapview.zoomLevel = 17;
                return;
            }
        }
        
    }
    else{
        [mapview setZoomLevel:12];
    }
    NSLog(@"选择用户没有添加到地图");
    
    //显示全部员工位置
    if(userId==-999){
        int i=0;
        BMKMapRect boundingRect = BMKMapRectNull;
        for (NSDictionary *dict in staffList) {
            NSString *latitude=[dict objectForKey:@"offsetLatitude"];
            NSString *longtitude=[dict objectForKey:@"offsetLongtitude"];
            if((NSNull*)longtitude != [NSNull null] && (NSNull*)latitude != [NSNull null]){
                CLLocationCoordinate2D coor;
                coor.latitude = latitude.doubleValue;
                coor.longitude = longtitude.doubleValue;
                
                SignAnnotation *signAnnotation = [[SignAnnotation alloc]init];
                signAnnotation.coordinate = coor;
                signAnnotation.userDict=dict;
                [mapview addAnnotation:signAnnotation];
                
                BMKMapPoint mp = BMKMapPointForCoordinate(coor);
                BMKMapRect pRect = BMKMapRectMake(mp.x, mp.y, 0, 0);
                
                if (i == 0) {
                    boundingRect = pRect;
                } else {
                    boundingRect = BMKMapRectUnion(boundingRect, pRect);
                }
                i++;
            }
        }
    
        if(!BMKMapRectIsNull(boundingRect))
            [mapview setVisibleMapRect:boundingRect animated:NO];
        else if([staffList count]>0){
            
            NSDictionary *dict = [staffList lastObject];
            //判空处理，当latitude longtitude为NSNULL时，返回return;
            NSString *latitude;
            NSString *longtitude;
             if ((NSNull*)[dict objectForKey:@"offsetLatitude"]!=[NSNull null])
             {
                 latitude=[dict objectForKey:@"offsetLatitude"];
                 
             }
             else{
                 return;
             }
            if ((NSNull*)[dict objectForKey:@"offsetLongtitude"]!=[NSNull null])
            {
               longtitude=[dict objectForKey:@"offsetLongtitude"];
            }
            else{
                 return;
            }

            
           
            mapview.centerCoordinate=CLLocationCoordinate2DMake(latitude.doubleValue, longtitude.doubleValue);
            mapview.zoomLevel=13;
        }
        
        return;
    }
    
//    [self addSignAnnotation:dict];

    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.delegate = self;
    HUD.labelText = @"未找到该员工位置！";
    [HUD show:YES];
    [HUD hide:YES afterDelay:1];
}
-(void)clearMap{
    NSMutableArray *tmpArray=[[NSMutableArray alloc] init];
    for (BMKPointAnnotation *anno in mapview.annotations)
        [tmpArray addObject:anno];
    [mapview removeAnnotations:tmpArray];
    
    NSMutableArray *tmpOverlayArray=[[NSMutableArray alloc] init];
    for (BMKShape *shape in mapview.overlays) {
        [tmpOverlayArray addObject:shape];
    }
    [mapview removeOverlays:tmpOverlayArray];
}

#pragma mark - 轨迹查询
-(void)chagangMonitorStaffListTableViewControllerDidLocusQuery:(ChagangMonitorStaffListTableViewController *)controller{
    floatTagViewController.view.hidden=NO;
    staffListViewContoller.view.hidden=YES;
    staffListBackgroundView.hidden=YES;
    lbTime.hidden=YES;
   
    [self clearMap];
    
    NSDictionary *dict=controller.selectDict;
    int userId=[[dict objectForKey:@"userID"] intValue];
    
    hubFlag=YES;
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"数据查询中，请稍后...";
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
    [self loadUserLocusDataWithUserId:userId searchDate:floatTagViewController.timeDate.text];

}
#pragma mark - 加载用户轨迹
-(void)refreshUserLocus:(NSDictionary*)userDetails{
    
    [self clearMap];
    NSLog(@"clear map ...");
    
    if(!userDetails)
        return;
    
    NSString *userImageUrl=[userDetails objectForKey:@"user_image"];
    NSArray *tmppositions=[userDetails objectForKey:@"position"];
    //签到时间的数据
     NSDictionary *checkinPoint=[userDetails objectForKey:@"checkinpoints"];
    //判断字典checkinPoint 为NSNull类型的时候（字典对象的元素是否为空）
    if ((NSNull*)checkinPoint!=[NSNull null]) {
        CLLocationCoordinate2D coor;
        coor.latitude = [[checkinPoint objectForKey:@"offsetLatitude"] doubleValue];
        coor.longitude = [[checkinPoint objectForKey:@"offsetLongtitude"] doubleValue];
        SignInAnnotation *signinAnnotation = [[SignInAnnotation alloc]init];
        signinAnnotation.coordinate = coor;
        signinAnnotation.AnnotationDict=userDetails;
        [mapview addAnnotation:signinAnnotation];
        mapview.centerCoordinate = coor;
        mapview.zoomLevel = 17;

    }
    
//      if((NSNull*)longtitude != [NSNull null] && (NSNull*)latitude != [NSNull null]){
         //            }
    
//**************************
    
    NSMutableArray *positions=[NSMutableArray new];
     //有记录一样，坐标一样绘线会出问题，因此不加载重复的坐标.
    NSString *lastSignTime=@"";
    for (NSDictionary *dict in tmppositions) {
        NSString *signtime=[dict objectForKey:@"signTime"];
        if([lastSignTime isEqualToString:signtime])
            continue;
        lastSignTime=signtime;
        [positions addObject:dict];
    }
    
    int userId=[[userDetails objectForKey:@"userID"] intValue];
    NSString *userName=[userDetails objectForKey:@"userName"];
    
    floatTagViewController.userName.text=userName;
    floatTagViewController.userId.text=[NSString stringWithFormat:@"%d",userId];
   // NSData *data=[[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:userImageUrl]];
    [floatTagViewController.userImageView sd_setImageWithURL:[NSURL URLWithString:userImageUrl] placeholderImage:[UIImage imageNamed:@"查岗监控－浮动窗－头像"]];
    //floatTagViewController.userImageView.image=[UIImage imageWithData:data];
    // draw locus
    
    CLLocationCoordinate2D coors[[positions count]];
     BMKMapRect boundingRect = BMKMapRectNull;

    for (NSDictionary *pos in positions) {
        double offsetLatitude=[[pos objectForKey:@"offsetLatitude"] doubleValue];
        double  offsetLongtitude=[[pos objectForKey:@"offsetLongtitude"] doubleValue];
        
        int index=[positions indexOfObject:pos];
        coors[index].latitude=offsetLatitude;
        coors[index].longitude=offsetLongtitude;
        
        if(index==0){
            LocusAnnotation *signAnnotation = [[LocusAnnotation alloc]init];
            signAnnotation.coordinate = coors[index];
            signAnnotation.isBegin=YES;
            signAnnotation.userDict=pos;
            [mapview addAnnotation:signAnnotation];
        }
        if(index==[positions count]-1){
            LocusAnnotation *signAnnotation = [[LocusAnnotation alloc]init];
            signAnnotation.coordinate = coors[index];
            signAnnotation.isEnd=YES;
            signAnnotation.userDict=pos;
            [mapview addAnnotation:signAnnotation];
        }
        
        BMKMapPoint mp = BMKMapPointForCoordinate(coors[index]);
        BMKMapRect pRect = BMKMapRectMake(mp.x, mp.y, 0, 0);
        if (index == 0) {
            boundingRect = pRect;
        } else {
            boundingRect = BMKMapRectUnion(boundingRect, pRect);
        }
    }
    
    if(!positions || [positions count] < 1){
        MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:HUD];
        HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
        HUD.mode = MBProgressHUDModeCustomView;
        HUD.delegate = self;
        HUD.labelText = @"未找到该员工轨迹！";
        [HUD show:YES];
        [HUD hide:YES afterDelay:1];
    }

    BMKPolyline *polyline = [BMKPolyline polylineWithCoordinates:coors count:[positions count]];
    
    [mapview addOverlay:polyline];

    if(!BMKMapRectIsNull(boundingRect))
        [mapview setVisibleMapRect:boundingRect animated:NO];
    else if([staffList count]>0){
        NSDictionary *dict = [staffList lastObject];
        NSNumber *latitude=[dict objectForKey:@"offsetLatitude"];
        NSNumber *longtitude=[dict objectForKey:@"offsetLongtitude"];
        if(!latitude || (NSNull*)latitude == [NSNull null])
            latitude = 0;
        if(!longtitude || (NSNull*)longtitude == [NSNull null])
            longtitude = 0;
        
        if(latitude > 0 && longtitude > 0){
            mapview.centerCoordinate=CLLocationCoordinate2DMake(latitude.doubleValue, longtitude.doubleValue);
            mapview.zoomLevel=13;
        }
    }

    //画电子围栏
    NSArray *enclosure=[userDetails objectForKey:@"enclosure"];
    for (NSDictionary *item in enclosure) {
        int type=[[item objectForKey:@"type"] intValue];  //type 围栏形状，1为圆形，2为多边形
        
        
        if(type == 1){
            NSDictionary *geo=[item objectForKey:@"geo"];
            CLLocationCoordinate2D coord;
            coord.latitude=[[geo objectForKey:@"y"] doubleValue];
            coord.longitude=[[geo objectForKey:@"x"] doubleValue];
            CGFloat r = [[geo objectForKey:@"r"] floatValue];
            BMKCircle *circle=[BMKCircle circleWithCenterCoordinate:coord radius:r*1000];
            [mapview addOverlay:circle];
        }
        
        if(type == 2){
            NSArray *geo=[item objectForKey:@"geo"];
            CLLocationCoordinate2D coord[[geo count]];
            for (int i=0; i<[geo count]; i++) {
                NSDictionary *p = [geo objectAtIndex:i];
                coord[i].latitude = [[p objectForKey:@"y"] doubleValue];
                coord[i].longitude = [[p objectForKey:@"x"] doubleValue];
            }
            BMKPolygon *gon=[BMKPolygon polygonWithCoordinates:coord count:[geo count]];
            [mapview addOverlay:gon];
        }
    }
}

#pragma mark - 显示用户预警详细
-(void)chagangMonitorStaffListTableViewControllerDidShowWarningDetails:(int)userId{
    [self loadUserWarningById:userId];
}
-(void)loadUserWarningById:(int)userId{
    hubFlag=YES;
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"获取用户电子围栏详细，请稍后...";
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
    
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    [bDict setObject:[NSNumber numberWithInt:userId] forKey:@"userID"];
    [bDict setObject:[NSNumber numberWithInt:self.user.userEnterprise] forKey:@"enterprise"];
    
    [NetworkHandling sendPackageWithUrl:@"monitor/GetSingleVipWarning" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        if(!error){
            NSLog(@"sign in success");
            //            NSDictionary *inforDict=[result objectForKey:@"Response"];
            [self performSelectorOnMainThread:@selector(showUserWarningDetails:) withObject:[result objectForKey:@"Response"] waitUntilDone:YES];
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
-(void)updateUserWarningById:(NSString*)rowId{
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    [bDict setObject:rowId forKey:@"row_id"];
    
    [NetworkHandling sendPackageWithUrl:@"monitor/UpdateWarningState" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        if(!error){
            NSLog(@"sign in success");
            //            NSDictionary *inforDict=[result objectForKey:@"Response"];
            [self performSelectorOnMainThread:@selector(updateWarningRefresh) withObject:nil waitUntilDone:YES];
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


-(void)showUserWarningDetails:(NSDictionary*)details{
    informationViewController=[self.storyboard instantiateViewControllerWithIdentifier:@"ChagangMonitorWarningAreaInformationViewController"];
    CGRect rect = informationViewController.view.frame;
    rect=CGRectMake(10, 74, 300, 350);
    informationViewController.view.frame=rect;
    informationViewController.delegate=self;
    [self.view addSubview:informationViewController.view];
    [informationViewController loadWarningInformation:details];
}

-(void)chagangMonitorWarningAreaInformationViewControllerDidCancel:(NSString *)rowId{
    [informationViewController.view removeFromSuperview];
    informationViewController=nil;
    
    [self updateUserWarningById:rowId];
}
-(void)updateWarningRefresh{
    
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    [bDict setObject:[NSNumber numberWithInt:self.user.userID] forKey:@"userID"];
    [bDict setObject:[NSNumber numberWithInt:self.user.userEnterprise] forKey:@"enterprise"];
    
    [NetworkHandling sendPackageWithUrl:@"monitor/LeaderPostMonitor" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        if(!error){
            NSLog(@"sign in success");
            NSDictionary *tmpDict=[result objectForKey:@"Response"];
            city=[tmpDict objectForKey:@"city"];
            systemTime=[tmpDict objectForKey:@"systemTime"];
            staffList=[tmpDict objectForKey:@"detail"];
            //            tableArray =[result objectForKey:@"Response"];
            [self performSelectorOnMainThread:@selector(refreshStaffTableView) withObject:nil waitUntilDone:YES];
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
-(void)refreshStaffTableView{
    NSMutableArray *tmpArray=[[NSMutableArray alloc] initWithArray:staffList];
    NSMutableDictionary *dict=[[NSMutableDictionary alloc] initWithDictionary:[staffList objectAtIndex:0]];
    [dict setObject:[NSNumber numberWithInt:-999] forKey:@"userID"];
    [dict setObject:@"全部成员" forKey:@"userName"];
    [tmpArray insertObject:dict atIndex:0];
    staffListViewContoller.staffList=tmpArray;
    [staffListViewContoller.tableView reloadData];
}
-(void)flowTagCalendarButtonOnclick:(id)sender{
//    NSLog(@"calendar button onclick...");
    [self selectDate:sender];
}

-(void)selectDate:(id)sender{
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"BusinessProcess" bundle:nil];
    selectDateTimeViewController=[storyboard instantiateViewControllerWithIdentifier:@"PreferentialPurchaseSelectDateTimeViewControllerId"];
    selectDateTimeViewController.modeDateAndTime=1;
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
    selectDateTimeViewController.datetimePicker.date=selectDate;
    
    backView=[[UIView alloc] init];
    backView.backgroundColor=[UIColor blackColor];
    backView.alpha=0.1;
    
    backView.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [self.view addSubview:backView];
    [self.view addSubview:selectDateTimeViewController.view];
    
}
-(void)preferentialPurchaseSelectDateTimeViewControllerDidCancel{
    [backView removeFromSuperview];
    [selectDateTimeViewController.view removeFromSuperview];
    
    backView=nil;
    selectDateTimeViewController=nil;
}
-(void)preferentialPurchaseSelectDateTimeViewControllerDidFinished:(PreferentialPurchaseSelectDateTimeViewController *)controller{
    selectDate=controller.datetimePicker.date;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString=[dateFormatter stringFromDate:controller.datetimePicker.date];
    floatTagViewController.timeDate.text=dateString;
    [self preferentialPurchaseSelectDateTimeViewControllerDidCancel];
    
    hubFlag=YES;
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"数据查询中，请稍后...";
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
    [self loadUserLocusDataWithUserId:[floatTagViewController.userId.text intValue] searchDate:floatTagViewController.timeDate.text];
}

- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    //签到位置 sign-mark
    if([annotation isKindOfClass:[SignInAnnotation class]]){
        NSString *AnnotationViewID = @"SignInAnnotation";
        SignInAnnotationView *signinannotationView = nil;
        if (signinannotationView == nil) {
            signinannotationView = [[SignInAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
        }
        
        signinannotationView.signinAnnotationImage.image=[UIImage imageNamed:@"sign-mark"];
        signinannotationView.canShowCallout=YES;
        NSDictionary *dict=((SignInAnnotation*)annotation).AnnotationDict;
      
            NSString *info=[NSString stringWithFormat:@"签到:%@",[[dict objectForKey:@"checkinpoints"] objectForKey:@"signTime"]];
            signinannotationView.signinAnnotationLabel.text=info;
        
        return signinannotationView;
    }

    
    //实时位置annotation sign-mark
    if([annotation isKindOfClass:[SignAnnotation class]]){
        NSString *AnnotationViewID = @"SignAnnotation";
        SignAnnotationView *annotationView = nil;
        if (annotationView == nil) {
            annotationView = [[SignAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
        }
        
        annotationView.annotationImageView.image=[UIImage imageNamed:@"坐标红点"];
        annotationView.canShowCallout=YES;
        NSDictionary *dict=((SignAnnotation*)annotation).userDict;
        NSString *info=[NSString stringWithFormat:@"%@ %@",[dict objectForKey:@"userName"],[dict objectForKey:@"signTime"]];
        annotationView.annotationLabel.text=info;
        
        return annotationView;
    }
    //轨迹annotation
    if([annotation isKindOfClass:[LocusAnnotation class]]){
        NSString *AnnotationViewID = @"LocusAnnotation";
        LocusAnnotationView *annotationView = nil;
        if (annotationView == nil) {
            annotationView = [[LocusAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
        }

        annotationView.canShowCallout=NO;
        LocusAnnotation *anno=annotation;
        NSDictionary *dict=anno.userDict;
        NSString *timestring=[dict objectForKey:@"signTime"];
        timestring=[timestring substringFromIndex:11];
        timestring=[timestring substringToIndex:5];
        if(anno.isBegin){
            annotationView.annotationImageView.image=[UIImage imageNamed:@"start-icon"];
        
            NSString *info=[NSString stringWithFormat:@"S:%@",timestring];
            annotationView.annotationLabel.text=info;

        }
        if(anno.isEnd){
            annotationView.annotationImageView.image=[UIImage imageNamed:@"end-icon"];
            NSString *info=[NSString stringWithFormat:@"E:%@",timestring];
            annotationView.annotationLabel.text=info;

        }
        return annotationView;
    }
    
    return nil;
}
- (BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id <BMKOverlay>)overlay
{
    if ([overlay isKindOfClass:[BMKPolyline class]])
    {
        BMKPolylineView* polylineView = [[BMKPolylineView alloc] initWithOverlay:overlay];
        polylineView.strokeColor = [[UIColor blueColor] colorWithAlphaComponent:1];
        polylineView.lineWidth = 5.0;
        polylineView.alpha=0.3;
        
		return polylineView;
    }
    
    if([overlay isKindOfClass:[BMKCircle class]]){
        BMKCircleView* circleView=[[BMKCircleView alloc] initWithCircle:overlay];
        circleView.strokeColor = [[VariableStore hexStringToColor:@"ff6633"] colorWithAlphaComponent:0.5];
        circleView.lineWidth = 3.0;
        circleView.fillColor=[[VariableStore hexStringToColor:@"ff9966"] colorWithAlphaComponent:0.5];
        return circleView;
        
    }
    if([overlay isKindOfClass:[BMKPolygon class]]){
        BMKPolygonView *polygonView=[[BMKPolygonView alloc] initWithPolygon:overlay];
        polygonView.strokeColor=[[VariableStore hexStringToColor:@"ff6633"] colorWithAlphaComponent:0.5];
        polygonView.lineWidth = 3.0;
        polygonView.fillColor=[[VariableStore hexStringToColor:@"ff9966"] colorWithAlphaComponent:0.5];
        return polygonView;
    }
    
    return nil;
}

@end
