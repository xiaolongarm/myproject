//
//  W_VisitPlanAddSelectAddressController.m
//  CMCCMarketing
//
//  Created by gmj on 14-12-2.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import "W_VisitPlanAddSelectAddressController.h"
#import "W_VisitPlanAddViewController.h"

#import "NetworkHandling.h"
#import "MBProgressHUD.h"
#import "VariableStore.h"

@interface W_VisitPlanAddSelectAddressController ()<MBProgressHUDDelegate,BMKLocationServiceDelegate>{
    CLLocationCoordinate2D _currentSelectCoordinate;
    NSString *_currentSelectVisitAddress;
    int locationDelay;
    BMKGeoCodeSearch *geoSearch;
    BMKPoiSearch *poiSearch;
    
    BOOL hubFlag;
//    NSString *city;
    BMKLocationService *_locService;
    
}

@end

@implementation W_VisitPlanAddSelectAddressController


- (void)viewDidLoad
{
    [super viewDidLoad];
    searchbar.delegate=self;
    if(self.layoutSearchBar)
        searchbarLayoutConstraint.constant=64;
    [self initSubView];
}

-(void)initSubView{
    
    self.navigationItem.title = @"选择地址";
    UIBarButtonItem *rightButton=[[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(chooseAddress)];
    [rightButton setTintColor:[UIColor whiteColor]];
    [self.navigationItem setRightBarButtonItem:rightButton];
    //传入地图缺省值
    
    [_mapView removeAnnotations:_mapView.annotations];
    if (self.listType == 2) {
        //中小集团位置
        NSString *latitude=[_rDict objectForKey:@"latitude"];
        NSString *longitude=[_rDict objectForKey:@"longtitude"];
        CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(latitude.doubleValue, longitude.doubleValue);
         _mapView.centerCoordinate = coord;
        
        BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
        item.coordinate=_mapView.centerCoordinate;
       item.title = [_rDict objectForKey:@"grp_addr"];;//子标题
        [_mapView addAnnotation:item];
    }
    else{
        _mapView.centerCoordinate=CLLocationCoordinate2DMake(self.group.groupLatitude, self.group.groupLongitude);
        BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
        item.coordinate=_mapView.centerCoordinate;
        item.title = self.group.groupAddress;//子标题
        [_mapView addAnnotation:item];

    }
   
//    lbSignLocation.text=self.group.groupAddress;
//    self.addressType = 1;
    //_mapView.zoomLevel=13;
    //******************************
    self.mapView.delegate=self;
    
    geoSearch=[[BMKGeoCodeSearch alloc] init];
    geoSearch.delegate=self;
    
    poiSearch = [[BMKPoiSearch alloc] init];
    poiSearch.delegate=self;
    
    self.mapView.centerCoordinate=[VariableStore sharedInstance].coord;
    self.mapView.zoomLevel=13;
}

-(void)chooseAddress{
    
    if (_currentSelectVisitAddress != nil && _currentSelectVisitAddress.length > 0 ) {
        
//        W_VisitPlanAddViewController *control = (W_VisitPlanAddViewController *)self.vc;
//        NSMutableDictionary *dicAdd = [[NSMutableDictionary alloc] init];
//        double lat = _currentSelectCoordinate.latitude;
//        double log = _currentSelectCoordinate.longitude;
//        [dicAdd setObject:[NSNumber numberWithDouble:lat] forKey:@"baidu_latitude"];
//        [dicAdd setObject:[NSNumber numberWithDouble:log] forKey:@"baidu_longitude"];
//        [dicAdd setObject:_currentSelectVisitAddress forKey:@"visit_grp_add"];
//        control.selectVisitAddressDic = dicAdd;
//        control.lbContactAddress.text = _currentSelectVisitAddress;
//        [self.navigationController popViewControllerAnimated:YES];
        
        [self.delegate w_visitPlanAddSelectAddressControllerDidFinished:_currentSelectCoordinate selectWithAddress:_currentSelectVisitAddress];
        [self.navigationController popViewControllerAnimated:YES];
        
    } else {
        
        MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:HUD];
        HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
        HUD.mode = MBProgressHUDModeCustomView;
        HUD.delegate = self;
        HUD.labelText = @"您还没有选择地址！";
        [HUD show:YES];
        [HUD hide:YES afterDelay:1];
    }

}

-(void)mapView:(BMKMapView *)mapView onClickedMapBlank:(CLLocationCoordinate2D)coordinate{
    if(!touchRemarkButton.selected)
        return;
    hubFlag=YES;
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"正在获取位置信息，请稍后...";
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
    
    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    reverseGeocodeSearchOption.reverseGeoPoint = coordinate;
    [geoSearch reverseGeoCode:reverseGeocodeSearchOption];

}
-(void)connectToNetwork{
    while (hubFlag) {
        usleep(100000);
    }
}

-(void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error{
   
    if (error == BMK_SEARCH_NO_ERROR) {
        NSArray *parray=result.poiList;
        BMKPoiInfo *pt=[parray firstObject];
        //在此处理正常结果
        BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
        item.coordinate = result.location;
        
        if(pt){
            item.title = pt.name;
            item.subtitle = pt.address;
//            NSString *selectAddressString=[NSString stringWithFormat:@"%@-%@",pt.name,pt.address];
            lbSelectAddress.text=[NSString stringWithFormat:@"已选择:%@",pt.address];
            _currentSelectVisitAddress = pt.address;
            _currentSelectCoordinate = result.location;
        }
        else{
            item.title = result.address;
            lbSelectAddress.text=[NSString stringWithFormat:@"已选择[%@]",result.address];
            _currentSelectVisitAddress = result.address;
            _currentSelectCoordinate = result.location;
        }
//        city=result.addressDetail.city;
        [self.mapView addAnnotation:item];
        self.mapView.centerCoordinate = result.location;
    }
    else {
        NSLog(@"抱歉，未找到结果");
        MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:HUD];
        HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
        HUD.mode = MBProgressHUDModeCustomView;
        HUD.delegate = self;
        HUD.labelText = @"抱歉，未找到结果";
        [HUD show:YES];
        [HUD hide:YES afterDelay:1];
    }
    
    hubFlag=NO;
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    hubFlag=YES;
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"正在获取位置信息，请稍后...";
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
    
    BMKCitySearchOption *citySearchOption = [[BMKCitySearchOption alloc]init];
    citySearchOption.pageCapacity = 10;
    citySearchOption.city= [VariableStore sharedInstance].city;
    citySearchOption.keyword = searchBar.text;
    BOOL flag = [poiSearch poiSearchInCity:citySearchOption];
//    initLocationFlag=NO;
    
    if(flag)
    {
        NSLog(@"geo检索发送成功");
    }
    else
    {
        NSLog(@"geo检索发送失败");
        
    }
    [searchBar resignFirstResponder];
}
-(void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view{
    BMKPointAnnotation *p=view.annotation;
    
    
    NSString *selectAddressString;
    if(p.subtitle.length > 0)
        selectAddressString=p.subtitle;
    else
        selectAddressString=p.title;
    lbSelectAddress.text=[NSString stringWithFormat:@"已选择:%@",selectAddressString];
    _currentSelectVisitAddress = selectAddressString;
    _currentSelectCoordinate = p.coordinate;
}
static UIEdgeInsets pinPadding = { 64.f, 64.f, 64.f, 64.f };
-(void)onGetPoiResult:(BMKPoiSearch *)searcher result:(BMKPoiResult *)poiResult errorCode:(BMKSearchErrorCode)errorCode{
    if (errorCode == BMK_SEARCH_NO_ERROR && poiResult.poiInfoList) {
        //在此处理正常结果
        NSArray *parray=poiResult.poiInfoList;
        
        BMKMapRect boundingRect = BMKMapRectNull;
        
        for (BMKPoiInfo *info in parray) {
            
            BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
            item.coordinate = info.pt;
            item.title = info.name;
            item.subtitle=info.address;
            [self.mapView addAnnotation:item];
            self.mapView.centerCoordinate = info.pt;
            
            BMKMapPoint mp = BMKMapPointForCoordinate(info.pt);
            BMKMapRect pRect = BMKMapRectMake(mp.x, mp.y, 0, 0);
            NSInteger i = [parray indexOfObject:info];
            if (i == 0) {
                boundingRect = pRect;
            } else {
                boundingRect = BMKMapRectUnion(boundingRect, pRect);
            }
        }
//        [self.mapView setVisibleMapRect:boundingRect animated:NO];
        if(!BMKMapRectIsNull(boundingRect) && boundingRect.size.height > 0 && boundingRect.size.width > 0)
            [self.mapView setVisibleMapRect:boundingRect edgePadding:pinPadding animated:NO];
        else if([parray count]>0){
            BMKPoiInfo *pi = [parray lastObject];
            self.mapView.centerCoordinate=pi.pt;
            self.mapView.zoomLevel=13;
        }
            
    }
    else {
        NSLog(@"抱歉，未找到结果");
        MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:HUD];
        HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
        HUD.mode = MBProgressHUDModeCustomView;
        HUD.delegate = self;
        HUD.labelText = @"抱歉，未找到结果";
        [HUD show:YES];
        [HUD hide:YES afterDelay:1];
    }
    
    hubFlag=NO;
}
//-(void)clearMap{
//    NSArray* array = [NSArray arrayWithArray:self.mapView.annotations];
//    [self.mapView removeAnnotations:array];
//    array = [NSArray arrayWithArray:self.mapView.overlays];
//    [self.mapView removeOverlays:array];
//
//}
- (IBAction)touchRemarkButtonOnclick:(id)sender {
    touchRemarkButton.selected=!touchRemarkButton.selected;
}
- (IBAction)updateUserCurrentLocationOnclick:(id)sender {
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    [_locService startUserLocationService];
    
    lbSelectAddress.text=@"正在获取当前位置...";

}
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    locationDelay++;
    NSLog(@"didUpdateBMKUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    //    [self mapView:mapView didUpdateBMKUserLocation:userLocation];
    if(locationDelay > 2){
        [_locService stopUserLocationService];
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
@end
