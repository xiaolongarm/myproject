//
//  SettingPasswordViewController.m
//  CMCCMarketing
//
//  Created by talkweb on 15-3-6.
//  Copyright (c) 2015年 talkweb. All rights reserved.
//

#import "SettingPasswordViewController.h"
#import "NetworkHandling.h"
#import "MBProgressHUD.h"
#import "Base64codeFunc.h"

@interface SettingPasswordViewController ()<MBProgressHUDDelegate,UITextFieldDelegate>{
    BOOL hubFlag;
    BOOL sf;
}

@end

@implementation SettingPasswordViewController

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
    txtNewPasswordRetry.delegate=self;
    txtPassword.delegate=self;
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
- (IBAction)submitOnclick:(id)sender {
    [txtPassword resignFirstResponder];
    [txtNewPassword resignFirstResponder];
    [txtNewPasswordRetry resignFirstResponder];
    
    if(!sf){
        if(txtPassword.text.length==0){
            lbOldPassError.hidden=NO;
            lbErrorMessage.hidden=NO;
            lbErrorMessage.text=@"密码为空!";
        }
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
//old_password  原始密码
//new_password 新密码
//user_id 用户id
//enterprise
-(void)postData{
    
//    NSString *oldpass=[Base64codeFunc md5:txtPassword.text];
//    NSString *newpass=[Base64codeFunc md5:txtNewPassword.text];
    
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    [bDict setObject:[NSNumber numberWithInt:self.user.userID] forKey:@"user_id"];
    [bDict setObject:txtPassword.text forKey:@"old_password"];
    [bDict setObject:txtNewPassword.text forKey:@"new_password"];
    [bDict setObject:[NSNumber numberWithInt:self.user.userEnterprise] forKey:@"enterprise"];
    
//    [bDict setObject:txtFeedbackContent.text forKey:@"content"];
    
    [NetworkHandling sendPackageWithUrl:@"HamstrerServlet/upduserpwd" sendBody:bDict sendWithPostType:2 processHandler:^(NSDictionary *result, NSError *error) {
        
//    }]
//    
//    [NetworkHandling sendPackageWithUrl:@"HamstrerServlet/upduserpwd" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        if(!error){
            NSLog(@"sign in success");
            BOOL flag=[[result objectForKey:@"flag"] boolValue];
            //            BOOL flag=[[dict objectForKey:@"returnFlag"] boolValue];
            if(flag)
                [self performSelectorOnMainThread:@selector(submitSuccess) withObject:nil waitUntilDone:YES];
            else{
                NSString *errorinf=[result objectForKey:@"errorinf"];
                [self performSelectorOnMainThread:@selector(showMessage:) withObject:errorinf waitUntilDone:YES];
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
-(void)showMessage:(NSString*)infomation{
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"信息提示" message:infomation delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
    [myAlertView show];
}
-(void)submitSuccess{
    [self.navigationController popViewControllerAnimated:YES];
//    [self.navigationController popViewControllerAnimated:YES];
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if(![txtNewPassword.text isEqualToString:txtNewPasswordRetry.text]){
        lbNewPassRetryError.hidden=NO;
        lbErrorMessage.text=@"密码确认错误！";
        lbErrorMessage.hidden=NO;
        sf=NO;
    }
    else{
        lbNewPassRetryError.hidden=YES;
        lbErrorMessage.hidden=YES;
        lbOldPassError.hidden=YES;

        [textField resignFirstResponder];
        sf=YES;
    }
    return YES;
}

@end
