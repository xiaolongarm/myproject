//
//  TaskNameViewController.m
//  CMCCMarketing
//
//  Created by gmj on 15/6/17.
//  Copyright (c) 2015年 talkweb. All rights reserved.
//

#import "TaskNameViewController.h"
#import "MBProgressHUD.h"
#import "NetworkHandling.h"
#import <MessageUI/MessageUI.h>
#import "VariableStore.h"
#import "LTableViewCell.h"

@interface TaskNameViewController ()<MBProgressHUDDelegate,MFMessageComposeViewControllerDelegate>{
    BOOL hudFlag;
     BOOL validateFlag;
    NSMutableArray *tableviewArray;
    NSMutableArray *contacts;
    NSMutableArray *sendcontactArray;
     UIButton *button;
    UIImageView *checkImageView;
}
@property (strong, nonatomic) IBOutlet UITableView *taskTableView;

@end

@implementation TaskNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=[_passDict objectForKey:@"task_name"];
    [self InitControl];
     [self InitLoadData];
    // Do any additional setup after loading the view.
}

#pragma mark - 初始化页面控件
-(void)InitControl{
    tableviewArray = [NSMutableArray array];
    contacts=[NSMutableArray array];
    sendcontactArray=[NSMutableArray array];
    // Do any additional setup after loading the view, typically from a nib.

     button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(10, 10, 44, 44);
    [button addTarget:self action:@selector(allSelect:) forControlEvents:UIControlEventTouchUpInside];

    
//    button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    
    //2.设置文字和文字颜色
    [button setTitle:@"全选" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
//
//    //3.设置圆角幅度
    button.layer.cornerRadius = 10.0;
    button.layer.borderWidth = 1.0;
//
//    //4.设置frame
//     button.frame = CGRectMake(10, 10, 44, 50);
//    
//    //6.设置触发事件
//    [button addTarget:self action:@selector(allSelect:) forControlEvents:UIControlEventTouchUpInside];
    //7.添加到tableView tableFooterView中
    //self.taskTableView.tableHeaderView = button;
    
   
    UIBarButtonItem *rightButton=[[UIBarButtonItem alloc]initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(goSendSMS)];
    [rightButton setTintColor:[UIColor whiteColor]];
    [self.navigationItem setRightBarButtonItem:rightButton];
}

#pragma mark - 初始化数据
-(void)InitLoadData{
    hudFlag=YES;
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"数据查询中，请稍后...";
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
    
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
//    //客户经理归宿县市id
//    [bDict setObject:self.user.userCntyID forKey:@"cnty_id"];
    //   task_id
    [bDict setObject:[_passDict objectForKey:@"task_id"] forKey:@"task_id"];
    //客户经理手机号码
    [bDict setObject:self.user.userMobile forKey:@"vip_mngr_msisdn"];
    
    [NetworkHandling sendPackageWithUrl:@"smsmarketing/taskpublishdetail" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        if(!error){
            NSLog(@"sign in success");
            tableviewArray =[result objectForKey:@"smsuser"];
            
            //刷新表格，插入一条判别选中cell的数据
            for (id object in tableviewArray) {
                
                [object setValue:@"NO" forKey:@"checked"];
            }

            [self performSelectorOnMainThread:@selector(goReloadData) withObject:nil waitUntilDone:YES];
            
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

-(void)goReloadData{
    
         [self.tableView reloadData];

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
#pragma mark  发送短信
-(void)goSendSMS{
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
    
    sendcontactArray=[[NSMutableArray alloc] init];
    //拿出联系人的电话组成一个数组
    for (id object in contacts) {
        NSLog(@"langArray=%@", object);
        [sendcontactArray addObject:[object objectForKey:@"svc_code"]];
    }
    
    [picker setEditing:YES];
    
   // SString *string = [array componentsJoinedByString:@","];
    //联系人的电话
    picker.recipients=sendcontactArray;
   // NSString *cname=[VariableStore getCustomerManagerName];
    picker.body=[NSString stringWithFormat:@"%@",[_passDict objectForKey:@"message"]];
    
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
            [self SetSvcodeFlag];
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
#pragma mark - 上传电话号码状态
-(void)SetSvcodeFlag{
    hudFlag=YES;
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"数据提交中，请稍后...";
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
    
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    //    //客户经理归宿县市id
    //    [bDict setObject:self.user.userCntyID forKey:@"cnty_id"];
    //   task_id
    [bDict setObject:[_passDict objectForKey:@"task_id"] forKey:@"task_id"];
    //所以发送成功的手机号码
    
    NSString *Svcodestring = [sendcontactArray componentsJoinedByString:@","];
    [bDict setObject:Svcodestring forKey:@"svc_codes"];
    
    [NetworkHandling sendPackageWithUrl:@"smsmarketing/upddetailflag" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        if(!error){
            NSLog(@"sign in success");
            //tableviewArray =[result objectForKey:@"smsuser"];
            
            //刷新表格，插入一条判别选中cell的数据
//            for (id object in tableviewArray) {
//                
//                [object setValue:@"NO" forKey:@"checked"];
//            }
            
           // [self performSelectorOnMainThread:@selector(goShowMessage) withObject:nil waitUntilDone:YES];
            
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
-(void)goShowMessage{
    NSLog(@"send message success");
}


#pragma mark - UITableViewDelegate
- (void)allSelect:(UIButton*)sender{
    NSArray *anArrayOfIndexPath = [NSArray arrayWithArray:[_taskTableView indexPathsForVisibleRows]];
    for (int i = 0; i < [anArrayOfIndexPath count]; i++) {
        NSIndexPath *indexPath= [anArrayOfIndexPath objectAtIndex:i];
        LTableViewCell *cell = (LTableViewCell*)[_taskTableView cellForRowAtIndexPath:indexPath];
        NSUInteger row = [indexPath row];
        NSLog(@"%lu",(unsigned long)row);
        NSMutableDictionary *dic = [tableviewArray objectAtIndex:row];
        if ([[[(UIButton*)sender titleLabel] text] isEqualToString:@"全选"]) {
            [dic setObject:@"YES" forKey:@"checked"];
            [cell setChecked:YES];
            
        }else {
            [dic setObject:@"NO" forKey:@"checked"];
            [cell setChecked:NO];
            
        }
    }
    if ([[[(UIButton*)sender titleLabel] text] isEqualToString:@"全选"]){
        
        [contacts removeAllObjects];
        //********设置全选按钮的图片
        checkImageView.image = [UIImage imageNamed:@"Selected.png"];
        
        for (NSDictionary *dic in tableviewArray) {
            [dic setValue:@"YES" forKey:@"checked"];
            [contacts addObject:dic];
        }
        [(UIButton*)sender setTitle:@"取消" forState:UIControlStateNormal];
    }else{
        //********设置全选按钮的图片
          checkImageView.image = [UIImage imageNamed:@"Unselected.png"];
        for (NSDictionary *dic in tableviewArray) {
            [dic setValue:@"NO" forKey:@"checked"];
            [contacts removeObject:dic];
        }
        [(UIButton*)sender setTitle:@"全选" forState:UIControlStateNormal];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *myView= [[UIView alloc]init];
//    myView.layer.borderWidth=1;
//    myView.layer.borderColor=[[UIColor darkGrayColor]CGColor];
    myView.backgroundColor=[UIColor whiteColor];
    UIButton *headbutton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    //headbutton.frame = CGRectMake (10, 10, 320, 29);
    headbutton.frame = CGRectMake(0, 0, 200,44);
    [headbutton addTarget:self action:@selector(allSelect:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //    button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    //
    //2.设置文字和文字颜色
    [headbutton setTitle:@"全选" forState:UIControlStateNormal];
    [headbutton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [myView addSubview:headbutton];
    
  checkImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Unselected.png"]];
    checkImageView.frame = CGRectMake(10, 12, 20, 20);
//    checkImageView.frame = CGRectMake(10, 15, 20, 20);
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    
    CGColorRef color = CGColorCreate(colorSpaceRef, (CGFloat[]){1,0,0,1});
    
    [headbutton.layer setBorderColor:color];
    [headbutton addSubview:checkImageView];
    //[headbutton.layer setBorderColor:CFBridgingRetain([UIColor darkGrayColor])];
//    //
//    //    //3.设置圆角幅度
//    headbutton.layer.cornerRadius = 10.0;
//    headbutton.layer.borderWidth = 1.0;
    UIImageView *lineImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"实线条.png"]];
    lineImageView.frame= CGRectMake(0, 44, 320, 2);

    [myView addSubview:lineImageView];

    return myView;

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section

{
       return 44;
}


//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//   
//    return 44;
//    
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * identifier = @"Cell";
    LTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[LTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    NSUInteger row = [indexPath row];
    NSMutableDictionary *dic = [tableviewArray objectAtIndex:row];
    
    if ([tableviewArray count]==0) {
        return nil;
    }
    cell.m_detailText.textColor= [UIColor darkGrayColor];
    cell.m_detailText.text =[[tableviewArray objectAtIndex:row] objectForKey:@"svc_code"];;
    if ([[dic objectForKey:@"checked"] isEqualToString:@"NO"]) {
        [dic setObject:@"NO" forKey:@"checked"];
        [cell setChecked:NO];
        
    }else {
        //选中
        [dic setObject:@"YES" forKey:@"checked"];
        [cell setChecked:YES];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    LTableViewCell *cell = (LTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    
    NSUInteger row = [indexPath row];
    NSMutableDictionary *dic = [tableviewArray objectAtIndex:row];
    if ([[dic objectForKey:@"checked"] isEqualToString:@"NO"]) {
        //选中
        [dic setObject:@"YES" forKey:@"checked"];
        [cell setChecked:YES];
        [contacts addObject:dic];
    }else {
        //取消选中
        [dic setObject:@"NO" forKey:@"checked"];
        [cell setChecked:NO];
        [contacts removeObject:dic];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableviewArray count];
}
//
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *CellWithIdentifier = @"Cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellWithIdentifier];
//    }
//    NSUInteger row = [indexPath row];
//    cell.textLabel.textAlignment=NSTextAlignmentLeft;
//    cell.textLabel.text = [[tableviewArray objectAtIndex:row] objectForKey:@"svc_code"];
//    //cell.textLabel.text = [self.dataList objectAtIndex:row];
//    //cell.imageView.image = [UIImage imageNamed:@"green.png"];
//    //cell.accessoryType=UITableViewCellAccessoryCheckmark;
//    return cell;
//    
//}
//
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
////    //NSInteger se = indexPath.section;
////    // NSInteger row = indexPath.row;
////    sendIndexPath=indexPath;
////    [self performSegueWithIdentifier:@"taskNameSegue" sender:self];
//    
//    
//}

 

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
