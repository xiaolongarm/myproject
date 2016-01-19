//
//  SignMapViewController.m
//  CMCCMarketing
//
//  Created by talkweb on 14-9-4.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import "SignMapViewController.h"
#import "NetworkHandling.h"
#import "MBProgressHUD.h"

@interface SignMapViewController ()<BMKLocationServiceDelegate,MBProgressHUDDelegate>{
    BMKLocationService *_locService;
    CLLocationCoordinate2D _currentSelectCoordinate;
    int locationDelay;
    BMKGeoCodeSearch *geoSearch;
    BOOL isSuccessSubmit;
    
    BOOL hubFlag;
}
@end

@implementation SignMapViewController

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
    [self.navigationController setNavigationBarHidden:NO];
    [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerFunc) userInfo:nil repeats:YES];
    
    //    CGRect rect =CGRectMake(0, 0, mapPanel.frame.size.width, mapPanel.frame.size.height);
    //     mapView = [[BMKMapView alloc]initWithFrame:rect];
    //    [mapPanel addSubview:mapView];
    
    CGRect rect=CGRectMake(0, 0, mapviewBody.frame.size.width, mapviewBody.frame.size.height);
    mapView=[[BMKMapView alloc] initWithFrame:rect];
    [mapviewBody addSubview:mapView];
    mapView.delegate=self;
    mapView.hidden=YES;
    
    //初始化BMKLocationService
    _locService = [[BMKLocationService alloc]init];
    
    _locService.delegate = self;
    //启动LocationService
    [_locService startUserLocationService];
    
    //    mapView.showsUserLocation=YES;
    //    mapView.zoomLevel=16;
    //    mapView.mapType=BMKUserTrackingModeFollowWithHeading;
    
    mapView.showsUserLocation = NO;//先关闭显示的定位图层
    //    mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
    //    mapView.showsUserLocation = YES;//显示定位图层
    
    geoSearch=[[BMKGeoCodeSearch alloc] init];
    geoSearch.delegate=self;
    lbSignLocation.numberOfLines=0;
    
    if(self.isSignIn){
        lbLocationTitle.text=@"签到位置";
        lbTimeTitle.text=@"签到时间";
    }
    else{
        lbLocationTitle.text=@"签退位置";
        lbTimeTitle.text=@"签退时间";
    }
    
    isSuccessSubmit=NO;
    //提示定位中
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.delegate = self;
    HUD.labelText = @"正在定位 ... ";
    [HUD show:YES];
    [HUD hide:YES afterDelay:3];
}

//-(void)viewWillAppear:(BOOL)animated {
//    [mapView viewWillAppear];
//    mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
//    _locService.delegate = self;
//}
//
//-(void)viewWillDisappear:(BOOL)animated {
//    [mapView viewWillDisappear];
//    mapView.delegate = nil; // 不用时，置nil
//    _locService.delegate = nil;
//}

#pragma mark mapViewDelegate 代理方法
- (void)mapView:(BMKMapView *)mapView1 didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    BMKCoordinateRegion region;
    region.center.latitude  = userLocation.location.coordinate.latitude;
    region.center.longitude = userLocation.location.coordinate.longitude;
    region.span.latitudeDelta  = 0.005;
    region.span.longitudeDelta = 0.005;
    if (mapView)
    {
        mapView.region = region;
        NSLog(@"当前的坐标是: %f,%f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
        
        BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
        item.coordinate = userLocation.location.coordinate;//经纬度
        item.title = @"当前位置";    //标题
        item.subtitle = @"正在定位...";//子标题
        [mapView addAnnotation:item];
        if(mapView.hidden)
            mapView.hidden=NO;
    }
}

-(void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error{
    NSArray* array = [NSArray arrayWithArray:mapView.annotations];
    [mapView removeAnnotations:array];
    array = [NSArray arrayWithArray:mapView.overlays];
    [mapView removeOverlays:array];
    if (error == 0) {
        BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
        item.coordinate = result.location;
        item.title = result.address;
        [mapView addAnnotation:item];
        mapView.centerCoordinate = result.location;
        
        lbSignLocation.text=result.address;
        //        NSString* titleStr;
        //        NSString* showmeg;
        //        titleStr = @"反向地理编码";
        //        showmeg = [NSString stringWithFormat:@"%@",item.title];
        
        //        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:titleStr message:showmeg delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
        //        [myAlertView show];
    }
}
//-(void)mapView:(BMKMapView *)mapView1 regionDidChangeAnimated:(BOOL)animated{
//    [mapView.annotations enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//        BMKPointAnnotation *item = (BMKPointAnnotation *)obj;
//        if (item.coordinate.latitude == _currentSelectCoordinate.latitude && item.coordinate.longitude == _currentSelectCoordinate.longitude )
//        {
//            [mapView selectAnnotation:obj animated:YES];//执行之后,会让地图中的标注处于弹出气泡框状态
//            *stop = YES;
//        }
//    }];
//}
-(void)timerFunc{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *strDate = [dateFormatter stringFromDate:[NSDate date]];
    
    lbSignTime.text=strDate;
    //    NSLog(@"time:%@",strDate);
}
//实现相关delegate 处理位置信息更新
//处理方向变更信息
//- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
//{
//    NSLog(@"heading is %@",userLocation.heading);
//    [mapView updateLocationData:userLocation];
//}
//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    locationDelay++;
    NSLog(@"didUpdateBMKUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    //    [self mapView:mapView didUpdateBMKUserLocation:userLocation];
    if(locationDelay > 2){
        [_locService stopUserLocationService];
        [self mapView:mapView didUpdateBMKUserLocation:userLocation];
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



-(void)updateLocationInformation:(NSString*)locationInformation{
    lbSignLocation.text=locationInformation;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//- (IBAction)signButtonOnclick:(id)sender {
//
//}

- (void)mapView:(BMKMapView *)mapView didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"location error");
}
-(void)mapview:(BMKMapView *)mapView onDoubleClick:(CLLocationCoordinate2D)coordinate{
    NSLog(@"on double click map...");
}
- (IBAction)refreshLocation:(id)sender {
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.delegate = self;
    HUD.labelText = @"正在定位 ... ";
    [HUD show:YES];
    [HUD hide:YES afterDelay:3];
    
    lbSignLocation.text=@"正在获取您的当前位置，请耐心等候！";
    locationDelay=0;
    [_locService startUserLocationService];
}
//b : {
//    “userID” :用户ID,
//    "addressDesc":地理描述,
//    “signState”:签到状态, “0”手动签入  “1”表示签出 /”2” 终端自动上报gps,
//    “enterprise”:企业编码,
//    “longtitude”:真实经度,
//    “latitude”:真实维度,
//    ”offsetLongtitude”:百度偏移经度,
//    “offsetLatitude”:百度偏移维度,
//    “gpsType”:GPS类型,0表示GPS/1表示A_GPS,不传默认为0，
//    “signDate”:签到时间(yyyy-MM-dd HH:mm)
//}


-(void)connectToNetwork{
    
    while (hubFlag) {
        usleep(100000);
    }
}

//signin/SignIn
- (IBAction)submitLocation:(id)sender {
    
    hubFlag=YES;
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"数据查询中，请稍后...";
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
    
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    
    NSString *signState=self.isSignIn ? @"0" : @"1";
    
    [bDict setValue:[NSNumber numberWithInt:self.user.userID] forKey:@"userID"];
    [bDict setValue:lbSignLocation.text forKey:@"addressDesc"];
    [bDict setValue:signState forKey:@"signState"];
    [bDict setValue:[NSNumber numberWithInt:self.user.userEnterprise] forKey:@"enterprise"];
    [bDict setValue:[NSNumber numberWithDouble:_currentSelectCoordinate.longitude] forKey:@"longtitude"];
    [bDict setValue:[NSNumber numberWithDouble:_currentSelectCoordinate.latitude] forKey:@"latitude"];
    [bDict setValue:[NSNumber numberWithDouble:_currentSelectCoordinate.longitude] forKey:@"offsetLongtitude"];
    [bDict setValue:[NSNumber numberWithDouble:_currentSelectCoordinate.latitude] forKey:@"offsetLatitude"];
    [bDict setValue:@"0" forKey:@"gpsType"];
    [bDict setValue:lbSignTime.text forKey:@"signDate"];
    [bDict setValue:[[UIDevice currentDevice].identifierForVendor UUIDString] forKey:@"deviceID"];
    
    [NetworkHandling sendPackageWithUrl:@"signin/SignIn" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        NSDictionary *resultDict=[result valueForKey:@"Response"];
        BOOL flag=[[resultDict objectForKey:@"returnFlag"] boolValue];
        if(!error && resultDict&&flag){
            NSLog(@"sign in success");
            isSuccessSubmit=YES;
            [self performSelectorOnMainThread:@selector(showMessage:) withObject:@"成功！" waitUntilDone:YES];
            
        }
        else{
            //            int errorCode=[[result valueForKey:@"errorcode"] intValue];
            //            NSString *errorInfo=[result valueForKey:@"errorinf"];
            //            NSLog(@"error:%d info:%@",errorCode,errorInfo);
            
            [self performSelectorOnMainThread:@selector(showMessage:) withObject:@"失败！" waitUntilDone:YES];
        }
        
        hubFlag=NO;
    }];
}
-(void)showMessage:(NSString*)infomation{
    //    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"信息提示" message:infomation delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
    //    [myAlertView show];
    
    NSString *msg=@"";
    if(self.isSignIn)
        msg=[NSString stringWithFormat:@"签到%@",infomation];
    else
        msg=[NSString stringWithFormat:@"签退%@",infomation];
    
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.delegate = self;
    HUD.labelText = msg;
    [HUD show:YES];
    [HUD hide:YES afterDelay:3];
    
}
-(void)hudWasHidden:(MBProgressHUD *)hud{
    [hud removeFromSuperview];
    hud=nil;
    
    if(isSuccessSubmit)
        [self.navigationController popViewControllerAnimated:YES];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
