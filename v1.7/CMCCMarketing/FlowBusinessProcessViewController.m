//
//  FlowBusinessProcessViewController.m
//  CMCCMarketing
//
//  Created by talkweb on 14-9-16.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import "FlowBusinessProcessViewController.h"
#import "SendBoxHandling.h"
#import "FlowBusinessSendBoxViewController.h"

@interface FlowBusinessProcessViewController ()<UIActionSheetDelegate>{
    NSString *kUTTypeImage;
    NSString *kIDCardImage1;
    NSString *kIDCardImage2;
    
    UIImageView *preSettingImageView;
    UIImageView *zoomImageView;

}

@end

@implementation FlowBusinessProcessViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    lbFlowName.text=self.flowName;
    txtCustomerTel.text=self.customerTel;
    txtCustomerName.delegate=self;
    txtCustomerTel.delegate=self;
    txtCustomerIdCard.delegate=self;
    
    kIDCardImage1=@"idcard1.jpg";
    kIDCardImage2=@"idcard2.jpg";
    kUTTypeImage=@"public.image";
    
    UILongPressGestureRecognizer *longpressGesutre1=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(handleLongpressGesture1:)];
    UILongPressGestureRecognizer *longpressGesutre2=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(handleLongpressGesture2:)];

    [imgIdCard1 addGestureRecognizer:longpressGesutre1];
    [imgIdCard2 addGestureRecognizer:longpressGesutre2];
    
    
    UITapGestureRecognizer *singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap1:)];
    UITapGestureRecognizer *singleTap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap2:)];
    
    [imgIdCard1 addGestureRecognizer:singleTap1];
    [imgIdCard2 addGestureRecognizer:singleTap2];
    
    CGSize size =[[UIScreen mainScreen] bounds].size;
    zoomImageView = [[UIImageView alloc] init];
    zoomImageView.frame = CGRectMake(0, 0, size.width, size.height);
    zoomImageView.backgroundColor=[UIColor blackColor];
    [zoomImageView setUserInteractionEnabled:YES];
    UITapGestureRecognizer *singleTap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap3:)];
    [zoomImageView addGestureRecognizer:singleTap3];
}

-(void)handleSingleTap1:(UIGestureRecognizer *)gestureRecognizer{
    if(!imgIdCard1.image)
        return;
    
    zoomImageView.image=imgIdCard1.image;
    zoomImageView.contentMode=UIViewContentModeScaleAspectFit;
    [self.navigationController.view addSubview:zoomImageView];
}
-(void)handleSingleTap2:(UIGestureRecognizer *)gestureRecognizer{
    if(!imgIdCard2.image)
        return;
    
    zoomImageView.image=imgIdCard2.image;
    zoomImageView.contentMode=UIViewContentModeScaleAspectFit;
    [self.navigationController.view addSubview:zoomImageView];
}
-(void)handleSingleTap3:(UIGestureRecognizer *)gestureRecognizer{
    [zoomImageView removeFromSuperview];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    
    return YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if(IS_IPHONE4 && textField.tag > 12){
        CGRect rect=self.view.frame;
        rect.origin.y-=140;
        self.view.frame=rect;
    }
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if(IS_IPHONE4 && textField.tag > 12){
        CGRect rect=self.view.frame;
        rect.origin.y+=140;
        self.view.frame=rect;
    }
}

#pragma mark - camera




- (IBAction)cameralButtonOnclick:(id)sender {
    
    UIActionSheet *actionSheet=[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取 消" destructiveButtonTitle:@"相 机" otherButtonTitles:@"照片库", nil];
    actionSheet.tag=123;
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

- (void)image:(UIImage*)image didFinishSavingWithError:(NSError*)error contextInfo:(void*)contextInfo{
    if (!error) {
        NSLog(@"picture saved with no error.");
    }
    else
    {
        NSLog(@"error occured while saving the picture%@", error);
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{

    UIImage* editedImage = [info objectForKey:UIImagePickerControllerEditedImage];
    if(!preSettingImageView||preSettingImageView == imgIdCard2){
        imgIdCard1.image=editedImage;
        preSettingImageView=imgIdCard1;
    }
    else{
        imgIdCard2.image=editedImage;
        preSettingImageView=imgIdCard2;
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
-(void)handleLongpressGesture1:(UILongPressGestureRecognizer *)gestureRecognizer{
    if(gestureRecognizer.state==UIGestureRecognizerStateEnded){
        return;
    }
    else if(gestureRecognizer.state==UIGestureRecognizerStateBegan){
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"警告" message:@"您确定要删除当前选择的图片吗照片吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
        alertView.tag=1;
        
        imgIdCard1.layer.borderColor=[UIColor redColor].CGColor;
        imgIdCard1.layer.borderWidth=1;
        
        CGRect rect = self.view.frame;
        rect.origin.y-=120;
        self.view.frame=rect;
    }
}
-(void)handleLongpressGesture2:(UILongPressGestureRecognizer *)gestureRecognizer{
    if(gestureRecognizer.state==UIGestureRecognizerStateEnded){
        return;
    }
    else if(gestureRecognizer.state==UIGestureRecognizerStateBegan){
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"警告" message:@"您确定要删除当前选择的图片吗照片吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
        alertView.tag=2;
        
        imgIdCard2.layer.borderColor=[UIColor redColor].CGColor;
        imgIdCard2.layer.borderWidth=1;
        
        CGRect rect = self.view.frame;
        rect.origin.y-=120;
        self.view.frame=rect;
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(alertView.tag>10)
        return;
    if(buttonIndex){
        if(alertView.tag==1){
            imgIdCard1.image=nil;
            if(!imgIdCard1.image && !imgIdCard2.image)
                preSettingImageView=nil;
            else
                preSettingImageView=imgIdCard2;
        }
        if(alertView.tag==2){
            imgIdCard2.image=nil;
            if(!imgIdCard1.image && !imgIdCard2.image)
                preSettingImageView=nil;
            else
                preSettingImageView=imgIdCard1;
        }
    }
    
    
    if(alertView.tag==1){
        imgIdCard1.layer.borderWidth=0;
    }
    if(alertView.tag==2)
    {
        imgIdCard2.layer.borderWidth=0;
    }
    
    CGRect rect = self.view.frame;
    rect.origin.y+=120;
    self.view.frame=rect;
}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

    if([segue.identifier isEqualToString:@"FlowBusinessProcessToSendBoxSegue"]){
        FlowBusinessSendBoxViewController *controller=segue.destinationViewController;
        controller.isShaoYang=self.isShaoYang;
    }
    
}


-(NSString*)jpgPath{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMddHHmmssSSS"];
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    currentDateStr=[currentDateStr stringByAppendingString:@".jpg"];
    return currentDateStr;
}

-(IBAction)saveToBox:(id)sender {
    if(!imgIdCard1.image || !imgIdCard2.image){
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"警告" message:@"身份证拍照不能为空！" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"关闭", nil];
        alertView.tag=13;
        [alertView show];
        return;
    }
    
    

    if(self.isShaoYang){
        [self saveToBoxWithSY:sender];
        return;
    }
    
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    long long datetime = (long long)time;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,     NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *jpgPath1=[self jpgPath];
    [UIImageJPEGRepresentation(imgIdCard1.image, 1.0) writeToFile:[documentsDirectory stringByAppendingPathComponent:jpgPath1] atomically:YES];
    NSLog(@"save image path:%@",documentsDirectory);

    NSString *jpgPath2=[self jpgPath];
    [UIImageJPEGRepresentation(imgIdCard2.image, 1.0) writeToFile:[documentsDirectory stringByAppendingPathComponent:jpgPath2] atomically:YES];
    
    NSString *imgName=[NSString stringWithFormat:@"%@,%@",jpgPath1,jpgPath2];
    
    NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
    [dict setObject:[NSNumber numberWithInt:self.user.userID] forKey:@"customerManagerId"];
    [dict setObject:[NSNumber numberWithInt:self.user.userEnterprise] forKey:@"customerManagerEnterprise"];
    [dict setObject:[NSNumber numberWithLongLong:datetime] forKey:@"time"];
    [dict setObject:txtCustomerName.text forKey:@"customerName"];
    [dict setObject:txtCustomerIdCard.text forKey:@"customerIdCard"];
    [dict setObject:txtCustomerTel.text forKey:@"customerPhone"];
    [dict setObject:imgName forKey:@"customerIdCardPics"];
    [dict setObject:[NSNumber numberWithInt:0] forKey:@"lng"];
    [dict setObject:[NSNumber numberWithInt:0] forKey:@"lat"];
    [dict setObject:self.flowName forKey:@"packageType"];
    [dict setObject:self.flowDesc forKey:@"packageInfo"];
    [dict setObject:@"123" forKey:@"deviceID"];
    [dict setObject:@"3" forKey:@"bussID"];
    [dict setObject:[NSNumber numberWithBool:NO] forKey:@"upload"];
    
    BOOL flag=[SendBoxHandling setSendMessage:dict dataWithModule:kSendBoxModuleWithFlowBusiness];
    if(flag){
        [self performSegueWithIdentifier:@"FlowBusinessProcessToSendBoxSegue" sender:self];
        imgIdCard1.image=nil;
        imgIdCard2.image=nil;
        txtCustomerName.text=@"";
        txtCustomerTel.text=@"";
        txtCustomerIdCard.text=@"";

    }
    else{
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"警告" message:@"保存到发件箱失败！" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"关闭", nil];
        alertView.tag=12;
        [alertView show];
    }
}
-(IBAction)saveToBoxWithSY:(id)sender {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,     NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *jpgPath1=[self jpgPath];
    [UIImageJPEGRepresentation(imgIdCard1.image, 1.0) writeToFile:[documentsDirectory stringByAppendingPathComponent:jpgPath1] atomically:YES];
    NSLog(@"save image path:%@",documentsDirectory);
    
    NSString *jpgPath2=[self jpgPath];
    [UIImageJPEGRepresentation(imgIdCard2.image, 1.0) writeToFile:[documentsDirectory stringByAppendingPathComponent:jpgPath2] atomically:YES];
    
    NSString *imgName=[NSString stringWithFormat:@"%@,%@",jpgPath1,jpgPath2];
    
    NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
    [dict setObject:[NSNumber numberWithInt:self.user.userID] forKey:@"manager_id"];
    [dict setObject:self.user.userName forKey:@"manger_name"];
    [dict setObject:self.user.userMobile forKey:@"manager_mobile"];

    NSString *typeName;
    switch (self.busType) {
        case 0:
            typeName=@"10";
            break;
        case 1:
            typeName=@"11";
            break;
        case 2:
            typeName=@"12";
            break;
        default:
            break;
    }
    [dict setObject:typeName forKey:@"buss_type"];
    [dict setObject:self.flowPrice forKey:@"buss_type_name"];
    [dict setObject:self.flowName forKey:@"buss_name"];
    
    [dict setObject:dateString forKey:@"load_date"];
    [dict setObject:txtCustomerName.text forKey:@"user_name"];
    [dict setObject:txtCustomerIdCard.text forKey:@"user_code"];
    [dict setObject:txtCustomerTel.text forKey:@"user_mobile"];
    [dict setObject:imgName forKey:@"pic_url"];
    [dict setObject:[NSNumber numberWithBool:NO] forKey:@"upload"];
    
    BOOL flag=[SendBoxHandling setSendMessage:dict dataWithModule:kSendBoxModuleWithFlowBusinessForShaoYang];
    if(flag){
        [self performSegueWithIdentifier:@"FlowBusinessProcessToSendBoxSegue" sender:self];
        imgIdCard1.image=nil;
        imgIdCard2.image=nil;
        txtCustomerName.text=@"";
        txtCustomerTel.text=@"";
        txtCustomerIdCard.text=@"";
        
    }
    else{
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"警告" message:@"保存到发件箱失败！" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"关闭", nil];
        alertView.tag=12;
        [alertView show];
    }
}
//邵阳和营销业务录入接口
//shaoyang\v1_2\bussdisc\AddBussDisc
//必传参数
//buss_type 业务类型
//buss_type_name  业务类型名称
//buss_name 业务名称
//manager_id 客户经理id
//manger_name 客户经理名字
//manager_mobile 客户经理手机号码
//load_date  手机端录入时间 (格式  yyyy-MM-dd HH:mm:ss)
//user_mobile 客户手机号码
//user_name  客户姓名
//user_code  证件号
//非必传参数
//pic_url  证件图片地址
//返回参数
//flag
//
//上传图片serlvet参数
//type=bussdisc/客户经理id

@end
