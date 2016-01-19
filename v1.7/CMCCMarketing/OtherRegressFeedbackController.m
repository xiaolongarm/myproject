//
//  OtherRegressFeedbackController.m
//  CMCCMarketing
//
//  Created by gmj on 15-1-6.
//  Copyright (c) 2015年 talkweb. All rights reserved.
//

#import "OtherRegressFeedbackController.h"

#import "MBProgressHUD.h"
#import "NetworkHandling.h"

#import "PreferentialPurchaseSelectDateTimeViewController.h"

@interface OtherRegressFeedbackController ()<PreferentialPurchaseSelectDateTimeViewControllerDelegate,UITextViewDelegate,MBProgressHUDDelegate>{
    
    BOOL hubFlag;
    
    UIView *backView;
    PreferentialPurchaseSelectDateTimeViewController *selectDateTimeViewController;
    UIButton *selectDateBtn;
    
    NSString *_again_link_date;
    
}

@end

@implementation OtherRegressFeedbackController

#pragma mark - UITextView delegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}


#pragma mark - PreferentialPurchaseSelectDateTimeViewControll delegate

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
    if (selectDateBtn == self.btnAgain_link_date) {
        
        _again_link_date = dateString;
//        self.lblAgain_link_date.text = [NSString stringWithFormat:@"设定再拜访时间: %@",dateString];
        self.lblAgain_link_date.text =dateString;
        
    } else {
        
        ;
        
    }
    
    [self preferentialPurchaseSelectDateTimeViewControllerDidCancel];
}

- (IBAction)selectDate:(id)sender{
    
    selectDateBtn = sender;
    
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"BusinessProcess" bundle:nil];
    selectDateTimeViewController=[storyboard instantiateViewControllerWithIdentifier:@"PreferentialPurchaseSelectDateTimeViewControllerId"];
    selectDateTimeViewController.delegate=self;
    selectDateTimeViewController.modeDateAndTime=1;//设置模式为日期显示
    CGRect rect=selectDateTimeViewController.view.frame;
    
    rect.origin.x=0;
    rect.origin.y=[[UIScreen mainScreen] bounds].size.height - 300;
    rect.size.width=320;
    rect.size.height=300;
    
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
	// Do any additional setup after loading the view.
    [self initSubView];
}

-(void) initSubView{
    
    self.txtRemark.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.txtRemark.layer.borderWidth=1;
    self.txtRemark.layer.cornerRadius=3;
    self.txtRemark.layer.masksToBounds=YES;
    self.txtRemark.delegate=self;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnAgain_link_dateOnClick:(id)sender {
    
    [self selectDate:sender];
}

- (IBAction)submitOnClick:(id)sender {
    
    [self insertLinkData];
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

-(void)insertLinkData{
    
    if(self.txtRemark.text && self.txtRemark.text.length > 1){
        ;
    }else{
        [self showMessage:@"请填写内容."];
        return;
    }
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    _again_link_date = _again_link_date?_again_link_date:@"";
    [bDict setObject:_again_link_date forKey:@"again_link_date"];
    [bDict setObject:@"ios" forKey:@"client_os"];
    [bDict setObject:[self.diffUserDict objectForKey:@"diff_svc_code"]  forKey:@"diff_svc_code"];
    NSString *t_user_id = [NSString stringWithFormat:@"%d",self.user.userID ];
    [bDict setObject:t_user_id forKey:@"userID"];
    NSString *t_enterprise = [NSString stringWithFormat:@"%d",self.user.userEnterprise];
    [bDict setObject:t_enterprise forKey:@"enterprise"];
    if (self.switchIs_sensitive_user.on) {
        
        [bDict setObject:@"1" forKey:@"is_sensitive_user"];
    }else{
        [bDict setObject:@"0" forKey:@"is_sensitive_user"];
    }
    
    [bDict setObject:[NSString stringWithFormat:@"%d",self.linkType] forKey:@"link_type"];
    NSString *mobile = self.user.userMobile;
    [bDict setObject:mobile forKey:@"mobile"];
    NSString *remark = self.txtRemark.text;
    remark = remark?remark:@"";
    [bDict setObject:remark forKey:@"remark"];
    NSString *user_name = self.user.userName;
    [bDict setObject:user_name forKey:@"user_name"];
    
    
    [NetworkHandling sendPackageWithUrl:@"diffuserback/insertLink" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        if(!error){
            NSLog(@"sign in success");
            BOOL flag=[[result objectForKey:@"flag"] boolValue];
            if(flag){
                
//                [self performSelectorOnMainThread:@selector(showMessage:) withObject:@"提交成功！" waitUntilDone:YES];
                [self performSelectorOnMainThread:@selector(showErrorMessage:) withObject:@"提交成功！" waitUntilDone:YES];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                    [self.navigationController popToRootViewControllerAnimated:YES];
                    [self.navigationController popViewControllerAnimated:YES];
                });
            
                
            }else{
                
                [self performSelectorOnMainThread:@selector(showMessage:) withObject:@"提交失败！" waitUntilDone:YES];
            }
            
            
//            [self performSelectorOnMainThread:@selector(refreshTableView) withObject:nil waitUntilDone:YES];
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
-(void)showErrorMessage:(NSString *)title{
    
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.delegate = self;
    HUD.labelText = title;
    [HUD show:YES];
    [HUD hide:YES afterDelay:2];
}
-(void)hudWasHidden:(MBProgressHUD *)hud{
    [hud removeFromSuperview];
    hud=nil;
}
@end
