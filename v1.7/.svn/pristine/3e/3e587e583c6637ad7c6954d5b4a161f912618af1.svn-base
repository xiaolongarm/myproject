//
//  DataAcquisitionClientServerSegueTableViewController.h
//  CMCCMarketing
//
//  Created by gmj on 14-12-18.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import "User.h"
#import "Group.h"

#import "W_VisitPlanAddSelectGroupTableViewController.h"
#import "PreferentialPurchaseSelectDateTimeViewController.h"

@interface DataAcquisitionClientServerSegueTableViewController : UITableViewController<UITextFieldDelegate,UIActionSheetDelegate,VisitPlanAddSelectGroupTableViewControllerDelegate,PreferentialPurchaseSelectDateTimeViewControllerDelegate>


@property(nonatomic,strong)User *user;
@property(nonatomic,strong)Group *selectGroup;//选择的集团客户
@property (weak,nonatomic)UIButton *selectedButton;//选择的Button

@property (strong,nonatomic) NSString *visit_id;

@property (weak, nonatomic) IBOutlet UIButton *btnGroupName;
- (IBAction)btnGroupNameOnClick:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *txt_user_name;//客户姓名
@property (weak, nonatomic) IBOutlet UITextField *txt_user_msisdn;//客户号码

@property (weak, nonatomic) IBOutlet UISwitch *switch_is_linkman;//是否关键人
@property (weak, nonatomic) IBOutlet UISwitch *switch_is_act_part;//是否参加关键人活动
@property (weak, nonatomic) IBOutlet UISwitch *switch_is_m_plan;//关键人当月是否已拜访

@property (weak, nonatomic) IBOutlet UIButton *btn_plan_time;//关键人最近拜访时间
- (IBAction)btn_plan_timeOnClick:(id)sender;

@property (weak, nonatomic) IBOutlet UISwitch *switch_is_add_val_sev;//是否参与增值服务
@property (weak, nonatomic) IBOutlet UIButton *btn_add_val_sev_type;//参与增值服务类型
- (IBAction)btn_add_val_sev_typeOnClick:(id)sender;

@property (weak, nonatomic) IBOutlet UISwitch *switch_is_survey;//是否参与满意度调查
@property (weak, nonatomic) IBOutlet UITextField *txt_is_score;//满意度调查评价分值

@property (weak, nonatomic) IBOutlet UIButton *btn_complaint_time;//最近投诉时间
- (IBAction)btn_complaint_timeOnClick:(id)sender;

@property (weak, nonatomic) IBOutlet UISwitch *switch_is_repair;//投诉修复是否满意

@end
