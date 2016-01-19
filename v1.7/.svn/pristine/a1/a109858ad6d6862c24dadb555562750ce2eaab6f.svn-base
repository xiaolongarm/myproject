//
//  CsAchievementListViewController.m
//  CMCCMarketing
//
//  Created by kevin on 15/10/8.
//  Copyright © 2015年 talkweb. All rights reserved.
//

#import "CsAchievementListViewController.h"
#import "MBProgressHUD.h"
#import "NetworkHandling.h"
#import "PreferentialPurchaseSelectDateTimeViewController.h"
#import "CsAchievementListTableViewCell.h"

@interface CsAchievementListViewController ()<MBProgressHUDDelegate,PreferentialPurchaseSelectDateTimeViewControllerDelegate,UISearchBarDelegate>
{
    UISearchBar *searchbar;
    BOOL hudFlag;
    NSMutableArray *tableviewArray;
     NSMutableArray *fullArray;
    //时间选择器
    PreferentialPurchaseSelectDateTimeViewController *selectDateTimeViewController;
    UIView *backView;
    UIButton *selectDateWithButton;

}


@end

@implementation CsAchievementListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化导航栏
    if(IOS7)
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"320X64"] forBarMetrics:UIBarMetricsDefault];
    else
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"320X44"] forBarMetrics:UIBarMetricsDefault];
    
    UIBarButtonItem *leftButton=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回1"] style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    [leftButton setTintColor:[UIColor whiteColor]];
    
    [self.navigationItem setLeftBarButtonItem:leftButton];
    
    UIColor * color = [UIColor whiteColor];
    NSDictionary * dict=[NSDictionary dictionaryWithObject:color forKey:UITextAttributeTextColor];
    [self.navigationController.navigationBar setTitleTextAttributes:dict];
    
    [self InitControl];
    //[self InitLoadData];

}
-(void)goBack{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - 初始化页面控件
-(void)InitControl{
    //手绘搜索框
    CGRect rect=self.view.frame;
    rect.size.height=44;
    rect.origin.y=64;
    rect.origin.x=0;
    searchbar=[[UISearchBar alloc] init];
    searchbar.placeholder=@"请输入名称关键字或是电话号码查询";
    searchbar.frame=rect;
    searchbar.delegate=self;
    [self.view addSubview:searchbar];
    searchbar.hidden=YES;

    //搜索按钮
    UIBarButtonItem *rightButton=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"查询按钮"] style:UIBarButtonItemStylePlain target:self action:@selector(goSearch)];
    [rightButton setTintColor:[UIColor whiteColor]];
    [self.navigationItem setRightBarButtonItem:rightButton];
   //开始时间
    [self.startTime  addTarget:self action:@selector(itemSupplyTimeButtonOnclick:) forControlEvents:UIControlEventTouchUpInside];
//结束时间
     [self.endTime  addTarget:self action:@selector(itemSupplyTimeButtonOnclick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.checkButton addTarget:self action:@selector(InitLoadData) forControlEvents:UIControlEventTouchUpInside];
    _tableViewList.dataSource=self;
    _tableViewList.delegate=self;
}

#pragma mark - 初始化数据
-(void)InitLoadData{
    /**
     *   业务通报接口地址
     接口地址：
     changsha\v1_8\bussreport\getbusinessreport
     必传参数
     vip_mngr_msisdn 客户经理手机号码
     start_date 开始时间
     end_date 结束时间
     非必传参数
     target_name 指标名称
     返回参数
     vip_mngr_name 客户经理姓名
     target_name 指标名称
     objective_values 目标值
     finish_values 完成值
     ranking  排名

     */
    hudFlag=YES;
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"数据查询中，请稍后...";
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
    
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    //客户经理手机号码
    [bDict setObject:self.user.userMobile forKey:@"vip_mngr_msisdn"];
    //   user_id 客户经理id
    //开始时间
    NSString *startTimeString=self.startTime.titleLabel.text;
    if ([startTimeString isEqualToString:@"选择开始时间"]) {
        //获取当前时间
        NSDate *  senddate=[NSDate date];
        NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
        [dateformatter setDateFormat:@"YYYY-MM-dd"];
        startTimeString=[dateformatter stringFromDate:senddate];
    }
    [bDict setObject:startTimeString forKey:@"start_date"];
    //结束时间
    NSString *endTimeString=self.endTime.titleLabel.text;
    if ([endTimeString isEqualToString:@"选择结束时间"]) {
        //获取当前时间
        NSDate *  senddate=[NSDate date];
        NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
        [dateformatter setDateFormat:@"YYYY-MM-dd"];
        endTimeString=[dateformatter stringFromDate:senddate];
    }
    [bDict setObject:endTimeString forKey:@"end_date"];

    [NetworkHandling sendPackageWithUrl:@"bussreport/getbusinessreport" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        if(!error){
            NSLog(@"sign in success");
            tableviewArray =[result objectForKey:@"list"];
            //刷新表格，装入数据
            [self performSelectorOnMainThread:@selector(goOnReloadData:) withObject:nil waitUntilDone:YES];
        }else{
            int errorCode=[[result valueForKey:@"errorcode"] intValue];
            NSString *errorInfo=[result valueForKey:@"errorinf"];
            if(!errorInfo)
                errorInfo=@"提交数据出错了！";
            NSLog(@"error:%d info:%@",errorCode,errorInfo);
            [self performSelectorOnMainThread:@selector(showMessage:) withObject:errorInfo waitUntilDone:YES];
        }
        hudFlag=NO;
    }];
    
}

-(void)goOnReloadData:(id)sender{
    [_tableViewList reloadData];
}

#pragma mark -网络API相关

-(void)connectToNetwork{
    while (hudFlag) {
        usleep(100000);
    }
}
-(void)showMessage:(NSString*)infomation{
    
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"信息提示" message:infomation delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
    [myAlertView show];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [tableviewArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellWithIdentifier = @"Cell";
    CsAchievementListTableViewCell *cell = [self.tableViewList  dequeueReusableCellWithIdentifier:CellWithIdentifier];
    if (cell == nil) {
        cell = [[CsAchievementListTableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellWithIdentifier];
    }
    
    //    cell.textLabel.textAlignment=NSTextAlignmentLeft;
//    cell.textLabel.textColor=[UIColor darkGrayColor];
//    cell.textLabel.text = [[tableviewArray objectAtIndex:row] objectForKey:@"task_name"];
    cell.name.text=[[tableviewArray objectAtIndex:indexPath.row]objectForKey:@"target_name"];
     cell.time.text=[[tableviewArray objectAtIndex:indexPath.row]objectForKey:@"time"];
    cell.targetValue.text=[[tableviewArray objectAtIndex:indexPath.row]objectForKey:@"objective_values"];
    cell.targetValue.text=[[tableviewArray objectAtIndex:indexPath.row]objectForKey:@"finish_values"];
    cell.rank.text=[[tableviewArray objectAtIndex:indexPath.row]objectForKey:@"ranking"];
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //NSInteger se = indexPath.section;
    // NSInteger row = indexPath.row;
//    sendIndexPath=indexPath;
//    [self performSegueWithIdentifier:@"taskNameSegue" sender:self];
//    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - 选择时间控制器
-(void)itemSupplyTimeButtonOnclick:(id)sender{
    //关闭当前所有键盘
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"BusinessProcess" bundle:nil];
    selectDateTimeViewController=[storyboard instantiateViewControllerWithIdentifier:@"PreferentialPurchaseSelectDateTimeViewControllerId"];
    selectDateTimeViewController.delegate=self;
    CGRect rect=selectDateTimeViewController.view.frame;
    selectDateTimeViewController.modeDateAndTime=1;
    rect.origin.x=0;
    rect.origin.y=[[UIScreen mainScreen] bounds].size.height - 260;
    rect.size.width=320;
    rect.size.height=200;
    
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
    
    selectDateWithButton=sender;
    
}
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
    //    selectDateWithTextField.text=[dateFormatter stringFromDate:controller.datetimePicker.date];
    [selectDateWithButton setTitle:dateString forState:UIControlStateNormal];
    [self preferentialPurchaseSelectDateTimeViewControllerDidCancel];
}
#pragma mark -搜索方法 search delegate

-(void)goSearch{
    searchbar.hidden=!searchbar.hidden;
    if(searchbar.hidden)
        [searchbar resignFirstResponder];
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)sBar{
    [sBar resignFirstResponder];
    [self searchBar:sBar textDidChange:sBar.text];
}
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if(searchText.length==0){
        tableviewArray=fullArray;
        [_tableViewList reloadData];
        return;
    }
    
    NSMutableArray *tmpArray=[[NSMutableArray alloc] init];
    for (NSDictionary *item in tableviewArray) {
        
        NSString *name=[item objectForKey:@"target_name"];
                NSRange range1=[name rangeOfString:searchText];
        if(range1.location!= NSNotFound)
            [tmpArray addObject:item];
        
    }
    tableviewArray=tmpArray;
        [_tableViewList reloadData];
}


@end
