//
//  W_VisitPlanDetailsViewController.m
//  CMCCMarketing
//
//  Created by gmj on 14-11-25.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import "W_VisitPlanDetailsViewController.h"

#import "NetworkHandling.h"
#import "MBProgressHUD.h"
#import "W_VisistPlanSummaryViewController.h"
#import "VariableStore.h"
#import "UIImageView+WebCache.h"
#import "Toast+UIView.h"

@interface W_VisitPlanDetailsViewController ()<MBProgressHUDDelegate,UITextViewDelegate>{
    
    __weak IBOutlet UILabel *lbCNameTitle;
    BOOL hubFlag;
    UIImageView *zoomOutImageView;

}

@end

@implementation W_VisitPlanDetailsViewController


#pragma mark - notification handler

- (void)keyboardWillChangeFrame:(NSNotification *)notification{
    NSLog(@"%@",notification.userInfo);
    
    // 获取窗口的高度
    
    CGFloat windowH = [UIScreen mainScreen].bounds.size.height;
    

    // 键盘结束的Frm
    CGRect kbEndFrm = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    // 获取键盘结束的y值
    CGFloat kbEndY = kbEndFrm.origin.y;
    self.DviewBottomConst.constant = windowH - kbEndY;
//    NSDictionary *info = [notification userInfo];
//    CGFloat duration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
//    CGRect beginKeyboardRect = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
//    CGRect endKeyboardRect = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
//    CGFloat yOffset = endKeyboardRect.origin.y - beginKeyboardRect.origin.y;
//    CGRect rctViewSendBg = self.viewFoot.frame;
//    rctViewSendBg.origin.y += yOffset;
//    [UIView animateWithDuration:duration animations:^{
//        self.viewFoot.frame = rctViewSendBg;
//    }];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
    
}
-(void)goEdit{
    W_VisistPlanSummaryViewController *vc = [[W_VisistPlanSummaryViewController alloc] initWithNibName:@"W_VisistPlanSummaryViewController" bundle:nil];
    vc.user = self.user;
    vc.dicSelectVisitPlanDetail = self.dicSelectVisitPlanDetail;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
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
    
    self.txtReplyContent.delegate=self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
//    self.txtFieldReply.delegate = self;
    self.tbViewReply.delegate =self;
    self.tbViewReply.dataSource = self;
    
//    lbCNameTitle.text=[NSString stringWithFormat:@"%@：",[VariableStore getCustomerManagerName]];
//    
//#if (defined STANDARD_CS_VERSION) || (defined STANDARD_SY_VERSION)
//    int visit_sta = [[self.dicSelectVisitPlanDetail objectForKey:@"visit_sta"] intValue];
//    if(visit_sta != 3){
//        UIBarButtonItem *rightButton=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"编辑1"] style:UIBarButtonItemStylePlain target:self action:@selector(goEdit)];
//        [rightButton setTintColor:[UIColor whiteColor]];
//        [self.navigationItem setRightBarButtonItem:rightButton];
//    }
//#endif
    //从提醒消息界面过来要请求数据
    if ([self.fromMessage isEqualToString:@"1"]) {
        [self loadDetailData];
        //[self initSubView];
    }
   else
   {
         [self initSubView];
       [self loadReplayListData:@""];
   }
    
 
  // [self loadReplayListData:@""];
    
    self.tbViewReply.separatorStyle= UITableViewCellSeparatorStyleNone;
}

- (void)initSubView{
    
    
    
    self.navigationItem.title = @"拜访计划详情";
   
  
    self.lblvisit_grp_name.text = [self.dicSelectVisitPlanDetail objectForKey:@"visit_grp_name"];
    self.lblvisit_statr_time.text = [self.dicSelectVisitPlanDetail objectForKey:@"visit_statr_time"];
    self.lblvisit_end_time.text = [self.dicSelectVisitPlanDetail objectForKey:@"visit_end_time"];
    self.lblvisit_grp_add.text = [self.dicSelectVisitPlanDetail objectForKey:@"visit_grp_add"];
    self.lblvisit_grp_add.adjustsFontSizeToFitWidth=YES;
    self.lbllinkman.text = [self.dicSelectVisitPlanDetail objectForKey:@"linkman"];
    self.lblvip_mngr_name.text = [self.dicSelectVisitPlanDetail objectForKey:@"vip_mngr_name"];
    
    //陪同人员
    NSArray *accmanArray=[self.dicSelectVisitPlanDetail objectForKey:@"accman"];
    NSString *accmanString=@"";
    for (NSDictionary *dict in accmanArray) {
        accmanString = [accmanString stringByAppendingFormat:@"%@,",[dict objectForKey:@"name"]];
    }
    if([accmanString length]>1)
        accmanString=[accmanString substringToIndex:[accmanString length]-1];
    self.lbAccman.text=accmanString;
    
    int va = [[self.dicSelectVisitPlanDetail objectForKey:@"visit_sta"] intValue];
    if(va == 2){
        self.lbCheckInTimeTitle.hidden=NO;
        self.lbCheckInTime.hidden=NO;
        self.lbCheckInAddressTitle.hidden=NO;
         self.lbCheckInAddress.hidden=NO;
        self.lbCheckOutTimeTitle.hidden=NO;
        self.lbCheckOutTime.hidden=NO;
        self.lbRemarkTitle.hidden=NO;
        self.lbRemark.hidden=NO;
        /**
         *  已完成拜访计划隐藏开始结束时间
         */
        self.lblvisit_statr_time.hidden=YES;
        self.lblvisit_end_time.hidden=YES;
        self.dispStartTime.hidden=YES;
        self.dispEndTime.hidden=YES;
        
        self.lbCheckInTimeTitle.text=@"签到时间：";
        self.lbCheckInTime.text=[self.dicSelectVisitPlanDetail objectForKey:@"client_date0"];
        self.lbCheckInAddress.text=[self.dicSelectVisitPlanDetail objectForKey:@"signin_addr0"];
        self.lbCheckOutTime.text=[self.dicSelectVisitPlanDetail objectForKey:@"client_date1"];
        
                NSString *visit_remark =[self.dicSelectVisitPlanDetail objectForKey:@"visit_remark"];
       if(visit_remark && (NSNull*)visit_remark != [NSNull null])
            self.lbRemark.text=visit_remark;
       // self.lbRemark.textColor =[UIColor redColor];
       //self.lbRemark = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 231,21)];
        
        [self.lbRemark setNumberOfLines:0];
        [self.lbRemark sizeToFit];
//        UIFont *font = [UIFont fontWithName:@"Helvetica" size:15.0];
//        CGSize size = [self.lbRemark sizeWithFont:font constrainedToSize:CGSizeMake(200.0f, 200.0f) lineBreakMode:UILineBreakModeWordWrap];
//        CGRect rect = self.lbRemark.frame;
//        rect.size = size;
//        [self.lbRemark setFrame:rect];
//        [self.lbRemark setText:visit_remark];
    }
    if(va == 3){
        self.lbCheckInTimeTitle.hidden=NO;
        self.lbCheckInTime.hidden=NO;
        
        self.lbCheckInTimeTitle.text=@"失访原因：";
        
        self.lbCheckInTime.text=[self.dicSelectVisitPlanDetail objectForKey:@"visit_remark"];
        
        
    }
    
       //异步加载图片  签到图片
    UIActivityIndicatorView *indicatorView=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicatorView.center=CGPointMake(_sign_address_pic.frame.size.width/2, _sign_address_pic.frame.size.height/2);
    [indicatorView startAnimating];
    [_sign_address_pic addSubview:indicatorView];
    
    NSString *sinPicString=[self.dicSelectVisitPlanDetail objectForKey:@"singnin_url"];
    
    if(![sinPicString isEqualToString:@""])
    {
        NSURL *sinurl = [NSURL URLWithString:sinPicString];
        [self.sign_address_pic sd_setImageWithURL:sinurl placeholderImage:[UIImage imageNamed:@"placehoder"]];
        [indicatorView removeFromSuperview];
        
        //        NSURL *sinurl = [NSURL URLWithString:sinPicString];
        //        dispatch_queue_t queue =dispatch_queue_create("loadImage",NULL);
        //        dispatch_async(queue, ^{
        //            UIImage *sinimg = [UIImage imageWithData:[NSData dataWithContentsOfURL:sinurl]];
        //            dispatch_sync(dispatch_get_main_queue(), ^{
        //                self.sign_address_pic.image=sinimg;
        //                //[indicatorView removeFromSuperview];
        //            });
        //
        //        });
    }
    else
    {
        self.signPicLabel.hidden=YES;
        self.sign_address_pic.hidden=YES;
    }
    
    //异步加载图片 总结图片
    UIActivityIndicatorView *sum_indicatorView=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    sum_indicatorView.center=CGPointMake(_sumPic.frame.size.width/2, _sumPic.frame.size.height/2);
    [sum_indicatorView startAnimating];
    [_sumPic addSubview:sum_indicatorView];
    
    NSString *sumPicString=[self.dicSelectVisitPlanDetail objectForKey:@"returnpic"];
    if(![sumPicString isEqualToString:@""])
    {
        NSURL *sumurl = [NSURL URLWithString:sumPicString];
        [self.sumPic sd_setImageWithURL:sumurl placeholderImage:[UIImage imageNamed:@"placehoder"]];
        [sum_indicatorView removeFromSuperview];
        //       NSURL *sumurl = [NSURL URLWithString:sumPicString];
        //        dispatch_queue_t queue =dispatch_queue_create("loadImage2",NULL);
        //        dispatch_async(queue, ^{
        //            UIImage *sumimg = [UIImage imageWithData:[NSData dataWithContentsOfURL:sumurl]];
        //            dispatch_sync(dispatch_get_main_queue(), ^{
        //              self.sumPic.image=sumimg;
        //                //[indicatorView removeFromSuperview];
        //            });
        //            
        //        });
    }
    else
    {
        self.sumPicLabel.hidden=YES;
        self.sumPic.hidden=YES;
    }

    
//    0不提醒
//    1提前一小时提醒
//    2提前两小时提醒
//    3提前一天提醒
    NSString *t_visit_remind = [[self.dicSelectVisitPlanDetail objectForKey:@"visit_remind"] stringValue];
    if ([@"0" isEqualToString:t_visit_remind]) {
        
        self.lblvisit_remind.text = @"不提醒";
        
    } else if ([@"1" isEqualToString:t_visit_remind]){
        
        self.lblvisit_remind.text = @"提前一小时提醒";
        
    } else if ([@"2" isEqualToString:t_visit_remind]){
        
        self.lblvisit_remind.text = @"提前两小时提醒";
        
    } else if ([@"3" isEqualToString:t_visit_remind]){
        
        self.lblvisit_remind.text = @"提前一天提醒";
        
    }
    
    self.lblindb_date.text = [self.dicSelectVisitPlanDetail objectForKey:@"indb_date"];
    NSString *visit_content = [self.dicSelectVisitPlanDetail objectForKey:@"visit_content"];//说明
        //*****
    if ((NSNull *)visit_content == [NSNull null]) {
        
        visit_content = @"";
    }
    self.lblvisit_remark.text = visit_content;//说明
    
    int int_visit_sta=-2;
    //*****
    if([self.dicSelectVisitPlanDetail objectForKey:@"visit_sta"] && (NSNull*)[self.dicSelectVisitPlanDetail objectForKey:@"visit_sta"] != [NSNull null])
        int_visit_sta = [[self.dicSelectVisitPlanDetail objectForKey:@"visit_sta"] intValue];

    NSString *visit_sta =[NSString stringWithFormat:@"%d",int_visit_sta];//拜访状态
    if ([@"-2" isEqualToString:visit_sta]) {
        
        self.lblvisit_sta.text = @"状态异常";
        
    } else if ([@"-1" isEqualToString:visit_sta]) {
        
        self.lblvisit_sta.text = @"审核失败";
        
    } else if ([@"0" isEqualToString:visit_sta]){
        
        self.lblvisit_sta.text = @"待审核";
        
    } else if ([@"1" isEqualToString:visit_sta]){
        
        self.lblvisit_sta.text = @"待拜访";
        
    } else if ([@"2" isEqualToString:visit_sta]){
        
        self.lblvisit_sta.text = @"已完成";
        
    } else if ([@"3" isEqualToString:visit_sta]){
        
        self.lblvisit_sta.text = @"失访";
        
    }
    
    NSString *visit_examine_result = [self.dicSelectVisitPlanDetail objectForKey:@"visit_examine_result"];
    if ((NSNull *)visit_examine_result == [NSNull null]) {
        
        visit_examine_result = @"";
    }
    self.lblvisit_examine_result.text = visit_examine_result;//审核意见
    
    //从viewdidload copy
    lbCNameTitle.text=[NSString stringWithFormat:@"%@：",[VariableStore getCustomerManagerName]];
    
#if (defined STANDARD_CS_VERSION) || (defined STANDARD_SY_VERSION)
    int visit_sta1 = [[self.dicSelectVisitPlanDetail objectForKey:@"visit_sta"] intValue];
    if(visit_sta1 != 3){
        UIBarButtonItem *rightButton=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"编辑1"] style:UIBarButtonItemStylePlain target:self action:@selector(goEdit)];
        [rightButton setTintColor:[UIColor whiteColor]];
        [self.navigationItem setRightBarButtonItem:rightButton];
    }
#endif
    
 //*****为长沙主管，客户经理新增 拜访类型  4G换卡 终端销售 流量套餐 其它字段
     #if (defined MANAGER_CS_VERSION) || (defined STANDARD_CS_VERSION)
    
    /*
     if_gift 是否赠送礼品
     gift_name 礼品名称
     if_4g_trem 是否4g终端
     if_4g_card 是否4g卡
     if_4g_package 是否4g套餐
     test_4g 4G网络测试结果 好”、“良好”、“一般”、“差
     information_recommend 信息化产品推荐情况
     business_excavate 商机挖掘情况
     project_follow 项目跟进情况
     */
      self.if_gift.text =[self.dicSelectVisitPlanDetail objectForKey:@"if_gift"];
    self.gift_name.text =[self.dicSelectVisitPlanDetail objectForKey:@"gift_name"];
    self.if_4g_trem.text =[self.dicSelectVisitPlanDetail objectForKey:@"if_4g_trem"];
    self.if_4g_card.text =[self.dicSelectVisitPlanDetail objectForKey:@"if_4g_card"];
    self.if_4g_package.text =[self.dicSelectVisitPlanDetail objectForKey:@"if_4g_package"];
    self.test_4g.text =[self.dicSelectVisitPlanDetail objectForKey:@"test_4g"];
    self.information_recommend.text =[self.dicSelectVisitPlanDetail objectForKey:@"information_recommend"];
    self.business_excavate.text =[self.dicSelectVisitPlanDetail objectForKey:@"business_excavate"];
    self.project_follow.text =[self.dicSelectVisitPlanDetail objectForKey:@"project_follow"];

       self.visit_type.text =[self.dicSelectVisitPlanDetail objectForKey:@"visit_type"];
    
    self.card_4g.text = [self.dicSelectVisitPlanDetail objectForKey:@"card_4g"];
    self.term_cnt.text = [self.dicSelectVisitPlanDetail objectForKey:@"term_cnt"];
    self.flow_cnt.text = [self.dicSelectVisitPlanDetail objectForKey:@"flow_cnt"];
    self.other_cnt.text = [self.dicSelectVisitPlanDetail objectForKey:@"other_cnt"];
    #endif
    /**新增信息化
     unit_information  单位信息化
     unit_information_status 单位信息化现状
     potential_information 潜在信息化
     */
//    self.infmUnitText.layer.borderColor=[UIColor lightGrayColor].CGColor;
//    self.infmUnitText.layer.borderWidth=1;
//    self.infmUnitText.layer.cornerRadius=3;
//    self.infmUnitText.layer.masksToBounds=YES;
//    self.infmUnitText.delegate=self;
//    
//    self.infmStatusText.layer.borderColor=[UIColor lightGrayColor].CGColor;
//    self.infmStatusText.layer.borderWidth=1;
//    self.infmStatusText.layer.cornerRadius=3;
//    self.infmStatusText.layer.masksToBounds=YES;
//    self.infmStatusText.delegate=self;
//    
//    self.infmpotentialText.layer.borderColor=[UIColor lightGrayColor].CGColor;
//    self.infmpotentialText.layer.borderWidth=1;
//    self.infmpotentialText.layer.cornerRadius=3;
//    self.infmpotentialText.layer.masksToBounds=YES;
//    self.infmpotentialText.delegate=self;
    if([[self.dicSelectVisitPlanDetail objectForKey:@"visit_type"] isEqualToString:@"信息化"])
    {
        self.unitBtn.hidden=NO;
        self.statusBtn.hidden=NO;
        self.potentialBtn.hidden=NO;
       
    }

    self.infmUnitText.text=[self.dicSelectVisitPlanDetail objectForKey:@"unit_information"];
    self.infmStatusText.text=[self.dicSelectVisitPlanDetail objectForKey:@"unit_information_status"];
    self.infmpotentialText.text=[self.dicSelectVisitPlanDetail objectForKey:@"potential_information"];
 //不为长沙主管，客户经理 将拜访类型  4G换卡 终端销售 流量套餐 其它 字段隐藏
    
#if (defined STANDARD_SY_VERSION) || (defined MANAGER_SY_VERSION)
    self.visit_type.hidden=YES;
    self.disp_visit_type.hidden=YES;
    self.card_4g.hidden=YES;
    self.term_cnt.hidden=YES;
    self.flow_cnt.hidden=YES;
    self.other_cnt.hidden=YES;
    self.disp_card_4g.hidden=YES;
    self.disp_term_cnt.hidden=YES;
    self.disp_flow_cnt.hidden=YES;
    self.disp_other_cnt.hidden=YES;
    /*
     if_gift 是否赠送礼品
     gift_name 礼品名称
     if_4g_trem 是否4g终端
     if_4g_card 是否4g卡
     if_4g_package 是否4g套餐
     test_4g 4G网络测试结果 好”、“良好”、“一般”、“差
     information_recommend 信息化产品推荐情况
     business_excavate 商机挖掘情况
     project_follow 项目跟进情况
     */
    //self.inTableContentview.frame.size.height-=200;
    self.disp_if_gift.hidden=YES;
    self.disp_gift_name.hidden=YES;
    self.disp_if_4g_trem.hidden=YES;
    self.disp_if_4g_card.hidden=YES;
    self.disp_if_4g_package.hidden=YES;
    self.disp_test_4g.hidden=YES;
    self.disp_information_recommend.hidden=YES;
    self.disp_business_excavate.hidden=YES;
    self.disp_project_follow.hidden=YES;
    self.if_gift.hidden=YES;
    self.gift_name.hidden=YES;
    self.if_4g_trem.hidden=YES;
    self.if_4g_card.hidden=YES;
    self.if_4g_package.hidden=YES;
    self.test_4g.hidden=YES;
   self.information_recommend.hidden=YES;
    self.business_excavate.hidden=YES;
    self.project_follow.hidden=YES;
    self.titleGift.hidden=YES;
    self.contact4G.hidden=YES;
    self.titleTest4G.hidden=YES;
    self.TtitleDeal.hidden=YES;
        
#endif
    //******************
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.tbReplyList count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 104;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"W_VisitPlanDetailsViewControllerCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:CellIdentifier owner:self options:nil] objectAtIndex:0];
    }
    
    NSUInteger r = [indexPath row];
    NSDictionary *dicObj = [self.tbReplyList objectAtIndex:r];
    
    NSString *image_url = [dicObj objectForKey:@"image_url"];
    NSString *reply_time = [dicObj objectForKey:@"reply_time"];
    NSString *reply_content = [dicObj objectForKey:@"reply_content"];
    NSString *reply_name = [dicObj objectForKey:@"reply_name"];
    
    UIImageView *imgViewimage_url = (UIImageView*)[cell viewWithTag:100];
    UILabel *lblreply_time = (UILabel*)[cell viewWithTag:200];
    UILabel *lblreply_content = (UILabel *)[cell viewWithTag:300];
    UILabel *lblreply_name = (UILabel *)[cell viewWithTag:400];
    //for test bug
      // if (![image_url isEqualToString:@""])
   if (image_url && image_url.length>0)
 
    {
        
        NSURL *url = [NSURL URLWithString:image_url];
        dispatch_queue_t queue =dispatch_queue_create("loadImage",NULL);
        dispatch_async(queue, ^{
            
            NSData *resultData = [NSData dataWithContentsOfURL:url];
            UIImage *img = [UIImage imageWithData:resultData];
            
            dispatch_sync(dispatch_get_main_queue(), ^{
                
                imgViewimage_url.image = img;
            });
            
        });
        
    }else{
        ;
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *date=[dateFormatter dateFromString:reply_time];
    
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    [dateFormatter1 setDateFormat:@"MM月dd日 HH:mm"];
    
    NSString *rptime=[dateFormatter1 stringFromDate:date];
    
    lblreply_time.text = rptime;
    lblreply_content.text = reply_content;
    lblreply_name.text = reply_name;
    
    cell.selectionStyle= UITableViewCellSelectionStyleNone;
    
    return cell;
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
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
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
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];

    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
 
 */

-(void)showMessage:(NSString*)infomation{
    
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"信息提示" message:infomation delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
    [myAlertView show];
}

-(void)refreshReplyTableView{
    
    [self.tbViewReply reloadData];
}

-(void)connectToNetwork{
    
    while (hubFlag) {
        usleep(100000);
    }
}


// 从提醒消息页面跳转需要详情页面请求的数据
-(void)loadDetailData
{
    hubFlag=YES;
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"数据查询中，请稍后...";
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
    
    NSMutableDictionary *paramDict=[[NSMutableDictionary alloc] init];
    //enterprise 企业编码
    [paramDict setObject:[NSNumber numberWithInt:self.user.userEnterprise] forKey:@"enterprise"];
    
//    NSString *visit_id = [self.messagePassDict objectForKey:@"row_id"];
    //visit_id 拜访计划id NSString *visit_id = [self.dicSelectVisitPlanDetail objectForKey:@"row_id"];
//     NSString *visitID = [self.messagePassDict objectForKey:@"visit_id"];
   [paramDict setObject:self.passVisitID forKey:@"visit_id"];
    NSString *telNm= [NSString stringWithFormat:@"%@",self.user.userMobile];
     [paramDict setObject:telNm forKey:@"user_msisdn"];
    //user_lvl 用户级别
    int lvl = self.user.userLvl;
    
    [paramDict setObject:[NSString stringWithFormat:@"%d",lvl] forKey:@"user_lvl"];
    //[bDict setObject:[NSNumber numberWithInt:self.user.userLvl] forKey:@"user_lvl"];
    
    //user_id 用户id
    int uid = self.user.userID;
    NSString *userID = [NSString stringWithFormat:@"%d",uid];
    [paramDict setObject:userID forKey:@"user_id"];
    
    [NetworkHandling sendPackageWithUrl:@"visitplan/visitplanlist" sendBody:paramDict processHandler:^(NSDictionary *result, NSError *error) {
        
        hubFlag=NO;
        if(!error){
            
            NSLog(@"sign in success");
            if ([[result objectForKey:@"visit"] count]==0) {
                NSLog(@"拜访详情计划为空，无法获取");
//                [self.view makeToast:@"无法获取拜访计划详情"
//            duration:3.0
//            position:@"center"
//            title:@"提示"];
                self.dicSelectVisitPlanDetail=nil;
               // return ;
            }
            else{
           self.dicSelectVisitPlanDetail =[[result objectForKey:@"visit"] objectAtIndex:0];
               
            }
            [self performSelectorOnMainThread:@selector(fromMessagerefreshTableView) withObject:nil waitUntilDone:YES];
            
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

-(void)fromMessagerefreshTableView{
    [self initSubView];
    if (self.dicSelectVisitPlanDetail==nil) {
        
        [self.view makeToast:@"无法获取拜访计划详情详细信息"
                     duration:3.0
                     position:@"center"
                     title:@"提示"];
    }
    else
    {
    [self loadReplayListData:@""];
    }
}

-(void)loadReplayListData:(NSString *)row_id{
    
    hubFlag=YES;
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"数据查询中，请稍后...";
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
    
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    [bDict setObject:[NSNumber numberWithInt:self.user.userEnterprise] forKey:@"enterprise"];
//    if ([self.fromMessage isEqualToString:@"1"]) {
//        <#statements#>
//    }
    NSString *visit_id = [self.dicSelectVisitPlanDetail objectForKey:@"row_id"];
    
    [bDict setObject:visit_id forKey:@"visit_id"];
    
    [NetworkHandling sendPackageWithUrl:@"visitplan/visitplanreplylist" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        hubFlag=NO;
        if(!error){
            
            NSLog(@"sign in success");
            self.tbReplyList =[result objectForKey:@"visitreply"];
            [self performSelectorOnMainThread:@selector(refreshReplyTableView) withObject:nil waitUntilDone:YES];
            
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


-(void)addVisitPlanReplyData{
    
    hubFlag=YES;
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"数据提交中，请稍后...";
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
    
    /*
     
     enterprise企业编码
     visit_id拜访计划id
     client_os "ios"
     user_lvl用户级别 [bDict setObject:[NSNumber numberWithInt:self.user.userLvl] forKey:@"user_lvl"];
     reply_name回复人名字
     reply_msisdn回复人电话
     reply_content回复内容
     reply_user_id回复人id
     
     */
    
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    [bDict setObject:[NSNumber numberWithInt:self.user.userEnterprise] forKey:@"enterprise"];
    NSString *visit_id = [self.dicSelectVisitPlanDetail objectForKey:@"row_id"];
    [bDict setObject:visit_id forKey:@"visit_id"];
    NSString *client_os = @"ios";
    [bDict setObject:client_os forKey:@"client_os"];
    int lvl = self.user.userLvl;
    
    [bDict setObject:[NSString stringWithFormat:@"%d",lvl] forKey:@"user_lvl"];
    NSString *reply_name = self.user.userName;
    [bDict setObject:reply_name forKey:@"reply_name"];
    NSString *reply_msisdn = self.user.userMobile;
    [bDict setObject:reply_msisdn forKey:@"reply_msisdn"];
    NSString *reply_content =self.txtReplyContent.text;
    [bDict setObject:reply_content forKey:@"reply_content"];
    
    int uid = self.user.userID;
    NSString *reply_user_id = [NSString stringWithFormat:@"%d",uid];
    [bDict setObject:reply_user_id forKey:@"reply_user_id"];
    
    [NetworkHandling sendPackageWithUrl:@"visitplan/addvisitplanreply" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        hubFlag=NO;
        if(!error){
            
            NSLog(@"sign in success");
            BOOL flag=[[result objectForKey:@"flag"] boolValue];
            if(flag){
                
                [self performSelectorOnMainThread:@selector(showMessage:) withObject:@"回复成功！" waitUntilDone:YES];
                [self performSelectorOnMainThread:@selector(refeshReplyTable) withObject:nil waitUntilDone:YES];
                
            }else{
                
                [self performSelectorOnMainThread:@selector(showMessage:) withObject:@"回复失败！" waitUntilDone:YES];
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

- (void)refeshReplyTable{
    
    [self loadReplayListData:@""];
}

- (IBAction)addVisitPlanReplyOnClick:(id)sender {
    
    [self addVisitPlanReplyData];
    [self.txtReplyContent resignFirstResponder];
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
     return  [textField resignFirstResponder];
}

// 定义成方法方便多个label调用 增加代码的复用性
- (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font
{
    CGRect rect = [string boundingRectWithSize:CGSizeMake(320, 8000)//限制最大的宽度和高度
                                       options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading  |NSStringDrawingUsesLineFragmentOrigin//采用换行模式
                                    attributes:@{NSFontAttributeName: font}//传人的字体字典
                                       context:nil];
    
    return rect.size;
}
#pragma mark -查看大图
- (IBAction)clickZoomOutSignInPic:(id)sender {
    if(!self.sign_address_pic.image)
        return;
    
    zoomOutImageView.image=self.sign_address_pic.image;
    zoomOutImageView.contentMode=UIViewContentModeScaleAspectFit;
    [self.navigationController.view addSubview:zoomOutImageView];
}

- (IBAction)clickZoomOutSumPic:(id)sender {
    if(!self.sumPic.image)
        return;
    
    zoomOutImageView.image=self.sumPic.image;
    zoomOutImageView.contentMode=UIViewContentModeScaleAspectFit;
    [self.navigationController.view addSubview:zoomOutImageView];
}

-(void)handleSingleTap1:(UIGestureRecognizer *)gestureRecognizer{
    [zoomOutImageView removeFromSuperview];
}

- (IBAction)UnitShowMore:(id)sender {
    NSString *bodyString;
    bodyString=[self.dicSelectVisitPlanDetail objectForKey:@"unit_information"];
    if ([[self.dicSelectVisitPlanDetail objectForKey:@"unit_information"] isEqualToString:@""]) {
        bodyString=@"无内容可查看";
    }
    UIAlertView *unitAlertView = [[UIAlertView alloc] initWithTitle:nil message:bodyString delegate:self cancelButtonTitle:nil otherButtonTitles:@"查看完毕",nil];
    
    unitAlertView.tag=143;
    [unitAlertView show];
}

- (IBAction)StatusShowMore:(id)sender {
    NSString *bodyString;
    bodyString=[self.dicSelectVisitPlanDetail objectForKey:@"unit_information_status"];
    if ([[self.dicSelectVisitPlanDetail objectForKey:@"unit_information_status"] isEqualToString:@""]) {
        bodyString=@"无内容可查看";
    }

    UIAlertView *statusAlertView = [[UIAlertView alloc] initWithTitle:nil message:bodyString delegate:self cancelButtonTitle:nil otherButtonTitles:@"查看完毕",nil];
    
    statusAlertView.tag=143;
    [statusAlertView show];
}

- (IBAction)PotentialShowMore:(id)sender {
    NSString *bodyString;
    bodyString=[self.dicSelectVisitPlanDetail objectForKey:@"potential_information"];
    if ([[self.dicSelectVisitPlanDetail objectForKey:@"potential_information"] isEqualToString:@""]) {
        bodyString=@"无内容可查看";
    }
    UIAlertView *potentialAlertView = [[UIAlertView alloc] initWithTitle:nil message:bodyString delegate:self cancelButtonTitle:nil otherButtonTitles:@"查看完毕",nil];
    
    potentialAlertView.tag=143;
    [potentialAlertView show];
}
@end
