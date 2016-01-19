//
//  ChagangMonitorStaffListTableViewController.m
//  CMCCMarketing
//
//  Created by talkweb on 14-12-22.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import "ChagangMonitorStaffListTableViewController.h"
#import "ChagangMonitorStaffListTableViewCell.h"
#import "NetworkHandling.h"
#import "MBProgressHUD.h"

@interface ChagangMonitorStaffListTableViewController ()<MBProgressHUDDelegate>{
    BOOL hubFlag;
//    NSMutableArray *tableArray;
    double angle;
    UIImageView *animationView;
    BOOL animationFlag;
}

@end

@implementation ChagangMonitorStaffListTableViewController

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
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
//    hubFlag=YES;
//    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
//    [self.view addSubview:HUD];
//    HUD.delegate=self;
//    HUD.labelText=@"获取电子围栏信息，请稍后...";
//    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
//    [self loadUserWarningInformation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.staffList count];
//    return [tableArray count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}
//gps_sta gps位置上传状态 0正常 1关闭gps 2关闭网络 3未登
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"ChagangMonitorStaffListTableViewCell";
    ChagangMonitorStaffListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[ChagangMonitorStaffListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }

//    ChagangMonitorStaffListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChagangMonitorStaffListTableViewCell" forIndexPath:indexPath];
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    NSDictionary *dict=[self.staffList objectAtIndex:indexPath.row];
    //防止重复引用
     cell.holiday.text=@"";
    
    cell.itemName.text=[dict objectForKey:@"userName"];
    int userId=[[dict objectForKey:@"userID"] intValue];
    int managerrole=[[dict objectForKey:@"mngr_role"] intValue];
    
    if(userId==-999){
        cell.itemImageView.image=[UIImage imageNamed:@"群体图标"];
        cell.itemStateImageView.hidden=YES;
        cell.itemWarningImageView.image=[UIImage imageNamed:@"刷新"];
        animationView=cell.itemWarningImageView;
    }
    else{
        
        cell.itemWarningImageView.image=[UIImage imageNamed:@"监控－warning-icon"];
        
        BOOL is_check_in=[[dict objectForKey:@"is_check_in"] boolValue];
        //判断经理的类型，暂时加入营销1，区域4
        if (managerrole ==4) {
            if(is_check_in)
                cell.itemImageView.image=[UIImage imageNamed:@"区域经理头像"];
            else
                cell.itemImageView.image=[UIImage imageNamed:@"区域经理头像未签到"];
        }
        else
        {
            if(is_check_in)
                cell.itemImageView.image=[UIImage imageNamed:@"客户经理"];
            else
                cell.itemImageView.image=[UIImage imageNamed:@"客户经理(红色）"];
        }
        
        
        BOOL is_warn_gps=[[dict objectForKey:@"is_warn_gps"] boolValue];
        cell.itemWarningImageView.hidden=!is_warn_gps;
        
        int gps_sta=[[dict objectForKey:@"gps_sta"] intValue];
        
        switch (gps_sta) {
            case 0:
                cell.itemStateImageView.hidden=YES;
                break;
            case 1:
                cell.itemStateImageView.hidden=NO;
                cell.itemStateImageView.image=[UIImage imageNamed:@"GPS上传关闭"];
                break;
            case 2:
                cell.itemStateImageView.hidden=NO;
                cell.itemStateImageView.image=[UIImage imageNamed:@"没有网络"];
                break;
            case 3:
                cell.itemStateImageView.hidden=NO;
                cell.itemStateImageView.image=[UIImage imageNamed:@"未登录"];
                break;
                
            default:
                break;
        }
        /**
         *  增加请假显示
         */
        int isHoliday=[[dict objectForKey:@"is_holiday"] intValue];
        if(isHoliday==1){
            cell.holiday.text=@"请假";
        }

    }
    
    
    
    //人员头像－单个－红色  member-icon-un
    
    
    cell.itemLocusQueryButton.tag=indexPath.row;
    [cell.itemLocusQueryButton addTarget:self action:@selector(locusQueryOnclick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.itemLocusQueryButton addTarget:self action:@selector(locusQueryTouchDown:) forControlEvents:UIControlEventTouchDown];
    [cell.itemLocusQueryButton addTarget:self action:@selector(locusQueryTouchUp:) forControlEvents:UIControlEventTouchUpOutside];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    NSDictionary *dict=[self.staffList objectAtIndex:indexPath.row];
    BOOL is_warn_gps=[[dict objectForKey:@"is_warn_gps"] boolValue];
    int userId=[[dict objectForKey:@"userID"] intValue];
    if(is_warn_gps){
//        [self loadUserWarningById:userId];
        [self.delegate chagangMonitorStaffListTableViewControllerDidShowWarningDetails:userId];
    }
//    else{
        self.selectDict=[self.staffList objectAtIndex:indexPath.row];
        [self.delegate chagangMonitorStaffListTableViewControllerDidSelected:self];
//    }
    
    if(userId==-999){
//        animationFlag=YES;
//        [self startAnimation];
        [self rotate360WithDuration:0.5 repeatCount:3];
////        [self.delegate chagangMonitorStaffListTableViewControllerDidRefreshAllData];
    }
}

-(void)locusQueryOnclick:(id)sender{
    UIButton *button=sender;
    self.selectDict=[self.staffList objectAtIndex:button.tag];
    [self.delegate chagangMonitorStaffListTableViewControllerDidLocusQuery:self];
    [button superview].backgroundColor=[UIColor darkGrayColor];
}
-(void)locusQueryTouchDown:(id)sender{
    UIButton *button=sender;
    [button superview].backgroundColor=[UIColor blackColor];
}
-(void)locusQueryTouchUp:(id)sender{
    UIButton *button=sender;
    [button superview].backgroundColor=[UIColor darkGrayColor];
}

//-(void)loadUserWarningInformation{
//    
//    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
//    [bDict setObject:[NSNumber numberWithInt:self.user.userID] forKey:@"userID"];
//    [bDict setObject:[NSNumber numberWithInt:self.user.userEnterprise] forKey:@"enterprise"];
//    
//    [NetworkHandling sendPackageWithUrl:@"monitor/LeaderPostMonitor" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
//        
//        if(!error){
//            NSLog(@"sign in success");
//            NSDictionary *inforDict=[result objectForKey:@"Response"];
//            [self performSelectorOnMainThread:@selector(refreshUserWarning:) withObject:[inforDict objectForKey:@"detail"] waitUntilDone:YES];
//        }
//        else{
//            int errorCode=[[result valueForKey:@"errorcode"] intValue];
//            NSString *errorInfo=[result valueForKey:@"errorinf"];
//            NSLog(@"error:%d info:%@",errorCode,errorInfo);
//            [self performSelectorOnMainThread:@selector(showMessage:) withObject:errorInfo waitUntilDone:YES];
//        }
//        hubFlag=NO;
//    }];
//}
//-(void)refreshUserWarning:(NSArray*)staffList{
//    
//    tableArray=[[NSMutableArray alloc] initWithArray:staffList];
//    NSMutableDictionary *dict=[[NSMutableDictionary alloc] initWithDictionary:[staffList objectAtIndex:0]];
//    [dict setObject:[NSNumber numberWithInt:-999] forKey:@"userID"];
//    [dict setObject:@"全部成员" forKey:@"userName"];
//    [tableArray insertObject:dict atIndex:0];
//    [self.tableView reloadData];
//    
//}
-(void)connectToNetwork{
    while (hubFlag) {
        usleep(100000);
    }
}
-(void)showMessage:(NSString*)infomation{
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"信息提示" message:infomation delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
    [myAlertView show];
}
-(void)hudWasHidden:(MBProgressHUD *)hud{
    [hud removeFromSuperview];
    hud=nil;
}

-(void) startAnimation
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.001];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(endAnimation)];
    animationView.transform = CGAffineTransformMakeRotation(angle * (M_PI / 180.0f));
    [UIView commitAnimations];
}

-(void)endAnimation
{
    angle += 10;
    if(animationFlag)
        [self startAnimation];
}
- (void)startAnimationWithBlock
{
    CGAffineTransform endAngle = CGAffineTransformMakeRotation(angle * (M_PI / 180.0f));
    
    [UIView animateWithDuration:0.01 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        animationView.transform = endAngle;
    } completion:^(BOOL finished) {
        angle += 10; [self startAnimationWithBlock];
    }];
    
}
- (void)rotate360WithDuration:(CGFloat)aDuration repeatCount:(CGFloat)aRepeatCount{
	CAKeyframeAnimation *theAnimation = [CAKeyframeAnimation animation];
	theAnimation.values = [NSArray arrayWithObjects:
						   [NSValue valueWithCATransform3D:CATransform3DMakeRotation(0, 0,0,1)],
						   [NSValue valueWithCATransform3D:CATransform3DMakeRotation(3.13, 0,0,1)],
						   [NSValue valueWithCATransform3D:CATransform3DMakeRotation(6.26, 0,0,1)],
						   nil];
	theAnimation.cumulative = YES;
	theAnimation.duration = aDuration;
	theAnimation.repeatCount = aRepeatCount;
	theAnimation.removedOnCompletion = YES;
	
    theAnimation.timingFunctions = [NSArray arrayWithObjects:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn],
                                    [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut],
                                    nil
                                    ];

	[animationView.layer addAnimation:theAnimation forKey:@"transform"];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
