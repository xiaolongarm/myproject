//
//  BuildingDetailViewController.m
//  CMCCMarketing
//
//  Created by kevin on 15/8/24.
//  Copyright (c) 2015年 talkweb. All rights reserved.
//

#import "BuildingDetailViewController.h"
#import "NetworkHandling.h"
#import "MBProgressHUD.h"
@interface BuildingDetailViewController ()<MBProgressHUDDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIAlertViewDelegate,UIActionSheetDelegate>{
    UIImageView *zoomOutImageView;
    NSString *kUTTypeImage;
    
    BOOL isUpdateImage;
    BOOL hubFlag;
    int lastPhotograghImageViewIndex;
    BOOL isUploadFinished;
    BOOL isUploadError;
    
    NSMutableArray *upLoadImageBuffer;
}

@end

@implementation BuildingDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    upLoadImageBuffer=[[NSMutableArray alloc] init];
    
    #if (defined STANDARD_CS_VERSION)
    //提交按钮
    UIBarButtonItem *rightButton=[[UIBarButtonItem alloc]initWithTitle:@"上传" style:UIBarButtonItemStylePlain target:self action:@selector(UploadPic)];
    [rightButton setTintColor:[UIColor whiteColor]];
    [self.navigationItem setRightBarButtonItem:rightButton];
   #endif
    #if (defined MANAGER_CS_VERSION)
    self.cameralButton.hidden=YES;

#endif
     kUTTypeImage=@"public.image";
    /**
     *  查看大图方法
     */
    CGSize size =[[UIScreen mainScreen] bounds].size;
    zoomOutImageView = [[UIImageView alloc] init];
    zoomOutImageView.frame = CGRectMake(0, 0, size.width, size.height);
    zoomOutImageView.backgroundColor=[UIColor blackColor];
    [zoomOutImageView setUserInteractionEnabled:YES];
    UITapGestureRecognizer *singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap1:)];
    [zoomOutImageView addGestureRecognizer:singleTap1];
    /**
     添加单击手势查看大图
     */
    //必须开启imageView setUserInteractionEnable 属性，手势才能响应
    [self.buildingPic1 setUserInteractionEnabled:YES];
    
    [self.buildingPic1 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ThouchBuildingPic1:)]];
    //必须开启imageView setUserInteractionEnable 属性，手势才能响应
     [self.buildingPic2 setUserInteractionEnabled:YES];
    
    [self.buildingPic2 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ThouchBuildingPic2:)]];
    /**
     *  长按删除已选照片
     */
    [self.buildingPic1 addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(LongpressGesture1:)]];
    
    [self.buildingPic2 addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(LongpressGesture2:)]];

    self.buildingName.text=[_recipeDict objectForKey:@"market_name"];
     self.buildingCity.text=[_recipeDict objectForKey:@"b_cnty_name"];
     self.buildingStreet.text=[_recipeDict objectForKey:@"b_street"];
     self.buildingDetail.text=[_recipeDict objectForKey:@"market_address"];
     self.marketType.text=[_recipeDict objectForKey:@"market_tpye"];
    
    NSArray *urlArray=[[_recipeDict objectForKey:@"image_url"] componentsSeparatedByString:@","] ;
    NSString *nsstring0=@"";
    NSString *nsstring1=@"";
   
   if ([urlArray count]==2){
        nsstring0=[urlArray objectAtIndex:0];
        nsstring1=[urlArray objectAtIndex:1];
    }
    else if ([urlArray count]==1){
        nsstring0=[urlArray objectAtIndex:0];
    }
    //    else if ([urlArray count]==0){
    //
    //    }
    
    UIActivityIndicatorView *indicatorView=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicatorView.center=CGPointMake(_buildingPic2.frame.size.width/2, _buildingPic2.frame.size.height/2);
    [indicatorView startAnimating];
    [_buildingPic2 addSubview:indicatorView];
    
    //    NSURL *url = [NSURL URLWithString:[urlArray objectAtIndex:0]];
    dispatch_queue_t queue =dispatch_queue_create("loadImage",NULL);
    dispatch_async(queue, ^{
        //        for (NSString *urlString in urlArray) {
        //            urlString
        //        }
        NSData *resultData1 = [NSData dataWithContentsOfURL:[NSURL URLWithString:nsstring0]];
        NSData *resultData2 = [NSData dataWithContentsOfURL:[NSURL URLWithString:nsstring1]];
     
        // UIImage *img = [UIImage imageWithData:resultData];
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            _buildingPic1.image=[UIImage imageWithData:resultData1];
            _buildingPic2.image=[UIImage imageWithData:resultData2];
            
            [indicatorView removeFromSuperview];
        });
        
    });
     //self.buildingName.text=[_recipeDict objectForKey:@""];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark -长按删除照片
-(void)LongpressGesture1:(UILongPressGestureRecognizer *)gestureRecognizer{
    if(gestureRecognizer.state==UIGestureRecognizerStateEnded){
        return;
    }
    else if(gestureRecognizer.state==UIGestureRecognizerStateBegan){
        if(!self.buildingPic1.image)
            return;
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"警告" message:@"您确定要删除当前选择的图片吗照片吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
        alertView.tag=1;
        
        self.buildingPic1.layer.borderColor=[UIColor redColor].CGColor;
        self.buildingPic1.layer.borderWidth=1;
        
    }
}
-(void)LongpressGesture2:(UILongPressGestureRecognizer *)gestureRecognizer{
    if(gestureRecognizer.state==UIGestureRecognizerStateEnded){
        return;
    }
    else if(gestureRecognizer.state==UIGestureRecognizerStateBegan){
        if(!self.buildingPic2.image)
            return;
        
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"警告" message:@"您确定要删除当前选择的图片吗照片吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
        alertView.tag=2;
        
        self.buildingPic2.layer.borderColor=[UIColor redColor].CGColor;
        self.buildingPic2.layer.borderWidth=1;
        
    }
}
//-(void)handleLongpressGesture3:(UILongPressGestureRecognizer *)gestureRecognizer{
//    if(gestureRecognizer.state==UIGestureRecognizerStateEnded){
//        return;
//    }
//    else if(gestureRecognizer.state==UIGestureRecognizerStateBegan){
//        if(!self.imgView3.image)
//            return;
//        
//        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"警告" message:@"您确定要删除当前选择的图片吗照片吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//        [alertView show];
//        alertView.tag=3;
//        
//        self.imgView3.layer.borderColor=[UIColor redColor].CGColor;
//        self.imgView3.layer.borderWidth=1;
//        
//    }
//}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex){
        switch (alertView.tag) {
            case 1:
                self.buildingPic1.image=nil;
                self.buildingPic1.layer.borderWidth=0;
                break;
            case 2:
                self.buildingPic2.image=nil;
                self.buildingPic2.layer.borderWidth=0;
                break;
//            case 3:
//                self.imgView3.image=nil;
//                self.imgView3.layer.borderWidth=0;
//                break;
                
            default:
                break;
        }
    }
}


#pragma mark -拍照方法
- (IBAction)takeCameral:(id)sender {
    UIActionSheet *actionSheet=[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取 消" destructiveButtonTitle:@"相 机" otherButtonTitles:@"照片库", nil];
    actionSheet.tag=2;
    [actionSheet showInView:self.view];
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 0 || buttonIndex ==1){
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
    isUpdateImage=YES;
    lastPhotograghImageViewIndex++;
    
    [self getPhotograghImageView:lastPhotograghImageViewIndex].image = image;
}
-(UIImageView*)getPhotograghImageView:(int)index{
    if(!self.buildingPic1.image){
        lastPhotograghImageViewIndex=1;
        return self.buildingPic1;
    }
    if(!self.buildingPic2.image){
        lastPhotograghImageViewIndex=2;
        return self.buildingPic2;
    }
//    if(!self.imgView3.image){
//        lastPhotograghImageViewIndex=3;
//        return self.imgView3;
//    }
    
    switch (index) {
        case 1:
            return self.buildingPic1;
            break;
        case 2:
            return self.buildingPic2;
            break;
//        case 3:
//            return self.imgView3;
//            break;
        default:
            lastPhotograghImageViewIndex=1;
            return self.buildingPic1;
            break;
    }
}


#pragma mark -查看大图
//- (IBAction)zoomPictuer:(id)sender
-(void)ThouchBuildingPic1:(UIGestureRecognizer *)gestureRecognizer
{
    if(!self.buildingPic1.image)
        return;
    
    zoomOutImageView.image=self.buildingPic1.image;
    zoomOutImageView.contentMode=UIViewContentModeScaleAspectFit;
    [self.navigationController.view addSubview:zoomOutImageView];
}
//- (IBAction)zoomPic2:(id)sender
-(void)ThouchBuildingPic2:(UIGestureRecognizer *)gestureRecognizer

{
    if(!self.buildingPic2.image)
        return;
    
    zoomOutImageView.image=self.buildingPic2.image;
    zoomOutImageView.contentMode=UIViewContentModeScaleAspectFit;
    [self.navigationController.view addSubview:zoomOutImageView];
}
-(void)handleSingleTap1:(UIGestureRecognizer *)gestureRecognizer{
    [zoomOutImageView removeFromSuperview];
}


-(void)UploadPic{

NSString *nettype=[NetworkHandling GetCurrentNet];
if(!nettype){
    hubFlag=NO;
    UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"错误" message:@"当前没有连接网络，无法提交数据！" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"关闭", nil];
    [alertView show];
    return;
}

hubFlag=YES;
MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
[self.view addSubview:HUD];
HUD.delegate=self;
HUD.labelText=@"正在上载图片...";
[HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];

NSMutableDictionary *bDict = [[NSMutableDictionary alloc] init];
//
//        if(![[self.recipeDict objectForKey:@"image_url"] isEqualToString:@""]){
//            NSString *pic=[self.recipeDict objectForKey:@"image_url"];
//            NSArray *tmpArray=[pic componentsSeparatedByString:@","];
//            NSString *urlString=@"";
//            for (NSString *s in tmpArray) {
//                NSArray *arr=[s componentsSeparatedByString:@"/"];
//                NSString *name=[arr lastObject];
//                if([urlString isEqualToString:@""])
//                    urlString=name;
//                else
//                    urlString=[urlString stringByAppendingFormat:@",%@",name];
//            }
//            [bDict setObject:urlString forKey:@"img_url"];
//        }
//        else{
          [bDict setObject:@"" forKey:@"img_url"];
    //设置图片名称
       // }
        
if(isUpdateImage){
    if(self.buildingPic1.image)
        [upLoadImageBuffer addObject:self.buildingPic1.image];
    if(self.buildingPic2.image)
        [upLoadImageBuffer addObject:self.buildingPic2.image];
//            if(self.imgView3.image)
//                [upLoadImageBuffer addObject:self.imgView3.image];
}
if ([upLoadImageBuffer count] > 0) {
    [self submitPhotoWithDict:bDict withProgressHud:HUD uploadIndex:1];
} else {
    
    [self submitData:bDict submitdataState:HUD];
}

}

-(void)submitPhotoWithDict:(NSMutableDictionary*)bDict withProgressHud:(MBProgressHUD*)HUD uploadIndex:(int)index{
if(isUploadError)
    return;
UIImage *pic=[self popUploadImageFromBuffer];

if(isUploadFinished){
    [self submitData:bDict submitdataState:HUD];
    return;
}

HUD.labelText=[NSString stringWithFormat:@"正在上传第 %d 张图片...",index];
index++;
NSString *typeString=[NSString stringWithFormat:@"?type=building/%@",[_recipeDict objectForKey:@"market_code"]];
NSString *picName=[self getJPGFileName];
NSString *pn=[bDict objectForKey:@"img_url"];
if([pn isEqualToString:@""])
    pn=picName;
else
    pn=[pn stringByAppendingFormat:@",%@",picName];
    
[bDict setObject:pn forKey:@"img_url"];
[NetworkHandling UploadsyntheticPictures:pic currentPicName:picName uploadType:typeString completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
    
    if(!error){
        NSDictionary *d1=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        BOOL f1=[[d1 objectForKey:@"imgUpload"] boolValue];
        if(f1){
            [self submitPhotoWithDict:bDict withProgressHud:HUD uploadIndex:index];
        }
        else
            isUploadError=YES;
    }
    else
        isUploadError=YES;
}];
}
-(UIImage*)popUploadImageFromBuffer{

if([upLoadImageBuffer count] == 0){
    isUploadFinished=YES;
    return nil;
}

UIImage *image=[upLoadImageBuffer objectAtIndex:0];
[upLoadImageBuffer removeObjectAtIndex:0];
return image;

}
-(void)submitData:(NSMutableDictionary*)bDict submitdataState:(MBProgressHUD*)HUD{
HUD.labelText=@"正在提交数据...";
//        if (self.selectedWorkRecord) {//编辑模式
//            
//            /*
//             
//             shaoyang\v1_4\daily\upddaily
//             daily_content 日报内容
//             daily_id 日报id
//             img_url 图片名称
//             
//             */
//            
//            //        int userId = self.user.userID;
//            //        [bDict setObject:[NSString stringWithFormat:@"%d",userId] forKey:@"daily_user_id"];
//            //
//            //        NSString *userName = self.user.userName;
//            //        [bDict setObject:userName forKey:@"daily_user_name"];
//            
//            //        NSString *phone = self.user.userMobile;
//            //        [bDict setObject:phone forKey:@"daily_msisdn"];
//            
//            //        [bDict setObject:@"2015-01-17" forKey:@"daily_date"];
//            int userId = self.user.userID;
//            [bDict setObject:[NSString stringWithFormat:@"%d",userId] forKey:@"user_id"];
//            
//            [bDict setObject:self.lblDate.text forKey:@"daily_date"];
//            
//            NSString *content = self.txtViewContent.text;
//            [bDict setObject:content forKey:@"daily_content"];
//            
//            NSString *wrId = [self.selectedWorkRecord objectForKey:@"daily_id"];
//            [bDict setObject:wrId forKey:@"daily_id"];
//            
//            
//            [NetworkHandling sendPackageWithUrl:@"daily/upddaily" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
//                hubFlag=NO;
//                if(!error){
//                    
//                    NSLog(@"sign in success");
//                    BOOL flag=[[result objectForKey:@"flag"] boolValue];
//                    if(flag){
//                        
//                        [self performSelectorOnMainThread:@selector(submitSuccess) withObject:nil waitUntilDone:YES];
//                        
//                    }else{
//                        
//                        [self performSelectorOnMainThread:@selector(showMessage:) withObject:@"编辑失败！" waitUntilDone:YES];
//                    }
//                    
//             }else{

//                    int errorCode=[[result valueForKey:@"errorcode"] intValue];
//                    NSString *errorInfo=[result valueForKey:@"errorinf"];
//                    if(!errorInfo)
//                        errorInfo=@"提交数据出错了！";
//                    NSLog(@"error:%d info:%@",errorCode,errorInfo);
//                    [self performSelectorOnMainThread:@selector(showMessage:) withObject:errorInfo waitUntilDone:YES];
//                }
//                
//            }];
//            
//            
//        } else {

    /*
     changsha\v1_7\msgrpuserlink\updBuildingInfo
     必传参数
     market_code 楼宇编码
     img_url 图片url
     上报图片的参数type值 building/楼宇编码

     */
    
//            int userId = self.user.userID;
//            [bDict setObject:[NSString stringWithFormat:@"%d",userId] forKey:@"daily_user_id"];
//            
//            NSString *userName = self.user.userName;
//            [bDict setObject:userName forKey:@"daily_user_name"];

//            NSString *phone = self.user.userMobile;
    [bDict setObject:[_recipeDict objectForKey:@"market_code"] forKey:@"market_code"];
    
    //        [bDict setObject:@"2015-01-17" forKey:@"daily_date"];
  //  [bDict setObject:self.lblDate.text forKey:@"daily_date"];
//            NSString *content = self.txtViewContent.text;
//            [bDict setObject:content forKey:@"daily_content"];

    [NetworkHandling sendPackageWithUrl:@"msgrpuserlink/updBuildingInfo" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        hubFlag=NO;
        if(!error){
            
            NSLog(@"sign in success");
            BOOL flag=[[result objectForKey:@"flag"] boolValue];
            if(flag){
                
                [self performSelectorOnMainThread:@selector(submitSuccess) withObject:nil waitUntilDone:YES];
                
            }else{
                
                [self performSelectorOnMainThread:@selector(showMessage:) withObject:@"提交失败！" waitUntilDone:YES];
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
    
    
//}

}

-(void)submitSuccess{
//[self.navigationController popViewControllerAnimated:YES];
//    [self.navigationController popViewControllerAnimated:YES];
}

-(NSString*)getJPGFileName{
NSDate *de = [NSDate date];
NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
[dateFormatter setDateFormat:@"yyyyMMddHHmmssSSS"];
NSString *picName = [dateFormatter stringFromDate:de];
return [NSString stringWithFormat:@"%@.jpg",picName];
}

#pragma mark -网络API相关
-(void)connectToNetwork{
while (hubFlag) {
usleep(100000);
}
}
-(void)showMessage:(NSString*)infomation{

UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"信息提示" message:infomation delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
[myAlertView show];
}



@end
