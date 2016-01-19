//
//  OnlineTestViewController.m
//  CMCCMarketing
//
//  Created by Talkweb on 15/4/21.
//  Copyright (c) 2015年 talkweb. All rights reserved.
//

#import "OnlineTestViewController.h"
#import "OnlineTestNotiViewController.h"
#import "OnlineTestRecordViewController.h"
#import "OnlineTestMakeViewController.h"
#import "OnlineTestCheckAnswerViewController.h"
#import "NetworkHandling.h"
#import "MBProgressHUD.h"

@interface OnlineTestViewController ()<MBProgressHUDDelegate>
{
    BOOL hubFlag;
    BOOL reloadFlag;
    BOOL recordFlag;
    BOOL wrongFlag;
    NSDictionary *testDetails;
    MBProgressHUD *HudShow;
    MBProgressHUD *HudWait;
    NSDictionary *recordDic;
    NSDictionary *wrongDic;
}
@end

@implementation OnlineTestViewController

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
    HudShow =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HudShow];
    HudShow.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    HudShow.mode = MBProgressHUDModeCustomView;
    HudShow.delegate = self;
    
    
    HudWait =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HudWait];
    HudWait.mode = MBProgressHUDModeIndeterminate;
    HudWait.delegate=self;
    HudWait.labelText=nil;
    
    [self initSubPage];
    
    
    reloadFlag = YES;
    recordFlag = YES;
    wrongFlag = YES;
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
  
    if(reloadFlag){
        [self loadTestData:nil];
    }
    reloadFlag=YES;
    
}

-(void)loadTestData:(NSString *)visit_sta{
    hubFlag=YES;
    
    if(![NetworkHandling GetCurrentNet]){
        HudShow.mode = MBProgressHUDModeCustomView;
        HudShow.labelText = @"网络未连接,请检查您的网络";
        [HudShow show:YES];
        [HudShow hide:YES afterDelay:2];
        return;
    }
    
    HudWait.mode = MBProgressHUDModeIndeterminate;
    [HudWait show:YES];
//    [HudWait showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
    
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    [bDict setObject:[NSNumber numberWithInt:self.user.userID] forKey:@"user_id"];
    
    [NetworkHandling sendPackageWithUrl:@"question/GetExamInf" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        if(!error){
            //TODO erro code
            id temp = [result objectForKey:@"exam"];
            
            if ([temp  isKindOfClass:[NSDictionary class]]){
                testDetails = [result objectForKey:@"exam"];
                [self performSelectorOnMainThread:@selector(refreshTest) withObject:nil waitUntilDone:YES];
            }
            else{
//                HudShow.labelText = @"今天没有考试";
//                [HudShow show:YES];
//                [HudShow hide:YES afterDelay:2];
                [self performSelectorOnMainThread:@selector(showMessage:) withObject:@"今天没有考试" waitUntilDone:YES];
                //TODO
            }
        }else{
            int errorCode=[[result valueForKey:@"errorcode"] intValue];
            NSLog(@"error:%d error:%@",errorCode,[error localizedDescription]);
            [self performSelectorOnMainThread:@selector(showMessage:) withObject:[error localizedDescription] waitUntilDone:YES];
        }
        hubFlag=NO;
    }];
}

-(void)submitFinished:(NSString*)msg{
//    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
//    [self.view addSubview:HUD];
//    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
//    HUD.mode = MBProgressHUDModeCustomView;
//    HUD.delegate = self;
    HudShow.mode = MBProgressHUDModeCustomView;
    HudShow.labelText = msg;
    [HudShow show:YES];
    [HudShow hide:YES afterDelay:2];
}

-(void)refreshTest{
    [HudWait hide:YES];
    NSString *desc=[testDetails objectForKey:@"exam_batch_desc"];

    NSString* timeStr = [NSString stringWithFormat:@"%@", [testDetails objectForKey:@"exam_start_time"]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate* date = [formatter dateFromString:timeStr];
//    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    [dateFormatter1 setDateFormat:@"HH:mm"];
    NSString *currentDateStr1 = [dateFormatter1 stringFromDate:date];
    
    NSString* timeStr2 = [NSString stringWithFormat:@"%@", [testDetails objectForKey:@"exam_end_time"]];
    NSDateFormatter *formatter2 = [[NSDateFormatter alloc] init] ;
    [formatter2 setDateStyle:NSDateFormatterMediumStyle];
    [formatter2 setTimeStyle:NSDateFormatterShortStyle];
    [formatter2 setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate* date2 = [formatter dateFromString:timeStr2];
//    NSString *timeSp2 = [NSString stringWithFormat:@"%ld", (long)[date2 timeIntervalSince1970]];
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
    [dateFormatter2 setDateFormat:@"HH:mm"];
    NSString *currentDateStr2 = [dateFormatter2 stringFromDate:date2];
    
    NSString *tempTime = [NSString stringWithFormat:@"考试时间:%@-%@", currentDateStr1,currentDateStr2];
    
    self.labelTest.textAlignment = NSTextAlignmentCenter;
    self.labelTest.text = desc;
    
    self.labelTime.textAlignment = NSTextAlignmentCenter;
    self.labelTime.text = tempTime;
    self.labelTest.hidden = NO;
    
    NSString* severTimeStr = [NSString stringWithFormat:@"%@", [testDetails objectForKey:@"servser_time"]];
    NSDateFormatter *formatter3 = [[NSDateFormatter alloc] init] ;
    [formatter3 setDateStyle:NSDateFormatterMediumStyle];
    [formatter3 setTimeStyle:NSDateFormatterShortStyle];
    [formatter3 setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate* date3 = [formatter3 dateFromString:severTimeStr];
    
    long startTime = (long)[date timeIntervalSince1970];
    long endTime = (long)[date2 timeIntervalSince1970];
    long severTime = (long)[date3 timeIntervalSince1970];
    if (severTime >= startTime && severTime < endTime) {
        self.btnStartTest.hidden = NO;
        self.imageDisableStart.hidden = YES;
    }
    else{
        HudShow.mode = MBProgressHUDModeCustomView;
        if (severTime < startTime) {
//            MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
//            [self.view addSubview:HUD];
//            HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
//            HUD.mode = MBProgressHUDModeCustomView;
//            HUD.delegate = self;
            HudShow.labelText = @"今天考试未开始";
            [HudShow show:YES];
            [HudShow hide:YES afterDelay:2];
        }
        else if (severTime >= endTime){
//            MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
//            [self.view addSubview:HUD];
//            HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
//            HUD.mode = MBProgressHUDModeCustomView;
//            HUD.delegate = self;
            HudShow.labelText = @"今天考试已结束";
            [HudShow show:YES];
            [HudShow hide:YES afterDelay:2];
        }
        
    }
    
}



-(void)showMessage:(NSString*)infomation{

    [HudWait hide:YES];
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"信息提示" message:infomation delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
    [myAlertView show];
}

-(void)connectToNetwork{ //TODO
    while (hubFlag) {
        usleep(100000);
    }
}


- (void) initSubPage{
    
    if(IOS7)
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"320X64"] forBarMetrics:UIBarMetricsDefault];
    else
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"320X44"] forBarMetrics:UIBarMetricsDefault];
    
    self.navigationItem.title = @"在线考试";
    UIBarButtonItem *leftButton=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回1"] style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    [leftButton setTintColor:[UIColor whiteColor]];
    [self.navigationItem setLeftBarButtonItem:leftButton];
    
    UIColor * color = [UIColor whiteColor];
    NSDictionary * dict=[NSDictionary dictionaryWithObject:color forKey:UITextAttributeTextColor];
    [self.navigationController.navigationBar setTitleTextAttributes:dict];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.btnStartTest.hidden = YES;
    self.labelTest.hidden = YES;
}

-(void)goBack{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)testRecordOnClick:(id)sender{
    NSLog(@"recordFlag %d",recordFlag);
//    if(![NetworkHandling GetCurrentNet]){
//        HudShow.mode = MBProgressHUDModeCustomView;
//        HudShow.labelText = @"网络未连接,请检查您的网络";
//        [HudShow show:YES];
//        [HudShow hide:YES afterDelay:2];
//        return;
//    }
    if (recordFlag) {
        hubFlag=YES;
        HudWait.mode = MBProgressHUDModeIndeterminate;
        [HudWait show:YES];
//        [HudWait showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
        
        NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
        [bDict setObject:[NSNumber numberWithInt:self.user.userID] forKey:@"user_id"];
        
        [NetworkHandling sendPackageWithUrl:@"question/GetUserPapersList" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
            
            if(!error){
                //TODO erro code
                recordDic = result;
                    [self performSelectorOnMainThread:@selector(startRecord:) withObject:result waitUntilDone:YES];
                    
            }else{
                int errorCode=[[result valueForKey:@"errorcode"] intValue];
                NSLog(@"error:%d error:%@",errorCode,[error localizedDescription]);
                [self performSelectorOnMainThread:@selector(showMessage:) withObject:[error localizedDescription] waitUntilDone:YES];
            }
            hubFlag=NO;
        }];
    }
    else{
        [self performSelectorOnMainThread:@selector(startRecord:) withObject:recordDic waitUntilDone:YES];
    }
}

-(void)startRecord:(NSDictionary*)dict{
    [HudWait hide:YES];
    recordFlag = NO;
    reloadFlag = NO;
    if ([[dict objectForKey:@"exam"] count] > 0){
        OnlineTestRecordViewController *vc = [[OnlineTestRecordViewController alloc] initWithNibName:@"OnlineTestRecordViewController" bundle:nil];
        vc.recordList = [dict objectForKey:@"exam"];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else{
        HudShow.labelText = @"您当前没有考试记录";
        [HudShow show:YES];
        [HudShow hide:YES afterDelay:2];
    }
    
}


- (IBAction)myDoWrongOnClick:(id)sender{
//    if(![NetworkHandling GetCurrentNet]){
//        HudShow.mode = MBProgressHUDModeCustomView;
//        HudShow.labelText = @"网络未连接,请检查您的网络";
//        [HudShow show:YES];
//        [HudShow hide:YES afterDelay:2];
//        return;
//    }
    reloadFlag = NO;
    hubFlag=YES;
    if (wrongFlag) {
        HudWait.mode = MBProgressHUDModeIndeterminate;
        [HudWait show:YES];
//        [HudWait showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
        
        NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
        [bDict setObject:[NSNumber numberWithInt:self.user.userID] forKey:@"user_id"];
        
        [NetworkHandling sendPackageWithUrl:@"question/GetErrorInf" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
            
            if(!error){
                
                wrongDic = result;
                [self performSelectorOnMainThread:@selector(startMyWrong:) withObject:result waitUntilDone:YES];
                
                
                
            }else{
                int errorCode=[[result valueForKey:@"errorcode"] intValue];
                NSLog(@"error:%d error:%@",errorCode,[error localizedDescription]);
                [self performSelectorOnMainThread:@selector(showMessage:) withObject:[error localizedDescription] waitUntilDone:YES];
            }
            hubFlag=NO;
        }];
    }
    else{
        [self performSelectorOnMainThread:@selector(startMyWrong:) withObject:wrongDic waitUntilDone:YES];
    }
}

-(void)startMyWrong:(NSDictionary*)dict{
    [HudWait hide:YES];
    wrongFlag = NO;
    if ([[dict objectForKey:@"error_list"] count] > 0){
        reloadFlag = NO;
        OnlineTestCheckAnswerViewController *vc = [[OnlineTestCheckAnswerViewController alloc] initWithNibName:@"OnlineTestCheckAnswerViewController" bundle:nil];
        vc.user = self.user;
        vc.fromMyDoWrong = YES;
        vc.testQuestionDetails = [dict objectForKey:@"error_list"];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else{
        HudShow.labelText = @"您当前没有错题";
        [HudShow show:YES];
        [HudShow hide:YES afterDelay:2];
    }

}

- (IBAction)testNotiOnClick:(id)sender{
    reloadFlag = NO;
    OnlineTestNotiViewController *vc = [[OnlineTestNotiViewController alloc] initWithNibName:@"OnlineTestNotiViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (IBAction)startTestOnClick:(id)sender{
    
    
    hubFlag=YES;
//    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
//    [self.view addSubview:HUD];
//    HUD.delegate=self;
//    HUD.labelText=nil;
    HudWait.mode = MBProgressHUDModeIndeterminate;
    [HudWait show:YES];
//    [HudWait showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
    
    
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    
    [bDict setValue:[NSNumber numberWithInt:self.user.userID] forKey:@"user_id"];
    [bDict setValue:[testDetails objectForKey:@"exam_batch"] forKey:@"exam_batch"];
    [bDict setValue:[testDetails objectForKey:@"question_cnt"] forKey:@"question_cnt"];
    [bDict setValue:[testDetails objectForKey:@"question_buss_type"] forKey:@"question_buss_type"];
    [bDict setValue:[testDetails objectForKey:@"exam_end_time"] forKey:@"exam_end_time"];
    [NetworkHandling sendPackageWithUrl:@"question/GetPapersInf" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        if(!error){
            //TODO erro code
            [self performSelectorOnMainThread:@selector(checkResult:) withObject:result waitUntilDone:YES];
            //            self.recordList =[result objectForKey:@"exam"];
            if( 0){
                //                [self.onlineTestTableView reloadData];
                //                [self performSelectorOnMainThread:@selector(refreshvisitPlanTableView) withObject:nil waitUntilDone:YES];
                //                [self reloadKesData:visit_sta];
                
            }else{
                
                ;
            }
        }else{
            int errorCode=[[result valueForKey:@"errorcode"] intValue];
            NSLog(@"error:%d error:%@",errorCode,[error localizedDescription]);
            [self performSelectorOnMainThread:@selector(showMessage:) withObject:[error localizedDescription] waitUntilDone:YES];
        }
        hubFlag=NO;
    }];
    
    
    
}


-(void)checkResult:(NSDictionary*)dict{
    
    [HudWait hide:YES];
    if ([[dict objectForKey:@"papers_code"]intValue] == 1){
//        MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
//        [self.view addSubview:HUD];
//        HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
//        HUD.mode = MBProgressHUDModeCustomView;
//        HUD.delegate = self;
        HudShow.labelText = @"您已提交过考试试卷";
        [HudShow show:YES];
        [HudShow hide:YES afterDelay:2];
    }
    
    else if ([[dict objectForKey:@"papers_code"]intValue] == 2){
//        MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
//        [self.view addSubview:HUD];
//        HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
//        HUD.mode = MBProgressHUDModeCustomView;
//        HUD.delegate = self;
        HudShow.labelText = @"您已参与了两次考试";
        [HudShow show:YES];
        [HudShow hide:YES afterDelay:2];
    }
    
    else{
        recordFlag = YES;
        wrongFlag = YES;

        OnlineTestMakeViewController *vc = [[OnlineTestMakeViewController alloc] initWithNibName:@"OnlineTestMakeViewController" bundle:nil];
        vc.user = self.user;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
