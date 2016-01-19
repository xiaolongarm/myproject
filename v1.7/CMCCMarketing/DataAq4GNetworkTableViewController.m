//
//  DataAq4GNetworkTableViewController.m
//  CMCCMarketing
//
//  Created by kevin on 15/7/8.
//  Copyright (c) 2015年 talkweb. All rights reserved.
//

#import "DataAq4GNetworkTableViewController.h"
#import "PreferentialPurchaseSelectDateTimeViewController.h"
#import "MBProgressHUD.h"
#import "NetworkHandling.h"
#import "DataAq4GNetworkTableViewCell.h"

@interface DataAq4GNetworkTableViewController ()<PreferentialPurchaseSelectDateTimeViewControllerDelegate,MBProgressHUDDelegate>
{
    NSMutableArray *tableviewArray;
    NSMutableArray *customNumberArray;
    NSMutableArray *mobilePhoneNumberArray;
    NSMutableArray *dealTimeArray;
    
    //datapicker
    PreferentialPurchaseSelectDateTimeViewController *selectDateTimeViewController;
    UIView *backView;
    UIButton *selectDateWithButton;
    UITextField *WorkNumTextfield;
    BOOL hubFlag;
}

@end

@implementation DataAq4GNetworkTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self InitControl];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
#pragma mark - 初始化页面控件
-(void)InitControl{
    //tableviewArray = [NSMutableArray array];
    customNumberArray=[NSMutableArray array];
    mobilePhoneNumberArray=[NSMutableArray array];
    dealTimeArray=[NSMutableArray array];
    
    tableviewArray=[NSMutableArray arrayWithObjects:@"",@"",@"",nil];
    //TextField
    //    self.testTimeField.delegate = self;
    ////    self.testNameField.delegate = self;
    ////    self.testLocationField.delegate = self;
    ////    self.testOtherField.delegate = self;
    //
    //    self.testTimeField.tag = 1001;
    //
    //    self.testNameField.returnKeyType = UIReturnKeyDone;
    //    self.testLocationField.returnKeyType = UIReturnKeyDone;
    //    self.testOtherField.returnKeyType = UIReturnKeyDone;
    //
    //    //UIDatePicker
    //    datePicker = [[UIDatePicker alloc] init];
    //    datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    //    datePicker.minuteInterval = 30;
    //    [datePicker addTarget:self action:@selector(chooseDate:) forControlEvents:UIControlEventValueChanged];
    
    
    UIBarButtonItem *rightButton=[[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(goSendData)];
    [rightButton setTintColor:[UIColor whiteColor]];
    [self.navigationItem setRightBarButtonItem:rightButton];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    
    UIView *myView= [[UIView alloc]init];
    myView.backgroundColor=[UIColor whiteColor];
    UILabel *WorkNum= [[UILabel alloc] initWithFrame:CGRectMake(14, 8, 85, 21)];
    WorkNum.textColor =[UIColor darkGrayColor];
    WorkNum.text =@"申报工号:";
    WorkNum.textAlignment=NSTextAlignmentRight;
    
    WorkNumTextfield= [[UITextField alloc]initWithFrame:CGRectMake(122, 4, 158, 30)];
    WorkNumTextfield.textAlignment=NSTextAlignmentCenter;
    //    WorkNumTextfield.keyboardType=UIKeyboardTypeNumberPad;
    WorkNumTextfield.layer.cornerRadius=8.0f;
    WorkNumTextfield.layer.masksToBounds=YES;
    WorkNumTextfield.layer.borderWidth = 0.5f;
    WorkNumTextfield.layer.borderColor= [[UIColor darkTextColor]CGColor];
    [myView addSubview: WorkNum];
    [myView addSubview:WorkNumTextfield];
    UIImageView *lineImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"实线条.png"]];
    lineImageView.frame= CGRectMake(0, 44, 320, 2);
    [myView addSubview:lineImageView];
    return myView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section

{
    return 44;
}
//
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    UIView *myView= [[UIView alloc]init];
//    myView.backgroundColor=[UIColor whiteColor];
//
//    UIButton *addButtonView=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
//    [addButtonView addTarget:self action:@selector(addCellButton) forControlEvents:UIControlEventTouchUpInside];
//    // NSString *remindString=@"填写未在列表的陪同人员";
//    [addButtonView setTitle:@"新增 +" forState:UIControlStateNormal];
//    [addButtonView setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
//
//    [myView addSubview:addButtonView];
//    UIImageView *lineImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"实线条.png"]];
//    lineImageView.frame= CGRectMake(0, 44, 320, 2);
//
//    [myView addSubview:lineImageView];
//    return myView;
//
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 44;
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [tableviewArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * identifier = @"DataAq4GNetworkTableViewCell";
    DataAq4GNetworkTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"DataAq4GNetworkTableViewCell" owner:nil options:nil]lastObject];
    }
    //去掉选中效果
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.customPhoneNumber.keyboardType=UIKeyboardTypeNumberPad;
    cell.mobilePhoneNumber.keyboardType=UIKeyboardTypeNumberPad;
    //cell.keyAmount.keyboardType=UIKeyboardTypeNumberPad;
    //cell.ChangCardTextfiled.placeholder=@"换卡时间";
    [cell.dealTimeButton addTarget:self action:@selector(itemSupplyTimeButtonOnclick:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
    
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

/*改变删除按钮的title*/
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

/*删除用到的函数*/
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [tableviewArray removeObjectAtIndex:[indexPath row]];  //删除数组里的数据
        [self.tableView deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];  //删除对应数据的cell
    }
}

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



#pragma mark - 新增一个CELL
-(void)addCellButton{
    [tableviewArray addObject:@""];
    [self.tableView reloadData];
}

#pragma mark -提交数据
-(void)goSendData{
    
    //获取表格数据
    for (int i = 0; i < [tableviewArray count]; i++) {
        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:i inSection:0];
        
        DataAq4GNetworkTableViewCell *scell = (DataAq4GNetworkTableViewCell*)[self.tableView cellForRowAtIndexPath:indexPath];
        //[self.tableView cellForRowAtIndexPath:indexPath];
        NSUInteger row = [indexPath row];
        NSLog(@"%lu",(unsigned long)row);
        //客户号码
        NSString *cardNumberString=scell.customPhoneNumber.text;
        [customNumberArray addObject:cardNumberString];
        //移动号码
        NSString *mobilePhoneNumberString= scell.mobilePhoneNumber.text;
        [mobilePhoneNumberArray addObject:mobilePhoneNumberString];
        //办理时间**************************
        NSString *CardTimeString=scell.dealTimeButton.titleLabel.text;
        if ([CardTimeString isEqualToString:@"点击选择"]) {
            //获取当前时间
            NSDate *  senddate=[NSDate date];
            NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
            
            [dateformatter setDateFormat:@"YYYY-MM-dd"];
            CardTimeString=[dateformatter stringFromDate:senddate];
            
        }
        [dealTimeArray addObject:CardTimeString];
        
    }
    //客户号码string
    NSString *cardString = [customNumberArray componentsJoinedByString:@","];
    //移动号码string
    NSString *mobilePhoneString= [mobilePhoneNumberArray componentsJoinedByString:@","];
    //办理时间string
    NSString *timeString = [dealTimeArray componentsJoinedByString:@","];
    //***********************
    //提交参数
//    异网回归
//    shaoyang\v1_2\datacollect\datadifferentnetwork
//    必传参数
//    user_id 客户经理id (登录接口用户信息获取)
//    user_name 客户经理姓名 (登录接口用户信息获取)
//    user_msisdn 客户经理手机号码 (登录接口用户信息获取)
//    user_card 客户经理工号 (手机端录入)
//    cnty_id 客户经理归属县市 (登录接口用户信息获取)
//    msisdn 移动网手机号码(手机端录入有多个时用,号分隔)
//    diff_msisdn 异网手机号码(手机端录入有多个时用,号分隔)
//    deal_date 办理时间(手机端录入有多个时用,号分隔)
//    返回参数
//    flag  返回成功结果
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    [bDict setObject:[NSNumber numberWithInt:self.user.userID] forKey:@"user_id"];
    [bDict setObject:self.user.userName forKey:@"user_name"];
    [bDict setObject:self.user.userMobile forKey:@"user_msisdn"];
    if ([WorkNumTextfield.text isEqualToString:@""]) {
        MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:HUD];
        HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
        HUD.mode = MBProgressHUDModeCustomView;
        HUD.delegate = self;
        HUD.labelText = @"请填写申报工号！";
        [HUD show:YES];
        [HUD hide:YES afterDelay:1];
        return;
        
    }
    [bDict setObject:WorkNumTextfield.text forKey:@"user_card"];
    [bDict setObject:self.user.userCntyID forKey:@"cnty_id"];
    
    [bDict setObject:cardString forKey:@"msisdn"];
    [bDict setObject:mobilePhoneString forKey:@"diff_msisdn"];
    [bDict setObject:timeString forKey:@"deal_date"];
    
    
    hubFlag=YES;
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"正在提交数据，请稍后...";
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
    
    [NetworkHandling sendPackageWithUrl:@"datacollect/datadifferentnetwork" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        if(!error){
            NSLog(@"sign in success");
            // NSDictionary *dict=[result objectForKey:@"flag"];
            BOOL flag=[[result objectForKey:@"flag"] boolValue];
            if(flag)
            {
                [self performSelectorOnMainThread:@selector(showSuccessMessage:) withObject:@"提交信息成功,可再次输入新数据进行提交" waitUntilDone:YES];
            }
            else
            {
                [self performSelectorOnMainThread:@selector(showMessage:) withObject:@"提交信息失败！" waitUntilDone:YES];
            }
        }else{
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
-(void)connectToNetwork{
    while (hubFlag) {
        usleep(100000);
    }
}
-(void)showMessage:(NSString*)infomation{
    
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"信息提示" message:infomation delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
    [myAlertView show];
}
-(void)showSuccessMessage:(NSString*)infomation{
    [customNumberArray removeAllObjects];
    [mobilePhoneNumberArray removeAllObjects];
    [dealTimeArray removeAllObjects];
    [self.tableView reloadData];
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"信息提示" message:infomation delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
    [myAlertView show];
    
}



@end
