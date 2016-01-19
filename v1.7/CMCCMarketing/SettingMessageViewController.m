//
//  SettingMessageViewController.m
//  CMCCMarketing
//
//  Created by talkweb on 14-9-13.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//
#import "VariableStore.h"
#import "SettingMessageViewController.h"

#import "XGPush.h"
#import "XGSetting.h"
#define _IPHONE80_ 80000

@interface SettingMessageViewController ()<UIActionSheetDelegate>

@end

@implementation SettingMessageViewController

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

- (IBAction)receiveMsgOnclick:(id)sender {
//    self.swReceive.on=!self.swReceive.on;
    if(self.swReceive.on){
        [XGPush setAccount:@"13707318888"];
        NSString * deviceTokenStr = [XGPush registerDevice:[VariableStore sharedInstance].deviceToken];

        void (^successBlock)(void) = ^(void){
            //成功之后的处理
            NSLog(@"[XGPush]register successBlock ,deviceToken: %@",deviceTokenStr);
        };
        
        void (^errorBlock)(void) = ^(void){
            //失败之后的处理
            NSLog(@"[XGPush]register errorBlock");
        };
        
        //注册设备
        [[XGSetting getInstance] setChannel:@"cmmc"];
        [[XGSetting getInstance] setGameServer:@"kite"];
        [XGPush registerDevice:[VariableStore sharedInstance].deviceToken successCallback:successBlock errorCallback:errorBlock];
        
        //打印获取的deviceToken的字符串
        NSLog(@"deviceTokenStr is %@",deviceTokenStr);
    }
    else{
        [XGPush unRegisterDevice];
    }
}
- (IBAction)receiveMsgSoundOnclick:(id)sender {
}
- (IBAction)receiveMsgShockOnclick:(id)sender {
}
- (IBAction)reminderPeriodOnclick:(id)sender {
    UIActionSheet *actionSheet=[[UIActionSheet alloc] initWithTitle:@"提醒时段请选择" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"全天时段提醒" otherButtonTitles:@"工作时间段提醒", nil];
    [actionSheet showInView:self.view];
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
        
}

@end
