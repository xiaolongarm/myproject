//
//  KnowledgeBaseWithBusinessDetailsViewController.m
//  CMCCMarketing
//
//  Created by talkweb on 14-11-1.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import "KnowledgeBaseWithBusinessDetailsViewController.h"
#import "KnowledgeBaseWithBusinessDetailsDownloadTableViewCell.h"
#import "DocumentHandling.h"
#import "KnowledgeBaseDocumentReaderViewController.h"
#import "MBProgressHUD.h"
#import "NetworkHandling.h"

@interface KnowledgeBaseWithBusinessDetailsViewController ()<MBProgressHUDDelegate>
{
    BOOL hudFlag;
    NSMutableArray *downloadArray;
    NSURL *selectFilePath;
    NSString *selectFileName;
}

@end

@implementation KnowledgeBaseWithBusinessDetailsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
//{
//    filename = "mold.ppt";
//    filesize = "1.39MB";
//    uid = 2;
//    url = "http://192.168.31.45:8080/kite/uploadImage/OrderBusiness/knowledge/buss/1/mold.ppt";
//    version = 20140816101011;
//}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([_fromFlag isEqualToString:@"fromsetting"]) {
        self.navigationItem.title=@"最新优惠活动";
        [self loadNewDicsData];
    } else {
        UIBarButtonItem *rightButton=[[UIBarButtonItem alloc]initWithTitle:@"收藏" style:UIBarButtonItemStylePlain target:self action:@selector(CollectionKonwledge)];
        [rightButton setTintColor:[UIColor whiteColor]];
        [self.navigationItem setRightBarButtonItem:rightButton];
        [self InitController];
    }
    
   }

-(void)segmentSelected:(id)sender{
    UISegmentedControl* control = (UISegmentedControl*)sender;
    NSDictionary *dict=[self.detailsArray objectAtIndex:control.selectedSegmentIndex];
    [webView loadHTMLString:[dict objectForKey:@"content"] baseURL:nil];
}
-(void)InitController{
    downloadArray=[[NSMutableArray alloc] init];
    
    NSArray *tmpArray=[self.detailsDict objectForKey:@"attachment"];
    for (NSDictionary *dict in tmpArray) {
        NSMutableDictionary *tmpDict=[[NSMutableDictionary alloc] init];
        for (NSString *key in [dict allKeys]) {
            [tmpDict setObject:[dict objectForKey:key] forKey:key];
        }
        [tmpDict setObject:[NSNumber numberWithBool:NO] forKey:@"download"];
        [downloadArray addObject:tmpDict];
    }
    
    downloadTableView.dataSource=self;
    downloadTableView.delegate=self;
    downloadTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    
    [segTitleController removeAllSegments];
    
    int i=0;
    for (NSDictionary *dict in self.detailsArray) {
        [segTitleController insertSegmentWithTitle:[dict objectForKey:@"title"] atIndex:i animated:YES];
        i++;
    }
    [segTitleController addTarget:self action:@selector(segmentSelected:) forControlEvents:UIControlEventValueChanged];
    
    segTitleController.selectedSegmentIndex=0;
    //    segTitleController.segmentedControlStyle=uiseg
    [self segmentSelected:segTitleController];
    
    self.title = [self.detailsDict objectForKey:@"buss_title"];

    
}
-(void)loadNewDicsData{
    /**
     业务知识查询接口
     changsha\v1_8\collect\bussList
     必传参数
     row_id 业务知识id
     返回参数
     row_id 业务知识id
     buss_title 业务知识菜单
     attachment 附件
     title 小标题
     content 业务内容#return value description#>
     */
    
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    //    [bDict setObject:self.user.userMobile forKey:@"mobile"];
    [bDict setObject:[_apiDict objectForKey:@"menu_para"] forKey:@"row_id"];
    
    [NetworkHandling sendPackageWithUrl:@"collect/bussList" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        if(!error){
            NSLog(@"sign in success");
            _detailsDict =[result objectForKey:@"buss_title"];
            _detailsArray=[result objectForKey:@"buss_content"];
            [self performSelectorOnMainThread:@selector(InitController) withObject:nil waitUntilDone:YES];
        }
        else{
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)CollectionKonwledge{
    /**
     * 1、新增收藏夹记录
     changsha\v1_8\collect\addcollect
     必传参数
     menu_name 菜单名称
     menu_para 参数
     type 类型 1:业务知识，2:最新优惠活动
     user_id 用户id
     返回参数
     flag  true/false
     */
    hudFlag=YES;
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"数据提交中，请稍后...";
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
    
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    [bDict setObject:[self.detailsDict objectForKey:@"buss_title"] forKey:@"menu_name"];
    
    [bDict setObject:[self.detailsDict objectForKey:@"row_id"]  forKey:@"menu_para"];
    
    [bDict setObject:@"1" forKey:@"type"];
    //所以发送成功的手机号码
    //   user_id 客户经理id
    [bDict setObject:[NSNumber numberWithInt:self.user.userID] forKey:@"user_id"];
    
    //    NSString *Svcodestring = [sendcontactArray componentsJoinedByString:@","];
    //    [bDict setObject:Svcodestring forKey:@"svc_codes"];
    
    [NetworkHandling sendPackageWithUrl:@"collect/addcollect" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        if(!error){
            NSLog(@"sign in success");
            BOOL flag=[[result objectForKey:@"flag"] boolValue];
            if(flag)
            {
                [self performSelectorOnMainThread:@selector(showMessage:) withObject:@"收藏成功，可到设置->收藏查看" waitUntilDone:YES];
            }
            else{
                [self performSelectorOnMainThread:@selector(showMessage:) withObject:@"收藏失败" waitUntilDone:YES];
            }
            
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



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"KnowledgeBaseDocumentReaderSegue"]){
        KnowledgeBaseDocumentReaderViewController *readerViewController=segue.destinationViewController;
        readerViewController.filePath=selectFilePath;
        readerViewController.fileName=selectFileName;
    }
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return [(NSArray*)[self.detailsDict objectForKey:@"attachment"] count];
    return [downloadArray count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    KnowledgeBaseWithBusinessDetailsDownloadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KnowledgeBaseWithBusinessDetailsDownloadTableViewCell" forIndexPath:indexPath];

//    NSArray *array=[self.detailsDict objectForKey:@"attachment"];
//    NSDictionary *dict=[array objectAtIndex:indexPath.row];
    NSDictionary *dict=[downloadArray objectAtIndex:indexPath.row];
    cell.itemName.text= [NSString stringWithFormat:@"%@.%@",[dict objectForKey:@"filename"],[dict objectForKey:@"filesize"]];
    
//    BOOL download=[[dict objectForKey:@"download"] boolValue];
//    if(selected)
//        cell.itemImageView.image=[UIImage imageNamed:@"勾选"];
//    else
//        cell.itemImageView.image=[UIImage imageNamed:@"未勾选"];
    
//    cell.selectionStyle=UITableViewCellSelectionStyleNone;
//    BOOL download=[[dict objectForKey:@"download"] boolValue];
//    if(download)
//    cell.itemState.hidden=![[dict objectForKey:@"download"] boolValue];
//
//    NSString *rootDir = [dict objectForKey:@"uid"];
//    NSString *docDir=[dict objectForKey:@"version"];
//    NSString *fileName=[dict objectForKey:@"filename"];
//    BOOL flag=[DocumentHandling getFileIsExistPath:rootDir documetDirectory:docDir documentName:fileName];
    
//    if(download){
//        cell.itemState.text=@"下载完成";
//    }
//    else{
//        cell.itemState.text=@"未下载";
//    }
    
    return cell;
}
//{
//    filename = "mold.ppt";
//    filesize = "1.39MB";
//    uid = 2;
//    url = "http://192.168.31.45:8080/kite/uploadImage/OrderBusiness/knowledge/buss/1/mold.ppt";
//    version = 20140816101011;
//}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableDictionary *dict=[downloadArray objectAtIndex:indexPath.row];
    KnowledgeBaseWithBusinessDetailsDownloadTableViewCell *cell=(KnowledgeBaseWithBusinessDetailsDownloadTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];

    
    NSString *url=[dict objectForKey:@"url"];
    NSString *rootDir = [dict objectForKey:@"uid"];
    NSString *docDir=[dict objectForKey:@"version"];
    NSString *fileName=[dict objectForKey:@"filename"];
    BOOL flag=[DocumentHandling getFileIsExistPath:rootDir documetDirectory:docDir documentName:fileName];
    if(!flag){
        cell.itemState.hidden=NO;
        DocumentHandling *downloadHandling = [[DocumentHandling alloc] init];
//        downloadHandling.delegate=self;
        [downloadHandling downloadFileWithUrl:url fileRootPath:rootDir documetDirectory:docDir documentName:fileName progressLabel:cell.itemState];
    }
    else{
        
        NSFileManager *fileManager=[NSFileManager defaultManager];
        NSArray *urls = [fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
        NSURL *documentsDirectoryUrl = urls[0];
        documentsDirectoryUrl = [documentsDirectoryUrl URLByAppendingPathComponent:rootDir isDirectory:YES];
        documentsDirectoryUrl = [documentsDirectoryUrl URLByAppendingPathComponent:docDir isDirectory:YES];
        documentsDirectoryUrl = [documentsDirectoryUrl URLByAppendingPathComponent:fileName];
        selectFilePath=documentsDirectoryUrl;
        selectFileName=fileName;
//        [webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:documentsDirectory]]];
        [self performSegueWithIdentifier:@"KnowledgeBaseDocumentReaderSegue" sender:self];
    }
}
//-(void)documentHandlingDownloadDidFinished:(NSURL *)filePath{
//    dispatch_async(dispatch_get_main_queue(), ^{
////        [webView loadRequest:[NSURLRequest requestWithURL:filePath]];
//        [self performSegueWithIdentifier:@"KnowledgeBaseDocumentReaderSegue" sender:self];
//    });
//}

@end
