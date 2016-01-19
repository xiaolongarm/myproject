//
//  DataAcquisitionReportedTableViewController.m
//  CMCCMarketing
//
//  Created by talkweb on 14-9-28.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//
#import "DataAcquisitionReportedTableViewCell.h"
#import "DataAcquisitionReportedTableViewController.h"
#import "MBProgressHUD.h"
#import "NetworkHandling.h"
//#import "PreferentialPurchaseSelectGroupViewController.h"
#import "Group.h"
#import "W_VisitPlanAddSelectGroupTableViewController.h"

@interface DataAcquisitionReportedTableViewController ()<MBProgressHUDDelegate,
//PreferentialPurchaseSelectGroupViewControllerDelegate,
DataAcquisitionReportedTableViewCellDelegate,VisitPlanAddSelectGroupTableViewControllerDelegate,UIActionSheetDelegate>{
    BOOL hubFlag;
    
//    PreferentialPurchaseSelectGroupViewController *filterController;
    UIView *backView;
    Group *selectedGroup;
    UIButton *selectedGroupButton;
    
    NSString *kUTTypeImage;
    UIImageView *imgView;
    UIImageView *zoomImageView;
}

@end

@implementation DataAcquisitionReportedTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *rightButton=[[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(submitData)];
    [rightButton setTintColor:[UIColor whiteColor]];
    [self.navigationItem setRightBarButtonItem:rightButton];
    
   kUTTypeImage=@"public.image";
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
-(void)submitData{
//    if(selectedGroup){
//        MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
//        [self.view addSubview:HUD];
//        HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
//        HUD.mode = MBProgressHUDModeCustomView;
//        HUD.delegate = self;
//        HUD.labelText = @"您还没有选择集团信息！";
//        [HUD show:YES];
//        [HUD hide:YES afterDelay:2];
//        return;
//    }

    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
    DataAcquisitionReportedTableViewCell *cell=(DataAcquisitionReportedTableViewCell*)[self.tableView cellForRowAtIndexPath:indexPath];
    
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    [bDict setObject:[NSNumber numberWithInt:self.user.userID] forKey:@"user_id"];
    [bDict setObject:self.user.userName forKey:@"user_name"];
    [bDict setObject:self.user.userMobile forKey:@"user_msisdn"];
    [bDict setObject:[NSNumber numberWithInt:self.user.userEnterprise] forKey:@"enterprise"];

    NSString *alertMes = nil;
    if(!selectedGroup){
        alertMes = @"请选择单位";
    }
    else if ([cell.itemGroupStaffNumber.text length] == 0) {
        alertMes = @"请输入单位员工总数";
    }
    else if ([cell.itemGroupNum.text length] == 0) {
        alertMes = @"请输入集团成员数";
    }
    else if ([cell.itemMarketShareWithCMCC.text length] == 0) {
        alertMes = @"请输入移动市场占有率";
    }
    else if ([cell.itemMarketShareWithTeleCom.text length] == 0) {
        alertMes = @"请输入电信市场占有率";
    }
    else if ([cell.itemInformationTech.text length] == 0) {
        alertMes = @"请输入信息化情况";
    }
    else if ([cell.itemWarnLVL.text length] == 0) {
        alertMes = @"请输入预警级别";
    }
    else if ([cell.itemType.text length] == 0) {
        alertMes = @"请输入信息类型";
    }
    else if ([cell.itemContactJobWithfirst.text length] == 0) {
        alertMes = @"请输入对象1职务";
    }
    else if ([cell.itemContactNameWithSecond.text length] == 0) {
        alertMes = @"请输入联系对象2";
    }
    else if ([cell.itemContactJobWithSecond.text length] == 0) {
        alertMes = @"请输入对象2职务";
    }
    else if(![self isMobileNumber:cell.itemContactPhoneWithFirst.text] || ![self isMobileNumber:cell.itemContactPhoneWithSecond.text]){
        alertMes = @"请输入正确格式的联系电话";
    }
    else if ([cell.itemCompetition.text length] == 0) {
        alertMes = @"请输入竞争情况";
    }
    else if ([cell.itemGroupDemand.text length] == 0) {
        alertMes = @"请输入单位需求";
    }
    else if ([cell.itemWeDealWith.text length] == 0) {
        alertMes = @"请输入我方应对政策";
    }

    if (alertMes) {
        [[[UIAlertView alloc] initWithTitle:@"提示"
                                    message:alertMes
                                   delegate:nil
                          cancelButtonTitle:@"确定"
                          otherButtonTitles: nil] show];
        return;
    }
    
    hubFlag=YES;
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"正在提交数据，请稍后...";
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
    [self postData];
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


///// 手机号码的有效性判断
//检测是否是手机号码
- (BOOL)isMobileNumber:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,147,152,155,156,185,186
     * 电信：133,1349,153,180,181,189
     */
    NSString * MOBILE = @"^1(3[0-9]|4[7]|5[0-35-9]|8[0-25-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([phoneTest evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

-(void)postData{
    
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
    DataAcquisitionReportedTableViewCell *cell=(DataAcquisitionReportedTableViewCell*)[self.tableView cellForRowAtIndexPath:indexPath];
    
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    [bDict setObject:[NSNumber numberWithInt:self.user.userID] forKey:@"user_id"];
    [bDict setObject:self.user.userName forKey:@"user_name"];
    [bDict setObject:self.user.userMobile forKey:@"user_msisdn"];
    [bDict setObject:[NSNumber numberWithInt:self.user.userEnterprise] forKey:@"enterprise"];
    
    if(selectedGroup){
        [bDict setObject:selectedGroup.groupId forKey:@"grp_code"];
        [bDict setObject:selectedGroup.groupName forKey:@"grp_name"];
    }
    [bDict setObject:cell.itemGroupStaffNumber.text forKey:@"user_cnt"];
    [bDict setObject:cell.itemGroupNum.text forKey:@"grp_cnt"];
    [bDict setObject:cell.itemMarketShareWithCMCC.text forKey:@"cmcc_per"];
    [bDict setObject:cell.itemMarketShareWithTeleCom.text forKey:@"ctcc_per"];
    [bDict setObject:cell.itemInformationTech.text forKey:@"info_content"];
    
    [bDict setObject:cell.itemWarnLVL.text forKey:@"warn_lvl"];
    [bDict setObject:cell.itemType.text forKey:@"info_type"];
    [bDict setObject:cell.itemIsKeyPeople.on?@"关键人":@"非关键人" forKey:@"linkman_type"];
    [bDict setObject:cell.itemContactJobWithfirst.text forKey:@"job"];
    [bDict setObject:cell.itemContactPhoneWithFirst.text forKey:@"link_msisdn"];
    [bDict setObject:cell.itemContactNameWithSecond.text forKey:@"linkman2"];
    [bDict setObject:cell.itemContactJobWithSecond.text forKey:@"job2"];
    [bDict setObject:cell.itemContactPhoneWithSecond.text forKey:@"link_msisdn2"];
    
    [bDict setObject:cell.itemCompetition.text forKey:@"competition"];
    [bDict setObject:cell.itemGroupDemand.text forKey:@"demand"];
    [bDict setObject:cell.itemWeDealWith.text forKey:@"policy"];
    [bDict setObject:cell.itemFollowUpContent.text forKey:@"remark"];
    
    NSString *picName=[self jpgPath];
    [bDict setObject:picName forKey:@"customerIdCardPics"];
    
    [NetworkHandling UploadsyntheticPictures:imgView.image currentPicName:picName currentUser:self.user.userID uploadType:@"customeridcardpics" completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        if(!error){
            NSDictionary *d1=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            BOOL f1=[[d1 objectForKey:@"imgUpload"] boolValue];
            if(f1){
                [NetworkHandling sendPackageWithUrl:@"datacollect/competitorsInfo" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
                    
                    if(!error){
                        NSLog(@"sign in success");
                        NSDictionary *dict=[result objectForKey:@"Response"];
                        BOOL flag=[[dict objectForKey:@"returnFlag"] boolValue];
                        if(flag)
                            [self performSelectorOnMainThread:@selector(showMessage:) withObject:@"提交信息成功！" waitUntilDone:YES];
                        else
                            [self performSelectorOnMainThread:@selector(showMessage:) withObject:@"提交信息失败！" waitUntilDone:YES];
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
            else{
                hubFlag=NO;
                [self performSelectorOnMainThread:@selector(showMessage:) withObject:@"提交拍照信息失败！！" waitUntilDone:YES];
            }
        }
    }];
    
}

-(void)showMessage:(NSString*)infomation{
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"信息提示" message:infomation delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
    [myAlertView show];
}
-(void)refreshRemindButton{
   
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 950;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DataAcquisitionReportedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DataAcquisitionReportedTableViewCell" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.delegate=self;
    
    [cell.itemPhotograghButton addTarget:self action:@selector(goCameral:) forControlEvents:UIControlEventTouchUpInside];
    imgView=cell.itemCompetitionPhoto;
    
    return cell;
}

-(void)selectGroup:(id)sender{
    selectedGroupButton=sender;
//    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"BusinessProcess" bundle:nil];
//    filterController=[storyboard instantiateViewControllerWithIdentifier:@"MarketingGroupUserFilterViewControllerId"];
//    filterController.delegate=self;
//    filterController.user=self.user;
//    filterController.group=selectedGroup;
//    CGRect rect=filterController.view.frame;
//    
//    rect.origin.x=10;
//    rect.origin.y=80;
//    rect.size.width=300;
//    rect.size.height=340;
//    
//    filterController.view.frame=rect;
//    filterController.view.layer.borderWidth=1;
//    filterController.view.layer.borderColor=[UIColor colorWithRed:55/255.0 green:132/255.0 blue:173/255.0 alpha:1.0].CGColor;
//    filterController.view.layer.shadowOffset = CGSizeMake(2, 2);
//    filterController.view.layer.shadowOpacity = 0.80;
//    
//    backView=[[UIView alloc] init];
//    backView.backgroundColor=[UIColor blackColor];
//    backView.alpha=0.1;
//    
//    backView.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
//    [[self.view superview]addSubview:backView];
////    [self.view addSubview:backView];
//    
////    [self.view addSubview:filterController.view];
//    [[self.view superview]addSubview:filterController.view];
    
    W_VisitPlanAddSelectGroupTableViewController *controller=[[W_VisitPlanAddSelectGroupTableViewController alloc] initWithNibName:@"W_VisitPlanAddSelectGroupTableViewController" bundle:nil];
    controller.delegate=self;
    controller.user=self.user;
    controller.tableArray=self.user.groupInfo;
    controller.selectGroup=selectedGroup;
    
    [self.navigationController pushViewController:controller animated:YES];
}
//-(void)preferentialPurchaseSelectGroupViewControllerDidCanceled{
//    [backView removeFromSuperview];
//    [filterController.view removeFromSuperview];
//    
//    backView=nil;
//    filterController=nil;
//}
//-(void)preferentialPurchaseSelectGroupViewControllerDidFinished:(PreferentialPurchaseSelectGroupViewController *)controller{
//    selectedGroup=controller.group;
////    [greaterViewController.btGroupName setTitle:controller.group.groupName forState:UIControlStateNormal];
////    greaterViewController.txtGroupId.text=selectedGroup.groupId;
////    greaterViewController.txtGroupNo.text=[NSString stringWithFormat:@"%.0f",selectedGroup.groupserviceCode];
//   
//    [selectedGroupButton setTitle:selectedGroup.groupName forState:UIControlStateNormal];
//    [self preferentialPurchaseSelectGroupViewControllerDidCanceled];
//}

-(void)visitPlanAddSelectGroupTableViewControllerDidFinished:(W_VisitPlanAddSelectGroupTableViewController *)controller{
    selectedGroup=controller.selectGroup;
    [selectedGroupButton setTitle:selectedGroup.groupName forState:UIControlStateNormal];
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - cameral
//-(void)itemPhotographButtonOnclick:(id)sender{
//    //检查相机模式是否可用
//    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
//        NSLog(@"sorry, no camera or camera is unavailable.");
//        return;
//    }
//    
//    //创建图像选取控制器
//    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
//    //设置图像选取控制器的来源模式为相机模式
//    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
//    //设置图像选取控制器的类型为静态图像
//    imagePickerController.mediaTypes = [[NSArray alloc] initWithObjects:kUTTypeImage, nil];
//    //允许用户进行编辑
//    imagePickerController.allowsEditing = YES;
//    //设置委托对象
//    imagePickerController.delegate = self;
//    //以模视图控制器的形式显示
//    [self presentViewController:imagePickerController animated:YES completion:nil];
//}
//
//- (void)image:(UIImage*)image didFinishSavingWithError:(NSError*)error contextInfo:(void*)contextInfo{
//    if (!error) {
//        NSLog(@"picture saved with no error.");
//    }
//    else
//    {
//        NSLog(@"error occured while saving the picture%@", error);
//    }
//}
//
//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
//    
//    imgView.image = [info objectForKey:UIImagePickerControllerEditedImage];
//    [picker dismissViewControllerAnimated:YES completion:nil];
//    
//}
//- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
//    [picker dismissViewControllerAnimated:YES completion:nil];
//}
- (IBAction)goCameral:(id)sender{
    
    UIActionSheet *actionSheet=[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取 消" destructiveButtonTitle:@"相 机" otherButtonTitles:@"照片库", nil];
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
    imgView.image = image;
}
- (IBAction)zoomPhotoOnclick:(id)sender {
    if(!imgView.image)
        return;
    
    zoomImageView.image=imgView.image;
    zoomImageView.contentMode=UIViewContentModeScaleAspectFit;
    [self.navigationController.view addSubview:zoomImageView];
}
@end
