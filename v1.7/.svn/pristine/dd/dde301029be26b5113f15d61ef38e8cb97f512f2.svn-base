//
//  DataAcquisitionVipInformationsTableViewController.m
//  CMCCMarketing
//
//  Created by gmj on 14-12-18.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import "DataAcquisitionVipInformationsTableViewController.h"
#import "DataAcquisitionVipInformationsTableViewCell.h"

#import "NetworkHandling.h"
#import "MBProgressHUD.h"


@interface DataAcquisitionVipInformationsTableViewController ()<MBProgressHUDDelegate>{
    NSString *kUTTypeImage;
    BOOL hubFlag;
    
    __weak IBOutlet UIImageView *photograghImageView;
     UIImageView *zoomImageView;
}

@end

@implementation DataAcquisitionVipInformationsTableViewController

#pragma mark - UITextField delegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - UITextView delegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        //在这里做你响应return键的代码
        //        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    
    CGRect rect=self.view.frame;
    rect.origin.y-=200;
    self.view.frame=rect;
    return YES;
    
}

-(BOOL)textViewShouldEndEditing:(UITextView *)textView{
    
    CGRect rect=self.view.frame;
    rect.origin.y+=200;
    self.view.frame=rect;
    return YES;
    
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
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

    UIBarButtonItem *rightButton=[[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(submitData)];
    [rightButton setTintColor:[UIColor whiteColor]];
    [self.navigationItem setRightBarButtonItem:rightButton];
    
    self.txt_linkman_name.delegate= self;//关键人姓名
    self.txt_linkman_msisdn.delegate = self;//关键人联系电话
    self.txt_linkman_depart.delegate = self;//所属部门
    self.txt_linkman_job.delegate = self;//所在职务
    self.txt_linkman_msisdn_bak.delegate =self;//关键人其他电话

    self.txtView_remark.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.txtView_remark.layer.borderWidth=0.3f;
    self.txtView_remark.layer.cornerRadius=3;
    self.txtView_remark.layer.masksToBounds=YES;
    self.txtView_remark.delegate=self;
    
    self.txtView_explan.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.txtView_explan.layer.borderWidth=0.3f;
    self.txtView_explan.layer.cornerRadius=3;
    self.txtView_explan.layer.masksToBounds=YES;
    self.txtView_explan.delegate=self;
    kUTTypeImage=@"public.image";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 700;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"DataAcquisitionVipInformationsTableViewCell";
    DataAcquisitionVipInformationsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
    
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
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
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

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */



#pragma mark - visitPlanAddSelectGroupTableViewController delegate

-(void)visitPlanAddSelectGroupTableViewControllerDidFinished:(W_VisitPlanAddSelectGroupTableViewController *)controller{
    
    self.selectGroup = controller.selectGroup;
    
    [self.btnGroupName setTitle:self.selectGroup.groupName forState:UIControlStateNormal];
}

- (IBAction)btnGroupNameOnClick:(id)sender {//归属集团
    
    W_VisitPlanAddSelectGroupTableViewController *controller=[[W_VisitPlanAddSelectGroupTableViewController alloc] initWithNibName:@"W_VisitPlanAddSelectGroupTableViewController" bundle:nil];
    controller.delegate=self;
    controller.user=self.user;
    controller.tableArray=self.user.groupInfo;
    controller.selectGroup=self.selectGroup;
    
    [self.navigationController pushViewController:controller animated:YES];
    
}

- (IBAction)btn_linkman_typeOnClick:(id)sender {//关键人类型
    
    self.selectedButton = sender;
    
    UIActionSheet *actionSheet=[[UIActionSheet alloc] initWithTitle:@"关键人类型" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"决策关键人" otherButtonTitles:@"业务关键人", @"一般关键人", nil];
    actionSheet.tag=1;
    [actionSheet showInView:self.view];
    self.selectedButton=sender;
    
}

- (IBAction)btn_linkman_bussOnClick:(id)sender {//分管业务
    
    self.selectedButton = sender;
    
    UIActionSheet *actionSheet=[[UIActionSheet alloc] initWithTitle:@"分管业务" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"通信" otherButtonTitles:@"信息化", nil];
    actionSheet.tag=1;
    [actionSheet showInView:self.view];
    self.selectedButton=sender;
    
}

- (IBAction)btn_diff_typeOnClick:(id)sender {//异网关键人归属
    
    self.selectedButton = sender;
    
    UIActionSheet *actionSheet=[[UIActionSheet alloc] initWithTitle:@"异网关键人归属" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"联通" otherButtonTitles:@"电信", nil];
    actionSheet.tag=1;
    [actionSheet showInView:self.view];
    self.selectedButton=sender;
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (self.selectedButton == self.btn_diff_type) {//异网关键人归属
        
        if(buttonIndex == 0){
            
            [self.selectedButton setTitle:@"联通" forState:UIControlStateNormal];
        }
        else if(buttonIndex == 1){
            
            [self.selectedButton setTitle:@"电信" forState:UIControlStateNormal];
        }
        
    } else if (self.selectedButton == self.btn_linkman_buss) {//分管业务
        
        if(buttonIndex == 0){
            
            [self.selectedButton setTitle:@"通信" forState:UIControlStateNormal];
        }
        else if(buttonIndex == 1){
            
            [self.selectedButton setTitle:@"信息化" forState:UIControlStateNormal];
        }
        
    } else if (self.selectedButton == self.btn_linkman_type) {//关键人类型
        
        if(buttonIndex == 0){
            
            [self.selectedButton setTitle:@"决策关键人" forState:UIControlStateNormal];
        }
        else if(buttonIndex == 1){
            
            [self.selectedButton setTitle:@"业务关键人" forState:UIControlStateNormal];
            
        }else if(buttonIndex == 2){
            
            [self.selectedButton setTitle:@"一般关键人" forState:UIControlStateNormal];
        }
        
    }
    else if(actionSheet.tag == 123){
        if(buttonIndex == 0 || buttonIndex ==1){
            [self itemPhotographButtonOnclick:buttonIndex];
        }
    }
    
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

-(void)submitData{
    if(!self.selectGroup){
        [self showTips:@"请选择归属集团！"];
        return;
    }
    
    if(self.txt_linkman_name.text.length < 1){
        [self showTips:@"请填写关键人姓名！"];
        return;
    }
    if(self.txt_linkman_msisdn.text.length < 1){
        [self showTips:@"请填写关键人电话！"];
        return;
    }
    if(self.txt_linkman_msisdn.text.length !=11){
        [self showTips:@"请正确填写电话！"];
        return;
    }
    
    if(self.txt_linkman_depart.text.length < 1){
        [self showTips:@"请填写部门信息！"];
        return;
    }
    
    if(self.txt_linkman_job.text.length < 1){
        [self showTips:@"请填写职务信息！"];
        return;
    }
    
    NSString *alertMes = nil;
    if(!self.selectGroup){
        alertMes = @"请选择归属集团";
    }
    else if ([self.txt_linkman_name.text length] == 0) {
        alertMes = @"请输入关键人姓名";
    }
    else if(![self isMobileNumber:self.txt_linkman_msisdn.text]){
        alertMes = @"请输入正确格式的关键人联系电话";
    }
    else if ([self.txt_linkman_depart.text length] == 0) {
        alertMes = @"请输入所属部门";
    }
    else if ([self.txt_linkman_job.text length] == 0) {
        alertMes = @"请输入所在职务";
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
    
    /*
     
     visit_id:this.planId,
     linkman_name:utils.chinese2unicode(linkman_name),//关键人姓名
     linkman_msisdn:linkman_msisdn,//关键人联系电话
     grp_code:this.groupInfo.groupID,	//归属集团
     grp_name:utils.chinese2unicode(this.groupInfo.groupName),
     grp_lvl:this.groupInfo.grp_lvl,	//集团单位级别
     linkman_depart:utils.chinese2unicode(linkman_depart),//所属部门
     linkman_job:utils.chinese2unicode(linkman_job),//所在职务
     linkman_type:utils.chinese2unicode(linkman_type),//关键人类型
     linkman_buss:utils.chinese2unicode(linkman_buss),//分管业务
     is_diff_key:utils.chinese2unicode(is_diff_key),//是否异网关键人
     diff_type:utils.chinese2unicode(diff_type),//异网关键人归属
     linkman_msisdn_bak:linkman_msisdn_bak,//关键人其他电话
     is_grp_sa:utils.chinese2unicode(is_grp_sa),	//是否为集团sa单位
     is_def_linkman:utils.chinese2unicode(is_def_linkman),//是否日常拜访目标
     is_two_grp:utils.chinese2unicode(is_two_grp),//是否二级机构
     p_grp_name:utils.chinese2unicode(this.groupInfo.super_group_name),//上级机构名称
     remark:utils.chinese2unicode(remark),//备注
     explan:utils.chinese2unicode(explan)//说明
     
     */
    
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    
    NSString *client_os = @"ios";
    [bDict setObject:client_os forKey:@"client_os"];
    
    int uid = self.user.userID;
    NSString *reply_user_id = [NSString stringWithFormat:@"%d",uid];
    [bDict setObject:reply_user_id forKey:@"user_id"];
    
    [bDict setObject:[NSNumber numberWithInt:self.user.userEnterprise] forKey:@"enterprise"];
    
    NSString *vip_mngr_name = self.user.userName;
    [bDict setObject:vip_mngr_name forKey:@"vip_mngr_name"];
    
    NSString *vip_mngr_msisdn = self.user.userMobile;
    [bDict setObject:vip_mngr_msisdn forKey:@"vip_mngr_msisdn"];

    NSString *vp_id = self.visit_id;
    vp_id = vp_id?vp_id:@"";
    [bDict setObject:vp_id forKey:@"visit_id"];
    
    NSString *linkman_name = self.txt_linkman_name.text;
    [bDict setObject:linkman_name forKey:@"linkman_name"];
    
    NSString *linkman_msisdn = self.txt_linkman_msisdn.text;
    [bDict setObject:linkman_msisdn forKey:@"linkman_msisdn"];
    
    NSString *grp_code = self.selectGroup.groupId;
    [bDict setObject:grp_code forKey:@"grp_code"];
    
    NSString *grp_name = self.selectGroup.groupName;
    [bDict setObject:grp_name forKey:@"grp_name"];
    
    NSString *grp_lvl = self.selectGroup.groupLvl;
    [bDict setObject:grp_lvl forKey:@"grp_lvl"];
    
    NSString *linkman_depart = self.txt_linkman_depart.text;
    [bDict setObject:linkman_depart forKey:@"linkman_depart"];
    
    NSString *linkman_job = self.txt_linkman_job.text;
    [bDict setObject:linkman_job forKey:@"linkman_job"];
    
    NSString *linkman_type = self.btn_linkman_type.titleLabel.text;
    [bDict setObject:linkman_type forKey:@"linkman_type"];
    
    NSString *linkman_buss = self.btn_linkman_buss.titleLabel.text;
    [bDict setObject:linkman_buss forKey:@"linkman_buss"];
    
    NSString *is_diff_key = @"否";
    if (self.switch_is_diff_key.on) {
        
        is_diff_key = @"是";
    } else {
        is_diff_key = @"否";
    }
    [bDict setObject:is_diff_key forKey:@"is_diff_key"];
    
    
    NSString *diff_type = self.btn_diff_type.titleLabel.text;
    [bDict setObject:diff_type forKey:@"diff_type"];
    
    NSString *linkman_msisdn_bak = self.txt_linkman_msisdn_bak.text;
    [bDict setObject:linkman_msisdn_bak forKey:@"linkman_msisdn_bak"];
    
    NSString *is_grp_sa = @"否";
    if (self.switch_is_grp_sa.on) {
        
        is_grp_sa = @"是";
    } else {
        
        is_grp_sa = @"否";
    }
    [bDict setObject:is_grp_sa forKey:@"is_grp_sa"];
    
    NSString *is_def_linkman = @"否";
    if (self.switch_is_def_linkman.on) {
        
        is_def_linkman = @"是";
    } else {
        
        is_def_linkman = @"否";
    }
    [bDict setObject:is_def_linkman forKey:@"is_def_linkman"];
    
    NSString *is_two_grp = self.selectGroup.groupSuperGroupId;
    if (is_two_grp && is_two_grp.length >= 1) {
        
        is_two_grp = @"是";
        
    } else {
        
        is_two_grp = @"否";
    }
    [bDict setObject:is_two_grp forKey:@"is_two_grp"];
    
    NSString *p_grp_name = self.selectGroup.groupSuperGroupName;
    [bDict setObject:p_grp_name forKey:@"p_grp_name"];
    
    NSString *remark = self.txtView_remark.text;
    [bDict setObject:remark forKey:@"remark"];
    
    NSString *explan = self.txtView_explan.text;
    [bDict setObject:explan forKey:@"explan"];
    
    NSString *picName=[self jpgPath];
    [bDict setObject:picName forKey:@"image_url"];
//    linkuserPC / visit / image_id
    NSArray *arr=[picName componentsSeparatedByString:@"."];
    
    NSString *typeString=[NSString stringWithFormat:@"?type=linkuserPC/visit/%@",[arr objectAtIndex:0]];
    
    [NetworkHandling UploadsyntheticPictures:photograghImageView.image currentPicName:picName uploadType:typeString completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        if(!error){
            NSDictionary *d1=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            BOOL f1=[[d1 objectForKey:@"imgUpload"] boolValue];
            if(f1){
                [NetworkHandling sendPackageWithUrl:@"datacollect/visitInputLinkmanInfo" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
                    
                    hubFlag=NO;
                    if(!error){
                        
                        NSLog(@"sign in success");
                        id r = [result  objectForKey:@"Response"];
                        NSString *f = [r objectForKey:@"returnFlag"];
                        
                        Boolean flag=[f boolValue];
                        if(flag){
                            
                            [self performSelectorOnMainThread:@selector(showMessage:) withObject:@"提交成功！" waitUntilDone:YES];
                            
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
            else{
                hubFlag=NO;
                [self performSelectorOnMainThread:@selector(showMessage:) withObject:@"提交拍照信息失败！！" waitUntilDone:YES];
            }
        }
    }];
    
    
}
#pragma mark - cameral
//- (IBAction)photograghButtonOnclick:(id)sender {
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
//    photograghImageView.image = [info objectForKey:UIImagePickerControllerEditedImage];
//    [picker dismissViewControllerAnimated:YES completion:nil];
//    
//}
//- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
//    [picker dismissViewControllerAnimated:YES completion:nil];
//}
- (IBAction)photograghButtonOnclick:(id)sender{
    self.selectedButton=nil;
    
    UIActionSheet *actionSheet=[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取 消" destructiveButtonTitle:@"相 机" otherButtonTitles:@"照片库", nil];
    actionSheet.tag=123;
    [actionSheet showInView:self.view];

}
//-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
//    if(buttonIndex == 0 || buttonIndex ==1){
//        [self itemPhotographButtonOnclick:buttonIndex];
//    }
//    
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
    photograghImageView.image = image;
}
- (IBAction)zoomPhotoOnclick:(id)sender {
    if(!photograghImageView.image)
        return;
    
    zoomImageView.image=photograghImageView.image;
    zoomImageView.contentMode=UIViewContentModeScaleAspectFit;
    [self.navigationController.view addSubview:zoomImageView];
}


@end
