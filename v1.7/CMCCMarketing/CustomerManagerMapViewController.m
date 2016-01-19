//
//  CustomerManagerMapViewController.m
//  CMCCMarketing
//
//  Created by talkweb on 14-9-22.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import "CustomerManagerMapViewController.h"
#import "NetworkHandling.h"
#import "MBProgressHUD.h"
#import "VariableStore.h"

@interface CustomerManagerMapViewController ()<MBProgressHUDDelegate,BMKMapViewDelegate,BMKGeoCodeSearchDelegate,BMKLocationServiceDelegate,BMKPoiSearchDelegate>{
    BMKLocationService *_locService;
    CLLocationCoordinate2D _currentSelectCoordinate;
    int locationDelay;
    BMKGeoCodeSearch *geoSearch;
    BOOL hubFlag;
//    int addressType;
}


@end

@implementation CustomerManagerMapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    mapview.delegate=self;
//地理和反地理编码的初始化和代理
   geoSearch=[[BMKGeoCodeSearch alloc] init];
    geoSearch.delegate=self;

    
    if (self.listType == 0) {
        if(self.group.groupLatitude<1){
            mapview.centerCoordinate=[VariableStore sharedInstance].coord;
        }
        else{
            [self refreshUserLocaton];
            self.addressType = 1;
        }
        
        if(self.group.groupLatitude < 1 && self.group.groupDiduType == 1){
            [self getGroupAddress];
        }

//        if(self.group.groupLatitude<1){
//            //没有位置信息
//            mapview.centerCoordinate=[VariableStore sharedInstance].coord;
//             self.addressType = 3;
//            //就显示当前位置
//            [self MyPostion];
//        }
//        else if (self.group.groupDiduType==1)
//        {
//           //位置来自百度定位
//            [self refreshUserLocaton];
//            self.addressType = 2;
//        }
//            
//        else{
//            
//            [self refreshUserLocaton];
//            self.addressType = 1;
//        }
        
//        if(self.group.groupLatitude < 1 && self.group.groupDiduType == 1){
//            [self getGroupAddress];
//        }
        lbSignLocation.numberOfLines=0;
        lbGroupNameTitle.text=[NSString stringWithFormat:@"%@位置：",self.group.groupName];
        lbSignLocation.text=self.group.groupAddress;
    }
    else if(self.listType == 1){
        
        if(self.channels.latitude<1){
            mapview.centerCoordinate=[VariableStore sharedInstance].coord;
        }
        else{
            [self refreshCnlUserLocaton];
            self.addressType = 1;
        }
        
        if(self.channels.latitude < 1 && self.channels.didu_type == 1){
            [self getCnlAddress];
        }
        lbSignLocation.numberOfLines=0;
        lbGroupNameTitle.text=[NSString stringWithFormat:@"%@位置：",self.channels.chnl_name];
        lbSignLocation.text=self.channels.grp_addr;
    }
    //中小集团
      else if(self.listType == 2){
         if([[_littleDict objectForKey:@"longtitude"] isEqualToString:@""] ){
            //没有位置信息
             mapview.centerCoordinate=[VariableStore sharedInstance].coord;
             self.addressType = 3;
             [self MyPostion];
          }
          else{
              //位置来自上一次提交位置
              [self refreshLittleGrounpLocaton];
              self.addressType = 1;
          }
                lbSignLocation.numberOfLines=0;
          lbGroupNameTitle.text=[NSString stringWithFormat:@"%@位置：",[_littleDict objectForKey:@"grp_name"]];
          lbSignLocation.text=[_littleDict objectForKey:@"grp_addr"];
      }
    
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    switch (_addressType) {
        case 1:
            [self showTips:@"该位置来自上一次提交位置"];
            break;
        case 2:
            [self showTips:@"该位置来自百度定位"];
            break;
        case 3:
            [self showTips:@"该位置来自手机GPS定位！"];
            break;

        default:
            break;
    }
}
-(void)getCnlAddress{
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    [bDict setObject:self.channels.grp_addr forKey:@"grp_addr"];
    
    [NetworkHandling sendPackageWithUrl:@"grpuserlink/getgrpAddr" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        if(!error){
            NSLog(@"sign in success");
            BOOL flag=[[result objectForKey:@"is_null"] boolValue];
            if(flag){
                [self performSelectorOnMainThread:@selector(refreshUserLocationWithRequestBaidu:) withObject:result waitUntilDone:YES];
            }
            else{
                self.addressType=3;
            }
        }
        else{
            self.addressType = 4;
            
        }
        hubFlag=NO;
    }];
}

-(void)getGroupAddress{
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    [bDict setObject:self.group.groupAddress forKey:@"grp_addr"];
    
    [NetworkHandling sendPackageWithUrl:@"grpuserlink/getgrpAddr" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        if(!error){
            NSLog(@"sign in success");
            BOOL flag=[[result objectForKey:@"is_null"] boolValue];
            if(flag){
                [self performSelectorOnMainThread:@selector(refreshUserLocationWithRequestBaidu:) withObject:result waitUntilDone:YES];
            }
            else{
                self.addressType=3;
            }
        }
        else{
            self.addressType = 4;

        }
        hubFlag=NO;
    }];
}
-(void)refreshUserLocationWithRequestBaidu:(NSDictionary*)dict{
    NSString *latitude=[dict objectForKey:@"latitude"];
    NSString *longitude=[dict objectForKey:@"longtitude"];
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(latitude.doubleValue, longitude.doubleValue);
    mapview.centerCoordinate = coord;
    mapview.zoomLevel=16;
    
    BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
    item.coordinate=mapview.centerCoordinate;
    if (self.listType == 0) {
        item.title = self.group.groupName;
        item.subtitle = self.group.groupAddress;//子标题
    }
    else if(self.listType == 1){
        item.title = self.channels.chnl_name;
        item.subtitle = self.channels.grp_addr;//子标题
    }
    [mapview addAnnotation:item];
    
    self.addressType = 2;
}

-(void)refreshCnlUserLocaton{
    [mapview removeAnnotations:mapview.annotations];
    
    mapview.centerCoordinate=CLLocationCoordinate2DMake(self.channels.latitude, self.channels.longtitude);
    BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
    item.coordinate=mapview.centerCoordinate;
    item.title = self.channels.grp_addr;//子标题
    [mapview addAnnotation:item];
    lbSignLocation.text=self.channels.grp_addr;
   self.addressType = 1;
    mapview.zoomLevel=13;
    
}
//中小集团位置
-(void)refreshLittleGrounpLocaton{
    
            [mapview removeAnnotations:mapview.annotations];
    NSString *latitude=[_littleDict objectForKey:@"latitude"];
    NSString *longitude=[_littleDict objectForKey:@"longtitude"];
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(latitude.doubleValue, longitude.doubleValue);
    mapview.centerCoordinate = coord;

        BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
        item.coordinate=mapview.centerCoordinate;
    item.title = [_littleDict objectForKey:@"grp_addr"];//子标题
        [mapview addAnnotation:item];
//        self.addressType = 1;
        mapview.zoomLevel=13;
   
    
    
}
-(void)MyPostion{
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    [_locService startUserLocationService];
    BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
    item.coordinate = _currentSelectCoordinate;
//    item.title = info.name;
//    item.subtitle=info.address;
    [mapview addAnnotation:item];
    mapview.zoomLevel=13;

}
//从选择地址页面返回时刷新地图显示
-(void)forBackMap:(NSDictionary*)backDict{
    
    [mapview removeAnnotations:mapview.annotations];
    NSString *latitude=[backDict objectForKey:@"latitude"];
    NSString *longitude=[backDict objectForKey:@"longtitude"];
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(latitude.doubleValue, longitude.doubleValue);
    mapview.centerCoordinate = coord;
    
    BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
    item.coordinate=mapview.centerCoordinate; 
    item.title = [backDict objectForKey:@"address"];
    //子标题
    lbSignLocation.text=[backDict objectForKey:@"address"];
    [mapview addAnnotation:item];
    //        self.addressType = 1;
    mapview.zoomLevel=13;

}

-(void)refreshUserLocaton{
    
    [mapview removeAnnotations:mapview.annotations];
    
    mapview.centerCoordinate=CLLocationCoordinate2DMake(self.group.groupLatitude, self.group.groupLongitude);
    BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
    item.coordinate=mapview.centerCoordinate;
    item.title = self.group.groupAddress;//子标题
    [mapview addAnnotation:item];
    lbSignLocation.text=self.group.groupAddress;
    self.addressType = 1;
    mapview.zoomLevel=13;
}
-(void)showTips:(NSString*)msg{
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.delegate = self;
    HUD.labelText = msg;
    [HUD show:YES];
    [HUD hide:YES afterDelay:1];
}

#pragma mark mapViewDelegate 代理方法
-(void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error{
    NSArray* array = [NSArray arrayWithArray:mapview.annotations];
    [mapview removeAnnotations:array];
    array = [NSArray arrayWithArray:mapview.overlays];
    [mapview removeOverlays:array];
    if (error == 0) {
        //没有位置信息时候，反地理定位当前位置
        BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
        item.coordinate = result.location;
        item.title = result.address;
        [mapview addAnnotation:item];
        mapview.centerCoordinate = result.location;
    
        lbSignLocation.text=result.address;
        mapview.zoomLevel=13;
        

        //        NSString* titleStr;
        //        NSString* showmeg;
        //        titleStr = @"反向地理编码";
        //        showmeg = [NSString stringWithFormat:@"%@",item.title];
        
        //        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:titleStr message:showmeg delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
        //        [myAlertView show];
    }
}
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    locationDelay++;
    NSLog(@"didUpdateBMKUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
        if(locationDelay > 2){
        _currentSelectCoordinate=userLocation.location.coordinate;
            
        [_locService stopUserLocationService];
        
        BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
        reverseGeocodeSearchOption.reverseGeoPoint = userLocation.location.coordinate;
        BOOL flag = [geoSearch reverseGeoCode:reverseGeocodeSearchOption];
        if(flag)
        {
//            BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
//            
//            item.coordinate = _currentSelectCoordinate;
//            item.title = info.name;
//            item.subtitle=info.address;
//            [mapview addAnnotation:item];

            NSLog(@"反geo检索发送成功");
        }
        else
        {
            NSLog(@"反geo检索发送失败");
        }
    }
}

@end
