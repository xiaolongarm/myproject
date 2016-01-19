//
//  SettingCommentsAndFeedbackViewController.m
//  CMCCMarketing
//
//  Created by talkweb on 14-9-4.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import "SettingCommentsAndFeedbackViewController.h"
#import "MBProgressHUD.h"
#import "NetworkHandling.h"
#import "SettingCommentsAndFeedbackTableViewCell.h"

@interface SettingCommentsAndFeedbackViewController ()<UITextViewDelegate,MBProgressHUDDelegate,UITableViewDataSource,UITableViewDelegate>{
    BOOL hubFlag;
    NSArray *tableArray;
}

@end

@implementation SettingCommentsAndFeedbackViewController

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
    txtFeedbackContent.layer.borderColor=[UIColor lightGrayColor].CGColor;
    txtFeedbackContent.layer.borderWidth=1;
    txtFeedbackContent.layer.masksToBounds=YES;
    txtFeedbackContent.layer.cornerRadius=3;
    
    txtFeedbackContent.delegate=self;
    UIBarButtonItem *rightButton=[[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(submitData)];
    [rightButton setTintColor:[UIColor whiteColor]];
    [self.navigationItem setRightBarButtonItem:rightButton];
    
    feedbackTableView.dataSource=self;
    feedbackTableView.delegate=self;

    feedbackTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    hubFlag=YES;
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"正在获取数据，请稍后...";
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
    [self getData];
}
-(void)submitData{
    
    [txtFeedbackContent resignFirstResponder];
    
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

-(void)postData{
    
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    [bDict setObject:[NSNumber numberWithInt:self.user.userID] forKey:@"userid"];
    [bDict setObject:self.user.userName forKey:@"username"];
    [bDict setObject:self.user.userMobile forKey:@"mobile"];
    [bDict setObject:[NSNumber numberWithInt:self.user.userEnterprise] forKey:@"enterprise"];

    [bDict setObject:txtFeedbackContent.text forKey:@"content"];
    
    [NetworkHandling sendPackageWithUrl:@"setup/insertfeedBack" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        if(!error){
            NSLog(@"sign in success");
            BOOL flag=[[result objectForKey:@"flag"] boolValue];
//            BOOL flag=[[dict objectForKey:@"returnFlag"] boolValue];
            if(flag)
                [self performSelectorOnMainThread:@selector(submitSuccess:) withObject:@"提交信息成功！" waitUntilDone:YES];
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

-(void)getData{
    
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    [bDict setObject:[NSNumber numberWithInt:self.user.userID] forKey:@"userid"];
    [bDict setObject:self.user.userName forKey:@"username"];
    [bDict setObject:self.user.userMobile forKey:@"mobile"];
    [bDict setObject:[NSNumber numberWithInt:self.user.userEnterprise] forKey:@"enterprise"];
    
    [NetworkHandling sendPackageWithUrl:@"setup/feedBack" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        if(!error){
            NSLog(@"sign in success");
            tableArray =[result objectForKey:@"suggests"];
            [self performSelectorOnMainThread:@selector(refreshTableView) withObject:nil waitUntilDone:YES];
        
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
-(void)submitSuccess:(NSString*)information{
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.delegate = self;
    HUD.labelText = information;
    [HUD show:YES];
    [HUD hide:YES afterDelay:3];
    
    [self getData];
}
-(void)refreshTableView{
    [feedbackTableView reloadData];
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
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        //在这里做你响应return键的代码
        //        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableArray count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SettingCommentsAndFeedbackTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SettingCommentsAndFeedbackTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    NSDictionary *dict=[tableArray objectAtIndex:indexPath.row];
    cell.itemDate.text=[dict objectForKey:@"suggestdate"]==[NSNull null]?@"" : [dict objectForKey:@"suggestdate"];
    cell.itemFeedback.text=[dict objectForKey:@"content"]==[NSNull null]?@"" : [dict objectForKey:@"content"];
    cell.itemReply.text=[dict objectForKey:@"answer"]==[NSNull null]?@"未回复" : [dict objectForKey:@"answer"];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
@end
