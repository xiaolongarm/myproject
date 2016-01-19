//
//  W_VisitPlanMessageTableViewController.m
//  CMCCMarketing
//
//  Created by gmj on 14-12-3.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import "W_VisitPlanMessageTableViewController.h"
#import "W_VisitPlanDetailsViewController.h"

#import "NetworkHandling.h"
#import "MBProgressHUD.h"

@interface W_VisitPlanMessageTableViewController ()<MBProgressHUDDelegate>{
    
    BOOL hubFlag;
}

@end

@implementation W_VisitPlanMessageTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self initSubPage];
}

- (void) initSubPage{
    
    self.navigationItem.title = @"提醒消息";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.tableList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"W_VisitPlanMessageTableViewControllerCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:CellIdentifier owner:self options:nil] objectAtIndex:0];
    }

    UIImageView *imgimage_url = (UIImageView *)[cell viewWithTag:100];
    UILabel *lbltype = (UILabel *)[cell viewWithTag:200];
    UILabel *lbltime = (UILabel *)[cell viewWithTag:300];
    UILabel *lblvisit_remark = (UILabel *)[cell viewWithTag:400];
    UILabel *lblexamine_user_name = (UILabel *)[cell viewWithTag:500];

    NSUInteger r = [indexPath row];
    NSDictionary *dicObj = [self.tableList objectAtIndex:r];
    
    NSString *type = [dicObj objectForKey:@"type"];
    NSString *image_url = @"";
    NSString *time = @"";
    NSString *examine_user_name = @"";
    NSString *visit_remark = @"";

    if ([type isEqualToString:@"examine"]) {
        
        lbltype.text = @"审核";
        
        image_url = [dicObj objectForKey:@"image_url"];
        time = [dicObj objectForKey:@"time"];
        visit_remark = [dicObj objectForKey:@"visit_examine_result"];//
        if ((NSNull *)visit_remark == [NSNull null]) {
            
            visit_remark = @"";
        }
        examine_user_name = [dicObj objectForKey:@"examine_user_name"];
        
        
    } else if([type isEqualToString:@"reply"]){
        
        lbltype.text = @"回复";
        
        image_url = [dicObj objectForKey:@"image_url"];
        time = [dicObj objectForKey:@"time"];
        visit_remark = [dicObj objectForKey:@"reply_content"];
        if ((NSNull *)visit_remark == [NSNull null]) {
            
            visit_remark = @"";
        }
        examine_user_name = [dicObj objectForKey:@"reply_name"];
        
        
    } else if([type isEqualToString:@"visit"]){
        
//        lbltype.text = @"拜访";
        lbltype.adjustsFontSizeToFitWidth=YES;
        lbltype.text = [dicObj objectForKey:@"visit_grp_name"];
        image_url = [dicObj objectForKey:@"image_url"];
        time = [dicObj objectForKey:@"time"];
        visit_remark = [dicObj objectForKey:@"visit_remark"];
        if ((NSNull *)visit_remark == [NSNull null]) {
            
            visit_remark = @"";
        }
        examine_user_name = [dicObj objectForKey:@"examine_user_name"];
        
    }
    
    
    if ((NSNull *)image_url == [NSNull null]) {
        
        image_url = @"";
    }

    if (image_url && image_url.length>0) {
        
        NSURL *url = [NSURL URLWithString:image_url];
        dispatch_queue_t queue =dispatch_queue_create("loadImage",NULL);
        dispatch_async(queue, ^{
            
            NSData *resultData = [NSData dataWithContentsOfURL:url];
            UIImage *img = [UIImage imageWithData:resultData];
            
            dispatch_sync(dispatch_get_main_queue(), ^{
                
                imgimage_url.image = img;
            });
            
        });
        
    }else{
        
        ;
    }
    
    if ((NSNull *)time == [NSNull null]) {
        
        time = @"";
    }
    
    if ((NSNull *)examine_user_name == [NSNull null]) {
        
        examine_user_name = @"";
    }
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date=[dateFormatter dateFromString:time];
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    [dateFormatter1 setDateFormat:@"MM-dd HH:mm"];
    
    NSString *ttimeString=[dateFormatter1 stringFromDate:date];
    lbltime.text = ttimeString;
    lblvisit_remark.text = visit_remark;
    lblexamine_user_name.text = examine_user_name;
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    NSString *row_id =
    NSDictionary *dicMessage = [self.tableList objectAtIndex:indexPath.row];
    NSString *type = [dicMessage objectForKey:@"type"];
    NSString *vid ;
    if ([type isEqualToString:@"examine"]) {
        
        vid = [dicMessage objectForKey:@"row_id"] ;
        
        
    } else if([type isEqualToString:@"reply"]){//
        
        vid = [dicMessage objectForKey:@"visit_id"];//
        
        
    } else if([type isEqualToString:@"visit"]){
        
        vid = [dicMessage objectForKey:@"row_id"];
        
    }
    
//    int rowid=[[dicMessage objectForKey:@"visit_id"] intValue];
    
    /** W_VisistPlanSummaryViewController *vc = [[W_VisistPlanSummaryViewController alloc] initWithNibName:@"W_VisistPlanSummaryViewController" bundle:nil];
     vc.user = self.user;
     vc.dicSelectVisitPlanDetail = self.dicSelectVisitPlanDetail;
     [self.navigationController pushViewController:vc animated:YES];
**/
    //跳转到详情页面
    W_VisitPlanDetailsViewController *DetailView = [[W_VisitPlanDetailsViewController alloc] initWithNibName:@"W_VisitPlanDetailsViewController" bundle:nil];
    //传递参数，
    DetailView.passVisitID=vid;
    DetailView.user=self.user;
    DetailView.fromMessage=@"1";
    DetailView.messagePassDict = dicMessage;
     [self.navigationController pushViewController:DetailView animated:YES];
    //kevin----
//    [self.navigationController popViewControllerAnimated:NO];
//    [self.delegate w_visitPlanMessageTableViewControllerGoDetails:vid];
    
    
}

//-(void)toW_VisitPlanDetailsViewController:(NSString *)obj{
//    
//    W_VisitPlanDetailsViewController *vc = [[W_VisitPlanDetailsViewController alloc] initWithNibName:@"W_VisitPlanDetailsViewController" bundle:nil];
//    vc.dicSelectVisitPlanDetail = [self.visitPlanList objectAtIndex:0];
//    vc.user = self.user;
//    [self.navigationController pushViewController:vc animated:YES];
//    
//}

-(void)showMessage:(NSString*)infomation{
    
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"信息提示" message:infomation delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
    [myAlertView show];
}

-(void)refreshvisitPlanTableView{
    
    [self.tableView reloadData];
}

//-(void)connectToNetwork{
//    
//    while (hubFlag) {
//        usleep(100000);
//    }
//}

//-(void)loadVisitPlanListData:(NSString *)visit_id{
//    
//    hubFlag=YES;
//    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
//    [self.view addSubview:HUD];
//    HUD.delegate=self;
//    HUD.labelText=@"数据查询中，请稍后...";
//    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
//    
//    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
//    [bDict setObject:[NSNumber numberWithInt:self.user.userLvl] forKey:@"user_lvl"];
//    [bDict setObject:[NSNumber numberWithInt:self.user.userID] forKey:@"user_id"];
//    [bDict setObject:self.user.userMobile forKey:@"user_msisdn"];
//    [bDict setObject:[NSNumber numberWithInt:self.user.userEnterprise] forKey:@"enterprise"];
//    [bDict setObject:visit_id forKey:@"visit_id"];
//    
//    [NetworkHandling sendPackageWithUrl:@"visitplan/visitplanlist" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
//        
//        if(!error){
//            
//            NSLog(@"sign in success");
//            self.visitPlanList =[result objectForKey:@"visit"];
//            if (self.visitPlanList.count >0) {
//                
//                [self performSelectorOnMainThread:@selector(toW_VisitPlanDetailsViewController:) withObject:nil waitUntilDone:YES];
//            }
//            
//            
//        }else{
//            int errorCode=[[result valueForKey:@"errorcode"] intValue];
//            NSString *errorInfo=[result valueForKey:@"errorinf"];
//            NSLog(@"error:%d info:%@",errorCode,errorInfo);
//            [self performSelectorOnMainThread:@selector(showMessage:) withObject:errorInfo waitUntilDone:YES];
//        }
//        hubFlag=NO;
//    }];
//}

@end
