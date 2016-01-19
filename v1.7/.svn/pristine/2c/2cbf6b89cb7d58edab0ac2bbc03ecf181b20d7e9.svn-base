//
//  W_VisitPlanSignoutTableViewController.m
//  CMCCMarketing
//
//  Created by gmj on 14-11-27.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import "W_VisitPlanSignoutTableViewController.h"
#import "W_VisitPlanDetailsViewController.h"

#import "NetworkHandling.h"
#import "MBProgressHUD.h"
#import "VariableStore.h"

@interface W_VisitPlanSignoutTableViewController ()<BMKLocationServiceDelegate,MBProgressHUDDelegate>{
    
    BMKLocationService *_locService;
    CLLocationCoordinate2D _currentSelectCoordinate;
    int locationDelay;
    BMKGeoCodeSearch *geoSearch;
    BOOL isSuccessSubmit;
    
    BOOL hubFlag;
    BOOL isSign;
}

@end

@implementation W_VisitPlanSignoutTableViewController

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
    //传入地图缺省值
    self.mapView.centerCoordinate=[VariableStore sharedInstance].coord;
    self.mapView.zoomLevel=13;
    isSign=NO;
    //未获取精准位置前，签到按钮不可点击
    signButton.enabled=NO;
    
    [self initSubView];
}

-(void)initSubView{
//    NSString *latitude=[self.dicSelectVisitPlanDetail objectForKey:@"latitude1"];
//    NSString *longitude=[self.dicSelectVisitPlanDetail objectForKey:@"longitude1"];
// 
//    if(latitude && (NSNull*)latitude!=[NSNull null] && latitude.length > 0)
//        isSign=YES;
//    
//    if(isSign){
//        signButton.hidden=YES;
//        refreshLocationButton.hidden=YES;
//    }
    
    self.navigationItem.title = @"拜访签退";
    
    self.lblVisit_grp_name.text = [self.dicSelectVisitPlanDetail objectForKey:@"visit_grp_name"];
    self.lblLinkman.text = [self.dicSelectVisitPlanDetail objectForKey:@"linkman"];
    self.lblVip_mngr_name.text = [self.dicSelectVisitPlanDetail objectForKey:@"vip_mngr_name"];
    self.lblVip_mngr_msisdn.text = [self.dicSelectVisitPlanDetail objectForKey:@"vip_mngr_msisdn"];
    self.lblVisit_grp_add.text = [self.dicSelectVisitPlanDetail objectForKey:@"visit_grp_add"];
    
   
    
    self.mapView.delegate=self;
    self.mapView.hidden=NO;
    
    [self  whetherSign];
//    if(!isSign){
//        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//        NSString *strDate = [dateFormatter stringFromDate:[NSDate date]];
//        self.lblSignTime.text = strDate;
//        self.lblCurrentLocation.text = @"正在获取地址...";
//        
//        //初始化BMKLocationService
//        _locService = [[BMKLocationService alloc]init];
//        _locService.delegate = self;
//        //启动LocationService
//        [_locService startUserLocationService];
//        
//        geoSearch=[[BMKGeoCodeSearch alloc] init];
//        geoSearch.delegate=self;
//    }
//    else{
//        self.lblCurrentLocation.text=[self.dicSelectVisitPlanDetail objectForKey:@"signin_addr1"];
//        self.lblSignTime.text=[self.dicSelectVisitPlanDetail objectForKey:@"client_date1"];
//        
//        CLLocationDegrees lat=[latitude doubleValue];
//        CLLocationDegrees lon=[longitude doubleValue];
//        
//        CLLocation *location=[[CLLocation alloc]initWithLatitude:lat longitude:lon];
//        
//        BMKCoordinateRegion region;
//        region.center.latitude  = lat;
//        region.center.longitude = lon;
//        region.span.latitudeDelta  = 0.005;
//        region.span.longitudeDelta = 0.005;
//        if (self.mapView)
//        {
//            self.mapView.region = region;
//            
//            BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
//            item.coordinate = location.coordinate;//经纬度
//            item.title = @"当前位置";    //标题
//            item.subtitle = self.lblCurrentLocation.text;//子标题
//            [self.mapView addAnnotation:item];
//            if(self.mapView.hidden)
//                self.mapView.hidden=NO;
//        }
//    }
}
#pragma mark 是否签到方法
- (void)whetherSign{
    //    changsha\v1_6\visitplan\isvisitplansign
    //    必传参数
    //    sign_type 签到类型，"0"表示签入，"1"表示签出
    //    visit_id 拜访计划ID
    //    回传参数
    //    falg=false 则没有签到或者签退
    //    或者
    //    falg=true
    //    singnin_url 图片
    //    longitude 经度
    //    latitude 维度
    //    baidu_longitude 偏移经度
    //    baidu_latitude 偏移维度
    //    signin_addr 地址
    //    client_date 时间
    hubFlag=YES;
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"数据查询中，请稍后...";
    //    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
    NSMutableDictionary *paramDict=[[NSMutableDictionary alloc]init];
    NSString *visit_id = [self.dicSelectVisitPlanDetail objectForKey:@"row_id"];
    [paramDict setObject:visit_id forKey:@"visit_id"];
    [paramDict setObject:@"1" forKey:@"sign_type"];
    [NetworkHandling sendPackageWithUrl:@"visitplan/isvisitplansign" sendBody:paramDict processHandler:^(NSDictionary *result, NSError *error) {
        
        if(!error){
            BOOL flag=[[result objectForKey:@"flag"]boolValue];
            NSLog(@"API success");
            if(flag){
                //已经签到
                [self performSelectorOnMainThread:@selector(alreaySign:) withObject:result waitUntilDone:YES];
                isSign=YES;
                
            }else{
                //还没有签到
                isSign=NO;
                [self performSelectorOnMainThread:@selector(haveNoSign:) withObject:result waitUntilDone:YES];
            }
        }
        else{
            int errorCode=[[result valueForKey:@"errorcode"] intValue];
            NSString *errorInfo=[result valueForKey:@"errorinf"];
            if(!errorInfo)
                errorInfo=@"获取签到数据出错了！";
            NSLog(@"error:%d info:%@",errorCode,errorInfo);
            [self performSelectorOnMainThread:@selector(showMessage:) withObject:errorInfo waitUntilDone:YES];
        }
        hubFlag=NO;
    }];
    
    
}

-(void)haveNoSign:(NSDictionary*)recipeDict{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *strDate = [dateFormatter stringFromDate:[NSDate date]];
    self.lblSignTime.text = strDate;
    self.lblCurrentLocation.text = @"正在获取地址...";
    
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    [_locService startUserLocationService];
    
    geoSearch=[[BMKGeoCodeSearch alloc] init];
    geoSearch.delegate=self;
    
}
-(void)alreaySign:(NSDictionary*)recipeDict{
    signButton.hidden=YES;
    refreshLocationButton.hidden=YES;
    self.lblCurrentLocation.text=[recipeDict objectForKey:@"signin_addr"];
    self.lblSignTime.text=[recipeDict objectForKey:@"client_date"];
       //显示地图上签到的大头针
    CLLocationDegrees lat=[[recipeDict objectForKey:@"baidu_latitude"] doubleValue];
    CLLocationDegrees lon=[[recipeDict objectForKey:@"baidu_longitude"] doubleValue];
    
    CLLocation *location=[[CLLocation alloc]initWithLatitude:lat longitude:lon];
    
    BMKCoordinateRegion region;
    region.center.latitude  = lat;
    region.center.longitude = lon;
    region.span.latitudeDelta  = 0.005;
    region.span.longitudeDelta = 0.005;
    if (self.mapView)
    {
        self.mapView.region = region;
        
        BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
        item.coordinate = location.coordinate;//经纬度
        item.title = @"当前位置";    //标题
        item.subtitle = self.lblCurrentLocation.text;//子标题
        [self.mapView addAnnotation:item];
        if( self.mapView.hidden)
            self.mapView.hidden=NO;
    }
    
    
}


#pragma mark mapViewDelegate 代理方法
- (void)mapView:(BMKMapView *)mapView1 didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    BMKCoordinateRegion region;
    region.center.latitude  = userLocation.location.coordinate.latitude;
    region.center.longitude = userLocation.location.coordinate.longitude;
    region.span.latitudeDelta  = 0.005;
    region.span.longitudeDelta = 0.005;
    if (self.mapView)
    {
        self.mapView.region = region;
        NSLog(@"当前的坐标是: %f,%f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
        
        BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
        item.coordinate = userLocation.location.coordinate;//经纬度
        item.title = @"当前位置";    //标题
        item.subtitle = @"正在定位...";//子标题
        [self.mapView addAnnotation:item];
        
        if(self.mapView.hidden)
            self.mapView.hidden=NO;
    }
}

-(void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error{
    
    NSArray* array = [NSArray arrayWithArray:self.mapView.annotations];
    [self.mapView removeAnnotations:array];
    array = [NSArray arrayWithArray:self.mapView.overlays];
    [self.mapView removeOverlays:array];
    if (error == 0) {
        BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
        item.coordinate = result.location;
        item.title = result.address;
        [self.mapView addAnnotation:item];
        self.mapView.centerCoordinate = result.location;
        
        self.lblCurrentLocation.text=result.address;
        //获取精准位置前，签到按钮可点击
        signButton.enabled=YES;
    }
    
}

//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    locationDelay++;
    NSLog(@"didUpdateBMKUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    //    [self mapView:mapView didUpdateBMKUserLocation:userLocation];
    if(locationDelay > 2){
        [_locService stopUserLocationService];
        [self mapView:self.mapView didUpdateBMKUserLocation:userLocation];
        _currentSelectCoordinate=userLocation.location.coordinate;
        BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
        reverseGeocodeSearchOption.reverseGeoPoint = userLocation.location.coordinate;
        BOOL flag = [geoSearch reverseGeoCode:reverseGeocodeSearchOption];
        if(flag)
        {
            NSLog(@"反geo检索发送成功");
        }
        else
        {
            NSLog(@"反geo检索发送失败");
            
        }
    }
}


-(void)takePhoto{
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)toVisitPlanDetailOnClick:(id)sender {
    
    W_VisitPlanDetailsViewController *vc = [[W_VisitPlanDetailsViewController alloc] initWithNibName:@"W_VisitPlanDetailsViewController" bundle:nil];
    vc.dicSelectVisitPlanDetail = self.dicSelectVisitPlanDetail;
    vc.user = self.user;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)refreshLocationOnClick:(id)sender {
    locationDelay=0;
    self.lblCurrentLocation.text = @"正在获取地址...";
    [_locService startUserLocationService];
}

- (IBAction)signOnClick:(id)sender {
    
    [self submitLocationData];
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

-(void)submitLocationData{
    
    hubFlag=YES;
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"数据提交中，请稍后...";
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
    
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    NSString *client_os = @"ios";
    [bDict setObject:client_os forKey:@"client_os"];
    
    [bDict setObject:@"1" forKey:@"sign_type"];
    NSString *visit_id = [self.dicSelectVisitPlanDetail objectForKey:@"row_id"];
    [bDict setObject:visit_id forKey:@"visit_id"];
    [bDict setObject:self.lblSignTime.text forKey:@"client_date"];
    [bDict setObject:self.lblCurrentLocation.text forKey:@"signin_addr"];
    [bDict setValue:[NSNumber numberWithDouble:_currentSelectCoordinate.longitude] forKey:@"longitude"];
    [bDict setValue:[NSNumber numberWithDouble:_currentSelectCoordinate.latitude] forKey:@"latitude"];
    [bDict setObject:[NSNumber numberWithDouble:_currentSelectCoordinate.longitude] forKey:@"baidu_longitude"];
    [bDict setObject:[NSNumber numberWithDouble:_currentSelectCoordinate.latitude] forKey:@"baidu_latitude"];
//    [bDict setObject:@"" forKey:@"img_url"];
    
    NSString *grp_code = [self.dicSelectVisitPlanDetail objectForKey:@"visit_grp_code"];
    [bDict setObject:grp_code forKey:@"grp_code"];
    NSString *grp_name = [self.dicSelectVisitPlanDetail objectForKey:@"visit_grp_name"];
    [bDict setObject:grp_name forKey:@"grp_name"];
    
    [bDict setObject:[[UIDevice currentDevice].identifierForVendor UUIDString] forKey:@"device_id"];
    [bDict setObject:[NSNumber numberWithInt:self.user.userEnterprise] forKey:@"enterprise"];
    int uid = self.user.userID;
    NSString *reply_user_id = [NSString stringWithFormat:@"%d",uid];
    [bDict setObject:reply_user_id forKey:@"user_id"];
    
    [NetworkHandling sendPackageWithUrl:@"visitplan/visitplansign" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        hubFlag=NO;
        if(!error){
            
            NSLog(@"sign in success");
            BOOL flag=[[result objectForKey:@"flag"] boolValue];
            if(flag){
                
                [self performSelectorOnMainThread:@selector(signSuccesss) withObject:nil waitUntilDone:YES];
                
            }else{
                
                [self performSelectorOnMainThread:@selector(showMessage:) withObject:@"签退失败！" waitUntilDone:YES];
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
-(void)signSuccesss{
    NSString *sigOutnedstauts=@"1";
    [[NSNotificationCenter defaultCenter]postNotificationName:@"SignOutNotification" object:sigOutnedstauts];
   
//    [self.navigationController popToRootViewControllerAnimated:YES];
     [self.navigationController popViewControllerAnimated:YES];
    
   }
@end

