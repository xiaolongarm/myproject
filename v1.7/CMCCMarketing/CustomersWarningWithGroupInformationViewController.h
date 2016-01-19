//
//  CustomersWarningWithGroupInformationViewController.h
//  CMCCMarketing
//
//  Created by talkweb on 14-11-4.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Group.h"

@interface CustomersWarningWithGroupInformationViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *lbGroupName;
@property (weak, nonatomic) IBOutlet UILabel *lbGroupCode;
@property (weak, nonatomic) IBOutlet UILabel *lbGroupType;
@property (weak, nonatomic) IBOutlet UILabel *lbGroupAddress;
@property (weak, nonatomic) IBOutlet UILabel *lbCreateDocDatetime;
//@property (weak, nonatomic) IBOutlet UILabel *lbEnterpriseType;
@property (weak, nonatomic) IBOutlet UILabel *lbIndustryType;
@property (weak, nonatomic) IBOutlet UILabel *lbIndustrySubType;
//@property (weak, nonatomic) IBOutlet UILabel *lbGroupTypeId;
@property (weak, nonatomic) IBOutlet UILabel *lbGroupLvl;
//@property (weak, nonatomic) IBOutlet UILabel *lbGroupGrade;
//@property (weak, nonatomic) IBOutlet UILabel *lbGroupAgencyType;
//@property (weak, nonatomic) IBOutlet UILabel *lbJoinNetworkChannels;
@property (weak, nonatomic) IBOutlet UILabel *lbSuperGroupId;
@property (weak, nonatomic) IBOutlet UILabel *lbGroupState;

@property (weak, nonatomic) IBOutlet UILabel *lbCustomerManagerTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbCustomerManager;
@property (weak, nonatomic) IBOutlet UILabel *lbCustomerManagerPhoneTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbCustomerManagerPhone;
//长沙客户端新增集团人数字段
@property (weak, nonatomic) IBOutlet UILabel *lbGrounpNum;
@property (weak, nonatomic) IBOutlet UILabel *dispGrounpNum;

@property(nonatomic,strong)Group *group;
@property(nonatomic,strong)NSDictionary *groupDetails;
@end
