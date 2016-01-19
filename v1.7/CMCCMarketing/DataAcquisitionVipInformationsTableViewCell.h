//
//  DataAcquisitionVipInformationsTableViewCell.h
//  CMCCMarketing
//
//  Created by gmj on 14-12-18.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DataAcquisitionVipInformationsTableViewCell : UITableViewCell<UITextFieldDelegate,UITextViewDelegate>


/*
visit_id:this.planId,//
 
linkman_name:utils.chinese2unicode(linkman_name),//关键人姓名
 
linkman_msisdn:linkman_msisdn,//关键人联系电话
 
grp_code:this.groupInfo.groupID,	//归属集团//
grp_name:utils.chinese2unicode(this.groupInfo.groupName),//
 
grp_lvl:this.groupInfo.grp_lvl,	//集团单位级别//
 
linkman_depart:utils.chinese2unicode(linkman_depart),//所属部门
 
linkman_job:utils.chinese2unicode(linkman_job),//所在职务
 
linkman_type:utils.chinese2unicode(linkman_type),//关键人类型
 
linkman_buss:utils.chinese2unicode(linkman_buss),//分管业务
 
is_diff_key:utils.chinese2unicode(is_diff_key),//是否异网关键人
 
diff_type:utils.chinese2unicode(diff_type),//异网关键人归属
 
linkman_msisdn_bak:linkman_msisdn_bak,//关键人其他电话
 
is_grp_sa:utils.chinese2unicode(is_grp_sa),	//是否为集团sa单位
 
is_def_linkman:utils.chinese2unicode(is_def_linkman),//是否日常拜访目标
 
 
is_two_grp:utils.chinese2unicode(is_two_grp),//是否二级机构//
p_grp_name:utils.chinese2unicode(this.groupInfo.super_group_name),//上级机构名称//
 
 
remark:utils.chinese2unicode(remark),//备注
explan:utils.chinese2unicode(explan)//说明
*/

@property (weak, nonatomic) IBOutlet UITextField *txt_linkman_name;//关键人姓名

@property (weak, nonatomic) IBOutlet UITextField *txt_linkman_msisdn;//关键人联系电话

@property (weak, nonatomic) IBOutlet UIButton *btn_linkman_type;//关键人类型

@property (weak, nonatomic) IBOutlet UITextField *txt_linkman_depart;//所属部门

@property (weak, nonatomic) IBOutlet UITextField *txt_linkman_job;//所在职务

@property (weak, nonatomic) IBOutlet UIButton *btn_linkman_buss;//分管业务

@property (weak, nonatomic) IBOutlet UISwitch *switch_is_diff_key;//是否异网关键人

@property (weak, nonatomic) IBOutlet UIButton *btn_diff_type;//异网关键人归属

@property (weak, nonatomic) IBOutlet UITextField *txt_linkman_msisdn_bak;//关键人其他电话

@property (weak, nonatomic) IBOutlet UISwitch *switch_is_grp_sa;//是否为集团sa单位

@property (weak, nonatomic) IBOutlet UISwitch *switch_is_def_linkman;//是否日常拜访目标

@property (weak, nonatomic) IBOutlet UITextView *txtView_remark;//备注

@property (weak, nonatomic) IBOutlet UITextView *txtView_explan;//说明
@end
