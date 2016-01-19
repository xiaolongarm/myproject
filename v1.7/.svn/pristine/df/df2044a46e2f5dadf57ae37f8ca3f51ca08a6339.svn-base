//
//  WorkRecordDetailViewController.m
//  CMCCMarketing
//
//  Created by gmj on 15-1-27.
//  Copyright (c) 2015年 talkweb. All rights reserved.
//

#import "WorkRecordDetailViewController.h"

#import "WorkRecordAddViewController.h"

#import "NetworkHandling.h"
#import "MBProgressHUD.h"
#import "ManagerWorkRecordReplyListTableViewCell.h"
#import "WorkRecordViewController.h"

@interface WorkRecordDetailViewController (){
    
    BOOL hubFlag;
    NSArray *replylist;
}

@end

@implementation WorkRecordDetailViewController

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
    if (self.whereFrom==22) {
        [self getDetailDailyReport];
    }
    else{
        [self initController];
    }
}
-(void)initController
{
    replylist=[self.selectedWorkRecord objectForKey:@"replylist"];
    tbView.delegate=self;
    tbView.dataSource=self;
    tbView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    self.lblDate.text = [self.selectedWorkRecord objectForKey:@"daily_date"];
    NSInteger st = [[self.selectedWorkRecord objectForKey:@"daily_sta"] intValue];
    if (st == 0) {
        self.lblState.text = @"未点评";
    } else {
        
        self.lblState.text = @"已点评";
        
        btDelete.hidden=YES;
        btEdit.hidden=YES;
    }
    self.txtViewContent.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.txtViewContent.layer.borderWidth=0.3f;
    self.txtViewContent.text = [self.selectedWorkRecord objectForKey:@"daily_content"];
    NSString *imgUrl=[self.selectedWorkRecord objectForKey:@"daily_pic"];
    
    NSArray *tmpArray=[imgUrl componentsSeparatedByString:@","];
    
    //    if(!self.uploadImage && imgUrl){
    //        UIActivityIndicatorView *indicatorView=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    //        indicatorView.center=CGPointMake(imgUpload.frame.size.width/2, imgUpload.frame.size.height/2);
    //        [indicatorView startAnimating];
    //        [imgUpload addSubview:indicatorView];
    //
    //        dispatch_queue_t queue =dispatch_queue_create("loadImage",NULL);
    //        dispatch_async(queue, ^{
    //            NSData *resultData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imgUrl]];
    //            UIImage *img = [UIImage imageWithData:resultData];
    //
    //            dispatch_sync(dispatch_get_main_queue(), ^{
    //                imgUpload.image=img;
    //                self.uploadImage=imgUpload.image;
    //                [indicatorView removeFromSuperview];
    //            });
    //
    //        });
    //    }
    //    else
    //        imgUpload.image=self.uploadImage;
    
    for (NSString *url in tmpArray) {
        NSInteger i=[tmpArray indexOfObject:url];
        UIImageView *imageView;
        switch (i) {
            case 0:
                imageView=imgUpload1;
                break;
            case 1:
                imageView=imgUpload2;
                break;
            case 2:
                imageView=imgUpload3;
                break;
            default:
                imageView=imgUpload1;
                break;
        }
        NSString *queueName=[NSString stringWithFormat:@"loadImage%d",i];
        const char *qn=[queueName cStringUsingEncoding:NSUTF8StringEncoding];
        UIActivityIndicatorView *indicatorView=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        indicatorView.center=CGPointMake(imageView.frame.size.width/2, imageView.frame.size.height/2);
        [indicatorView startAnimating];
        [imageView addSubview:indicatorView];
        
        dispatch_queue_t queue =dispatch_queue_create(qn,NULL);
        dispatch_async(queue, ^{
            NSData *resultData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
            UIImage *img = [UIImage imageWithData:resultData];
            
            dispatch_sync(dispatch_get_main_queue(), ^{
                imageView.image=img;
                [indicatorView removeFromSuperview];
            });
            
        });
        
    }
    UITapGestureRecognizer *singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap1:)];
    UITapGestureRecognizer *singleTap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap2:)];
    UITapGestureRecognizer *singleTap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap3:)];
    [imgUpload1 addGestureRecognizer:singleTap1];
    [imgUpload2 addGestureRecognizer:singleTap2];
    [imgUpload3 addGestureRecognizer:singleTap3];
    //刷新列表
    [tbView reloadData];
}
-(void)getDetailDailyReport
{
    /*
     当日日报表信息或月日报信息接口
     shaoyang\v1_4\daily\onedailyinfo
     必传参数
     user_id 日报上传人员id
     非必传参数
     daily_date 日报时间 如果没有传这个参数则是读取当月的当日报上传人员所有日报信息
     
     */
    
    NSMutableDictionary *bDict = [[NSMutableDictionary alloc] init];
//    int userId = self.user.userID;
//    [bDict setObject:[NSString stringWithFormat:@"%d",userId] forKey:@"user_id"];
    [bDict setObject:[_recipeListDict objectForKey:@"daily_user_id"] forKey:@"user_id"];
        [bDict setObject:self.recipeDateString forKey:@"daily_date"];
    
    //    [NetworkHandling sendPackageWithUrl:@"HamstrerServlet/shaoyang/v1_4/daily/onedailyinfo" sendBody:bDict sendWithPostType:0 processHandler:^(NSDictionary *result, NSError *error) {
    [NetworkHandling sendPackageWithUrl:@"daily/onedailyinfo" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        hubFlag=NO;
        if(!error){
            
           // self.tbList = [result objectForKey:@"dailys"];
            //            if (self.tbList && self.tbList.count > 0) {
            self.selectedWorkRecord=[[result objectForKey:@"dailys"] firstObject];
            [self performSelectorOnMainThread:@selector(initController) withObject:@"" waitUntilDone:YES];
            
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
-(void)handleSingleTap1:(UIGestureRecognizer *)gestureRecognizer{
    [self showPhoto:imgUpload1.image];
}
-(void)handleSingleTap2:(UIGestureRecognizer *)gestureRecognizer{
    [self showPhoto:imgUpload2.image];
}
-(void)handleSingleTap3:(UIGestureRecognizer *)gestureRecognizer{
    [self showPhoto:imgUpload3.image];
}
-(void)showPhoto:(UIImage*)image{
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    CGRect rect =self.view.frame;
    rect.origin=CGPointZero;
    button.frame=rect;
    
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button addTarget:self action:@selector(cancelShowPhoto:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}
-(void)cancelShowPhoto:(id)sender{
    UIButton *button =sender;
    [button removeFromSuperview];
    button=nil;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"toWorkRecordEditViewControllerSegue"]) {
        
        WorkRecordAddViewController *vc = segue.destinationViewController;
        vc.selectedWorkRecord = self.selectedWorkRecord;
        vc.user=self.user;
//        vc.uploadImage1=self.uploadImage;
        vc.uploadImage1=imgUpload1.image;
        vc.uploadImage2=imgUpload2.image;
        vc.uploadImage3=imgUpload3.image;
        
    } else {
        
        
        
    }
}



-(void)showMessage:(NSString*)infomation{
    
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"信息提示" message:infomation delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
    [myAlertView show];
}

-(void)connectToNetwork{
    
    while (hubFlag) {
        usleep(100000);
    }
}


- (IBAction)deleWorkRecordOnClick:(id)sender {
    
    [self deleWorkRecordData];
}

-(void) deleWorkRecordData{
    /*
    
    删除日报
    shaoyang\v1_4\daily\deldaily
    必传参数
    daily_id 日报id
     
     */
    
    NSMutableDictionary *bDict = [[NSMutableDictionary alloc] init];
    
    NSString *wrId = [self.selectedWorkRecord objectForKey:@"daily_id"];
    [bDict setObject:wrId forKey:@"daily_id"];
    
//    [NetworkHandling sendPackageWithUrl:@"HamstrerServlet/shaoyang/v1_4/daily/deldaily" sendBody:bDict sendWithPostType:0 processHandler:^(NSDictionary *result, NSError *error) {
    [NetworkHandling sendPackageWithUrl:@"daily/deldaily" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        hubFlag=NO;
        if(!error){
            
            NSLog(@"sign in success");
            BOOL flag=[[result objectForKey:@"flag"] boolValue];
            if(flag){
                
                [self performSelectorOnMainThread:@selector(deleteSuccess) withObject:nil waitUntilDone:YES];
                
            }else{
                
                [self performSelectorOnMainThread:@selector(showMessage:) withObject:@"删除失败！" waitUntilDone:YES];
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
-(void)deleteSuccess{
   // [self.navigationController popViewControllerAnimated:YES];
    for (UIViewController *temp in self.navigationController.viewControllers) {
        if ([temp isKindOfClass:[WorkRecordViewController class]]) {
            [self.navigationController popToViewController:temp animated:YES];
        }
    }

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
    
    NSDictionary *dict=[replylist objectAtIndex:indexPath.row];
    cell.itemName.text=[dict objectForKey:@"reply_user_name"];
   // cell.itemContent.text=[dict objectForKey:@"reply_content"];
    
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
@end
