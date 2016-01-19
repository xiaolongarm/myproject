//
//  W_VisitPlanDetailsViewController.h
//  CMCCMarketing
//
//  Created by gmj on 14-11-25.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface W_VisitPlanDetailsViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>


@property (strong,nonatomic)NSDictionary *dicSelectVisitPlanDetail;

@property (strong,nonatomic)NSDictionary *messagePassDict;

@property (strong,nonatomic)NSArray *tbReplyList;

@property(nonatomic,strong)User *user;


@property(nonatomic,strong)NSString *fromMessage;
@property(nonatomic,strong)NSString  *passVisitID;
//拜访类型数据-kevin
@property (weak, nonatomic) IBOutlet UILabel *visit_type;
@property (weak, nonatomic) IBOutlet UILabel *disp_visit_type;

@property (strong, nonatomic) IBOutlet UITableView *tbViewReply;

@property (weak, nonatomic) IBOutlet UILabel *lblvisit_grp_name;
@property (strong, nonatomic) IBOutlet UILabel *dispStartTime;
@property (strong, nonatomic) IBOutlet UILabel *dispEndTime;

@property (weak, nonatomic) IBOutlet UILabel *lblvisit_statr_time;
@property (weak, nonatomic) IBOutlet UILabel *lblvisit_end_time;
@property (weak, nonatomic) IBOutlet UILabel *lblvisit_grp_add;
@property (weak, nonatomic) IBOutlet UILabel *lbllinkman;
@property (weak, nonatomic) IBOutlet UILabel *lblvip_mngr_name;
@property (weak, nonatomic) IBOutlet UILabel *lblvisit_remind;
@property (weak, nonatomic) IBOutlet UILabel *lblindb_date;
@property (weak, nonatomic) IBOutlet UILabel *lblvisit_remark;
@property (weak, nonatomic) IBOutlet UILabel *lblvisit_sta;
@property (weak, nonatomic) IBOutlet UILabel *lblvisit_examine_result;//审核意见

@property (weak,nonatomic) IBOutlet UILabel *lbAccman;
@property (weak,nonatomic) IBOutlet UILabel *lbCheckInTime;
@property (strong, nonatomic) IBOutlet UILabel *lbCheckInAddress;
@property (weak,nonatomic) IBOutlet UILabel *lbCheckOutTime;
@property (weak,nonatomic) IBOutlet UILabel *lbCheckInTimeTitle;
@property (strong, nonatomic) IBOutlet UILabel *lbCheckInAddressTitle;
@property (weak,nonatomic) IBOutlet UILabel *lbCheckOutTimeTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbRemarkTitle;
@property (strong, nonatomic) IBOutlet UILabel *lbRemark;
//签到标签以及图片
@property (weak, nonatomic) IBOutlet UILabel *signPicLabel;
@property (weak, nonatomic) IBOutlet UIImageView *sign_address_pic;
//总结标签以及图片
@property (weak, nonatomic) IBOutlet UILabel *sumPicLabel;
@property (weak, nonatomic) IBOutlet UIImageView *sumPic;
//新增部分字段的label值-Kevin 2015-6-10
@property (weak, nonatomic) IBOutlet UILabel *card_4g;
@property (weak, nonatomic) IBOutlet UILabel *term_cnt;
@property (weak, nonatomic) IBOutlet UILabel *flow_cnt;
@property (weak, nonatomic) IBOutlet UILabel *other_cnt;
//新增部分字段的显示label
@property (weak, nonatomic) IBOutlet UILabel *disp_card_4g;
@property (weak, nonatomic) IBOutlet UILabel *disp_term_cnt;
@property (weak, nonatomic) IBOutlet UILabel *disp_flow_cnt;
@property (weak, nonatomic) IBOutlet UILabel *disp_other_cnt;
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
//新增部分字段的显示label
@property (weak, nonatomic) IBOutlet UILabel *disp_if_gift;
@property (weak, nonatomic) IBOutlet UILabel *disp_gift_name;
@property (weak, nonatomic) IBOutlet UILabel *disp_if_4g_trem;
@property (weak, nonatomic) IBOutlet UILabel *disp_if_4g_card;
@property (weak, nonatomic) IBOutlet UILabel *disp_if_4g_package;
@property (weak, nonatomic) IBOutlet UILabel *disp_test_4g;

@property (weak, nonatomic) IBOutlet UILabel *disp_information_recommend;
@property (weak, nonatomic) IBOutlet UILabel *disp_business_excavate;
@property (weak, nonatomic) IBOutlet UILabel *disp_project_follow;
//新增部分字段的label值
@property (weak, nonatomic) IBOutlet UILabel *if_gift;
@property (weak, nonatomic) IBOutlet UILabel *gift_name;
@property (weak, nonatomic) IBOutlet UILabel *if_4g_trem;
@property (weak, nonatomic) IBOutlet UILabel *if_4g_card;
@property (weak, nonatomic) IBOutlet UILabel *if_4g_package;

@property (weak, nonatomic) IBOutlet UILabel *information_recommend;
@property (weak, nonatomic) IBOutlet UILabel *business_excavate;
@property (weak, nonatomic) IBOutlet UILabel *project_follow;
@property (weak, nonatomic) IBOutlet UILabel *test_4g;
//新增部分字段的标题框
@property (weak, nonatomic) IBOutlet UILabel *titleGift;
@property (weak, nonatomic) IBOutlet UILabel *contact4G;
@property (weak, nonatomic) IBOutlet UILabel *titleTest4G;
@property (weak, nonatomic) IBOutlet UILabel *TtitleDeal;
//新增信息化
@property (strong, nonatomic) IBOutlet UILabel *infmTitle;
@property (strong, nonatomic) IBOutlet UILabel *infmUnitTitle;
@property (strong, nonatomic) IBOutlet UILabel *infmUnitText;
@property (strong, nonatomic) IBOutlet UILabel *infmStatusTitle;
@property (strong, nonatomic) IBOutlet UILabel *infmStatusText;
@property (strong, nonatomic) IBOutlet UILabel *infmpotentialTitle;
@property (strong, nonatomic) IBOutlet UILabel *infmpotentialText;
- (IBAction)UnitShowMore:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *unitBtn;
- (IBAction)StatusShowMore:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *statusBtn;
- (IBAction)PotentialShowMore:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *potentialBtn;




//底部输入框所需要的输入框约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *DviewBottomConst;
//
@property (weak, nonatomic) IBOutlet UIView *inTableContentview;

- (IBAction)addVisitPlanReplyOnClick:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *txtReplyContent;

@property (weak, nonatomic) IBOutlet UIView *viewFoot;
//@property (weak, nonatomic) IBOutlet UITextField *txtFieldReply;
- (IBAction)clickZoomOutSignInPic:(id)sender;

- (IBAction)clickZoomOutSumPic:(id)sender;


@end
