//
//  PreferentialPurchaseViewController.m
//  CMCCMarketing
//
//  Created by talkweb on 14-9-15.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import "PreferentialPurchaseViewController.h"
#import "PreferentialPurchaseCustomerInformationViewController.h"
#import "PreferentialPurchasePhoneInformationViewController.h"
#import "PreferentialPurchaseContractsInformationViewController.h"
#import "PreferentialPurchaseSendBoxViewController.h"
#import "PreferentialPurchaseContractsRecordViewController.h"
#import "PreferentialPurchaseSelectGroupViewController.h"
#import "MBProgressHUD.h"
#import "SendBoxHandling.h"
#import "PreferentialPurchaseSelectDateTimeViewController.h"

#define BODY_TAB_VIEW_SIZE_WIDTH 300
#define BODY_TAB_VIEW_SIZE_HEIGHT 290

@interface PreferentialPurchaseViewController ()<PreferentialPurchaseCustomerInformationViewControllerDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,MBProgressHUDDelegate,PreferentialPurchaseSelectGroupViewControllerDelegate,PreferentialPurchaseContractsInformationViewControllerDelegate,PreferentialPurchaseSelectDateTimeViewControllerDelegate>{
    PreferentialPurchaseCustomerInformationViewController *customerInformationController;
    PreferentialPurchasePhoneInformationViewController *phoneInformationController;
    PreferentialPurchaseContractsInformationViewController *contractsInformationController;
    
    NSString *kUTTypeImage;
    NSString *kIDCardImage1;
    NSString *kIDCardImage2;
    UIImageView *preSettingImageView;
    
    PreferentialPurchaseSelectGroupViewController *filterController;
    UIView *backView;
    Group *selectedGroup;
    
    PreferentialPurchaseSelectDateTimeViewController *selectDateTimeViewController;
//    UITextField *selectDateWithTextField;
    UIButton *selectDateWithButton;
}

@end

@implementation PreferentialPurchaseViewController

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
    
    customerInformationController=[[self storyboard] instantiateViewControllerWithIdentifier:@"PreferentialPurchaseCustomerInformationId"];
    phoneInformationController=[[self storyboard] instantiateViewControllerWithIdentifier:@"PreferentialPurchasePhoneInformationId"];
    contractsInformationController=[[self storyboard] instantiateViewControllerWithIdentifier:@"PreferentialPurchaseContractsInformationId"];
    
    [bodyView addSubview:customerInformationController.view];
    customerInformationController.view.frame=CGRectMake(0, 0,BODY_TAB_VIEW_SIZE_WIDTH,BODY_TAB_VIEW_SIZE_HEIGHT);
    [bodyView addSubview:phoneInformationController.view];
    phoneInformationController.view.frame=customerInformationController.view.frame;
    
    [bodyView addSubview:contractsInformationController.view];
    contractsInformationController.view.frame=customerInformationController.view.frame;

    
    
    customerInformationController.delegate=self;
    contractsInformationController.delegate=self;
    
    kIDCardImage1=@"idcard1.jpg";
    kIDCardImage2=@"idcard2.jpg";
    kUTTypeImage=@"public.image";
    
    UIBarButtonItem *rightButton=[[UIBarButtonItem alloc]initWithTitle:@"发件箱" style:UIBarButtonItemStylePlain target:self action:@selector(goSendBox)];
    [rightButton setTintColor:[UIColor whiteColor]];
    
    [self.navigationItem setRightBarButtonItem:rightButton];
    
    
    
    
    if(self.isSelected){
        selectedGroup=self.selectedCustomerGroup;
        customerInformationController.txtCustomerPhone.text=self.selectedCustomerPhone;
        [customerInformationController.btGroupName setTitle:self.selectedCustomerGroup?self.selectedCustomerGroup.groupName:self.groupName forState:UIControlStateNormal];
        
        phoneInformationController.txtPhoneModel.text=self.terminalName;
        phoneInformationController.txtPhoneFee.text=self.terminalPrice;

        customerInformationButton.selected=NO;
        phoneInformationButton.selected=YES;
        contractPhoneButton.selected=NO;
        [bodyView bringSubviewToFront:phoneInformationController.view];
    }
    else{
        customerInformationButton.selected=YES;
        phoneInformationButton.selected=NO;
        contractPhoneButton.selected=NO;
        [bodyView bringSubviewToFront:customerInformationController.view];
    }
    
}
-(void)goSendBox{
    [self performSegueWithIdentifier:@"PreferentialPurchaseSendBoxSegue" sender:self];
}
- (IBAction)customerInformationButtonOnclick:(id)sender {
    [bodyView bringSubviewToFront:customerInformationController.view];
    customerInformationButton.selected=YES;
    phoneInformationButton.selected=NO;
    contractsInformationButton.selected=NO;

}
- (IBAction)phoneInformationButtonOnclick:(id)sender {
    [bodyView bringSubviewToFront:phoneInformationController.view];
    customerInformationButton.selected=NO;
    phoneInformationButton.selected=YES;
    contractsInformationButton.selected=NO;

}
- (IBAction)contractsInformationButtonOnclick:(id)sender {
    [bodyView bringSubviewToFront:contractsInformationController.view];
    customerInformationButton.selected=NO;
    phoneInformationButton.selected=NO;
    contractsInformationButton.selected=YES;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"PreferentialPurchaseSendBoxSegue"]){
        PreferentialPurchaseSendBoxViewController *controller=segue.destinationViewController;
        controller.user=self.user;
    }
    if([segue.identifier isEqualToString:@"PreferentialPurchaseContractsRecordSegue"]){
        PreferentialPurchaseContractsRecordViewController *controller=segue.destinationViewController;
        controller.user=self.user;
        controller.type=contractsInformationButton.enabled?@"0":@"1";
    }
}


-(NSString*)jpgPath{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMddHHmmssSSS"];
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    currentDateStr=[currentDateStr stringByAppendingString:@".jpg"];
    return currentDateStr;
}

- (IBAction)sendBoxButtonOnclick:(id)sender {
    UIImageView *imgIdCard1=customerInformationController.imgIdCard1;
    UIImageView *imgIdCard2=customerInformationController.imgIdCard2;
    
    
    if(!imgIdCard1.image || !imgIdCard2.image){
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"警告" message:@"身份证拍照不能为空！" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"关闭", nil];
        alertView.tag=13;
        [alertView show];
        return;
    }
    
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    long long datetime = (long long)time;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,     NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    //    NSString *rootPath=[documentsDirectory stringByAppendingPathComponent:moduleName];
    
    NSString *jpgPath1=[self jpgPath];
    [UIImageJPEGRepresentation(imgIdCard1.image, 1.0) writeToFile:[documentsDirectory stringByAppendingPathComponent:jpgPath1] atomically:YES];
    NSLog(@"save image path:%@",documentsDirectory);
    // Write image to PNG
    //    [UIImagePNGRepresentation(image) writeToFile:pngPath atomically:YES];
    NSString *jpgPath2=[self jpgPath];
    [UIImageJPEGRepresentation(imgIdCard2.image, 1.0) writeToFile:[documentsDirectory stringByAppendingPathComponent:jpgPath2] atomically:YES];
    
    //    NSMutableDictionary *imgDict =[[NSMutableDictionary alloc] init];
    //    [imgDict setObject: forKey:@"img1"];
    //    [imgDict setObject:imgIdCard2.image forKey:@"img2"];

    NSString *imgName=[NSString stringWithFormat:@"%@,%@",jpgPath1,jpgPath2];
    
//    NSString *customerName=customerInformationController.txtCustomerName.text;
  
    NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
    [dict setObject:[NSNumber numberWithInt:self.user.userID] forKey:@"customerManagerId"];
    [dict setObject:[NSNumber numberWithInt:self.user.userEnterprise] forKey:@"customerManagerEnterprise"];
    [dict setObject:[NSNumber numberWithLongLong:datetime] forKey:@"time"];
    
    [dict setObject:customerInformationController.txtCustomerName.text forKey:@"customerName"];
    [dict setObject:customerInformationController.txtIDCard.text forKey:@"customerIdCard"];
    [dict setObject:customerInformationController.txtCustomerPhone.text forKey:@"customerPhone"];
    [dict setObject:imgName forKey:@"customerIdCardPics"];
//    [dict setObject:customerInformationController.txtPassword.text forKey:@"servicePwd"];
    [dict setObject:[NSNumber numberWithInt:0] forKey:@"lng"];
    [dict setObject:[NSNumber numberWithInt:0] forKey:@"lat"];

    [dict setObject:@"123" forKey:@"deviceID"];
    [dict setObject:phoneInformationController.txtPhoneIME.text forKey:@"imsiCode"];
    [dict setObject:phoneInformationController.txtPhoneModel.text forKey:@"brandType"];
    
    [dict setObject:selectedGroup.groupId forKey:@"groupID"];
    
    [dict setObject:selectedGroup.groupName forKey:@"groupName"];
    [dict setObject:contractsInformationController.txtQuantity.text forKey:@"payMoney"];
    [dict setObject:contractsInformationController.txtStoredFee.text forKey:@"prestoreMoney"];
    [dict setObject:contractsInformationController.txtGiftOfMonthFee.text forKey:@"monthReturn"];
    [dict setObject:contractsInformationController.txtLowestMonthFee.text forKey:@"monthLowest"];
    [dict setObject:contractsInformationController.txtReturnOfMonthFee.text forKey:@"monthEndReturn"];
    [dict setObject:contractsInformationController.txtContractTerm.text forKey:@"contactPeriod"];
    NSString *sdate=[contractsInformationController.btStartDate.titleLabel.text isEqualToString:@"请选择"]?@"1900-01-01":contractsInformationController.btStartDate.titleLabel.text;
    NSString *edate=[contractsInformationController.btEndDate.titleLabel.text isEqualToString:@"请选择"]?@"1900-01-01":contractsInformationController.btEndDate.titleLabel.text;
    [dict setObject:sdate forKey:@"contactStartDate"];
    [dict setObject:edate forKey:@"contactEndDate"];
    [dict setObject:contractsInformationController.txtPostNumberOfMonth.text forKey:@"payMonths"];
    [dict setObject:contractsInformationController.txtMemo.text forKey:@"remark"];
    
    [dict setObject:contractsInformationButton.enabled?@"0":@"1" forKey:@"type"];
    [dict setObject:@"3" forKey:@"bussID"];
    [dict setObject:[NSNumber numberWithBool:NO] forKey:@"upload"];
    
    BOOL flag=[SendBoxHandling setSendMessage:dict dataWithModule:kSendBoxModuleWithOfferToBuy];
    if(flag){
        [self performSegueWithIdentifier:@"PreferentialPurchaseSendBoxSegue" sender:self];
        selectedGroup=nil;
        customerInformationController.imgIdCard1.image=nil;
        customerInformationController.imgIdCard2.image=nil;
        customerInformationController.btGroupName.titleLabel.text=nil;
        customerInformationController.txtCustomerName.text=nil;
        customerInformationController.txtCustomerPhone.text=nil;
        customerInformationController.txtIDCard.text=nil;
//        customerInformationController.txtPassword.text=nil;
//        customerInformationController.txtPasswordRetry.text=nil;
        
        phoneInformationController.txtPhoneModel.text=nil;
        phoneInformationController.txtPhoneIME.text=nil;
        phoneInformationController.txtPhoneFee.text=nil;
        
        contractsInformationController.txtQuantity.text=nil;
        contractsInformationController.txtStoredFee.text=nil;
        contractsInformationController.txtGiftOfMonthFee.text=nil;
        contractsInformationController.txtLowestMonthFee.text=nil;
        contractsInformationController.txtReturnOfMonthFee.text=nil;
        contractsInformationController.txtContractTerm.text=nil;
        contractsInformationController.btStartDate.titleLabel.text=nil;
        contractsInformationController.btEndDate.titleLabel.text=nil;
        contractsInformationController.txtPostNumberOfMonth.text=nil;
        contractsInformationController.txtMemo.text=nil;

    }
    else{
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"警告" message:@"保存到发件箱失败！" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"关闭", nil];
        alertView.tag=12;
        [alertView show];
    }
}

-(void)goCamera{
    //检查相机模式是否可用
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        NSLog(@"sorry, no camera or camera is unavailable.");
        return;
    }
    
    //创建图像选取控制器
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    //设置图像选取控制器的来源模式为相机模式
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
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
    if(!preSettingImageView||preSettingImageView == customerInformationController.imgIdCard2){
        customerInformationController.imgIdCard1.image=editedImage;
        preSettingImageView=customerInformationController.imgIdCard1;
    }
    else{
        customerInformationController.imgIdCard2.image=editedImage;
        preSettingImageView=customerInformationController.imgIdCard2;
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
-(void)deleteIDCard1{
    UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"警告" message:@"您确定要删除当前选择的图片吗照片吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
    alertView.tag=1;
    
    customerInformationController.imgIdCard1.layer.borderColor=[UIColor redColor].CGColor;
    customerInformationController.imgIdCard1.layer.borderWidth=1;
    
    CGRect rect = self.view.frame;
    rect.origin.y-=140;
    self.view.frame=rect;
}

-(void)deleteIDCard2{
    UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"警告" message:@"您确定要删除当前选择的图片吗照片吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
    alertView.tag=2;
    
    customerInformationController.imgIdCard2.layer.borderColor=[UIColor redColor].CGColor;
    customerInformationController.imgIdCard2.layer.borderWidth=1;
    
    CGRect rect = self.view.frame;
    rect.origin.y-=140;
    self.view.frame=rect;
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(alertView.tag>10)
        return;
    if(buttonIndex){
        if(alertView.tag==1){
            customerInformationController.imgIdCard1.image=nil;
            if(!customerInformationController.imgIdCard1.image && !customerInformationController.imgIdCard2.image)
                preSettingImageView=nil;
            else
                preSettingImageView=customerInformationController.imgIdCard2;
        }
        if(alertView.tag==2){
            customerInformationController.imgIdCard2.image=nil;
            if(!customerInformationController.imgIdCard1.image && !customerInformationController.imgIdCard2.image)
                preSettingImageView=nil;
            else
                preSettingImageView=customerInformationController.imgIdCard1;
        }
    }
    
    
    if(alertView.tag==1){
        customerInformationController.imgIdCard1.layer.borderWidth=0;
    }
    if(alertView.tag==2)
    {
        customerInformationController.imgIdCard2.layer.borderWidth=0;
    }
    
    CGRect rect = self.view.frame;
    rect.origin.y+=140;
    self.view.frame=rect;
}
-(void)selectGroup{
    filterController=[self.storyboard instantiateViewControllerWithIdentifier:@"MarketingGroupUserFilterViewControllerId"];
    filterController.delegate=self;
    filterController.user=self.user;
    filterController.group=selectedGroup;
    CGRect rect=filterController.view.frame;
    
    rect.origin.x=10;
    rect.origin.y=80;
    rect.size.width=300;
    rect.size.height=340;
    
    filterController.view.frame=rect;
    filterController.view.layer.borderWidth=1;
    filterController.view.layer.borderColor=[UIColor colorWithRed:55/255.0 green:132/255.0 blue:173/255.0 alpha:1.0].CGColor;
    filterController.view.layer.shadowOffset = CGSizeMake(2, 2);
    filterController.view.layer.shadowOpacity = 0.80;
    
    backView=[[UIView alloc] init];
    backView.backgroundColor=[UIColor blackColor];
    backView.alpha=0.1;
    
    backView.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [self.view addSubview:backView];
    
    [self.view addSubview:filterController.view];
}
-(void)beginEdit{
    CGRect rect=self.view.frame;
    rect.origin.y-=160;
    self.view.frame=rect;
}
-(void)endEdit{
    CGRect rect=self.view.frame;
    rect.origin.y+=160;
    self.view.frame=rect;
}
-(void)selectDate:(id)sender{
    //PreferentialPurchaseSelectDateTimeViewControllerId
    selectDateTimeViewController=[self.storyboard instantiateViewControllerWithIdentifier:@"PreferentialPurchaseSelectDateTimeViewControllerId"];
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
-(void)preferentialPurchaseSelectGroupViewControllerDidCanceled{
    [backView removeFromSuperview];
    [filterController.view removeFromSuperview];
    
    backView=nil;
    filterController=nil;
}
-(void)preferentialPurchaseSelectGroupViewControllerDidFinished:(PreferentialPurchaseSelectGroupViewController *)controller{
    selectedGroup=controller.group;
//    customerInformationController.txtGroupName.text=controller.group.groupName;
    [customerInformationController.btGroupName setTitle:controller.group.groupName forState:UIControlStateNormal];
    
    [self preferentialPurchaseSelectGroupViewControllerDidCanceled];
}


- (IBAction)contractPhoneButtonOnclick:(id)sender {
    [contractPhoneButton setBackgroundImage:[UIImage imageNamed:@"switch_chen1"] forState:UIControlStateNormal];
    [barePhoneButton setBackgroundImage:[UIImage imageNamed:@"switch_hui2"] forState:UIControlStateNormal];
    [contractPhoneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [barePhoneButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    
    contractsInformationButton.enabled=YES;
}
- (IBAction)barePhoneButtonOnclick:(id)sender {
    [contractPhoneButton setBackgroundImage:[UIImage imageNamed:@"switch_hui1"] forState:UIControlStateNormal];
    [barePhoneButton setBackgroundImage:[UIImage imageNamed:@"switch_chen2"] forState:UIControlStateNormal];
    [contractPhoneButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [barePhoneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    if(contractsInformationButton.selected){
        customerInformationButton.selected=YES;
        contractsInformationButton.selected=NO;
         [bodyView bringSubviewToFront:customerInformationController.view];
    }
    contractsInformationButton.enabled=NO;
    
}

@end
