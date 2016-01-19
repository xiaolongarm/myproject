//
//  GroupBroadbandSendboxViewController.m
//  CMCCMarketing
//
//  Created by talkweb on 14-9-19.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//
#import "GroupBroadbandSendboxTableViewCell.h"
#import "GroupBroadbandSendboxViewController.h"
#import "SendBoxHandling.h"
#import "MBProgressHUD.h"
#import "NetworkHandling.h"


@interface GroupBroadbandSendboxViewController ()<MBProgressHUDDelegate>{
    NSMutableArray *tableArray;
    BOOL hubFlag;
    
    MBProgressHUD *HUD;
    int uploadNumber;

}

@end

@implementation GroupBroadbandSendboxViewController

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
    sendboxTableView.dataSource=self;
    sendboxTableView.delegate=self;
    sendboxTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self loadTableData];
}
-(void)loadTableData{
    tableArray =[SendBoxHandling getSendMessageWithModule:kSendBoxModuleWithGroupBrodadband];
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
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableArray count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 160;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GroupBroadbandSendboxTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GroupBroadbandSendboxTableViewCell" forIndexPath:indexPath];
    
    NSDictionary *dict=[tableArray objectAtIndex:indexPath.row];
    cell.itemGroupName.text=[dict objectForKey:@"groupName"];
//    cell.itemSpecialLinePro.text=[self getSpecialLinePro:[[dict objectForKey:@"specialLinePro"] intValue]];
    //specialLineProText
    cell.itemSpecialLinePro.text=[dict objectForKey:@"specialLineProText"];
    cell.itemBroadband.text=[NSString stringWithFormat:@"%d",[[dict objectForKey:@"bandWidth"] intValue]];
    cell.itemStartAndEndDate.text=[NSString stringWithFormat:@"%@ 至 %@",[dict objectForKey:@"contactStartDate"],[dict objectForKey:@"contactEndDate"]];
    cell.itemSaveDate.text=[dict objectForKey:@"saveDate"];
    
    BOOL flag=[[dict objectForKey:@"upload"] boolValue];
    cell.itemUploadState.text=flag?@"已发送":@"未发送";

    return cell;
}
//-(NSString*)getSpecialLinePro:(int)number{
//    switch (number) {
//        case 0:
//            return @"数字电视";
//        case 1:
//            return @"互联网";
//        case 2:
//            return @"WLAN";
//        case 3:
//            return @"裸光纤";
//            
//        default:
//            return @"数字电视";
//    }
//}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
- (IBAction)sendMessage:(id)sender {
    hubFlag=YES;
    HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"正在提交数据，请稍后...";
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
    
    BOOL f=NO;
    for (NSMutableDictionary *dict in tableArray) {
        int i = (int)[tableArray indexOfObject:dict];
        BOOL flag=[[dict objectForKey:@"upload"] boolValue];
        if(!flag){
            f=YES;
            [self submitMeesage:dict finishedState:(i == [tableArray count]-1) currentIndex:i];
        }
    }
    
    if(!f)
        hubFlag=NO;
    
}
-(void)connectToNetwork{
    while (hubFlag) {
        usleep(100000);
    }
}
-(void)submitMeesage:(NSMutableDictionary*)bDict finishedState:(BOOL)finished currentIndex:(int)index{
    [NetworkHandling sendPackageWithUrl:@"broadband/BroadBand" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        if(!error){
            NSDictionary *d3=[result objectForKey:@"Response"];
            BOOL f3=[[d3 objectForKey:@"returnFlag"] boolValue];
            if(f3){
                NSLog(@"受理单据提交成功");
                uploadNumber++;
                float precentage=(float)uploadNumber/([tableArray count]*3);
                //                                          float precentage=(float)(index+1)/[tableArray count];
                NSLog(@"----precentage:%.2f------",precentage);
                HUD.labelText=[NSString stringWithFormat:@"正在提交数据 %d%%", (int)(precentage*100)] ;
                
                [bDict setObject:[NSNumber numberWithBool:YES] forKey:@"upload"];
                
                if(finished){
                    BOOL result=[SendBoxHandling refreshMessageWithModule:kSendBoxModuleWithGroupBrodadband rewriteArray:tableArray];
                    if(result)
                        NSLog(@"回写发送箱列表数据成功。");
                    hubFlag=NO;
                    [self performSelectorOnMainThread:@selector(refreshTableView) withObject:nil waitUntilDone:YES];
                }
            }
            else{
                hubFlag=NO;
                [self performSelectorOnMainThread:@selector(showMessage:) withObject:@"提交业务办理表单申请失败！" waitUntilDone:YES];
            }
        }
        else{
            hubFlag=NO;
            int errorCode=[[result valueForKey:@"errorcode"] intValue];
            NSString *errorInfo=[result valueForKey:@"errorinf"];
            errorInfo=errorInfo?errorInfo:@"提交数据失败！";
            NSLog(@"error:%d info:%@",errorCode,errorInfo);
            if(!errorInfo)
                errorInfo=@"提交数据出错了！";
            [self performSelectorOnMainThread:@selector(showMessage:) withObject:errorInfo waitUntilDone:YES];
        }
    }];

}
-(void)refreshTableView{
    [sendboxTableView reloadData];
}

-(void)showMessage:(NSString*)infomation{
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"信息提示" message:infomation delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
    [myAlertView show];
}
-(void)hudWasHidden:(MBProgressHUD *)hud{
    [hud removeFromSuperview];
    hud=nil;
}


@end
