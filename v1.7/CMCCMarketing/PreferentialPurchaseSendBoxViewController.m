//
//  PreferentialPurchaseSendBoxViewController.m
//  CMCCMarketing
//
//  Created by talkweb on 14-9-18.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//
#import "PreferentialPurchaseSendBoxTableViewCell.h"
#import "PreferentialPurchaseSendBoxViewController.h"
#import "SendBoxHandling.h"
#import "MBProgressHUD.h"
#import "NetworkHandling.h"

@interface PreferentialPurchaseSendBoxViewController ()<MBProgressHUDDelegate>{
    NSMutableDictionary *sendDict;
    NSMutableArray *fullTableArray;
    BOOL hubFlag;
    
    MBProgressHUD *HUD;
    int uploadNumber;
}

@end

@implementation PreferentialPurchaseSendBoxViewController

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
    sendBoxTableView.delegate=self;
    sendBoxTableView.dataSource=self;
    [sendBoxTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [self loadTableData];
}
-(void)loadTableData{
    fullTableArray =[SendBoxHandling getSendMessageWithModule:kSendBoxModuleWithOfferToBuy];
    sendDict=[[NSMutableDictionary alloc] init];
    
    for (NSDictionary *item in fullTableArray) {
        BOOL flag=[[item objectForKey:@"upload"] boolValue];
        if(!flag){
            //            NSData *data=[item objectForKey:@"groupName"];
            //            NSString *groupName=[[NSString alloc] initWithData:data encoding:NSUTF16BigEndianStringEncoding];
            NSString *groupName=[item objectForKey:@"groupName"];
            int num=[[sendDict objectForKey:groupName] intValue];
            num++;
            [sendDict setObject:[NSNumber numberWithInt:num] forKey:groupName];
        }
    }
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
    return [[sendDict allKeys] count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PreferentialPurchaseSendBoxTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PreferentialPurchaseSendBoxTableViewCell" forIndexPath:indexPath];
    
    NSString *key=[[sendDict allKeys] objectAtIndex:indexPath.row];

    cell.itemName.text=key;
    int num=[[sendDict objectForKey:key] intValue];
    cell.itemState.text=[NSString stringWithFormat:@"未发送（%d）",num];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

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
    for (NSMutableDictionary *dict in fullTableArray) {
        int i = (int)[fullTableArray indexOfObject:dict];
        BOOL flag=[[dict objectForKey:@"upload"] boolValue];
        if(!flag){
            f=YES;
            [self submitIDCard:dict finishedState:(i == [fullTableArray count]-1) currentIndex:i];
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

-(void)submitIDCard:(NSMutableDictionary*)bDict finishedState:(BOOL)finished currentIndex:(int)index{
    NSString *nettype=[NetworkHandling GetCurrentNet];
    if(!nettype){
        hubFlag=NO;
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"错误" message:@"当前没有连接网络，无法提交数据！" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"关闭", nil];
        [alertView show];
        return;
    }
    
    //send idcard image
    NSString *imgName=[bDict objectForKey:@"customerIdCardPics"];
    NSArray *imgNameArray=[imgName componentsSeparatedByString:@","];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,     NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *img1=[documentsDirectory stringByAppendingPathComponent:[imgNameArray objectAtIndex:0]];
    NSString *img2=[documentsDirectory stringByAppendingPathComponent:[imgNameArray objectAtIndex:1]];
    
    UIImage *pic1=[UIImage imageWithContentsOfFile:img1];
    UIImage *pic2=[UIImage imageWithContentsOfFile:img2];
    
    [NetworkHandling UploadsyntheticPictures:pic1 currentPicName:[imgNameArray objectAtIndex:0] currentUser:self.user.userID uploadType:@"flow" completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if(!error){
            NSDictionary *d1=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            BOOL f1=[[d1 objectForKey:@"imgUpload"] boolValue];
            if(f1){
                NSLog(@"第一张身份证上传成功。。。");
                uploadNumber++;
                float precentage=(float)uploadNumber/([fullTableArray count]*3);
                //                float precentage=(float)((index+1)*3-2)/([tableArray count]*3);
                NSLog(@"----precentage:%.2f------",precentage);
                HUD.labelText=[NSString stringWithFormat:@"正在提交数据 %d%%", (int)(precentage*100)] ;
                
                [NetworkHandling UploadsyntheticPictures:pic2 currentPicName:[imgNameArray objectAtIndex:1] currentUser:self.user.userID uploadType:@"flow" completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                    if(!error){
                        
                        NSDictionary *d2=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                        BOOL f2=[[d2 objectForKey:@"imgUpload"] boolValue];
                        if(f2){
                            NSLog(@"第二张身份证上传成功。。。");
                            uploadNumber++;
                            float precentage=(float)uploadNumber/([fullTableArray count]*3);
                            //                            float precentage=(float)((index+1)*3-1)/([tableArray count]*3);
                            NSLog(@"----precentage:%.2f------",precentage);
                            HUD.labelText=[NSString stringWithFormat:@"正在提交数据 %d%%", (int)(precentage*100)] ;
                            
                            [self submitFlowHandling:bDict complettionHandler:^(NSDictionary *result, NSError *error) {
                                if(!error){
                                    NSDictionary *d3=[result objectForKey:@"Response"];
                                    BOOL f3=[[d3 objectForKey:@"returnFlag"] boolValue];
                                    if(f3){
                                        NSLog(@"受理单据提交成功");
                                        uploadNumber++;
                                        float precentage=(float)uploadNumber/([fullTableArray count]*3);
                                        //                                          float precentage=(float)(index+1)/[tableArray count];
                                        NSLog(@"----precentage:%.2f------",precentage);
                                        HUD.labelText=[NSString stringWithFormat:@"正在提交数据 %d%%", (int)(precentage*100)] ;
                                        
                                        [bDict setObject:[NSNumber numberWithBool:YES] forKey:@"upload"];
                                        
                                        if(finished){
                                            BOOL result=[SendBoxHandling refreshMessageWithModule:kSendBoxModuleWithOfferToBuy rewriteArray:fullTableArray];
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
                                //                                  hubFlag=NO;
                            }];
                        }
                    }
                    else{
                        NSLog(@"error");
                    }
                }];
            }
        }
        else{
            NSLog(@"error");
        }
    }];
    
}
-(void)refreshTableView{
    [self loadTableData];
    [sendBoxTableView reloadData];
}
-(void)submitFlowHandling:(NSDictionary*)bDict complettionHandler:(void(^)(NSDictionary *result, NSError *error))block{
    //IosOffSale OffSale
    [NetworkHandling sendPackageWithUrl:@"sale/IosOffSale" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        block(result,error);
    }];
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
