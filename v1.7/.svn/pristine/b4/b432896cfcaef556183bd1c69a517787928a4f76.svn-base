//
//  WorkRecordAddViewController.m
//  CMCCMarketing
//
//  Created by gmj on 15-1-26.
//  Copyright (c) 2015年 talkweb. All rights reserved.
//

#import "WorkRecordAddViewController.h"

#import "NetworkHandling.h"
#import "MBProgressHUD.h"

//#import "PreferentialPurchaseSelectDateTimeViewController.h"

@interface WorkRecordAddViewController ()<UITextViewDelegate,UIActionSheetDelegate,MBProgressHUDDelegate,UIAlertViewDelegate,UIActionSheetDelegate> {
    
    BOOL hubFlag;
    
    UIView *backView;
//    PreferentialPurchaseSelectDateTimeViewController *selectDateTimeViewController;
    UIButton *selectDateBtn;
    BOOL isUpdateImage;
    
    int lastPhotograghImageViewIndex;
    BOOL isUploadFinished;
    BOOL isUploadError;
    
    NSMutableArray *upLoadImageBuffer;
    
}

@end

@implementation WorkRecordAddViewController

//#pragma mark - PreferentialPurchaseSelectDateTimeViewControll delegate
//
//-(void)preferentialPurchaseSelectDateTimeViewControllerDidCancel{
//    
//    [backView removeFromSuperview];
//    [selectDateTimeViewController.view removeFromSuperview];
//    
//    backView=nil;
//    selectDateTimeViewController=nil;
//}
//
//-(void)preferentialPurchaseSelectDateTimeViewControllerDidFinished:(PreferentialPurchaseSelectDateTimeViewController *)controller{
//    
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
//    NSString *dateString=[dateFormatter stringFromDate:controller.datetimePicker.date];
//    self.lblDate.text = dateString;
//    [self preferentialPurchaseSelectDateTimeViewControllerDidCancel];
//    
//}

//- (IBAction)selectDate:(id)sender{
//    
//    selectDateBtn = sender;
//    
//    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"BusinessProcess" bundle:nil];
//    selectDateTimeViewController=[storyboard instantiateViewControllerWithIdentifier:@"PreferentialPurchaseSelectDateTimeViewControllerId"];
//    selectDateTimeViewController.delegate=self;
//    selectDateTimeViewController.modeDateAndTime=1;
//    CGRect rect=selectDateTimeViewController.view.frame;
//    
//    rect.origin.x=0;
//    rect.origin.y=[[UIScreen mainScreen] bounds].size.height - 300;
//    rect.size.width=320;
//    rect.size.height=300;
//    
//    selectDateTimeViewController.view.frame=rect;
//    selectDateTimeViewController.view.layer.borderWidth=1;
//    selectDateTimeViewController.view.layer.borderColor=[UIColor colorWithRed:55/255.0 green:132/255.0 blue:173/255.0 alpha:1.0].CGColor;
//    selectDateTimeViewController.view.layer.shadowOffset = CGSizeMake(2, 2);
//    selectDateTimeViewController.view.layer.shadowOpacity = 0.80;
//    
//    backView=[[UIView alloc] init];
//    backView.backgroundColor=[UIColor blackColor];
//    backView.alpha=0.1;
//    
//    backView.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
//    [self.view addSubview:backView];
//    [self.view addSubview:selectDateTimeViewController.view];
//    
//    
//}




#pragma mark - UITextView delegate

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    
    CGRect rect=self.view.frame;
    rect.origin.y-=80;
    self.view.frame=rect;
    return YES;
}

-(BOOL)textViewShouldEndEditing:(UITextView *)textView{
    
    CGRect rect=self.view.frame;
    rect.origin.y+=80;
    self.view.frame=rect;
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}


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
    self.txtViewContent.placeholder=@"请添加日报内容.";
    
    // Do any additional setup after loading the view.
    upLoadImageBuffer=[[NSMutableArray alloc] init];
    
    self.txtViewContent.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.txtViewContent.layer.borderWidth=0.3f;
    self.txtViewContent.layer.cornerRadius=3;
    self.txtViewContent.layer.masksToBounds=YES;
    self.txtViewContent.delegate=self;
    
    self.lblDate.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.lblDate.layer.borderWidth=0.3f;
//    [self.lblDate addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onSelectDate:)]];
    
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
//    NSString *dateString=[dateFormatter stringFromDate:[NSDate date]];
//    self.lblDate.text=[NSString stringWithFormat:@"  %@",dateString];
    
    self.lblDate.text=[self.timesArray firstObject];
    
    [self initSubView];
}
//-(void)onSelectDate:(UITapGestureRecognizer *)recognizer{
//    if(recognizer.state == UIGestureRecognizerStateEnded){
////        [self performAlert:@"点击"];
//        NSLog(@"onclick...");
//    }
//}
-(void) initSubView{
    
    if (self.selectedWorkRecord) {
        
        [self.navigationItem setTitle:@"编辑日报"];
        self.btnDate.hidden = YES;
        self.lblDate.text = [self.selectedWorkRecord objectForKey:@"daily_date"];
        self.txtViewContent.text=[self.selectedWorkRecord objectForKey:@"daily_content"];
        self.imgView1.image=self.uploadImage1;
         self.imgView2.image=self.uploadImage2;
         self.imgView3.image=self.uploadImage3;
        
    } else {
        
        [self.navigationItem setTitle:@"添加日报"];
        self.btnDate.hidden = NO;
    }
    
    [self.imgView1 addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongpressGesture1:)]];
    
     [self.imgView2 addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongpressGesture2:)]];
    
     [self.imgView3 addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongpressGesture3:)]];
}
-(void)handleLongpressGesture1:(UILongPressGestureRecognizer *)gestureRecognizer{
    if(gestureRecognizer.state==UIGestureRecognizerStateEnded){
        return;
    }
    else if(gestureRecognizer.state==UIGestureRecognizerStateBegan){
        if(!self.imgView1.image)
            return;
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"警告" message:@"您确定要删除当前选择的图片吗照片吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
        alertView.tag=1;
        
        self.imgView1.layer.borderColor=[UIColor redColor].CGColor;
        self.imgView1.layer.borderWidth=1;

    }
}
-(void)handleLongpressGesture2:(UILongPressGestureRecognizer *)gestureRecognizer{
    if(gestureRecognizer.state==UIGestureRecognizerStateEnded){
        return;
    }
    else if(gestureRecognizer.state==UIGestureRecognizerStateBegan){
        if(!self.imgView2.image)
            return;

        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"警告" message:@"您确定要删除当前选择的图片吗照片吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
        alertView.tag=2;
        
        self.imgView2.layer.borderColor=[UIColor redColor].CGColor;
        self.imgView2.layer.borderWidth=1;
        
    }
}
-(void)handleLongpressGesture3:(UILongPressGestureRecognizer *)gestureRecognizer{
    if(gestureRecognizer.state==UIGestureRecognizerStateEnded){
        return;
    }
    else if(gestureRecognizer.state==UIGestureRecognizerStateBegan){
        if(!self.imgView3.image)
            return;

        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"警告" message:@"您确定要删除当前选择的图片吗照片吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
        alertView.tag=3;
        
        self.imgView3.layer.borderColor=[UIColor redColor].CGColor;
        self.imgView3.layer.borderWidth=1;
        
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex){
        switch (alertView.tag) {
            case 1:
                self.imgView1.image=nil;
                self.imgView1.layer.borderWidth=0;
                break;
            case 2:
                self.imgView2.image=nil;
                self.imgView2.layer.borderWidth=0;
                break;
            case 3:
                self.imgView3.image=nil;
                self.imgView3.layer.borderWidth=0;
                break;

            default:
                break;
        }
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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




- (IBAction)btnCameraOnClick:(id)sender {
    UIActionSheet *actionSheet=[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取 消" destructiveButtonTitle:@"相 机" otherButtonTitles:@"照片库", nil];
    actionSheet.tag=2;
    [actionSheet showInView:self.view];
    //[self addOfCamera];
}
//
//-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
//    if(buttonIndex == 0 || buttonIndex ==1){
//        [self addOfCamera:buttonIndex];
//    }
//    
//}
//-(void)itemPhotographButtonOnclick:(int)typeId{
//    //检查相机模式是否可用
//    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
//        NSLog(@"sorry, no camera or camera is unavailable.");
//        return;
//    }
//    
//    //创建图像选取控制器
//    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
//    //设置图像选取控制器的来源模式为相机模式
//    if(!typeId)
//        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
//    else
//        imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//    //设置图像选取控制器的类型为静态图像
//    imagePickerController.mediaTypes = [[NSArray alloc] initWithObjects:kUTTypeImage, nil];
//    //允许用户进行编辑
//    imagePickerController.allowsEditing = YES;
//    //设置委托对象
//    imagePickerController.delegate = self;
//    //以模视图控制器的形式显示
//    [self presentViewController:imagePickerController animated:YES completion:nil];
//}
//#pragma mark –
//#pragma mark Camera View Delegate Methods
////点击相册中的图片或者照相机照完后点击use 后触发的方法
//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
//    
//    UIImage *image;
//    [picker dismissViewControllerAnimated:YES completion:nil];//关掉照相机
//    image = [info objectForKey:UIImagePickerControllerEditedImage];
//    
//    //把选中的图片添加到界面中
//    //    [self performSelector:@selector(saveImage:) withObject:image afterDelay:0.5];
//    [self performSelectorOnMainThread:@selector(saveImage:) withObject:image waitUntilDone:YES];
//}
//
////点击cancel调用的方法
//- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
//    [picker dismissViewControllerAnimated:YES completion:nil];
//    
//}
////把图片添加到当前view中
//- (void)saveImage:(UIImage *)image {
//    self.visitImageView.image = image;
//}
//- (IBAction)zoomImageOnclick:(id)sender {
//    if(!self.visitImageView.image)
//        return;
//    
//    zoomImageView.image=self.visitImageView.image;
//    zoomImageView.contentMode=UIViewContentModeScaleAspectFit;
//    [self.navigationController.view addSubview:zoomImageView];
//}
//

//

//把图片添加到当前view中
- (void)saveImage:(UIImage *)image {
    isUpdateImage=YES;
    lastPhotograghImageViewIndex++;
    
    [self getPhotograghImageView:lastPhotograghImageViewIndex].image = image;
}
-(UIImageView*)getPhotograghImageView:(int)index{
    if(!self.imgView1.image){
        lastPhotograghImageViewIndex=1;
        return self.imgView1;
    }
    if(!self.imgView2.image){
        lastPhotograghImageViewIndex=2;
        return self.imgView2;
    }
    if(!self.imgView3.image){
        lastPhotograghImageViewIndex=3;
        return self.imgView3;
    }
    
    switch (index) {
        case 1:
            return self.imgView1;
            break;
        case 2:
            return self.imgView2;
            break;
        case 3:
            return self.imgView3;
            break;
        default:
            lastPhotograghImageViewIndex=1;
            return self.imgView1;
            break;
    }
}
- (void) addOfCamera:(int)typeId
{
    //先设定sourceType为相机，然后判断相机是否可用（ipod）没相机，不可用将sourceType设定为相片库
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
//        if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
//            sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//        }
    if(!typeId){
       sourceType = UIImagePickerControllerSourceTypeCamera;}
            else
            {sourceType = UIImagePickerControllerSourceTypePhotoLibrary;}
//    sourceType = UIImagePickerControllerSourceTypeCamera; //照相机
//    sourceType = UIImagePickerControllerSourceTypePhotoLibrary; //图片库
//    sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum; //保存的相片
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];//初始化
    picker.delegate = self;
    picker.allowsEditing = YES;//设置可编辑
    picker.sourceType = sourceType;
    [self presentViewController:picker animated:YES completion:nil];//进入照相界面
    
}

#pragma mark –
#pragma mark Camera View Delegate Methods
//点击相册中的图片或者照相机照完后点击use 后触发的方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *image;
    [picker dismissViewControllerAnimated:YES completion:nil];//关掉照相机
    image = [info objectForKey:UIImagePickerControllerEditedImage];
    
    //把选中的图片添加到界面中
    [self performSelector:@selector(saveImage:) withObject:image afterDelay:0.5];
}

//点击cancel调用的方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
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
-(void)hudWasHidden:(MBProgressHUD *)hud{
    [hud removeFromSuperview];
    hud=nil;
}
- (IBAction)btnAddWorkRecordOnClick:(id)sender {
    
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
    
    if(self.selectedWorkRecord){
        NSString *pic=[self.selectedWorkRecord objectForKey:@"daily_pic"];
        NSArray *tmpArray=[pic componentsSeparatedByString:@","];
        NSString *urlString=@"";
        for (NSString *s in tmpArray) {
            NSArray *arr=[s componentsSeparatedByString:@"/"];
            NSString *name=[arr lastObject];
            if([urlString isEqualToString:@""])
                urlString=name;
            else
                urlString=[urlString stringByAppendingFormat:@",%@",name];
        }
        [bDict setObject:urlString forKey:@"daily_image"];
    }
    else{
       [bDict setObject:@"" forKey:@"daily_image"];//设置图片名称
    }
    
    if(isUpdateImage){
        if(self.imgView1.image)
            [upLoadImageBuffer addObject:self.imgView1.image];
        if(self.imgView2.image)
            [upLoadImageBuffer addObject:self.imgView2.image];
        if(self.imgView3.image)
            [upLoadImageBuffer addObject:self.imgView3.image];
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
    NSString *typeString=[NSString stringWithFormat:@"?type=daily/%d/%@",self.user.userID,self.lblDate.text];
    NSString *picName=[self getJPGFileName];
    NSString *pn=[bDict objectForKey:@"daily_image"];
    if([pn isEqualToString:@""])
        pn=picName;
    else
        pn=[pn stringByAppendingFormat:@",%@",picName];
    [bDict setObject:pn forKey:@"daily_image"];
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
    HUD.labelText=@"正在提交日报...";
    if (self.selectedWorkRecord) {//编辑模式
        
        
        /*
         
         shaoyang\v1_4\daily\upddaily
         daily_content 日报内容
         daily_id 日报id
         daily_image 图片名称
         
        */
        
//        int userId = self.user.userID;
//        [bDict setObject:[NSString stringWithFormat:@"%d",userId] forKey:@"daily_user_id"];
//        
//        NSString *userName = self.user.userName;
//        [bDict setObject:userName forKey:@"daily_user_name"];
        
//        NSString *phone = self.user.userMobile;
//        [bDict setObject:phone forKey:@"daily_msisdn"];
        
//        [bDict setObject:@"2015-01-17" forKey:@"daily_date"];
        int userId = self.user.userID;
        [bDict setObject:[NSString stringWithFormat:@"%d",userId] forKey:@"user_id"];
        
        [bDict setObject:self.lblDate.text forKey:@"daily_date"];
        
        NSString *content = self.txtViewContent.text;
        [bDict setObject:content forKey:@"daily_content"];
        
        NSString *wrId = [self.selectedWorkRecord objectForKey:@"daily_id"];
        [bDict setObject:wrId forKey:@"daily_id"];
        

    [NetworkHandling sendPackageWithUrl:@"daily/upddaily" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
            hubFlag=NO;
            if(!error){
                
                NSLog(@"sign in success");
                BOOL flag=[[result objectForKey:@"flag"] boolValue];
                if(flag){
                    
                    [self performSelectorOnMainThread:@selector(submitSuccess) withObject:nil waitUntilDone:YES];
                    
                }else{
                    
                    [self performSelectorOnMainThread:@selector(showMessage:) withObject:@"编辑失败！" waitUntilDone:YES];
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
        
        
    } else {
        
        /*
         daily_date 日报时间
         daily_content 日报内容
         daily_user_id 上报人员id
         daily_user_name 上报人员姓名
         daily_msisdn 上报人员电话
         daily_image 上报图片名称
         
         */
        
        int userId = self.user.userID;
        [bDict setObject:[NSString stringWithFormat:@"%d",userId] forKey:@"daily_user_id"];
        
        NSString *userName = self.user.userName;
        [bDict setObject:userName forKey:@"daily_user_name"];
        
        NSString *phone = self.user.userMobile;
        [bDict setObject:phone forKey:@"daily_msisdn"];
        
//        [bDict setObject:@"2015-01-17" forKey:@"daily_date"];
        [bDict setObject:self.lblDate.text forKey:@"daily_date"];
        NSString *content = self.txtViewContent.text;
        [bDict setObject:content forKey:@"daily_content"];
        
        [NetworkHandling sendPackageWithUrl:@"daily/adddaily" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
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
        
        
    }
 
}

-(void)submitSuccess{
    int index=[[self.navigationController viewControllers]indexOfObject:self];
    if(self.selectedWorkRecord)
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:index-2] animated:NO];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnDateOnClick:(id)sender {
    
//    [self selectDate:nil];
    

    
    UIActionSheet *actionSheet;
    actionSheet=[[UIActionSheet alloc] init];
    actionSheet.delegate=self;
    [actionSheet setTitle:@"日报日期选择"];
    
    for (NSString *title in self.timesArray)
        [actionSheet addButtonWithTitle:title];
    
    [actionSheet addButtonWithTitle:@"取 消"];
    actionSheet.cancelButtonIndex=actionSheet.numberOfButtons-1;

    [actionSheet showInView:self.view];
    
    
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (actionSheet.tag==2) {
        if(buttonIndex == 0 || buttonIndex ==1){
            [self addOfCamera:buttonIndex];
        }

    } else {
        if(buttonIndex == actionSheet.numberOfButtons - 1){
            return;
        }
        self.lblDate.text=[self.timesArray objectAtIndex:buttonIndex];
    }
    
}
-(NSString*)getJPGFileName{
    NSDate *de = [NSDate date];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMddHHmmssSSS"];
    NSString *picName = [dateFormatter stringFromDate:de];
    return [NSString stringWithFormat:@"%@.jpg",picName];
}



@end
