//
//  WorkRecordViewController.m
//  CMCCMarketing
//
//  Created by gmj on 15-1-26.
//  Copyright (c) 2015年 talkweb. All rights reserved.
//

#import "WorkRecordViewController.h"

#import "WorkRecordAddViewController.h"

#import "NetworkHandling.h"
#import "MBProgressHUD.h"

#import "WorkRecordViewControllerCell.h"

#import "WorkRecordDetailViewController.h"
#import "WorkRecordListViewController.h"

@interface WorkRecordViewController ()<MBProgressHUDDelegate>{
    
    BOOL hubFlag;
    NSArray *timesArray;
}

@end

@implementation WorkRecordViewController


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if([segue.identifier isEqualToString:@"toWorkRecordAddViewControllerSegue"]){
        
        WorkRecordAddViewController *controller=segue.destinationViewController;
        controller.user=self.user;
        controller.timesArray=timesArray;
        
    }else if([segue.identifier isEqualToString:@"toWorkRecordDetailViewControllerSegue"]){
        
        WorkRecordDetailViewController *vc = segue.destinationViewController;
        vc.selectedWorkRecord = self.selectedWorkRecord;
        vc.user=self.user;
        vc.whereFrom=11;
//        vc.uploadImage=self.selectedCellImage;
    }
    
    else if([segue.identifier isEqualToString:@"toWorkRecordListViewControllerSegue"]){
        WorkRecordListViewController *controller=segue.destinationViewController;
        controller.user=self.user;
        controller.tbList=self.tbList;
    }
    
}

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
    
    
    
    self.tbView.dataSource=self;
    self.tbView.delegate=self;
    self.tbView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.keyValues = [[NSMutableDictionary alloc] init];
    self.keys= [[NSMutableArray alloc] init];
    
//    self.view.backgroundColor=[UIColor colorWithRed:100/255.0 green:184/255.0 blue:229/255.0 alpha:1.0];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    hubFlag=YES;
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"数据查询中，请稍后...";
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
    [self loadWorkRecordData];
    [self loadWorkRecordAddWithDay];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    int c = self.tbList? self.tbList.count : 0;
    return c;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WorkRecordViewControllerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WorkRecordViewControllerCell" forIndexPath:indexPath];
    
    NSDictionary *dicObj = [self.tbList objectAtIndex:indexPath.row];
    int weekIndex=[[dicObj objectForKey:@"week_day"] intValue];
    NSString *weekString =[self getWeekWith:weekIndex];
    cell.lblDate.text = [NSString stringWithFormat:@"%@  %@",[dicObj objectForKey:@"daily_date"],weekString];

    //如果日报列表包含了今天的就不能再添加日报
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
//    NSString *dateString=[dateFormatter stringFromDate:[NSDate date]];
//    if([dateString isEqualToString:cell.lblDate.text])
//        btAdd.hidden=YES;
    
    NSString *content = [NSString stringWithFormat:@"内容:%@",[dicObj objectForKey:@"daily_content"]];
    content = [content stringByAppendingString:@"\n "];
    //itemContent.numberOfLines = 0;
     //cell.lblContent.font = [UIFont systemFontOfSize:15];
  //  [ cell.lblContent sizeToFit];
  //cell.lblContent.text = content;
   cell.txtContent.text=content;
    NSString *image_url = [dicObj objectForKey:@"daily_pic"];
    cell.btnImg1.hidden=YES;
    cell.btnImg2.hidden=YES;
    cell.btnImg3.hidden=YES;
    if (image_url && image_url.length>0) {
        NSArray *tmpArray=[image_url componentsSeparatedByString:@","];
        
        NSURL *url = [NSURL URLWithString:[tmpArray firstObject]];
        [self asyncLoadPhotoWithView:cell.btnImg1 requestUrl:url];
        cell.btnImg1.hidden=NO;
        if([tmpArray count]>1){
            NSURL *url1 = [NSURL URLWithString:[tmpArray objectAtIndex:1]];
            [self asyncLoadPhotoWithView:cell.btnImg2 requestUrl:url1];
            cell.btnImg2.hidden=NO;
        }
        if([tmpArray count]>2){
            NSURL *url2 = [NSURL URLWithString:[tmpArray objectAtIndex:2]];
            [self asyncLoadPhotoWithView:cell.btnImg3 requestUrl:url2];
            cell.btnImg3.hidden=NO;
        }
        
    }
//    else{
//        UIImage *defaultImage=[UIImage imageNamed:@"null_Image"];
//        cell.btnImg1.image=defaultImage;
//        cell.btnImg1.hidden=YES;
//        cell.btnImg2.image=defaultImage;
//        cell.btnImg2.hidden=YES;
//        cell.btnImg3.image=defaultImage;
//        cell.btnImg3.hidden=YES;
//
//    }
    
    NSArray *replylist=[dicObj objectForKey:@"replylist"];
    if(replylist && ((NSNull*)replylist != [NSNull null]) && [replylist count]>0){
        NSDictionary *obj=[replylist firstObject];
        cell.lbReplyName.text=[obj objectForKey:@"reply_user_name"];
        cell.lbReplyContent.text=[obj objectForKey:@"reply_content"];
        NSString *imageUrl=[obj objectForKey:@"image_url"];
        //加载回复内容图片
        NSURL *url = [NSURL URLWithString:imageUrl];
        cell.vwReplyBodyView.hidden=NO;
        [self asyncLoadPhotoWithView:cell.lbReplyImageView requestUrl:url];
    }
    else
        cell.vwReplyBodyView.hidden=YES;
    return cell;
}
-(void)asyncLoadPhotoWithView:(UIImageView*)imgView requestUrl:(NSURL*)url{
    UIActivityIndicatorView *indicatorView=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicatorView.center=CGPointMake(imgView.frame.size.width/2, imgView.frame.size.height/2);
    [indicatorView startAnimating];
    [imgView addSubview:indicatorView];
    
//    NSURL *url = [NSURL URLWithString:[tmpArray lastObject]];
    dispatch_queue_t queue =dispatch_queue_create("loadImage",NULL);
    dispatch_async(queue, ^{
        NSData *resultData = [NSData dataWithContentsOfURL:url];
        UIImage *img = [UIImage imageWithData:resultData];
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            imgView.image=img;
            [indicatorView removeFromSuperview];
        });
        
    });
    imgView.hidden=NO;
}
-(NSString*)getWeekWith:(int)index{
    switch (index) {
        case 1:
            return @"星期一";
            break;
        case 2:
            return @"星期二";
            break;
        case 3:
            return @"星期三";
            break;
        case 4:
            return @"星期四";
            break;
        case 5:
            return @"星期五";
            break;
        case 6:
            return @"星期六";
            break;
        case 7:
            return @"星期天";
            break;
        case 0:
            return @"星期天";
            break;
        default:
            break;
    }
    return @"";
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    NSDictionary *dicObj = [self.tbList objectAtIndex:indexPath.row];
//    NSString *img = [dicObj objectForKey:@"daily_pic"];
//    if (img && img.length > 0 ) {
    
        return 176;
        
//    } else {
//        
//        return 95;
//    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    WorkRecordViewControllerCell *cell=(WorkRecordViewControllerCell*)[tableView cellForRowAtIndexPath:indexPath];
//    self.selectedCellImage=[cell.btnImg imageView].image;
    self.selectedWorkRecord = [self.tbList objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"toWorkRecordDetailViewControllerSegue" sender:nil];
    
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

-(void)showMessage:(NSString*)infomation{
    
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"信息提示" message:infomation delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
    [myAlertView show];
}

-(void)connectToNetwork{
    
    while (hubFlag) {
        usleep(100000);
    }
}
-(void)hudWasHidden:(MBProgressHUD *)hud{
    [hud removeFromSuperview];
    hud=nil;
}
-(void)refreshTableView{
    btAdd.hidden=NO;
    [self.tbView reloadData];
}
-(void)loadWorkRecordAddWithDay{
    NSMutableDictionary *bDict = [[NSMutableDictionary alloc] init];
    int userId = self.user.userID;
    [bDict setObject:[NSString stringWithFormat:@"%d",userId] forKey:@"user_id"];
    [bDict setObject:[NSNumber numberWithInt:self.user.userEnterprise] forKey:@"enterprise"];
//    kite/HamstrerServlet/shaoyang/v1_4/daily/getdailydate
//    enterprise: 2,user_id: 4

    [NetworkHandling sendPackageWithUrl:@"daily/getdailydate" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        hubFlag=NO;
        if(!error){
            
            timesArray = [result objectForKey:@"times"];
            if([timesArray count] == 0)
                [self performSelectorOnMainThread:@selector(hiddenAddButton:) withObject:[NSNumber numberWithBool:[timesArray count] == 0] waitUntilDone:YES];
            
        }else{
            
            int errorCode=[[result valueForKey:@"errorcode"] intValue];
            NSString *errorInfo=[result valueForKey:@"errorinf"];
            if(!errorInfo)
                errorInfo=@"提交数据出错了！";
            NSLog(@"error:%d info:%@",errorCode,errorInfo);
            [self performSelectorOnMainThread:@selector(showMessage:) withObject:errorInfo waitUntilDone:YES];
        }
        
    }];
}
-(void)hiddenAddButton:(NSNumber*)flag{
    btAdd.hidden=[flag boolValue];
}
-(void)loadWorkRecordData{
    
    /*
     当日日报表信息或月日报信息接口
     shaoyang\v1_4\daily\onedailyinfo
     必传参数
     user_id 日报上传人员id
     非必传参数
     daily_date 日报时间 如果没有传这个参数则是读取当月的当日报上传人员所有日报信息
     
     */
    
    NSMutableDictionary *bDict = [[NSMutableDictionary alloc] init];
    int userId = self.user.userID;
    [bDict setObject:[NSString stringWithFormat:@"%d",userId] forKey:@"user_id"];
    //    [bDict setObject:@"2015-01-17" forKey:@"daily_date"];

//    [NetworkHandling sendPackageWithUrl:@"HamstrerServlet/shaoyang/v1_4/daily/onedailyinfo" sendBody:bDict sendWithPostType:0 processHandler:^(NSDictionary *result, NSError *error) {
    [NetworkHandling sendPackageWithUrl:@"daily/onedailyinfo" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        hubFlag=NO;
        if(!error){
            
            self.tbList = [result objectForKey:@"dailys"];
//            if (self.tbList && self.tbList.count > 0) {
            
                [self performSelectorOnMainThread:@selector(refreshTableView) withObject:@"" waitUntilDone:YES];
                
//            } else {
//                
//                ;
//            }
           
        
        }else{
            
            int errorCode=[[result valueForKey:@"errorcode"] intValue];
            NSString *errorInfo=[result valueForKey:@"errorinf"];
            if(!errorInfo)
                errorInfo=@"提交数据出错了！";
            NSLog(@"error:%d info:%@",errorCode,errorInfo);
            [self performSelectorOnMainThread:@selector(showMessage:) withObject:errorInfo waitUntilDone:YES];
        }
        
    }];
    
}
- (IBAction)goWorkRecordListOfWeek:(id)sender {
    
    [self performSegueWithIdentifier:@"toWorkRecordListViewControllerSegue" sender:self];
}


@end
