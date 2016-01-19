//
//  W_VisitPlanSignTableViewController.m
//  CMCCMarketing
//
//  Created by gmj on 14-11-27.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import "W_VisitPlanSignTableViewController.h"
#import "W_VisitPlanDetailsViewController.h"

#import "NetworkHandling.h"
#import "MBProgressHUD.h"
#import "VariableStore.h"
#import "UIImageView+WebCache.h"

@interface W_VisitPlanSignTableViewController ()<BMKMapViewDelegate,BMKGeoCodeSearchDelegate,BMKLocationServiceDelegate,MBProgressHUDDelegate,UIActionSheetDelegate>{
    
    BMKLocationService *_locService;
    CLLocationCoordinate2D _currentSelectCoordinate;
    int locationDelay;
    BMKGeoCodeSearch *geoSearch;
    BOOL isSuccessSubmit;

    BOOL hubFlag;
    BOOL isSign;
    NSString *kUTTypeImage;
    
    UIImageView *zoomImageView;
}

@end

@implementation W_VisitPlanSignTableViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization3
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //传入地图缺省值
    self.mapView.centerCoordinate=[VariableStore sharedInstance].coord;
    self.mapView.zoomLevel=13;
    //未获取精准位置前，签到按钮不可点击
    signButton.enabled=NO;

    isSign=NO;
    kUTTypeImage=@"public.image";
    [self initSubView];
    
    CGSize size =[[UIScreen mainScreen] bounds].size;
    zoomImageView = [[UIImageView alloc] init];
    zoomImageView.frame = CGRectMake(0, 0, size.width, size.height);
    zoomImageView.backgroundColor=[UIColor blackColor];
    [zoomImageView setUserInteractionEnabled:YES];
    UITapGestureRecognizer *singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap1:)];
    [zoomImageView addGestureRecognizer:singleTap1];
}
-(void)handleSingleTap1:(UIGestureRecognizer *)gestureRecognizer{
    [zoomImageView removeFromSuperview];
}


-(void)initSubView{
    
    
//    NSString *latitude=[self.dicSelectVisitPlanDetail objectForKey:@"latitude0"];
//    NSString *longitude=[self.dicSelectVisitPlanDetail objectForKey:@"longitude0"];
//    if(latitude && (NSNull*)latitude!=[NSNull null] && latitude.length > 0)
//        isSign=YES;
    
    self.navigationItem.title = @"拜访签到";
    
   
//    if(!isSign){
//        UIBarButtonItem *rightButton=[[UIBarButtonItem alloc]initWithTitle:@"拍照" style:UIBarButtonItemStylePlain target:self action:@selector(takePhoto)];
//        [rightButton setTintColor:[UIColor whiteColor]];
//        [self.navigationItem setRightBarButtonItem:rightButton];
//
//    }
//    else{
//        signButton.hidden=YES;
//        refreshLocationButton.hidden=YES;
//    }
    self.scrollView.contentSize = self.view.frame.size;
    
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
//        _locService = [[BMKLocationService alloc]init];
//        _locService.delegate = self;
//        [_locService startUserLocationService];
//        
//        geoSearch=[[BMKGeoCodeSearch alloc] init];
//        geoSearch.delegate=self;
//    }
//    else{
//        self.lblCurrentLocation.text=[self.dicSelectVisitPlanDetail objectForKey:@"signin_addr0"];
//        self.lblSignTime.text=[self.dicSelectVisitPlanDetail objectForKey:@"client_date0"];
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
//            if( self.mapView.hidden)
//                self.mapView.hidden=NO;
//        }
//        
//        NSString *imageUrl=[self.dicSelectVisitPlanDetail objectForKey:@"singnin_url"];
//        if(imageUrl && (NSNull*)imageUrl != [NSNull null] && imageUrl.length > 0){
//            NSURL *url = [NSURL URLWithString:imageUrl];
//            dispatch_queue_t queue =dispatch_queue_create("loadImage",NULL);
//            dispatch_async(queue, ^{
//                
//                NSData *resultData = [NSData dataWithContentsOfURL:url];
//                UIImage *img = [UIImage imageWithData:resultData];
//                if(img){
//                    dispatch_sync(dispatch_get_main_queue(), ^{
//                        
//                        self.imgViewSign.image = img;
//                    });
//                }
//            });
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
    [paramDict setObject:@"0" forKey:@"sign_type"];
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
    
            UIBarButtonItem *rightButton=[[UIBarButtonItem alloc]initWithTitle:@"拍照" style:UIBarButtonItemStylePlain target:self action:@selector(takePhoto)];
            [rightButton setTintColor:[UIColor whiteColor]];
            [self.navigationItem setRightBarButtonItem:rightButton];
    

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
    //显示签到图片
    if(![[recipeDict objectForKey:@"singnin_url"] isEqualToString:@""])
    {
        NSURL *sinurl = [NSURL URLWithString:[recipeDict objectForKey:@"singnin_url"]];
        [self.imgViewSign sd_setImageWithURL:sinurl];
    }
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
    //屏蔽从照片库选取照片
//    UIActionSheet *actionSheet=[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取 消" destructiveButtonTitle:@"相 机" otherButtonTitles:@"照片库", nil];
     UIActionSheet *actionSheet=[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取 消" destructiveButtonTitle:@"相 机" otherButtonTitles:nil, nil];
    actionSheet.tag=2;
    [actionSheet showInView:self.view];
//    [self addOfCamera];
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 0){
        [self itemPhotographButtonOnclick:buttonIndex];
    }
    
}
-(void)itemPhotographButtonOnclick:(int)typeId{
    //检查相机模式是否可用
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        NSLog(@"sorry, no camera or camera is unavailable.");
        return;
    }
    
    //创建图像选取控制器
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    //设置图像选取控制器的来源模式为相机模式
    if(!typeId)
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    else
        imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    //设置图像选取控制器的类型为静态图像
    imagePickerController.mediaTypes = [[NSArray alloc] initWithObjects:kUTTypeImage, nil];
    //允许用户进行编辑
    imagePickerController.allowsEditing = YES;
    //设置委托对象
    imagePickerController.delegate = self;
    //以模视图控制器的形式显示
    [self presentViewController:imagePickerController animated:YES completion:nil];
}
#pragma mark –
#pragma mark Camera View Delegate Methods
//点击相册中的图片或者照相机照完后点击use 后触发的方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *image;
    [picker dismissViewControllerAnimated:YES completion:nil];//关掉照相机
    image = [info objectForKey:UIImagePickerControllerEditedImage];
    
    //把选中的图片添加到界面中
    //    [self performSelector:@selector(saveImage:) withObject:image afterDelay:0.5];
    [self performSelectorOnMainThread:@selector(saveImage:) withObject:image waitUntilDone:YES];
}

//点击cancel调用的方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}
//把图片添加到当前view中
- (void)saveImage:(UIImage *)image {
    self.imgViewSign.image = image;
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
    
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    NSString *client_os = @"ios";
    [bDict setObject:client_os forKey:@"client_os"];
    
    [bDict setObject:@"0" forKey:@"sign_type"];
    NSString *visit_id = [self.dicSelectVisitPlanDetail objectForKey:@"row_id"];
    [bDict setObject:visit_id forKey:@"visit_id"];
    [bDict setObject:self.lblSignTime.text forKey:@"client_date"];
    [bDict setObject:self.lblCurrentLocation.text forKey:@"signin_addr"];
    [bDict setValue:[NSNumber numberWithDouble:_currentSelectCoordinate.longitude] forKey:@"longitude"];
    [bDict setValue:[NSNumber numberWithDouble:_currentSelectCoordinate.latitude] forKey:@"latitude"];
    [bDict setObject:[NSNumber numberWithDouble:_currentSelectCoordinate.longitude] forKey:@"baidu_longitude"];
    [bDict setObject:[NSNumber numberWithDouble:_currentSelectCoordinate.latitude] forKey:@"baidu_latitude"];
    [bDict setObject:@"" forKey:@"img_url"];
    
    NSString *grp_code = [self.dicSelectVisitPlanDetail objectForKey:@"visit_grp_code"];
    [bDict setObject:grp_code forKey:@"grp_code"];
    NSString *grp_name = [self.dicSelectVisitPlanDetail objectForKey:@"visit_grp_name"];
    [bDict setObject:grp_name forKey:@"grp_name"];
    
    [bDict setObject:[[UIDevice currentDevice].identifierForVendor UUIDString] forKey:@"device_id"];
    [bDict setObject:[NSNumber numberWithInt:self.user.userEnterprise] forKey:@"enterprise"];
    int uid = self.user.userID;
    NSString *reply_user_id = [NSString stringWithFormat:@"%d",uid];
    [bDict setObject:reply_user_id forKey:@"user_id"];
    
    hubFlag=YES;
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"数据提交中，请稍后...";
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
    
    [self postData:bDict];
    
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
-(NSString*)jpgPath{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMddHHmmssSSS"];
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    currentDateStr=[currentDateStr stringByAppendingString:@".jpg"];
    return currentDateStr;
}
-(void)postData:(NSMutableDictionary*)bDict {
    
    NSString *nettype=[NetworkHandling GetCurrentNet];
    if(!nettype){
        hubFlag=NO;
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"错误" message:@"当前没有连接网络，无法提交数据！" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"关闭", nil];
        [alertView show];
        return;
    }

    UIImage *pic = self.imgViewSign.image;
    if (pic) {
        
        NSString *picName=[self jpgPath];
        [bDict setObject:picName forKey:@"img_url"];//设置图片名称
        int visit_id = [[self.dicSelectVisitPlanDetail objectForKey:@"row_id"] intValue];
//        NSString *paramString=[NSString stringWithFormat:@"?type='visitplan/%d/'",visit_id];
        
        
        [NetworkHandling UploadsyntheticPictures:pic currentPicName:picName currentUser:visit_id uploadType:@"visitplan" completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
            if(!error){
                NSDictionary *d1=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                BOOL f1=[[d1 objectForKey:@"imgUpload"] boolValue];
                if(f1){
                    NSLog(@"%@图片上传成功。。。",picName);
                    
                    [self submitLocationData:bDict];
                    
                }else{
                    
                    NSLog(@"%@图片上传失败。。。",picName);
                }
                
            }else{
                
                NSLog(@"error");
            }
            
        }];
        
    } else {
        
        [self submitLocationData:bDict];
    }
    
}

-(void)submitLocationData:(NSMutableDictionary*)bDict{

    [NetworkHandling sendPackageWithUrl:@"visitplan/visitplansign" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        hubFlag=NO;
        if(!error){
            
            NSLog(@"sign in success");
            BOOL flag=[[result objectForKey:@"flag"] boolValue];
            if(flag){
                [self performSelectorOnMainThread:@selector(signSuccesss) withObject:nil waitUntilDone:YES];
            }else{
                
                [self performSelectorOnMainThread:@selector(showMessage:) withObject:@"签到失败！" waitUntilDone:YES];
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
    /**
     *  发送签到转态给上一页
     */
    NSString *sigInedstauts=@"1";
    [[NSNotificationCenter defaultCenter]postNotificationName:@"SignInNotification" object:sigInedstauts];
    [self.navigationController popViewControllerAnimated:YES];
//    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (IBAction)zoomImageOnclick:(id)sender {
    if(!self.imgViewSign.image)
        return;
    
    zoomImageView.image=self.imgViewSign.image;
    zoomImageView.contentMode=UIViewContentModeScaleAspectFit;
    [self.navigationController.view addSubview:zoomImageView];
}

@end
