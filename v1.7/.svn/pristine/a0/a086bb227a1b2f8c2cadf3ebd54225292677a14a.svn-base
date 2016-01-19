//
//  ManagerWorkRecordDetailViewController.m
//  CMCCMarketing
//
//  Created by gmj on 15-2-2.
//  Copyright (c) 2015年 talkweb. All rights reserved.
//

#import "ManagerWorkRecordDetailViewController.h"

#import "NetworkHandling.h"
#import "MBProgressHUD.h"
#import "ManagerWorkRecordReplyListTableViewCell.h"
#import "UIImageView+WebCache.h"
//#import "KeyboardExtendHandling.h"

@interface ManagerWorkRecordDetailViewController  ()<MBProgressHUDDelegate>{
    UIImageView *zoomOutImageView;
    BOOL hubFlag;
    NSArray *replylist;
    NSDictionary *daily;
//    KeyboardExtendHandling *keyboardExtendhandling;
}

@end

@implementation ManagerWorkRecordDetailViewController



-(void)showMessage:(NSString*)infomation{
    
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"信息提示" message:infomation delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
    [myAlertView show];
}

-(void)refreshTableView{
    if(!daily || ([NSNull null] == (NSNull*)daily)){
        tbView.hidden=YES;
        vwBottomBody.hidden=YES;
    }
    else{
        tbView.hidden=NO;
        vwBottomBody.hidden=NO;
    }
    /**
     从已完成列表页面过来隐藏底部和顶部
     */
    if(![_FromVisitlist count]==0)
    {
        _topView.hidden=YES;
        vwBottomBody.hidden=YES;
    }
  
    
    lbDate.text=[daily objectForKey:@"daily_date"];
   NSString *content =[daily objectForKey:@"daily_content"];
    //textView高度自适应
//    UITextView *detailView  = [[UITextView alloc]initWithFrame:CGRectMake(93, 57, 217, 0)];
//    detailView.font = [UIFont systemFontOfSize:14];
//    detailView.text = content;
//    CGSize deSize = [detailView sizeThatFits:CGSizeMake(217,CGFLOAT_MAX)];
   
    self.txtContent.scrollEnabled=YES;
    //self.txtContent.contentSize.height=CGRectGetHeight(deSize.height) ;    // self.txtContent.contentSize =CGRectMake(93, 57, 217, deSize.height);
  self.txtContent.text=content;
    //同事改变View的高度
//    CGRect rect=self.contentView.frame;
//    rect.size.height= rect.size.height + deSize.height;
//    [self.contentView setFrame:rect];
    
    BOOL daily_sta=[[daily objectForKey:@"daily_sta"] intValue];
    if(daily_sta)
        lbState.text=@"已回复";
    else
        lbState.text=@"已提交";
    
    //加载图片
    NSString *daily_pic=[daily objectForKey:@"daily_pic"];
    NSString *nsstring0=@"";
    NSString *nsstring1=@"";
    NSString *nsstring2=@"";
    NSArray *urlArray=[daily_pic componentsSeparatedByString:@","];
    if ([urlArray count]==3) {
        nsstring0=[urlArray objectAtIndex:0];
        nsstring1=[urlArray objectAtIndex:1];
        nsstring2=[urlArray objectAtIndex:2];
    }
    else if ([urlArray count]==2){
        nsstring0=[urlArray objectAtIndex:0];
        nsstring1=[urlArray objectAtIndex:1];
    }
    else if ([urlArray count]==1){
        nsstring0=[urlArray objectAtIndex:0];
    }
//    else if ([urlArray count]==0){
//        
//    }

    UIActivityIndicatorView *indicatorView=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicatorView.center=CGPointMake(imgDailyPic.frame.size.width/2, imgDailyPic.frame.size.height/2);
    [indicatorView startAnimating];
    [imgDailyPic addSubview:indicatorView];

//    NSURL *url = [NSURL URLWithString:[urlArray objectAtIndex:0]];
    dispatch_queue_t queue =dispatch_queue_create("loadImage",NULL);
    dispatch_async(queue, ^{
//        for (NSString *urlString in urlArray) {
//            urlString
//        }
        NSData *resultData0 = [NSData dataWithContentsOfURL:[NSURL URLWithString:nsstring0]];
        NSData *resultData1 = [NSData dataWithContentsOfURL:[NSURL URLWithString:nsstring1]];
        NSData *resultData2 = [NSData dataWithContentsOfURL:[NSURL URLWithString:nsstring2]];
       // UIImage *img = [UIImage imageWithData:resultData];
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            imgDailyPic.image=[UIImage imageWithData:resultData0];
            self.imgDaliyPic2.image=[UIImage imageWithData:resultData1];
           self.imgDaliyPic3.image=[UIImage imageWithData:resultData2];
            [indicatorView removeFromSuperview];
        });
        
    });
    
    replylist=[daily objectForKey:@"replylist"];
    [tbView reloadData];
}

-(void)connectToNetwork{
    
    while (hubFlag) {
        usleep(100000);
    }
}


-(void)loadWorkRecordData{
    
    hubFlag=YES;
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"数据查询中，请稍后...";
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
    
    /*
     必传参数
     user_id 写日报的用户id
     非必传参数
     daily_date 日报时间 不传的时候为查询当天
     */
     NSMutableDictionary *bDict = [[NSMutableDictionary alloc] init];
    
   // NSString *value = [_selectedWorkRecord objectForKey:@"daily_cnt"];
    if([_FromVisitlist count]==0)
    {
   // if ((NSNull *)value == [NSNull null]) {
        //从日志页面
        txtReply.text=@"";
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *dateString=[dateFormatter stringFromDate:self.selectDate];
        
        NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
        [dateFormatter1 setDateFormat:@"MM月dd日"];
        NSString *dateShortString=[dateFormatter1 stringFromDate:self.selectDate];
        lbSearchDate.text=dateShortString;
        
       
        NSString *daily_user_id = [self.selectedWorkRecord objectForKey:@"daily_user_id"];
        [bDict setObject:daily_user_id forKey:@"user_id"];
        [bDict setObject:dateString forKey:@"daily_date"];
    } else {
        //从拜访计划完成页面过来
    [bDict setObject:[_FromVisitlist objectForKey:@"user_id"] forKey:@"user_id"];
        [bDict setObject:[_FromVisitlist objectForKey:@"time"] forKey:@"daily_date"];
    }
    
//    

    [NetworkHandling sendPackageWithUrl:@"daily/onedailyinfo" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        hubFlag=NO;
        
        if(!error){
            NSLog(@"sign in success");
            
            NSArray *dailys = [result objectForKey:@"dailys"];
            daily=[dailys firstObject];
            [self performSelectorOnMainThread:@selector(refreshTableView) withObject:nil waitUntilDone:YES];
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






- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)goBack{
    
    //[self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    if(IOS7)
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"320X64"] forBarMetrics:UIBarMetricsDefault];
    else
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"320X44"] forBarMetrics:UIBarMetricsDefault];
    
    self.navigationItem.title = @"工作日报详情";
    UIBarButtonItem *leftButton=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回1"] style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    [leftButton setTintColor:[UIColor whiteColor]];
    [self.navigationItem setLeftBarButtonItem:leftButton];
    
    UIColor * color = [UIColor whiteColor];
    NSDictionary * dict=[NSDictionary dictionaryWithObject:color forKey:UITextAttributeTextColor];
    [self.navigationController.navigationBar setTitleTextAttributes:dict];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];

    /**
     *  查看大图方法
     */
    CGSize size =[[UIScreen mainScreen] bounds].size;
    zoomOutImageView = [[UIImageView alloc] init];
    zoomOutImageView.frame = CGRectMake(0, 0, size.width, size.height);
    zoomOutImageView.backgroundColor=[UIColor blackColor];
    [zoomOutImageView setUserInteractionEnabled:YES];
    UITapGestureRecognizer *singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap1:)];
    [zoomOutImageView addGestureRecognizer:singleTap1];

    
    tbView.delegate=self;
    tbView.dataSource=self;
    tbView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    txtReply.delegate=self;
    [self loadWorkRecordData];
    
    lbDate.text=@"";
    lbState.text=@"";
//    lbContent.text=@"";
    _txtContent.text=@"";
    /**
     从已完成列表页面过来隐藏底部和顶部
     */
    if(![_FromVisitlist count]==0)
    {
        _topView.hidden=YES;
        vwBottomBody.hidden=YES;
    }

//    keyboardExtendhandling=[[KeyboardExtendHandling alloc]initKeyboardHangling:self.view];
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
- (IBAction)preDateOnclick:(id)sender {
    NSTimeInterval weekInterval = 1 * 24 * 60 * 60;
    self.selectDate = [self.selectDate dateByAddingTimeInterval: -weekInterval];
    [self loadWorkRecordData];

}
- (IBAction)nextDateOnclick:(id)sender {
    NSTimeInterval weekInterval = 1 * 24 * 60 * 60;
    self.selectDate = [self.selectDate dateByAddingTimeInterval: weekInterval];
    [self loadWorkRecordData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [replylist count] ;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UILabel *itemContent = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 218, 80)];
    //自适应高度
    NSDictionary *dict=[replylist objectAtIndex:indexPath.row];
    itemContent.numberOfLines = 0;
    itemContent.font = [UIFont systemFontOfSize:15];
    itemContent.text = [dict objectForKey:@"reply_content"];
    [itemContent sizeToFit];
    
    return itemContent.frame.size.height+60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ManagerWorkRecordReplyListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ManagerWorkRecordReplyListTableViewCell" forIndexPath:indexPath];

    
    /*
     {
     "daily_id" = 56;
     "image_url" = "http://appbox.talkyun.com/kite/uploadImage/OrderBusiness/personInfo/2.jpg?t=1416282246909";
     "reply_content" = "\U6253\U6270\U4e86";
     "reply_date" = "2015-02-03 16:47:54";
     "reply_msisdn" = 13467657275;
     "reply_user_id" = 2;
     "reply_user_name" = "\U674e\U5929\U7693";
     }
     */
    NSDictionary *dict=[replylist objectAtIndex:indexPath.row];
    cell.itemName.text=[dict objectForKey:@"reply_user_name"];
    //cell.itemContent.text=[dict objectForKey:@"reply_content"];
    UILabel *itemContent = (UILabel *)[cell.contentView viewWithTag:111];
    if (!itemContent) {
        itemContent = [[UILabel alloc] initWithFrame:CGRectMake(62, 28, 218, 20)];
        itemContent.numberOfLines = 0;
        itemContent.font = [UIFont systemFontOfSize:15];
        [itemContent setTextColor:[UIColor darkGrayColor]];
        itemContent.text = [dict objectForKey:@"reply_content"];
        [itemContent sizeToFit];
        // itemContent.textColor = [UIColor colorWithRed:107/255.0f green:107/255.0f blue:107/255.0f alpha:1];
        itemContent.tag = 111;
        //自适应高度
        [cell.contentView addSubview:itemContent];
    }

    UIActivityIndicatorView *indicatorView=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicatorView.center=CGPointMake(cell.itemImageView.frame.size.width/2, cell.itemImageView.frame.size.height/2);
    [indicatorView startAnimating];
    [cell.itemImageView addSubview:indicatorView];
    
    NSString *image_url=[dict objectForKey:@"image_url"];
    NSURL *url = [NSURL URLWithString:image_url];
    dispatch_queue_t queue =dispatch_queue_create("loadImage",NULL);
    dispatch_async(queue, ^{
        NSData *resultData = [NSData dataWithContentsOfURL:url];
        UIImage *img = [UIImage imageWithData:resultData];
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            cell.itemImageView.image=img;
            [indicatorView removeFromSuperview];
        });
        
    });
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
- (IBAction)replyOnclick:(id)sender {
    [txtReply resignFirstResponder];
    hubFlag=YES;
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"数据查询中，请稍后...";
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
    
    /*
     reply_user_id:user.userID,                    
     reply_user_name:utils.chinese2unicode(user.userName),
     reply_msisdn:user.mobile,
     daily_id: this.detail.daily_id,
     reply_content:utils.chinese2unicode(replyContent)
     */
    
    NSMutableDictionary *bDict = [[NSMutableDictionary alloc] init];
    
    int daily_id=[[daily objectForKey:@"daily_id"] intValue];
    
    [bDict setObject:[NSNumber numberWithInt:self.user.userID] forKey:@"reply_user_id"];
    [bDict setObject:self.user.userName forKey:@"reply_user_name"];
    [bDict setObject:self.user.userMobile forKey:@"reply_msisdn"];
    [bDict setObject:[NSNumber numberWithInt:daily_id] forKey:@"daily_id"];
    [bDict setObject:txtReply.text forKey:@"reply_content"];
    

    [NetworkHandling sendPackageWithUrl:@"daily/adddailyplanreply" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        hubFlag=NO;
        
        if(!error){
            NSLog(@"sign in success");
            
            BOOL flag = [[result objectForKey:@"flag"] boolValue];
            if(flag){
                [self performSelectorOnMainThread:@selector(loadWorkRecordData) withObject:nil waitUntilDone:YES];
            }
            else{
                NSString *errorInfo=@"回复失败！";
                [self performSelectorOnMainThread:@selector(showMessage:) withObject:errorInfo waitUntilDone:YES];
            }
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
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
        CGRect rect=self.view.frame;
        rect.origin.y-=260;
        self.view.frame=rect;
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
        CGRect rect=self.view.frame;
        rect.origin.y+=260;
        self.view.frame=rect;
}
#pragma mark -查看大图

- (IBAction)onclickZoomOutPic:(id)sender {
    if(!self->imgDailyPic.image)
        return;
    
    zoomOutImageView.image=self->imgDailyPic.image;
    zoomOutImageView.contentMode=UIViewContentModeScaleAspectFit;
    [self.navigationController.view addSubview:zoomOutImageView];

}

- (IBAction)onclickZoomOutPic2:(id)sender {
    if(!self.imgDaliyPic2.image)
        return;
    
    zoomOutImageView.image=self.imgDaliyPic2.image;
    zoomOutImageView.contentMode=UIViewContentModeScaleAspectFit;
    [self.navigationController.view addSubview:zoomOutImageView];

}

- (IBAction)onclickZoomOutPic3:(id)sender {
    if(!self.imgDaliyPic3.image)
        return;
    
    zoomOutImageView.image=self.imgDaliyPic3.image;
    zoomOutImageView.contentMode=UIViewContentModeScaleAspectFit;
    [self.navigationController.view addSubview:zoomOutImageView];

}
-(void)handleSingleTap1:(UIGestureRecognizer *)gestureRecognizer{
    [zoomOutImageView removeFromSuperview];
}
#pragma mark -textView高度自适应
- (float) heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width
{
    UITextView *detailTextView = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, width, 0)];
    detailTextView.font = [UIFont systemFontOfSize:fontSize];
    detailTextView.text = value;
    CGSize deSize = [detailTextView sizeThatFits:CGSizeMake(width,CGFLOAT_MAX)];
    return deSize.height;
}

@end
