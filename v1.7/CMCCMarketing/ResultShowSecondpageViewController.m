//
//  ResultShowSecondpageViewController.m
//  CMCCMarketing
//
//  Created by Talkweb on 15/4/30.
//  Copyright (c) 2015年 talkweb. All rights reserved.
//

#import "ResultShowSecondpageViewController.h"
#import "ResultShowGridViewController.h"
#import "NetworkHandling.h"
#import "MBProgressHUD.h"

@interface ResultShowSecondpageViewController ()<MBProgressHUDDelegate>
{
    MBProgressHUD *HudWait;
    MBProgressHUD *HudShow;
}
@end

@implementation ResultShowSecondpageViewController

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
    [self initSubPage];
    // Do any additional setup after loading the view from its nib.
}


- (void) initSubPage{
    
    if(IOS7)
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"320X64"] forBarMetrics:UIBarMetricsDefault];
    else
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"320X44"] forBarMetrics:UIBarMetricsDefault];
    
    self.navigationItem.title = @"业绩通报";
//    UIBarButtonItem *leftButton=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回1"] style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
//    UIBarButtonItem *leftButton=[[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
//    [leftButton setTintColor:[UIColor whiteColor]];
//    [self.navigationItem setLeftBarButtonItem:leftButton];
    
//    [self.navigationItem.leftBarButtonItem setTitle:@"返回"];
    
    UIColor * color = [UIColor whiteColor];
    NSDictionary * dict=[NSDictionary dictionaryWithObject:color forKey:UITextAttributeTextColor];
    [self.navigationController.navigationBar setTitleTextAttributes:dict];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.secondTableView.dataSource=self; //TODO SIZE
    
    self.secondTableView.delegate=self;
    self.secondTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    HudWait =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HudWait];
    HudWait.delegate=self;
    HudWait.labelText=nil;
    
    HudShow =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HudShow];
    HudShow.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    HudShow.mode = MBProgressHUDModeCustomView;
    HudShow.delegate = self;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [self.resultList count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"cellForRowAtIndexPath");
    static NSString *CellIdentifier = @"ResultShowSecondpageViewControllerCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:CellIdentifier owner:self options:nil] objectAtIndex:0];
    }
    
    NSUInteger r = [indexPath row];
    NSDictionary *dicObj = [self.resultList objectAtIndex:r];
    
    NSString *des = [dicObj objectForKey:@"exam_batch_desc"];
    
    UILabel *result_des = (UILabel*)[cell viewWithTag:100];
    result_des.text = des;
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger r =indexPath.row;
    NSLog(@"indexPath %d  %@",r,self.resultStr);
    
    NSDictionary *dicObj = [self.resultList objectAtIndex:r];
    
    [HudWait show:YES];
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    if([self.resultStr isEqualToString:@"营销经理成绩通报"]){
        [bDict setValue:@"1" forKey:@"user_lvl"];
    }
    else{
        [bDict setValue:@"0" forKey:@"user_lvl"];
    }
    
    [bDict setValue:[dicObj objectForKey:@"exam_batch"] forKey:@"exam_batch"];
    [NetworkHandling sendPackageWithUrl:@"question/GetNoticerList" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        if(!error){
            
            [self performSelectorOnMainThread:@selector(toGrid:) withObject:[result objectForKey:@"exam_result"] waitUntilDone:NO];
            
            
        }
        else{
            int errorCode=[[result valueForKey:@"errorcode"] intValue];
            NSLog(@"error:%d error:%@",errorCode,[error localizedDescription]);
            [self performSelectorOnMainThread:@selector(showMessage:) withObject:[error localizedDescription] waitUntilDone:YES];
        }
    }];
    
    
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:NO];
}

-(void)toGrid:(NSArray*)arry{
    [HudWait hide:YES];
    
    NSLog(@"GetNoticerList  %@",arry);
    if ([arry count] > 0){
        ResultShowGridViewController *vc = [[ResultShowGridViewController alloc] initWithNibName:@"ResultShowGridViewController" bundle:nil];
        vc.resultList = arry;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else{
//        HudShow.labelText = @"您当前没有考试记录";
//        [HudShow show:YES];
//        [HudShow hide:YES afterDelay:2];
    }
}

-(void)showMessage:(NSString*)infomation{
    
    [HudWait hide:YES];
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"信息提示" message:infomation delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
    [myAlertView show];
}


-(void)goBack{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
