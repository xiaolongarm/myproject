//
//  ResultShowHomepageViewController.m
//  CMCCMarketing
//
//  Created by Talkweb on 15/4/30.
//  Copyright (c) 2015年 talkweb. All rights reserved.
//

#import "ResultShowHomepageViewController.h"
#import "ResultShowSecondpageViewController.h"
#import "NetworkHandling.h"
#import "MBProgressHUD.h"


@interface ResultShowHomepageViewController ()<MBProgressHUDDelegate>
{
    MBProgressHUD *HudWait;
    MBProgressHUD *HudShow;
    NSArray *tableArray;
    int num;
}
@end

@implementation ResultShowHomepageViewController

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
    UIBarButtonItem *leftButton=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回1"] style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    [leftButton setTintColor:[UIColor whiteColor]];
    [self.navigationItem setLeftBarButtonItem:leftButton];
    
    UIColor * color = [UIColor whiteColor];
    NSDictionary * dict=[NSDictionary dictionaryWithObject:color forKey:UITextAttributeTextColor];
    [self.navigationController.navigationBar setTitleTextAttributes:dict];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.tableViewOfResultShow.dataSource=self; //TODO SIZE
    
    self.tableViewOfResultShow.delegate=self;
    
    self.tableViewOfResultShow.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    HudWait =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HudWait];
    HudWait.delegate=self;
    HudWait.labelText=nil;
    
    HudShow =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HudShow];
    HudShow.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    HudShow.mode = MBProgressHUDModeCustomView;
    HudShow.delegate = self;
    
#ifdef MANAGER_SY_VERSION
    tableArray=[[NSArray alloc] initWithObjects:@"主管成绩通报",@"营销经理成绩通报", nil];
#endif
    
#ifdef STANDARD_SY_VERSION
    tableArray=[[NSArray alloc] initWithObjects:@"营销经理成绩通报", nil];
#endif
    
    
}


-(void)goBack{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [tableArray count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ResultShowHomepageViewControllerCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:CellIdentifier owner:self options:nil] objectAtIndex:0];
    }
    
    UILabel *result_des = (UILabel*)[cell viewWithTag:100];
    result_des.text = [tableArray objectAtIndex:indexPath.row];;
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger r =indexPath.row;
    NSLog(@"indexPath %d  %@",r,[tableArray objectAtIndex:indexPath.row]);
    if(![NetworkHandling GetCurrentNet]){
        HudShow.mode = MBProgressHUDModeCustomView;
        HudShow.labelText = @"网络未连接,请检查您的网络";
        [HudShow show:YES];
        [HudShow hide:YES afterDelay:2];
        return;
    }
    num = r;
    [HudWait show:YES];
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    [NetworkHandling sendPackageWithUrl:@"question/GetAllExamInf" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        if(!error){
            
            [self performSelectorOnMainThread:@selector(toNextController:) withObject:[result objectForKey:@"exam_results"] waitUntilDone:NO];
            
            
        }
        else{
            int errorCode=[[result valueForKey:@"errorcode"] intValue];
            NSLog(@"error:%d error:%@",errorCode,[error localizedDescription]);
            [self performSelectorOnMainThread:@selector(showMessage:) withObject:[error localizedDescription] waitUntilDone:YES];
        }
    }];
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:NO];
}

-(void)toNextController:(NSArray*)arry{
    [HudWait hide:YES];
    NSLog(@"GetAllExamInf  %@",arry);
    if ([arry count] > 0){
        ResultShowSecondpageViewController *vc = [[ResultShowSecondpageViewController alloc] initWithNibName:@"ResultShowSecondpageViewController" bundle:nil];
        vc.resultList = arry;
        vc.resultStr = [tableArray objectAtIndex:num];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else{
        HudShow.labelText = @"您当前没有考试记录";
        [HudShow show:YES];
        [HudShow hide:YES afterDelay:2];
    }
}

-(void)showMessage:(NSString*)infomation{
    
    [HudWait hide:YES];
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"信息提示" message:infomation delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
    [myAlertView show];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
