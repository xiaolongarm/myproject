//
//  CustomerManagerContactsDetailsViewController.m
//  CMCCMarketing
//
//  Created by talkweb on 14-10-29.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import "CustomerManagerContactsDetailsViewController.h"
#import "CustomerManagerContactsDetailsTableViewCell.h"
#import "CustomerManagerContactsEditViewController.h"
#import "MBProgressHUD.h"
#import "VariableStore.h"
#import "AddLittleGrounpViewController.h"

@interface CustomerManagerContactsDetailsViewController ()<MBProgressHUDDelegate>{
    BOOL validateFlag;
}

@end

@implementation CustomerManagerContactsDetailsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    detailsTableView.delegate=self;
    detailsTableView.dataSource=self;
    detailsTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    if (self.listType == 2) {
        btCallPhone.hidden=YES;
        btSendMsg.hidden=YES;
    }
    
#if (defined MANAGER_CS_VERSION) || (defined MANAGER_SY_VERSION)
    btCallPhone.hidden=YES;
    btSendMsg.hidden=YES;
//    tableTopLayoutConstraint.constant = 0;
    imgLine.hidden=YES;
    tableLayoutConstraint.constant=0;
#endif
    
#if (defined STANDARD_CS_VERSION) || (defined STANDARD_SY_VERSION)
    UIBarButtonItem *rightButton=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"编辑1"] style:UIBarButtonItemStylePlain target:self action:@selector(goEdit)];
    [rightButton setTintColor:[UIColor whiteColor]];
    [self.navigationItem setRightBarButtonItem:rightButton];
#endif
  
}
-(void)goEdit{
    if (self.listType == 2) {
        [self performSegueWithIdentifier:@"updateContactsegue" sender:self];
    }
    else{
         [self.delegate customerManagerContactsDetailsViewGoEdit:self.contactsDict];
    }
//    [self performSegueWithIdentifier:@"CustomerManagerContactsEditFromContactDetailsSegue" sender:self];
//    [self.navigationController popViewControllerAnimated:YES];
   
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
if([segue.identifier isEqualToString:@"updateContactsegue"]){
        AddLittleGrounpViewController *controler=segue.destinationViewController;
        controler.user=self.user;
        controler.listType = self.listType;
    controler.whereFrom=9;
        controler.Dict=self.contactsDict;
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.listType == 0) {
        return 2;
    }
    else if(self.listType == 1){
        return 1;
    }
    else if(self.listType == 2){
        return 1;
    }
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0){
        if (self.listType == 0) {
            return 16;
        }
        else if(self.listType == 1){
            return 13;
        }
        else if(self.listType == 2){
            return 4;
        }

    }
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.listType == 0) {
        //备注
        if(indexPath.section == 0 && indexPath.row == 15){
            return 60;
        }
        //照片
        if(indexPath.section == 0 && indexPath.row == 14){
            return 80;
        }
        return 30;
    }
    else if(self.listType == 1){
        if(indexPath.row == 11){
            return 80;
        }
        if(indexPath.row == 12){
            return 60;
        }
        return 30;
    }
     else if(self.listType == 2){
          return 30;
     }
    return 30;
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(!section){
        if (self.listType == 0) {
            return @"联系人基础信息";
        }
        else if(self.listType == 1){
            return @"渠道老板基础信息";
        }
        else if(self.listType == 2){
            return @"";
        }

    }
    
    return [NSString stringWithFormat:@"%@基础信息",[VariableStore getCustomerManagerName]];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return .1f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomerManagerContactsDetailsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CustomerManagerContactsDetailsTableViewCell" forIndexPath:indexPath];
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.itemImage.hidden=YES;
    cell.itemMoreText.hidden=YES;
    cell.itemContent.hidden=NO;
    if (self.listType == 0) {
        if(indexPath.section == 0){
            switch (indexPath.row) {
                case 0:
                {
                    cell.itemTitle.text=@"姓名";
                    cell.itemContent.text=[self.contactsDict objectForKey:@"linkman"];
                    
                    UIImageView *imageView=[[UIImageView alloc] init];
                    imageView.frame=CGRectMake([UIScreen mainScreen].bounds.size.width - 120 -20, 10, 120, 77);
                    int flag=[[self.contactsDict objectForKey:@"flag"]intValue];
                    if(flag == 0)
                        imageView.image=[UIImage imageNamed:@"uncheck-tag"];
                    if(flag == 2)
                        imageView.image=[UIImage imageNamed:@"fail-tag"];
                    [detailsTableView addSubview:imageView];
                }
                    break;
                case 1:{
                    int sex=[[self.contactsDict objectForKey:@"linkman_sex"] intValue];
                    NSString *sexString=@"";
                    switch (sex) {
                        case 0:
                            sexString=@"未知";
                            break;
                        case 1:
                            sexString=@"男";
                            break;
                        case 2:
                            sexString=@"女";
                            break;
                        default:
                            break;
                    }
                    cell.itemTitle.text=@"性别";
                    cell.itemContent.text=sexString;
                }
                    break;
                case 2:
                    cell.itemTitle.text=@"手机号码";
                    cell.itemContent.text=[self.contactsDict objectForKey:@"linkman_msisdn"];
                    break;
                case 3:
                    cell.itemTitle.text=@"其他联系号码";
                    cell.itemContent.text=[self.contactsDict objectForKey:@"linkman_tel"];
                    break;
                case 4:
                    cell.itemTitle.text=@"其他联系方式";
                    cell.itemContent.text=[self.contactsDict objectForKey:@"linkman_tel_bak"];
                    break;
                case 5:
                    cell.itemTitle.text=@"所在部门(处室)";
                    cell.itemContent.text=[self.contactsDict objectForKey:@"depart"];
                    break;
                case 6:
                    cell.itemTitle.text=@"所属集团单位";
                    cell.itemContent.text=self.group.groupName;
                    break;
                case 7:
                    cell.itemTitle.text=@"职务";
                    cell.itemContent.text=[self.contactsDict objectForKey:@"job"];
                    break;
                case 8:
                    cell.itemTitle.text=@"生日日期";
                    cell.itemContent.text=[self.contactsDict objectForKey:@"linkman_birthday"];
                    break;
                case 9:{
                    cell.itemTitle.text=@"生日提醒";
                    
                    //is_birthday_remind: 生日提醒 0:不提醒 1:提醒
                    int flag=[[self.contactsDict objectForKey:@"is_birthday_remind"] intValue];
                    cell.itemContent.text=flag?@"提醒":@"不提醒";
                }
                    break;
                case 10:
                    cell.itemTitle.text=@"类别";
                    cell.itemContent.text=[self.contactsDict objectForKey:@"key_type"];
                    break;
                case 11:
                    cell.itemTitle.text=@"异网关键人";
                    cell.itemContent.text=[self.contactsDict objectForKey:@"is_diff_key"];
                    break;
                case 12:
                    cell.itemTitle.text=@"归属运营商";
                    cell.itemContent.text=[self.contactsDict objectForKey:@"chinamobile"];
                    break;
                case 13:
                    cell.itemTitle.text=@"第一优先";
                    cell.itemContent.text=[self.contactsDict objectForKey:@"is_first"];
                    break;
                case 14:{
                    cell.itemTitle.text=@"照片";
                    
                    cell.itemContent.hidden=YES;
                    cell.itemImage.hidden=NO;
                    
                    NSString *imageUrl=[self.contactsDict objectForKey:@"userimg"];
                    if(imageUrl && (NSNull*)imageUrl != [NSNull null] && imageUrl.length > 0){
                        NSURL *url = [NSURL URLWithString:imageUrl];
                        dispatch_queue_t queue =dispatch_queue_create("loadImage",NULL);
                        dispatch_async(queue, ^{
                            
                            NSData *resultData = [NSData dataWithContentsOfURL:url];
                            UIImage *img = [UIImage imageWithData:resultData];
                            if(img){
                                dispatch_sync(dispatch_get_main_queue(), ^{
                                    
                                    cell.itemImage.image = img;
                                });
                            }
                        });
                    }
                    //                cell.itemContent.text=[self.contactsDict objectForKey:@"diff_svc_code"];
                }
                    break;
                case 15:
                    cell.itemTitle.text=@"备注";
                    //                cell.itemContent.text=[self.contactsDict objectForKey:@"diff_svc_code"];
                    cell.itemContent.hidden=YES;
                    cell.itemMoreText.hidden=NO;
                    cell.itemMoreText.text=[self.contactsDict objectForKey:@"remark"];
                    break;
                    
                default:
                    break;
            }
        }
        else{
            
            switch (indexPath.row) {
                case 0:
                    
                    cell.itemTitle.text=[NSString stringWithFormat:@"%@姓名",[VariableStore getCustomerManagerName]];
                    cell.itemContent.text=[self.contactsDict objectForKey:@"vip_mngr_name"];
                    break;
                case 1:
                    cell.itemTitle.text=[NSString stringWithFormat:@"%@电话号码",[VariableStore getCustomerManagerName]];
                    cell.itemContent.text=[self.contactsDict objectForKey:@"vip_mngr_msisdn"];
                    break;
                    
                default:
                    break;
            }
            
        }
    }
    else if (self.listType == 1) {
        switch (indexPath.row) {
            case 0:
            {
                cell.itemTitle.text=@"姓名";
                cell.itemContent.text=[self.contactsDict objectForKey:@"boss_name"];
                
                UIImageView *imageView=[[UIImageView alloc] init];
                imageView.frame=CGRectMake([UIScreen mainScreen].bounds.size.width - 120 -20, 10, 120, 77);
                int flag=[[self.contactsDict objectForKey:@"flag"]intValue];
                if(flag == 0)
                    imageView.image=[UIImage imageNamed:@"uncheck-tag"];
                if(flag == 2)
                    imageView.image=[UIImage imageNamed:@"fail-tag"];
                [detailsTableView addSubview:imageView];
            }
                break;
            case 1:{
                int sex=[[self.contactsDict objectForKey:@"boss_sex"] intValue];
                NSString *sexString=@"";
                switch (sex) {
                    case 0:
                        sexString=@"未知";
                        break;
                    case 1:
                        sexString=@"男";
                        break;
                    case 2:
                        sexString=@"女";
                        break;
                    default:
                        break;
                }
                cell.itemTitle.text=@"性别";
                cell.itemContent.text=sexString;
            }
                break;
            case 2:
                cell.itemTitle.text=@"BOSS工号";
                cell.itemContent.text=[self.contactsDict objectForKey:@"boss_card"];
                break;
            case 3:
                cell.itemTitle.text=@"手机号码";
                cell.itemContent.text=[self.contactsDict objectForKey:@"boss_msisdn"];
                break;
            case 4:
                cell.itemTitle.text=@"其他联系号码";
                cell.itemContent.text=[self.contactsDict objectForKey:@"boss_tel"];
                break;
            case 5:
                cell.itemTitle.text=@"其他联系方式";
                cell.itemContent.text=[self.contactsDict objectForKey:@"boss_tel_bak"];
                break;
            case 6:
                cell.itemTitle.text=@"所属单位";
                cell.itemContent.text=self.channels.chnl_name;
                break;
            case 7:
                cell.itemTitle.text=@"生日日期";
                cell.itemContent.text=[self.contactsDict objectForKey:@"boss_birthday"];
                break;
            case 8:
                cell.itemTitle.text=@"生日提醒";
                int flag=[[self.contactsDict objectForKey:@"is_birthday_remind"] intValue];
                cell.itemContent.text=flag?@"提醒":@"不提醒";
                break;
            case 9:{
                cell.itemTitle.text=@"异网关键人";
                cell.itemContent.text=[self.contactsDict objectForKey:@"is_diff_key"];
            }
                break;
            case 10:
                cell.itemTitle.text=@"归属运营商";
                cell.itemContent.text=[self.contactsDict objectForKey:@"chinamobile"];
                break;
            case 11:
            {
                cell.itemTitle.text=@"照片";
                
                cell.itemContent.hidden=YES;
                cell.itemImage.hidden=NO;
                
                NSString *imageUrl=[self.contactsDict objectForKey:@"userimg"];
                if(imageUrl && (NSNull*)imageUrl != [NSNull null] && imageUrl.length > 0){
                    NSURL *url = [NSURL URLWithString:imageUrl];
                    dispatch_queue_t queue =dispatch_queue_create("loadImage",NULL);
                    dispatch_async(queue, ^{
                        
                        NSData *resultData = [NSData dataWithContentsOfURL:url];
                        UIImage *img = [UIImage imageWithData:resultData];
                        if(img){
                            dispatch_sync(dispatch_get_main_queue(), ^{
                                
                                cell.itemImage.image = img;
                            });
                        }
                    });
                }
            }
                break;
            case 12:
                cell.itemTitle.text=@"备注";
                cell.itemContent.text=[self.contactsDict objectForKey:@"remark"];
                break;
           
            default:
                break;
        }
    }
   if (self.listType == 2) {
       switch (indexPath.row) {
           case 0:
           {
               cell.itemTitle.text=@"名称:";
               cell.itemContent.text=[self.contactsDict objectForKey:@"key_name"];
               
               UIImageView *imageView=[[UIImageView alloc] init];
               imageView.frame=CGRectMake([UIScreen mainScreen].bounds.size.width - 120 -20, 10, 120, 77);
               int flag=[[self.contactsDict objectForKey:@"state"]intValue];
               if(flag == 0)
                   imageView.image=[UIImage imageNamed:@"uncheck-tag"];
               if(flag == 2)
                   imageView.image=[UIImage imageNamed:@"fail-tag"];
               [detailsTableView addSubview:imageView];
           }
            break;
           case 1:
               cell.itemTitle.text=@"手机号码:";
               cell.itemContent.text=[self.contactsDict objectForKey:@"key_mobile"];
               break;
           case 2:
           {
               cell.itemTitle.text=@"部门:";
               cell.itemContent.text=[self.contactsDict objectForKey:@"key_dept"];
               if ([[self.contactsDict objectForKey:@"key_dept"] isEqualToString:@""]) {
                   cell.itemContent.text=@"-";
               }
           }
               break;
           case 3:
               cell.itemTitle.text=@"职务:";
               cell.itemContent.text=[self.contactsDict objectForKey:@"key_post"];
               if ([[self.contactsDict objectForKey:@"key_post"] isEqualToString:@""]) {
                   cell.itemContent.text=@"-";
               }

               break;
               
           default:
               break;
       }
   }
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    

}
- (IBAction)callPhone:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",[self.contactsDict objectForKey:@"linkman_msisdn"]]]];
}
- (IBAction)callSMS:(id)sender {
    Class messageClass = (NSClassFromString(@"MFMessageComposeViewController"));
    
    if (messageClass != nil) {
        // Check whether the current device is configured for sending SMS messages
        if ([messageClass canSendText]) {
            [self displaySMSComposerSheet];
        }
        else {
            UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"设备没有短信功能" delegate:nil cancelButtonTitle:nil  otherButtonTitles:@"确定", nil];
            [myAlertView show];
            
        }
    }
    else {
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"iOS版本过低,iOS4.0以上才支持程序内发送短信" delegate:nil cancelButtonTitle:nil  otherButtonTitles:@"确定", nil];
        [myAlertView show];
    }
}

-(void)displaySMSComposerSheet{
    MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
    picker.messageComposeDelegate = self;
    
    NSMutableArray *contactArray=[[NSMutableArray alloc] init];

    [contactArray addObject:[self.contactsDict objectForKey:@"linkman_msisdn"]];
    
    [picker setEditing:YES];
    
    picker.recipients=contactArray;
    NSString *cname=[VariableStore getCustomerManagerName];
    picker.body=[NSString stringWithFormat:@"尊敬的客户您好！我是您的%@%@，湖南移动竭诚为您服务，在通讯上如有任何问题，请随时拨打%@电话：%@ \n祝您生活 工作愉快！",cname,self.user.userName,self.user.userName,self.user.userMobile];
    
    validateFlag=YES;
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"正在组织短信发送数据...";
    [HUD showWhileExecuting:@selector(idleForSegue) onTarget:self withObject:nil animated:YES];
    
    [self presentViewController:picker animated:YES completion:^{
        validateFlag=NO;
    }];
    
}
-(void)idleForSegue{
    while (validateFlag) {
        usleep(100000);
    }
}
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller
                 didFinishWithResult:(MessageComposeResult)result {
    UIAlertView *myAlertView;
    switch (result)
    {
        case MessageComposeResultCancelled:
            NSLog(@"Result: SMS sending canceled");
            break;
        case MessageComposeResultSent:
            NSLog(@"Result: SMS sent");
            break;
        case MessageComposeResultFailed:
            myAlertView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"短信发送失败!" delegate:nil cancelButtonTitle:nil  otherButtonTitles:@"关闭", nil];
            [myAlertView show];
            break;
        default:
            NSLog(@"Result: SMS not sent");
            break;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
