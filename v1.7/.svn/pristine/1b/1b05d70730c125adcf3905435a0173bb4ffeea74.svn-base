//
//  CustomerManagerContactsEditViewController.m
//  CMCCMarketing
//
//  Created by talkweb on 14-9-22.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//
#import "CustomerManagerContactsEditSubViewController.h"
#import "CustomerManagerContactsEditViewController.h"
#import "PreferentialPurchaseSelectDateTimeViewController.h"
#import "MBProgressHUD.h"
#import "NetworkHandling.h"

@interface CustomerManagerContactsEditViewController()<CustomerManagerContactsEditSubViewControllerDelegate,UIActionSheetDelegate,PreferentialPurchaseSelectDateTimeViewControllerDelegate,MBProgressHUDDelegate>{
    CustomerManagerContactsEditSubViewController *subviewController;

    PreferentialPurchaseSelectDateTimeViewController *selectDateTimeViewController;
    UIButton *selectDateWithButton;
    UIView *backView;
    BOOL hubFlag;
    BOOL isEditImage;
}

@end

@implementation CustomerManagerContactsEditViewController

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

    kUTTypeImage = @"public.image";
    isEditImage = NO;
    subviewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"CustomerManagerContactsEditSubViewId"];
    subviewController.contactsDict = self.contactDict;
    subviewController.listType = self.listType;
    subviewController.delegate = self;
    
    CGRect rect=CGRectMake(0, 0, 320, 700);
    subviewController.view.frame=rect;
    [bodyScrollView addSubview:subviewController.view];
    [subviewController setEditData];
    bodyScrollView.contentSize=rect.size;

    UIBarButtonItem *rightButton=[[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveEdit)];
    [rightButton setTintColor:[UIColor whiteColor]];
    [self.navigationItem setRightBarButtonItem:rightButton];
    
#if (defined MANAGER_CS_VERSION) || (defined STANDARD_CS_VERSION)
    tableTopLayoutConstraint.constant=-64;
#endif
    
//#if (defined MANAGER_SY_VERSION) || (defined STANDARD_SY_VERSION)
//
//#endif
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
-(void)saveEdit{

    if(subviewController.txtPhone.text.length < 1){
        [self showTips:@"联系人电话号码不能为空！"];
        return;
    }
    if(subviewController.txtPhone.text.length > 1 && subviewController.txtPhone.text.length != 11){
        [self showTips:@"请填写正确的手机号码！"];
        return;
    }
    if(subviewController.txtName.text.length < 1){
        [self showTips:@"联系人姓名不能为空！"];
        return;
    }
    
    hubFlag=YES;
    
    NSString *msg=@"";
    if(isEditImage)
        msg=@"正在上传照片,请稍后...";
    else
        msg=@"正在提交数据，请稍后...";
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=msg;
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
    
    if(!isEditImage)
        [self submitData:@"0"];
    else
        [self submitImage];
    
}
-(void)connectToNetwork{
    while (hubFlag) {
        usleep(100000);
    }
}

-(void)submitImage{
    NSString *picName;
    if(self.listType == 0){
        picName=[NSString stringWithFormat:@"%d%@",self.user.userID,subviewController.txtPhone.text];
        [NetworkHandling UploadsyntheticPictures:subviewController.userImageView.image currentPicName:picName uploadType:@"linkuserPC" completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
            NSDictionary *d1=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            BOOL f=[[d1 objectForKey:@"imgUpload"] boolValue];
            if(!error && f){
                [self submitData:@"1"];
                
            }
        }];
    }
    if(self.listType == 1){
        //txtPhone.text == boss_msisdn
         picName=[NSString stringWithFormat:@"%d%@",self.user.userID,subviewController.txtPhone.text];
        [NetworkHandling UploadsyntheticPictures:subviewController.userImageView.image currentPicName:picName currentUser:self.user.userID uploadType:@"chnlboss" completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
            NSDictionary *d1=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            BOOL f=[[d1 objectForKey:@"imgUpload"] boolValue];
            if(!error && f){
                [self submitData:@"1"];
                
            }
        }];
    }
}
-(void)submitData:(NSString*)isImage{
    if (self.listType == 0) {
        NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
        [bDict setObject:self.user.userMobile forKey:@"vip_mngr_msisdn"];
        [bDict setObject:[NSNumber numberWithInt:self.user.userEnterprise] forKey:@"enterprise"];
        
        [bDict setObject:self.isEdit?[self.contactDict objectForKey:@"row_id"]:@"-999" forKey:@"row_id"];
        [bDict setObject:self.group.groupId forKey:@"grp_code"];
        [bDict setObject:@"0" forKey:@"flag"];
        [bDict setObject:self.group.groupName forKey:@"grp_name"];
        [bDict setObject:self.user.userName forKey:@"vip_mngr_name"];
        [bDict setObject:subviewController.txtPhone.text forKey:@"linkman_msisdn"];
        [bDict setObject:subviewController.txtName.text forKey:@"linkman"];
        [bDict setObject:[NSNumber numberWithInt:self.user.userID] forKey:@"user_id"];
        [bDict setObject:self.user.userName forKey:@"user_name"];
        if(subviewController.btBirthday.titleLabel.text.length > 0)
            [bDict setObject:subviewController.btBirthday.titleLabel.text forKey:@"linkman_birthday"];
        else
            [bDict setObject:@"" forKey:@"linkman_birthday"];
        [bDict setObject:subviewController.txtOtherPhone.text forKey:@"linkman_tel"];
        [bDict setObject:subviewController.txtOtherContact.text forKey:@"linkman_tel_bak"];
        [bDict setObject:subviewController.txtDepart.text forKey:@"depart"];
        [bDict setObject:subviewController.txtJob.text forKey:@"job"];
        if(subviewController.btType.titleLabel.text.length > 0)
            [bDict setObject:subviewController.btType.titleLabel.text forKey:@"key_type"];
        else
            [bDict setObject:@"" forKey:@"key_type"];
        [bDict setObject:subviewController.swIsDiffKey.on?@"是":@"否" forKey:@"is_diff_key"];
        [bDict setObject:subviewController.swSex.on?[NSNumber numberWithInt:1]:[NSNumber numberWithInt:2] forKey:@"linkman_sex"];
        
        [bDict setObject:[NSNumber numberWithInt:subviewController.swBirthdayRemind.on] forKey:@"is_birthday_remind"];
        NSString *remark=@"";
        if(subviewController.bt1c2n.selected)
            remark=[remark stringByAppendingString:@"一卡双号用户"];
        if(subviewController.btMultipleNumber.selected)
            remark=[remark stringByAppendingString:@",多移动号码用户"];
        if(subviewController.btUnicom2n.selected)
            remark=[remark stringByAppendingString:@",联通双枪用户"];
        if(subviewController.btTeleCom2n.selected)
            remark=[remark stringByAppendingString:@",电信双枪用户"];
        if(subviewController.bt3n.selected)
            remark=[remark stringByAppendingString:@",三枪用户"];
        
        [bDict setObject:remark forKey:@"remark"];
        if(subviewController.btOperators.titleLabel.text.length > 0)
            [bDict setObject:subviewController.btOperators.titleLabel.text forKey:@"chinamobile"];
        else
            [bDict setObject:@"" forKey:@"chinamobile"];
        [bDict setObject:subviewController.swIsFirst.on?@"是":@"否" forKey:@"is_first"];
        [bDict setObject:isImage forKey:@"isImg"];
        [bDict setObject:@"0" forKey:@"op_stat"]; //0新增 1修改
        [bDict setObject:@"ios" forKey:@"client_os"];
        
        
        
        [NetworkHandling sendPackageWithUrl:@"grpuserlink/updUserInfo" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
            
            if(!error){
                NSLog(@"sign in success");
                BOOL flag=[[result objectForKey:@"flag"] boolValue];
                if(flag){
                    [self performSelectorOnMainThread:@selector(showMessage:) withObject:@"提交资料成功！" waitUntilDone:YES];
                }
                else{
                    [self performSelectorOnMainThread:@selector(showMessage:) withObject:@"提交资料失败！" waitUntilDone:YES];
                }
            }
            else{
                int errorCode=[[result valueForKey:@"errorcode"] intValue];
                NSString *errorInfo=[result valueForKey:@"errorinf"];
                if(!errorInfo)
                    errorInfo=@"提交数据出错了！";
                NSLog(@"error:%d info:%@",errorCode,errorInfo);
                [self performSelectorOnMainThread:@selector(showMessage:) withObject:errorInfo waitUntilDone:YES];
            }
            hubFlag=NO;
        }];
    }
    else if(self.listType == 1){
        NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
        [bDict setObject:self.user.userMobile forKey:@"vip_mngr_msisdn"];
        [bDict setObject:[NSNumber numberWithInt:self.user.userEnterprise] forKey:@"enterprise"];
        
        [bDict setObject:self.isEdit?[self.contactDict objectForKey:@"row_id"]:@"-999" forKey:@"row_id"];
        NSLog(@"self.isEdit --   %d  %@",self.isEdit,[self.contactDict objectForKey:@"row_id"]);
        [bDict setObject:self.channels.chnl_code forKey:@"chnl_code"];
        [bDict setObject:@"0" forKey:@"flag"];
        [bDict setObject:self.channels.chnl_name forKey:@"chnl_name"];
        [bDict setObject:self.user.userName forKey:@"vip_mngr_name"];
        [bDict setObject:subviewController.txtPhone.text forKey:@"boss_msisdn"];
        [bDict setObject:subviewController.txtName.text forKey:@"boss_name"];
        [bDict setObject:[NSNumber numberWithInt:self.user.userID] forKey:@"user_id"];
        [bDict setObject:self.user.userName forKey:@"user_name"];
        if(subviewController.btBirthday.titleLabel.text.length > 0)
            [bDict setObject:subviewController.btBirthday.titleLabel.text forKey:@"boss_birthday"];
        else
            [bDict setObject:@"" forKey:@"linkman_birthday"];
        [bDict setObject:subviewController.txtOtherPhone.text forKey:@"boss_tel"];
        [bDict setObject:subviewController.txtOtherContact.text forKey:@"boss_tel_bak"];
        [bDict setObject:subviewController.txtDepart.text forKey:@"boss_card"];
//        [bDict setObject:subviewController.txtJob.text forKey:@"boss_card"];
        if(subviewController.btType.titleLabel.text.length > 0)
            [bDict setObject:subviewController.btType.titleLabel.text forKey:@"key_type"];
        else
            [bDict setObject:@"" forKey:@"key_type"];
        [bDict setObject:subviewController.swIsDiffKey.on?@"是":@"否" forKey:@"is_diff_key"];
        [bDict setObject:subviewController.swSex.on?[NSNumber numberWithInt:1]:[NSNumber numberWithInt:2] forKey:@"boss_sex"];
        [bDict setObject:[NSNumber numberWithInt:subviewController.swBirthdayRemind.on] forKey:@"is_birthday_remind"];
        NSString *remark=@"";
        if(subviewController.bt1c2n.selected)
            remark=[remark stringByAppendingString:@"一卡双号用户"];
        if(subviewController.btMultipleNumber.selected)
            remark=[remark stringByAppendingString:@",多移动号码用户"];
        if(subviewController.btUnicom2n.selected)
            remark=[remark stringByAppendingString:@",联通双枪用户"];
        if(subviewController.btTeleCom2n.selected)
            remark=[remark stringByAppendingString:@",电信双枪用户"];
        if(subviewController.bt3n.selected)
            remark=[remark stringByAppendingString:@",三枪用户"];
        
        [bDict setObject:remark forKey:@"remark"];
        if(subviewController.btOperators.titleLabel.text.length > 0)
            [bDict setObject:subviewController.btOperators.titleLabel.text forKey:@"chinamobile"];
        else
            [bDict setObject:@"" forKey:@"chinamobile"];
        [bDict setObject:subviewController.swIsFirst.on?@"是":@"否" forKey:@"is_first"];
        [bDict setObject:isImage forKey:@"isImg"];
        [bDict setObject:@"0" forKey:@"op_stat"]; //0新增 1修改
        [bDict setObject:@"ios" forKey:@"client_os"];
        
        
        
        [NetworkHandling sendPackageWithUrl:@"grpuserlink/updChnlBossInfo" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
            
            if(!error){
                NSLog(@"sign in successupdChnlBossInfo  %@",result);
                BOOL flag=[[result objectForKey:@"flag"] boolValue];
                if(flag){
                    [self performSelectorOnMainThread:@selector(showMessage:) withObject:@"提交资料成功！" waitUntilDone:YES];
                }
                else{
                    [self performSelectorOnMainThread:@selector(showMessage:) withObject:@"提交资料失败！" waitUntilDone:YES];
                }
            }
            else{
                int errorCode=[[result valueForKey:@"errorcode"] intValue];
                NSString *errorInfo=[result valueForKey:@"errorinf"];
                if(!errorInfo)
                    errorInfo=@"提交数据出错了！";
                NSLog(@"error:%d info:%@",errorCode,errorInfo);
                [self performSelectorOnMainThread:@selector(showMessage:) withObject:errorInfo waitUntilDone:YES];
            }
            hubFlag=NO;
        }];
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

-(void)selectType:(id)sender{
    UIActionSheet *actionSheet=[[UIActionSheet alloc] initWithTitle:@"类别请选择" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"决策关键人" otherButtonTitles:@"联系关键人",@"业务关键人", nil];
    actionSheet.tag=1;
    [actionSheet showInView:self.view];
    selectDateWithButton=sender;
}

-(void)selectOperators:(id)sender{
    UIActionSheet *actionSheet=[[UIActionSheet alloc] initWithTitle:@"运营商请选择" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"联通" otherButtonTitles:@"电信", nil];
    [actionSheet showInView:self.view];
    selectDateWithButton=sender;
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(actionSheet.tag == 1){
        if(buttonIndex==0){
            [selectDateWithButton setTitle:@"决策关键人" forState:UIControlStateNormal];
        }
        else if(buttonIndex==1){
            [selectDateWithButton setTitle:@"联系关键人" forState:UIControlStateNormal];
        }
        else if(buttonIndex==2){
            [selectDateWithButton setTitle:@"业务关键人" forState:UIControlStateNormal];
        }
       
    }
    else if(actionSheet.tag == 2){
        if(buttonIndex == 0 || buttonIndex ==1){
            [self itemPhotographButtonOnclick:buttonIndex];
        }
    }
    else{
        if(buttonIndex==0){
            [selectDateWithButton setTitle:@"联通" forState:UIControlStateNormal];
        }
        else if(buttonIndex==1){
            [selectDateWithButton setTitle:@"电信" forState:UIControlStateNormal];
        }
       
    }
    
}
-(void)selectDate:(id)sender{
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"BusinessProcess" bundle:nil];
    selectDateTimeViewController=[storyboard instantiateViewControllerWithIdentifier:@"PreferentialPurchaseSelectDateTimeViewControllerId"];
    selectDateTimeViewController.delegate=self;
    CGRect rect=selectDateTimeViewController.view.frame;
    
    rect.origin.x=0;
    rect.origin.y=[[UIScreen mainScreen] bounds].size.height - 200;
    rect.size.width=320;
    rect.size.height=200;
    
    selectDateTimeViewController.view.frame=rect;
    selectDateTimeViewController.view.layer.borderWidth=1;
    selectDateTimeViewController.view.layer.borderColor=[UIColor colorWithRed:55/255.0 green:132/255.0 blue:173/255.0 alpha:1.0].CGColor;
    selectDateTimeViewController.view.layer.shadowOffset = CGSizeMake(2, 2);
    selectDateTimeViewController.view.layer.shadowOpacity = 0.80;
    
    backView=[[UIView alloc] init];
    backView.backgroundColor=[UIColor blackColor];
    backView.alpha=0.1;
    
    backView.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [self.view addSubview:backView];
    [self.view addSubview:selectDateTimeViewController.view];
    
    selectDateWithButton=sender;
    
}
-(void)preferentialPurchaseSelectDateTimeViewControllerDidCancel{
    [backView removeFromSuperview];
    [selectDateTimeViewController.view removeFromSuperview];
    
    backView=nil;
    selectDateTimeViewController=nil;
}
-(void)preferentialPurchaseSelectDateTimeViewControllerDidFinished:(PreferentialPurchaseSelectDateTimeViewController *)controller{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString=[dateFormatter stringFromDate:controller.datetimePicker.date];
    //    selectDateWithTextField.text=[dateFormatter stringFromDate:controller.datetimePicker.date];
    [selectDateWithButton setTitle:dateString forState:UIControlStateNormal];
    [self preferentialPurchaseSelectDateTimeViewControllerDidCancel];
}
-(void)setEditData{
    [subviewController setEditData];
}
-(void)goCamera{
    UIActionSheet *actionSheet=[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取 消" destructiveButtonTitle:@"相 机" otherButtonTitles:@"照片库", nil];
    actionSheet.tag=2;
    [actionSheet showInView:self.view];
}
//-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
//    if(buttonIndex == 0 || buttonIndex ==1){
//        [self itemPhotographButtonOnclick:buttonIndex];
//    }
//}
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
    subviewController.userImageView.image=image;
    isEditImage=YES;
}
@end
