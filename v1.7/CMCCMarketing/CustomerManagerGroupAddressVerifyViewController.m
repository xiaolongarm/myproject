//
//  CustomerManagerGroupAddressVerifyViewController.m
//  CMCCMarketing
//
//  Created by talkweb on 15-4-30.
//  Copyright (c) 2015年 talkweb. All rights reserved.
//

#import "CustomerManagerGroupAddressVerifyViewController.h"
#import "KeyboardHanding.h"
#import "NetworkHandling.h"
#import "MBProgressHUD.h"
#import "KeyboardExtendHandling.h"
#import "VariableStore.h"
@interface CustomerManagerGroupAddressVerifyViewController ()<MBProgressHUDDelegate>{
    BMKLocationService *_locService;
    CLLocationCoordinate2D _currentSelectCoordinate;
    int locationDelay;
    BMKGeoCodeSearch *geoSearch;
    KeyboardExtendHandling *keyboardExtendHandling;
    
    BOOL hubFlag;
}

@end

@implementation CustomerManagerGroupAddressVerifyViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.mapview.delegate=self;
    //传入地图缺省值
//   self.mapview.centerCoordinate=[VariableStore sharedInstance].coord;
//   self.mapview.zoomLevel=13;

    txtVerifyContent.layer.borderColor=[UIColor lightGrayColor].CGColor;
    txtVerifyContent.layer.borderWidth=.5f;
//垃圾代码导致闪退
//    keyboardExtendHandling=[[KeyboardExtendHandling alloc] initKeyboardHangling:self.view];

    lbAddressTitle.text = [NSString stringWithFormat:@"%@地理位置：",[self.addrmsgDict objectForKey:@"grp_name"]];
    lbAddressTitle.adjustsFontSizeToFitWidth=YES;
    
    lbAddress.text = [self.addrmsgDict objectForKey:@"grp_addr"];
    lbAddress.adjustsFontSizeToFitWidth=YES;
    
    NSString *latitude = [self.addrmsgDict objectForKey:@"latitude"];
    NSString *longtitude = [self.addrmsgDict objectForKey:@"longtitude"];
    
    
//  
//    [self.mapview removeAnnotations:self.mapview.annotations];
//    
//       self.mapview.centerCoordinate=CLLocationCoordinate2DMake(latitude.doubleValue, longtitude.doubleValue);
//        BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
//        item.coordinate=self.mapview.centerCoordinate;
//        //item.title = self.group.groupAddress;//子标题
//        [self.mapview addAnnotation:item];
//        self.mapview.zoomLevel=13;
    
    
//    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude.doubleValue, longtitude.doubleValue);
//    self.mapview.centerCoordinate = coordinate;
//    self.mapview.zoomLevel = 13;
//    
//    BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
//    item.coordinate=self.mapview.centerCoordinate;
//    item.title = [self.msgDict objectForKey:@"grp_name"];//子标题
//    item.subtitle = [self.msgDict objectForKey:@"grp_addr"];
//    [self.mapview addAnnotation:item];
}
-(void)connectToNetwork{
    while (hubFlag) {
        usleep(100000);
    }
}
-(void)showMessage:(NSString*)infomation{
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"信息提示" message:infomation delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
    [myAlertView show];
}
-(void)hudWasHidden:(MBProgressHUD *)hud{
    [hud removeFromSuperview];
    hud=nil;
}
//grpuserlink/updleaderremindsta
- (IBAction)submitOnclick:(id)sender {
    hubFlag=YES;
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"正在提交数据，请稍后...";
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
    
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    
    [bDict setObject:[self.addrmsgDict objectForKey:@"grp_code"] forKey:@"grp_code"];
    int verifyflag = swVerify.on ? 1 : 2;
    [bDict setObject:[NSNumber numberWithInt:verifyflag] forKey:@"flag"];
    [bDict setObject:[NSNumber numberWithInt:self.user.userID] forKey:@"user_id"];
    [bDict setObject:[NSNumber numberWithInt:self.user.userEnterprise] forKey:@"enterprise"];
    [bDict setObject:self.user.userName forKey:@"user_name"];
    [bDict setValue:@"ios" forKey:@"client_os"];
    [bDict setValue:[self.addrmsgDict objectForKey:@"vip_mngr_msisdn"] forKey:@"vip_mngr_msisdn"];
    [bDict setObject:txtVerifyContent.text forKey:@"examine_remark"];
    NSString *url=@"grpuserlink/examineGrpAdd";
    
    [NetworkHandling sendPackageWithUrl:url sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        if(!error){
            BOOL flag = [[result objectForKey:@"flag"] boolValue];
            NSLog(@"sign in success");
            if(flag){
                [self performSelectorOnMainThread:@selector(verifySuccess) withObject:nil waitUntilDone:YES];
            }
            else{
                [self performSelectorOnMainThread:@selector(showMessage:) withObject:@"修改审核提醒状态失败！" waitUntilDone:YES];
            }
        }
        else{
            int errorCode=[[result valueForKey:@"errorcode"] intValue];
            NSString *errorInfo=[result valueForKey:@"errorinf"];
            if(!errorInfo)
                errorInfo=@"提交数据出错！";
            NSLog(@"error:%d info:%@",errorCode,errorInfo);
            [self performSelectorOnMainThread:@selector(showMessage:) withObject:errorInfo waitUntilDone:YES];
        }
       hubFlag=NO;
    }];

}
-(void)verifySuccess{
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.delegate = self;
    HUD.labelText=@"审核成功！";
    [HUD show:YES];
    [HUD hide:YES afterDelay:1];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.navigationController popViewControllerAnimated:YES];
//});
}
//#pragma mark mapViewDelegate 代理方法
//- (void)mapView:(BMKMapView *)mapView1 didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
//{
//    BMKCoordinateRegion region;
//    region.center.latitude  = userLocation.location.coordinate.latitude;
//    region.center.longitude = userLocation.location.coordinate.longitude;
//    region.span.latitudeDelta  = 0.005;
//    region.span.longitudeDelta = 0.005;
//  }
//
//-(void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error{
//    
//    NSArray* array = [NSArray arrayWithArray:self.mapview.annotations];
//    [self.mapview removeAnnotations:array];
//    array = [NSArray arrayWithArray:self.mapview.overlays];
//    [self.mapview removeOverlays:array];
//    
//}
////处理位置坐标更新
//- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
//{
//    locationDelay++;
//    NSLog(@"didUpdateBMKUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
//    //    [self mapView:mapView didUpdateBMKUserLocation:userLocation];
//    if(locationDelay > 2){
//        [_locService stopUserLocationService];
//        [self mapView:self.mapview didUpdateBMKUserLocation:userLocation];
//        _currentSelectCoordinate=userLocation.location.coordinate;
//        BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
//        reverseGeocodeSearchOption.reverseGeoPoint = userLocation.location.coordinate;
//        BOOL flag = [geoSearch reverseGeoCode:reverseGeocodeSearchOption];
//        if(flag)
//        {
//            NSLog(@"反geo检索发送成功");
//        }
//        else
//        {
//            NSLog(@"反geo检索发送失败");
//            
//        }
//    }
//}
//

@end
