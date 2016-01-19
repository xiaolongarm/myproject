//
//  W_VisistPlanSummaryViewController.h
//  CMCCMarketing
//
//  Created by gmj on 14-11-27.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface W_VisistPlanSummaryViewController : UIViewController <UITextViewDelegate,UITextFieldDelegate>

@property(nonatomic,strong)User *user;

@property (strong,nonatomic)NSDictionary *dicSelectVisitPlanDetail;
@property (strong, nonatomic) IBOutlet UIScrollView *xScrollview;

@property (weak, nonatomic) IBOutlet UILabel *lblVisit_grp_name;
@property (weak, nonatomic) IBOutlet UILabel *lblLinkman;
@property (weak, nonatomic) IBOutlet UILabel *lblVip_mngr_name;
@property (weak, nonatomic) IBOutlet UILabel *lblVip_mngr_msisdn;
@property (weak, nonatomic) IBOutlet UILabel *lblVisit_grp_add;
@property (weak, nonatomic) IBOutlet UITextView *txtViewContent;
@property (weak, nonatomic) IBOutlet UIImageView *visitImageView;

//增加输入参数
//输入框前得四个参数
@property (weak, nonatomic) IBOutlet UILabel *lbCard;
@property (weak, nonatomic) IBOutlet UILabel *lbSales;
@property (weak, nonatomic) IBOutlet UILabel *lbdataFlow;
@property (weak, nonatomic) IBOutlet UILabel *lbOther;
//输入框
@property (weak, nonatomic) IBOutlet UITextField *Card4gInput;
@property (weak, nonatomic) IBOutlet UITextField *termSales;
@property (weak, nonatomic) IBOutlet UITextField *dataFlowInput;
@property (weak, nonatomic) IBOutlet UITextField *otherInput;

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
@property (weak, nonatomic) IBOutlet UILabel *titleGift;
@property (weak, nonatomic) IBOutlet UILabel *title4g;
@property (weak, nonatomic) IBOutlet UILabel *title4gNetwork;
@property (weak, nonatomic) IBOutlet UILabel *tilteDeal;
//新增部分字段的显示label
@property (weak, nonatomic) IBOutlet UILabel *disp_if_gift;
@property (weak, nonatomic) IBOutlet UILabel *disp_gift_name;
//@property (weak, nonatomic) IBOutlet UILabel *disp_if_4g_trem;
//@property (weak, nonatomic) IBOutlet UILabel *disp_if_4g_card;
//@property (weak, nonatomic) IBOutlet UILabel *disp_if_4g_package;
//@property (weak, nonatomic) IBOutlet UILabel *disp_test_4g;

@property (weak, nonatomic) IBOutlet UILabel *disp_information_recommend;
@property (weak, nonatomic) IBOutlet UILabel *disp_business_excavate;
@property (weak, nonatomic) IBOutlet UILabel *disp_project_follow;
//新增部分字段的label值
@property (weak, nonatomic) IBOutlet UISwitch *if_gift;
@property (weak, nonatomic) IBOutlet UITextField *gift_name;
@property (weak, nonatomic) IBOutlet UIImageView *if4gtremImage;
@property (weak, nonatomic) IBOutlet UIImageView *if4gcardImage;
@property (weak, nonatomic) IBOutlet UIImageView *if4gpackageImage;

@property (weak, nonatomic) IBOutlet UIButton *if_4g_trem;
@property (weak, nonatomic) IBOutlet UIButton *if_4g_card;
@property (weak, nonatomic) IBOutlet UIButton *if_4g_package;

@property (weak, nonatomic) IBOutlet UITextView *information_recommend;
@property (weak, nonatomic) IBOutlet UITextView *business_excavate;
@property (weak, nonatomic) IBOutlet UITextView *project_follow;
@property (weak, nonatomic) IBOutlet UISegmentedControl *test_4g;
//新增信息化
@property (strong, nonatomic) IBOutlet UILabel *informationTitle;

@property (strong, nonatomic) IBOutlet UILabel *inmfUnitTitle;
@property (strong, nonatomic) IBOutlet UITextView *inmfUnitText;
@property (strong, nonatomic) IBOutlet UILabel *inmfStatusTitle;
@property (strong, nonatomic) IBOutlet UITextView *inmfStatusText;
@property (strong, nonatomic) IBOutlet UILabel *infmPotentialTitle;
@property (strong, nonatomic) IBOutlet UITextView *infmPotentialText;

- (IBAction)SumTiping:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *baseInfm;

- (IBAction)StatusTip:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *statusInfm;

- (IBAction)PotentialTip:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *InneedInfm;

- (IBAction)SummaryTip:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *contentButton;


- (IBAction)IfGiftButton:(id)sender;

- (IBAction)Mobile4GButton:(id)sender;
- (IBAction)ChangCard4GButton:(id)sender;
- (IBAction)Taocang4GButton:(id)sender;

- (IBAction)Test4gButton:(id)sender;
- (IBAction)toVisitPlanDetailOnClick:(id)sender;


@property (strong, nonatomic) IBOutlet UIButton *tipButton;


@end
