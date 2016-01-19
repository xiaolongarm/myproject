//
//  W_VisistPlanSummaryViewController.m
//  CMCCMarketing
//
//  Created by gmj on 14-11-27.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import "W_VisistPlanSummaryViewController.h"
#import "W_VisitPlanDetailsViewController.h"

#import "NetworkHandling.h"
#import "MBProgressHUD.h"
#import "Toast+UIView.h"

#define NUMBERS @"0123456789"

@interface W_VisistPlanSummaryViewController ()<MBProgressHUDDelegate,UIActionSheetDelegate,UIAlertViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    BOOL isSubmit;
    BOOL hubFlag;
    NSString *kUTTypeImage;
    UIImageView *zoomImageView;
    NSString *ifGiftString;
      NSString *test4GString;
    NSString *if4gtremString;
     NSString *if4gCardSrting;
     NSString *if4gPackage;
}

@end

@implementation W_VisistPlanSummaryViewController

#pragma mark - UITextView delegate

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
//    if (textView==self.information_recommend||textView==self.business_excavate||textView==self.project_follow)
//if(![textView.text isEqualToString:@""])
//    {
//    [self.view makeToast:@"1） 单位负责信息化业务的关键人姓名及电话；2）单位信息化现状（若正使用竞争对手信息化产品：则说明正使用XX产品，资费如何，合同到期时间；若正使用我方信息化产品，则注明回款情况）; 3）潜在信息化需求（如集团专线、MAS、预存统购、工作终端、移动OA……）"
//    duration:2.0 position:@"center" title:Nil];
//    }

    
        CGRect rect=self.xScrollview.frame;
        rect.origin.y-=100;
        self.xScrollview.frame=rect;
    return YES;
//}
//else{
//    return NO;
//}

//    CGRect rect=self.view.frame;
//    rect.origin.y-=100;
//    self.view.frame=rect;
//    return YES;
}

-(BOOL)textViewShouldEndEditing:(UITextView *)textView{
//    self.information_recommend.delegate=self;
//    self.business_excavate.delegate=self;
//    self.project_follow.delegate=self;
//    if (textView==self.information_recommend||textView==self.business_excavate||textView==self.project_follow) {
        CGRect rect=self.xScrollview.frame;
        rect.origin.y+=100;
        self.xScrollview.frame=rect;
        return YES;
//    }
//    else{
//        return NO;
//    }

}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
//    if(![text isEqualToString:@""])
//    {
        //[_backgroundTextView setHidden:YES];
//        [self.view makeToast:@"  1） 单位负责信息化业务的关键人姓名及电话；2）单位信息化现状（若正使用竞争对手信息化产品：则说明正使用XX产品，资费如何，合同到期时间；若正使用我方信息化产品，则注明回款情况）; 3）潜在信息化需求（如集团专线、MAS、预存统购、工作终端、移动OA……）"
//                                 duration:3.0
//                                 position:@"center"
//                                    title:@"提示"];
  //  }
//    if([text isEqualToString:@""]&&range.length==1&&range.location==0){
//        [_backgroundTextView setHidden:NO];
//    }
    
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark textfiled delegate方法


-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField==self.otherInput||textField==self.dataFlowInput) {
        CGRect rect=self.view.frame;
        rect.origin.y-=100;
        self.view.frame=rect;
    }
    return YES;

}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if (textField==self.otherInput||textField==self.dataFlowInput){
        
    CGRect rect=self.view.frame;
    rect.origin.y+=100;
    self.view.frame=rect;
    }
    return YES;

    
}
- (BOOL)textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString*)string
{
    
    NSLog(@"exec shouldChangeCharactersInRange Funcatin");
    if (textField==self.Card4gInput||textField==self.termSales||textField==self.dataFlowInput){
    NSCharacterSet*cs;
    cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    BOOL basicTest = [string isEqualToString:filtered];
    if(!basicTest) {
        
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                       message:@"请输入数字"
                                                      delegate:nil
                                             cancelButtonTitle:@"确定"
                                             otherButtonTitles:nil];
        
        [alert show];
        return NO;
        
    }
    }
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initSubView];
    kUTTypeImage=@"public.image";
    
    CGSize size =[[UIScreen mainScreen] bounds].size;
    zoomImageView = [[UIImageView alloc] init];
    zoomImageView.frame = CGRectMake(0, 0, size.width, size.height);
    zoomImageView.backgroundColor=[UIColor blackColor];
    [zoomImageView setUserInteractionEnabled:YES];
    UITapGestureRecognizer *singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap1:)];
    [zoomImageView addGestureRecognizer:singleTap1];
}
-(void)handleSingleTap1:(UIGestureRecognizer *)gestureRecognizer{
    [zoomImageView removeFromSuperview];
}
-(void)initSubView{
    //设置scrollview滚动
    self.xScrollview.contentSize = CGSizeMake(320, 1050);
    self.xScrollview.showsVerticalScrollIndicator=YES;
    self.navigationItem.title = @"拜访总结";
    UIBarButtonItem *rightButton=[[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(submitSummary)];
    [rightButton setTintColor:[UIColor whiteColor]];
    [self.navigationItem setRightBarButtonItem:rightButton];
    
    //为长沙主管，客户经理***************
    #if (defined MANAGER_CS_VERSION) || (defined STANDARD_CS_VERSION)
    //***********设置输入框键盘类型
    
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
    
   
    
    //button setting
   [self.if_4g_trem addTarget:self action:@selector(Mobile4GButton:) forControlEvents: UIControlEventTouchUpInside];
    self.if_4g_trem.tag=11;
    if4gtremString=@"否";
    
    [self.if_4g_card addTarget:self action:@selector(ChangCard4GButton:) forControlEvents: UIControlEventTouchUpInside];
    self.if_4g_card.tag=11;
     if4gCardSrting=@"否";
    [self.if_4g_package addTarget:self action:@selector(Taocang4GButton:) forControlEvents: UIControlEventTouchUpInside];
    
    self.if_4g_package.tag=11;
     if4gPackage=@"否";
    
    self.test_4g.selectedSegmentIndex=0;
    test4GString=@"好";
    //textfiled delegate setting
     self.information_recommend.delegate=self;
    self.business_excavate.delegate=self;
    self.project_follow.delegate=self;
    //textview setting
    self.information_recommend.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.information_recommend.layer.borderWidth=1;
    self.information_recommend.layer.cornerRadius=3;
    self.information_recommend.layer.masksToBounds=YES;
    self.information_recommend.delegate=self;
    
    self.business_excavate.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.business_excavate.layer.borderWidth=1;
    self.business_excavate.layer.cornerRadius=3;
    self.business_excavate.layer.masksToBounds=YES;
    self.business_excavate.delegate=self;
    
    self.project_follow.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.project_follow.layer.borderWidth=1;
    self.project_follow.layer.cornerRadius=3;
    self.project_follow.layer.masksToBounds=YES;
    self.project_follow.delegate=self;
    
    self.Card4gInput.delegate=self;
    self.termSales.delegate=self;
    self.dataFlowInput.delegate=self;
    self.otherInput.delegate=self;
    
    self.Card4gInput.keyboardType= UIKeyboardTypeNumberPad;
    self.termSales.keyboardType=UIKeyboardTypeNumberPad;
    self.dataFlowInput.keyboardType=UIKeyboardTypeNumberPad;
    //信息化相关设置
    self.inmfUnitText.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.inmfUnitText.layer.borderWidth=1;
    self.inmfUnitText.layer.cornerRadius=3;
    self.inmfUnitText.layer.masksToBounds=YES;
    self.inmfUnitText.delegate=self;
    
    self.inmfStatusText.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.inmfStatusText.layer.borderWidth=1;
    self.inmfStatusText.layer.cornerRadius=3;
    self.inmfStatusText.layer.masksToBounds=YES;
    self.inmfStatusText.delegate=self;

    self.infmPotentialText.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.infmPotentialText.layer.borderWidth=1;
    self.infmPotentialText.layer.cornerRadius=3;
    self.infmPotentialText.layer.masksToBounds=YES;
    self.infmPotentialText.delegate=self;
    
    //********加入显示已经提交过的信息显示（信息化内容等）*****
    //    Card4gInput;
    //    *termSales;
    //     *dataFlowInput;
    //    *otherInput;
    self.Card4gInput.text = [self.dicSelectVisitPlanDetail objectForKey:@"card_4g"];
    self.termSales.text = [self.dicSelectVisitPlanDetail objectForKey:@"term_cnt"];
    self.dataFlowInput.text = [self.dicSelectVisitPlanDetail objectForKey:@"flow_cnt"];
    self.otherInput.text = [self.dicSelectVisitPlanDetail objectForKey:@"other_cnt"];
    //显示信息化内容
    self.inmfUnitText.text = [self.dicSelectVisitPlanDetail objectForKey:@"unit_information"];
    self.inmfStatusText.text = [self.dicSelectVisitPlanDetail objectForKey:@"unit_information_status"];
    self.infmPotentialText.text = [self.dicSelectVisitPlanDetail objectForKey:@"potential_information"];
   self.gift_name.text = [self.dicSelectVisitPlanDetail objectForKey:@"gift_name"];
    self.information_recommend.text  = [self.dicSelectVisitPlanDetail objectForKey:@"information_recommend"];
    self.business_excavate.text  = [self.dicSelectVisitPlanDetail objectForKey:@"business_excavate"];
    self.project_follow.text  = [self.dicSelectVisitPlanDetail objectForKey:@"project_follow"];
    //礼品赠送
    if ( [[self.dicSelectVisitPlanDetail objectForKey:@"if_gift"] isEqualToString:@"是"]) {
        self.if_gift.on=YES;
       //  ifGiftString=@"是";
    } else {
       self.if_gift.on=NO;
        //ifGiftString=@"否";

    }
    //4G覆盖情况
    if ([[self.dicSelectVisitPlanDetail objectForKey:@"if_4g_trem"] isEqualToString:@"是"]) {
        self.if4gtremImage.image=[UIImage imageNamed:@"Selected.png"];
        if4gtremString=@"是";
    }
    if ([[self.dicSelectVisitPlanDetail objectForKey:@"if_4g_card"] isEqualToString:@"是"]) {
       self.if4gcardImage.image=[UIImage imageNamed:@"Selected.png"];
        if4gCardSrting =@"是";
    }
    if ([[self.dicSelectVisitPlanDetail objectForKey:@"if_4g_package"] isEqualToString:@"是"]) {
        self.if4gpackageImage.image=[UIImage imageNamed:@"Selected.png"];
        if4gPackage =@"是";
    }
 
    //4G网络
    if ([[self.dicSelectVisitPlanDetail objectForKey:@"test_4g"] isEqualToString:@"好"])
    {
        self.test_4g.selectedSegmentIndex=0;
    }
    if ([[self.dicSelectVisitPlanDetail objectForKey:@"test_4g"] isEqualToString:@"良好"]) {
        self.test_4g.selectedSegmentIndex=1;
    }
    if ([[self.dicSelectVisitPlanDetail objectForKey:@"test_4g"] isEqualToString:@"一般"]) {
        self.test_4g.selectedSegmentIndex=2;
    }
    if ([[self.dicSelectVisitPlanDetail objectForKey:@"test_4g"] isEqualToString:@"差"]) {
        self.test_4g.selectedSegmentIndex=3;
    }

    //***************
#endif
    
    //不为长沙主管，客户经理 将4label 4个textfiled 隐藏
#if (defined STANDARD_SY_VERSION) || (defined MANAGER_SY_VERSION)
    self.lbCard.hidden=YES;
     self.lbSales.hidden=YES;
    self.lbdataFlow.hidden=YES;
     self.lbOther.hidden=YES;
    
    self.Card4gInput.hidden=YES;
    self.termSales.hidden=YES;
    self.dataFlowInput.hidden=YES;
    self.otherInput.hidden=YES;
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
    self.titleGift.hidden=YES;
    self.title4g.hidden=YES;
    self.title4gNetwork.hidden=YES;
    self.tilteDeal.hidden=YES;
    self.disp_if_gift.hidden=YES;
    self.disp_gift_name.hidden=YES;
    self.disp_information_recommend.hidden=YES;
    self.disp_business_excavate.hidden=YES;
    self.disp_project_follow.hidden=YES;
    self.if_gift.hidden=YES;
    self.gift_name.hidden=YES;
    self.if4gtremImage.hidden=YES;
    self.if4gcardImage.hidden=YES;
    self.if4gpackageImage.hidden=YES;
    self.if_4g_trem.hidden=YES;
    self.if_4g_card.hidden=YES;
    self.if_4g_package.hidden=YES;
    self.information_recommend.hidden=YES;
    self.business_excavate.hidden=YES;
    self.project_follow.hidden=YES;
    self.test_4g.hidden=YES;
//    self.otherInput.hidden=YES;
//    self.otherInput.hidden=YES;

    
#endif
    //*****************************
    //初始化总结内容控件
    self.txtViewContent.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.txtViewContent.layer.borderWidth=1;
    self.txtViewContent.layer.cornerRadius=3;
    self.txtViewContent.layer.masksToBounds=YES;
    self.txtViewContent.delegate=self;
    
    if([[self.dicSelectVisitPlanDetail objectForKey:@"visit_type"] isEqualToString:@"信息化"])
    {
        self.baseInfm.hidden=NO;
        self.statusInfm.hidden=NO;
        self.InneedInfm.hidden=NO;
        self.contentButton.hidden=NO;
    }
    //加入显示拜访对象名称
    self.lblVisit_grp_name.text = [self.dicSelectVisitPlanDetail objectForKey:@"visit_grp_name"];

    self.lblVip_mngr_name.text = [self.dicSelectVisitPlanDetail objectForKey:@"vip_mngr_name"];
    self.lblLinkman.text = [self.dicSelectVisitPlanDetail objectForKey:@"linkman"];
    self.lblVip_mngr_name.text = [self.dicSelectVisitPlanDetail objectForKey:@"vip_mngr_name"];
    self.lblVip_mngr_msisdn.text = [self.dicSelectVisitPlanDetail objectForKey:@"vip_mngr_msisdn"];
    self.lblVisit_grp_add.text = [self.dicSelectVisitPlanDetail objectForKey:@"visit_grp_add"];
    
    NSString *visit_remark=[self.dicSelectVisitPlanDetail objectForKey:@"visit_remark"];
    isSubmit=NO;
    if(visit_remark && (NSNull*)visit_remark != [NSNull null] && visit_remark.length > 0)
        isSubmit=YES;
    if(isSubmit){
        self.txtViewContent.text=visit_remark;
        
        
        NSString *imageUrl=[self.dicSelectVisitPlanDetail objectForKey:@"returnpic"];
        if(imageUrl && (NSNull*)imageUrl != [NSNull null] && imageUrl.length > 0){
            NSURL *url = [NSURL URLWithString:imageUrl];
            dispatch_queue_t queue =dispatch_queue_create("loadImage",NULL);
            dispatch_async(queue, ^{
                
                NSData *resultData = [NSData dataWithContentsOfURL:url];
                UIImage *img = [UIImage imageWithData:resultData];
                if(img){
                    dispatch_sync(dispatch_get_main_queue(), ^{
                        
                        self.visitImageView.image = img;
                    });
                }
            });
        }
        
    }

}

-(void)submitSummary{
    hubFlag=YES;
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"数据提交中，请稍后...";
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
    
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    //*****为长沙主管，客户经理新增 拜访类型  4G换卡 终端销售 流量套餐 其它字段
#if (defined MANAGER_CS_VERSION) || (defined STANDARD_CS_VERSION)
    
    if (![self.Card4gInput.text isEqualToString:@""]) {
        [bDict setObject:self.Card4gInput.text forKey:@"card_4g"];
    }
 if (![self.termSales.text isEqualToString:@""])
{
 [bDict setObject:self.termSales.text forKey:@"term_cnt"];

}
 if (![self.dataFlowInput.text isEqualToString:@""])
 {
      [bDict setObject:self.dataFlowInput.text forKey:@"flow_cnt"];
 }
     if (![self.otherInput.text  isEqualToString:@""])
     {
       [bDict setObject:self.otherInput.text forKey:@"other_cnt"];
     }
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
    
    [bDict setObject:ifGiftString forKey:@"if_gift"];
     [bDict setObject:self.gift_name.text forKey:@"gift_name"];
     [bDict setObject:if4gtremString forKey:@"if_4g_trem"];
    [bDict setObject:if4gCardSrting forKey:@"if_4g_card"];
    [bDict setObject:if4gPackage forKey:@"if_4g_package"];
     [bDict setObject:test4GString forKey:@"test_4g"];
     [bDict setObject:self.information_recommend.text forKey:@"information_3recommend"];
    [bDict setObject:self.business_excavate.text forKey:@"business_excavate"];
    [bDict setObject:self.project_follow.text forKey:@"project_follow"];
    
    /**
     *   unit_information  单位信息化
     unit_information_status 单位信息化现状
     potential_information 潜在信息化
     */
    [bDict setObject:self.inmfUnitText.text forKey:@"unit_information"];
    [bDict setObject:self.inmfStatusText.text forKey:@"unit_information_status"];
    [bDict setObject:self.infmPotentialText.text forKey:@"potential_information"];
#endif
    
    [bDict setObject:[NSNumber numberWithInt:self.user.userEnterprise] forKey:@"enterprise"];
    int uid = self.user.userID;
    NSString *reply_user_id = [NSString stringWithFormat:@"%d",uid];
    [bDict setObject:reply_user_id forKey:@"user_id"];
    
    NSString *visit_id = [self.dicSelectVisitPlanDetail objectForKey:@"row_id"];
    [bDict setObject:visit_id forKey:@"row_id"];
    NSString *client_os = @"ios";
    [bDict setObject:client_os forKey:@"client_os"];
    
    NSString *visit_remark =self.txtViewContent.text;//失访原因
    [bDict setObject:visit_remark forKey:@"visit_remark"];
    NSString *img_url = @"";
    [bDict setObject:img_url forKey:@"img_url"];
    NSString *visit_sta = [self.dicSelectVisitPlanDetail objectForKey:@"visit_sta"];
    [bDict setObject:visit_sta forKey:@"visit_sta"];
    
    [self postData:bDict];
}

-(NSString*)jpgPath{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMddHHmmssSSS"];
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    currentDateStr=[currentDateStr stringByAppendingString:@".jpg"];
    return currentDateStr;
}
-(void)postData:(NSMutableDictionary*)bDict {
    
    NSString *nettype=[NetworkHandling GetCurrentNet];
    if(!nettype){
        hubFlag=NO;
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"错误" message:@"当前没有连接网络，无法提交数据！" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"关闭", nil];
        [alertView show];
        return;
    }
    
    UIImage *pic = self.visitImageView.image;
    if (pic) {
        
        NSString *picName=[self jpgPath];
        [bDict setObject:picName forKey:@"img_url"];//设置图片名称
        int visit_id = [[self.dicSelectVisitPlanDetail objectForKey:@"row_id"] intValue];
        //        NSString *paramString=[NSString stringWithFormat:@"?type='visitplan/%d/'",visit_id];
        
        
        [NetworkHandling UploadsyntheticPictures:pic currentPicName:picName currentUser:visit_id uploadType:@"visitplan" completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
            if(!error){
                NSDictionary *d1=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                BOOL f1=[[d1 objectForKey:@"imgUpload"] boolValue];
                if(f1){
                    NSLog(@"%@图片上传成功。。。",picName);
                    
                    [self addSummaryData:bDict];
                    
                }else{
                    
                    NSLog(@"%@图片上传失败。。。",picName);
                }
                
            }else{
                
                NSLog(@"error");
            }
            
        }];
        
    } else {
        
        [self addSummaryData:bDict];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)IfGiftButton:(id)sender {
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    if (isButtonOn) {
        ifGiftString = @"是";
    }else {
        ifGiftString = @"否";
    }
}


- (IBAction)Test4gButton:(id)sender {
    int selectedSegment = self.test_4g.selectedSegmentIndex;
    NSLog(@"Segment %d selected\n", selectedSegment);
    if (selectedSegment==0) {
        test4GString=@"好";
    }
    if (selectedSegment==1) {
         test4GString=@"良好";
    }
    if (selectedSegment==2) {
         test4GString=@"一般";
    }
    if (selectedSegment==3) {
         test4GString=@"差";
    }
    
}

- (IBAction)toVisitPlanDetailOnClick:(id)sender{
    
    W_VisitPlanDetailsViewController *vc = [[W_VisitPlanDetailsViewController alloc] initWithNibName:@"W_VisitPlanDetailsViewController" bundle:nil];
    vc.user = self.user;
    vc.dicSelectVisitPlanDetail = self.dicSelectVisitPlanDetail;
    [self.navigationController pushViewController:vc animated:YES];
    
}
#pragma mark -查看信息化提示
- (IBAction)SumTiping:(id)sender {
    UIAlertView *sumtipAlertView = [[UIAlertView alloc] initWithTitle:nil message:@"单位通信及信息化业务关键人信息（包括姓名、联系方式等）" delegate:self cancelButtonTitle:nil otherButtonTitles:@"查看完毕",nil];

    sumtipAlertView.tag=123;
    [sumtipAlertView show];
}

- (IBAction)StatusTip:(id)sender {
    UIAlertView *statusTipAlertView = [[UIAlertView alloc] initWithTitle:nil message:@"4G信号覆盖情况；室分建设需求情况；单位家属小区宽带需求情况等" delegate:self cancelButtonTitle:nil otherButtonTitles:@"查看完毕",nil];
    
    statusTipAlertView.tag=133;
    [statusTipAlertView show];
}

- (IBAction)PotentialTip:(id)sender {
    UIAlertView *potentialTipAlertView = [[UIAlertView alloc] initWithTitle:nil message:@"单位潜在信息化需求（如集团专线、MAS、预存统购、工作终端等）；单位OA使用情况；省定58家网站资源引入情况" delegate:self cancelButtonTitle:nil otherButtonTitles:@"查看完毕",nil];
    
    potentialTipAlertView.tag=143;
    [potentialTipAlertView show];
}

- (IBAction)SummaryTip:(id)sender {
    UIAlertView *SummaryAlertView = [[UIAlertView alloc] initWithTitle:nil message:@"与我公司或竞争对手信息化签约情况，包括产品类型、数量、资费、合同金额、合同到期时间等" delegate:self cancelButtonTitle:nil otherButtonTitles:@"查看完毕",nil];
    
    SummaryAlertView.tag=154;
    [SummaryAlertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
//    if (alertView.tag==123) {
//        if (buttonIndex==0) {
//            
//        }
//    }
}
- (void)willPresentAlertView:(UIAlertView *)alertView {
    // 遍历 UIAlertView 所包含的所有控件
    for (UIView *tempView in alertView.subviews) {
        if ([tempView isKindOfClass:[UILabel class]]) {
            // 当该控件为一个 UILabel 时
            UILabel *tempLabel = (UILabel *) tempView;
            if ([tempLabel.text isEqualToString:alertView.message]) {
                // 调整对齐方式
               // tempLabel.textAlignment = UITextAlignmentLeft;
                // 调整字体大小
                [tempLabel setFont:[UIFont systemFontOfSize:12.0]];
                
            }
            
        }
        
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

-(void)addSummaryData:(NSDictionary*)bDict{
    
    [NetworkHandling sendPackageWithUrl:@"visitplan/addvisitplanresult" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        hubFlag=NO;
        if(!error){
            
            NSLog(@"sign in success");
            BOOL flag=[[result objectForKey:@"flag"] boolValue];
            if(flag){
        
                [self performSelectorOnMainThread:@selector(postSuccess) withObject:nil waitUntilDone:YES];
            }else{
                
                [self performSelectorOnMainThread:@selector(showMessage:) withObject:@"提交失败！" waitUntilDone:YES];
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
-(void)postSuccess{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (IBAction)goCameraOnclick:(id)sender {
    UIActionSheet *actionSheet=[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取 消" destructiveButtonTitle:@"相 机" otherButtonTitles:@"照片库", nil];
    actionSheet.tag=2;
    [actionSheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 0 || buttonIndex ==1){
        [self itemPhotographButtonOnclick:buttonIndex];
    }
    
}
-(void)itemPhotographButtonOnclick:(int)typeId{
    //检查相机模式是否可用
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        NSLog(@"sorry, no camera or camera is unavailable.");
        return;
    }
    
    //创建图像选取控制器
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    //设置图像选取控制器的来源模式为相机模式
    if(!typeId)
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    else
        imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    //设置图像选取控制器的类型为静态图像
    imagePickerController.mediaTypes = [[NSArray alloc] initWithObjects:kUTTypeImage, nil];
    //允许用户进行编辑
    imagePickerController.allowsEditing = YES;
    //设置委托对象
    imagePickerController.delegate = self;
    //以模视图控制器的形式显示
    [self presentViewController:imagePickerController animated:YES completion:nil];
}
#pragma mark –
#pragma mark Camera View Delegate Methods
//点击相册中的图片或者照相机照完后点击use 后触发的方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *image;
    [picker dismissViewControllerAnimated:YES completion:nil];//关掉照相机
    image = [info objectForKey:UIImagePickerControllerEditedImage];
    
    //把选中的图片添加到界面中
    //    [self performSelector:@selector(saveImage:) withObject:image afterDelay:0.5];
    [self performSelectorOnMainThread:@selector(saveImage:) withObject:image waitUntilDone:YES];
}

//点击cancel调用的方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}
//把图片添加到当前view中
- (void)saveImage:(UIImage *)image {
    self.visitImageView.image = image;
}
- (IBAction)zoomImageOnclick:(id)sender {
    if(!self.visitImageView.image)
        return;
    
    zoomImageView.image=self.visitImageView.image;
    zoomImageView.contentMode=UIViewContentModeScaleAspectFit;
    [self.navigationController.view addSubview:zoomImageView];
}

- (IBAction)Mobile4GButton:(id)sender {
    if (self.if_4g_trem.tag ==11) {
        self.if4gtremImage.image=[UIImage imageNamed:@"Selected.png"];
        self.if_4g_trem.tag =22;
       if4gtremString=@"是";
        return;
    }
   if (self.if_4g_trem.tag ==22) {
        self.if4gtremImage.image=[UIImage imageNamed:@"Unselected.png"];
       self.if_4g_trem.tag =11;
       if4gtremString=@"否";
       return;

    }
}

- (IBAction)ChangCard4GButton:(id)sender {
    if (self.if_4g_card.tag ==11) {
        self.if4gcardImage.image=[UIImage imageNamed:@"Selected.png"];
        self.if_4g_card.tag =22;
        if4gCardSrting=@"是";
        return;

    }
    if (self.if_4g_card.tag ==22) {
        self.if4gcardImage.image=[UIImage imageNamed:@"Unselected.png"];
        self.if_4g_card.tag =11;
        if4gCardSrting=@"否";
        return;
    }

}

- (IBAction)Taocang4GButton:(id)sender {
    if (self.if_4g_package.tag ==11) {
        self.if4gpackageImage.image=[UIImage imageNamed:@"Selected.png"];
        self.if_4g_package.tag =22;
        if4gPackage=@"是";
        return;
    }
    if (self.if_4g_package.tag ==22) {
        self.if4gpackageImage.image=[UIImage imageNamed:@"Unselected.png"];
        self.if_4g_package.tag =11;
        if4gPackage=@"否";
     return;
    }

}
@end
