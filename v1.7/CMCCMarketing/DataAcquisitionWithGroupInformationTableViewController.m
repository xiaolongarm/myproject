//
//  DataAcquisitionWithGroupInformationTableViewController.m
//  CMCCMarketing
//
//  Created by talkweb on 15-2-27.
//  Copyright (c) 2015年 talkweb. All rights reserved.
//

#import "DataAcquisitionWithGroupInformationTableViewController.h"
#import "DataAcquisitionWithGroupInformationTableViewCell.h"
#import "PreferentialPurchaseSelectGroupViewController.h"
#import "MBProgressHUD.h"
#import "NetworkHandling.h"

@interface DataAcquisitionWithGroupInformationTableViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,PreferentialPurchaseSelectGroupViewControllerDelegate,MBProgressHUDDelegate,UIActionSheetDelegate>{
    NSString *kUTTypeImage;
    
    UIImageView *imgView;
    
    PreferentialPurchaseSelectGroupViewController *filterController;
    UIView *backView;
    Group *selectedGroup;
    UIButton *selectGroupButton;
    
    BOOL hubFlag;
}

@end

@implementation DataAcquisitionWithGroupInformationTableViewController

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
    
    kUTTypeImage=@"public.image";
    
    UIBarButtonItem *rightButton=[[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(submitData)];
    [rightButton setTintColor:[UIColor whiteColor]];
    [self.navigationItem setRightBarButtonItem:rightButton];
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
    return 1000;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DataAcquisitionWithGroupInformationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DataAcquisitionWithGroupInformationTableViewCell" forIndexPath:indexPath];
    
    [cell.itemNameOfTheButton addTarget:self action:@selector(itemNameOfTheButtonOnclick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.itemPhotographButton addTarget:self action:@selector(photoModeSelection) forControlEvents:UIControlEventTouchUpInside];
    imgView=cell.itemCompetitionPhoto;
    
    cell.itemTheTotalNumberOfEmployees.delegate=self;
    cell.itemTheTotalNumberOfMembersOfTheGroup.delegate=self;
    cell.itemCMCCMarketShare.delegate=self;
    cell.itemTelecomMarketShare.delegate=self;
    cell.itemCaseInformation.delegate=self;
    cell.itemWarningLevel.delegate=self;
    cell.itemCategory.delegate=self;
    cell.itemPosition.delegate=self;
    cell.itemPhone.delegate=self;
    cell.itemTheSecondPersonToContact.delegate=self;
    cell.itemPosition2.delegate=self;
    cell.itemPhone2.delegate=self;
    cell.itemDemandInformation.delegate=self;
    
    return cell;
}
-(void)photoModeSelection{
    UIActionSheet *actionSheet=[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取 消" destructiveButtonTitle:@"照相机" otherButtonTitles:@"图 库", nil];
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
    
    imgView.image = [info objectForKey:UIImagePickerControllerEditedImage];
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
-(void)itemNameOfTheButtonOnclick:(id)sender{
    selectGroupButton=sender;
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"BusinessProcess" bundle:nil];
    filterController=[storyboard instantiateViewControllerWithIdentifier:@"MarketingGroupUserFilterViewControllerId"];
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
    filterController.lbTitle.text=@"请选择集团单位";
    backView=[[UIView alloc] init];
    backView.backgroundColor=[UIColor blackColor];
    backView.alpha=0.1;
    
    backView.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [self.view addSubview:backView];
    
    [self.view addSubview:filterController.view];
}
-(void)preferentialPurchaseSelectGroupViewControllerDidCanceled{
    [backView removeFromSuperview];
    [filterController.view removeFromSuperview];
    
    backView=nil;
    filterController=nil;
}
-(void)preferentialPurchaseSelectGroupViewControllerDidFinished:(PreferentialPurchaseSelectGroupViewController *)controller{
    selectedGroup=controller.group;
    [selectGroupButton setTitle:controller.group.groupName forState:UIControlStateNormal];
    [self preferentialPurchaseSelectGroupViewControllerDidCanceled];
}

#pragma mark - post data

-(void)submitData{
    
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
-(void)postData{
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
    DataAcquisitionWithGroupInformationTableViewCell *cell=(DataAcquisitionWithGroupInformationTableViewCell*)[self.tableView cellForRowAtIndexPath:indexPath];
    
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    [bDict setObject:[NSNumber numberWithInt:self.user.userID] forKey:@"user_id"];
    [bDict setObject:self.user.userName forKey:@"user_name"];
    [bDict setObject:self.user.userMobile forKey:@"user_msisdn"];
    [bDict setObject:[NSNumber numberWithInt:self.user.userEnterprise] forKey:@"enterprise"];
    
    if(selectedGroup){
        [bDict setObject:selectedGroup.groupId forKey:@"grp_code"];
        [bDict setObject:selectedGroup.groupName forKey:@"grp_name"];
    }
    
    [bDict setObject:cell.itemTheTotalNumberOfEmployees.text forKey:@"user_cnt"];
    [bDict setObject:cell.itemTheTotalNumberOfMembersOfTheGroup.text forKey:@"grp_cnt"];
    [bDict setObject:cell.itemCMCCMarketShare.text forKey:@"cmcc_per"];
    [bDict setObject:cell.itemTelecomMarketShare.text forKey:@"ctcc_per"];
    [bDict setObject:cell.itemCaseInformation.text forKey:@"info_content"];
    
    [bDict setObject:cell.itemWarningLevel.text forKey:@"warn_lvl"];
    [bDict setObject:cell.itemCategory.text forKey:@"info_type"];
    [bDict setObject:cell.itemIsKeyPeople.on?@"关键人":@"非关键人" forKey:@"linkman_type"];
    [bDict setObject:cell.itemPosition.text forKey:@"job"];
    [bDict setObject:cell.itemPhone.text forKey:@"link_msisdn"];
    [bDict setObject:cell.itemTheSecondPersonToContact.text forKey:@"linkman2"];
    [bDict setObject:cell.itemPosition2.text forKey:@"job2"];
    [bDict setObject:cell.itemPhone2.text forKey:@"link_msisdn2"];
    
    [bDict setObject:cell.itemCompetition.text forKey:@"competition"];
    [bDict setObject:cell.itemDemandInformation.text forKey:@"demand"];
    [bDict setObject:cell.itemOurStrategy.text forKey:@"policy"];
    [bDict setObject:cell.itemThisWeekTrackingCase.text forKey:@"remark"];

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

-(void)hudWasHidden:(MBProgressHUD *)hud{
    [hud removeFromSuperview];
    hud=nil;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
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

@end
