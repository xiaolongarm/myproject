//
//  DataAcquisitionWithGeneralInformationTableViewController.m
//  CMCCMarketing
//
//  Created by talkweb on 15-2-27.
//  Copyright (c) 2015年 talkweb. All rights reserved.
//

#import "DataAcquisitionWithGeneralInformationTableViewController.h"
#import "DataAcquisitionWithGeneralInformationTableViewCell.h"
#import "MBProgressHUD.h"
#import "NetworkHandling.h"

@interface DataAcquisitionWithGeneralInformationTableViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,MBProgressHUDDelegate>{
    NSString *kUTTypeImage;
    
    UIImageView *imgView;
    BOOL hubFlag;
}

@end

@implementation DataAcquisitionWithGeneralInformationTableViewController

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
    DataAcquisitionWithGeneralInformationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DataAcquisitionWithGeneralInformationTableViewCell" forIndexPath:indexPath];
    
    [cell.itemPhotographButton addTarget:self action:@selector(itemPhotographButtonOnclick:) forControlEvents:UIControlEventTouchUpInside];
    imgView=cell.itemMarketingPolicyPhoto;
    
    cell.itemDemandForSupport.delegate=self;
    cell.itemCompetitorsCategory.delegate=self;
    cell.itemMarketingPlace.delegate=self;
    return cell;
}

-(void)itemPhotographButtonOnclick:(id)sender{
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
    
    imgView.image = [info objectForKey:UIImagePickerControllerEditedImage];
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
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
    DataAcquisitionWithGeneralInformationTableViewCell *cell=(DataAcquisitionWithGeneralInformationTableViewCell*)[self.tableView cellForRowAtIndexPath:indexPath];
    
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    [bDict setObject:[NSNumber numberWithInt:self.user.userID] forKey:@"user_id"];
    [bDict setObject:self.user.userName forKey:@"user_name"];
    [bDict setObject:self.user.userMobile forKey:@"user_msisdn"];
    [bDict setObject:[NSNumber numberWithInt:self.user.userEnterprise] forKey:@"enterprise"];
    

//    visit_id拜访计划Id，没有则传-1
//	competitor_type 竞争对手类别
//	market_add 营销地点
//	Activities 活动宣传内容
//	buss_handle 业务办理情况
//	fee_policy 自费政策
//	trem_policy 终端政策
//	broadband_policy 宽带政策
//	other_policy 其他政策
//	detailed_description 其他详细说明
//	demand 需求支撑
//	answer_policy 我方应对政策

    [bDict setObject:@"-1" forKey:@"visit_id"];
    [bDict setObject:cell.itemCompetitorsCategory.text forKey:@"competitor_type"];
    [bDict setObject:cell.itemMarketingPlace.text forKey:@"market_add"];
    [bDict setObject:cell.itemActivitiesPromotionalContent.text forKey:@"Activities"];
    [bDict setObject:cell.itemTransactBusinessCase.text forKey:@"buss_handle"];
    [bDict setObject:cell.itemTariffPolicy.text forKey:@"fee_policy"];
    [bDict setObject:cell.itemTerminalPolicy.text forKey:@"trem_policy"];
    [bDict setObject:cell.itemBroadbandPolicy.text forKey:@"broadband_policy"];
    [bDict setObject:cell.itemOtherPolicy.text forKey:@"other_policy"];
    [bDict setObject:cell.itemOtherDetails.text forKey:@"detailed_description"];
    [bDict setObject:cell.itemDemandForSupport.text forKey:@"demand"];
    [bDict setObject:cell.itemOurStrategy.text forKey:@"answer_policy"];

    NSString *picName=[self jpgPath];
    [bDict setObject:picName forKey:@"image_url"];
    
    NSString *typeString=[NSString stringWithFormat:@"?type=datacollect/public/%d",self.user.userID];
    
    [NetworkHandling UploadsyntheticPictures:imgView.image currentPicName:picName uploadType:typeString completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
    
        if(!error){
            NSDictionary *d1=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            BOOL f1=[[d1 objectForKey:@"imgUpload"] boolValue];
            if(f1){
                [NetworkHandling sendPackageWithUrl:@"datacollect/visitPublicInformationInfo" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
                    
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
