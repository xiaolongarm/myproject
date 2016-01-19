//
//  SettingInformationViewController.m
//  CMCCMarketing
//
//  Created by talkweb on 14-9-4.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import "SettingInformationViewController.h"
#import "NetworkHandling.h"
#import "VariableStore.h"
#import "MBProgressHUD.h"
#import "Toast+UIView.h"

@interface SettingInformationViewController ()<UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,MBProgressHUDDelegate>{
    NSString *kUTTypeImage;
//    NSString *kUserImage;

}

@end

@implementation SettingInformationViewController

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
    self.title=@"个人信息";
    self.navigationItem.leftBarButtonItem.title = @"返回";
    
    userName.text=self.user.userName;
    userTelephone.text=self.user.userMobile;
//    NSString *sex=self.user.userSex;
//    userSex.text=sex&&(NSNull*)sex != [NSNull null]?sex:@"未知";
    
    switch (self.user.userSex) {
        case 0:
            userSex.text=@"未知";
            break;
        case 1:
            userSex.text=@"男";
            break;
        case 2:
            userSex.text=@"女";
            break;
        default:
            break;
    }

    userDept.text=self.user.userDeptDesc;
    userMail.text=self.user.userEmail;
    
    [self loadUserImage];
    
//    kUserImage=@"user.jpg";
    kUTTypeImage=@"public.image";
    
//#ifdef MANAGER_VERSION
#if (defined MANAGER_CS_VERSION) || (defined MANAGER_SY_VERSION)
    swGpsReport.enabled=NO;
#endif
    
//#ifdef STANDARD_VERSION
#if (defined STANDARD_CS_VERSION) || (defined STANDARD_SY_VERSION)
    swGpsReport.on=![VariableStore sharedInstance].isStopGPSReport;
#endif
}
-(void)loadUserImage{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSURL *url=[NSURL URLWithString:self.user.userImageUrl];
        NSData *data=[[NSData alloc] initWithContentsOfURL:url];
        UIImage *image=[UIImage imageWithData:data];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [btUserImage setImage:image forState:UIControlStateNormal];
        });
    });
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)changeImage:(id)sender {
    UIActionSheet *actionSheet=[[UIActionSheet alloc] initWithTitle:@"修改照片请选择" delegate:self cancelButtonTitle:@"照相机" destructiveButtonTitle:@"取 消" otherButtonTitles:@"图 库", nil];
    [actionSheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(!buttonIndex)
        return;
    [self goCamera:buttonIndex];
}

-(void)goCamera:(int)type{
    //检查相机模式是否可用
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        NSLog(@"sorry, no camera or camera is unavailable.");
        return;
    }
    
    //创建图像选取控制器
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    //设置图像选取控制器的来源模式为相机模式
    imagePickerController.sourceType = type == 2 ? UIImagePickerControllerSourceTypeCamera:UIImagePickerControllerSourceTypePhotoLibrary;
    
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

//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyyMMddHHmmssSSS"];
//    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    
    //update user image
    [NetworkHandling UploadsyntheticPictures:editedImage currentPicName:[NSString stringWithFormat:@"%d",self.user.userID] currentUser:self.user.userID uploadType:@"personInfo" completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if(!error){
            [self.delegate updatePersonImageDidFinished];
        }
    }];
    
    
    [btUserImage setImage:editedImage forState:UIControlStateNormal];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
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
- (IBAction)switchGpsReportState:(id)sender {
    UISwitch *switchButton=sender;
    [self postGpsState:switchButton.on?@"1":@"0"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)),dispatch_get_global_queue(0, 0), ^{
        [VariableStore sharedInstance].isStopGPSReport=!switchButton.on;
        if(switchButton.on){
            
            if(![VariableStore sharedInstance].locationDataAcquisition){
                [VariableStore sharedInstance].locationDataAcquisition=[[LocationDataAcquisition alloc] init];
            }
            
            [VariableStore sharedInstance].locationDataAcquisition.user=self.user;
            [[VariableStore sharedInstance].locationDataAcquisition startLocationDataAcquisition];
        }
    });

}

-(void)postGpsState:(NSString*)state{
    hubFlag=YES;
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"数据提交中，请稍后...";
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];

    
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    [bDict setObject:[NSNumber numberWithInt:self.user.userID] forKey:@"user_id"];
    [bDict setObject:state forKey:@"is_close_gps"];
    
//    is_close_gps 是否关闭gps功能 (注类型为字符串  "0"关闭gps "1"开启gps
    
    [NetworkHandling sendPackageWithUrl:@"HamstrerServlet/closegps" sendBody:bDict sendWithPostType:2 processHandler:^(NSDictionary *result, NSError *error) {
         hubFlag=NO;
        if(!error){
            NSLog(@"sign in success");
            BOOL flag=[[result objectForKey:@"flag"] boolValue];
            if(!flag){
                NSString *errorinf=[result objectForKey:@"errorinf"];
                [self performSelectorOnMainThread:@selector(showMessage:) withObject:errorinf waitUntilDone:YES];
               
            }
            
            //GPS修改成功
            HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
            HUD.mode = MBProgressHUDModeCustomView;
            HUD.delegate = self;
            HUD.labelText = @"GPS修改成功";
            [HUD show:YES];
            [HUD hide:YES afterDelay:1];
        }
        else{
            int errorCode=[[result valueForKey:@"errorcode"] intValue];
            NSString *errorInfo=[result valueForKey:@"errorinf"];
            if(!errorInfo)
                errorInfo=@"提交数据出错了！";
            NSLog(@"error:%d info:%@",errorCode,errorInfo);
            [self performSelectorOnMainThread:@selector(showMessage:) withObject:errorInfo waitUntilDone:YES];
            //修改不成功
            //GPS修改不成功
//            MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
//            [self.view addSubview:HUD];
//            HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
//            HUD.mode = MBProgressHUDModeCustomView;
//            HUD.delegate = self;
//            HUD.labelText = @"GPS修改不成功";
            
//            [HUD show:YES];
//            [HUD hide:YES afterDelay:1];
//            [self.view makeToast:@"GPS修改不成功"
//                        duration:3.0
//                        position:@"center"
//                           title:@"提示"];
        }
    }];
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

@end
