//
//  CustomersWarningWithGroupInformationViewController.m
//  CMCCMarketing
//
//  Created by talkweb on 14-11-4.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import "CustomersWarningWithGroupInformationViewController.h"

@interface CustomersWarningWithGroupInformationViewController ()

@end

@implementation CustomersWarningWithGroupInformationViewController

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
    
    self.lbGroupName.text=self.group.groupName;
    self.lbGroupCode.text=self.group.groupId;
    self.lbGroupType.text=self.group.groupTypeName;
    self.lbGroupAddress.text=self.group.groupAddress;
    [self.lbGroupAddress setAdjustsFontSizeToFitWidth:YES];
    self.lbCreateDocDatetime.text=self.group.groupCreateDocDate;
//    self.lbEnterpriseType.text=@"";
    self.lbIndustryType.text=self.group.groupIndustryTypeName;
    self.lbIndustrySubType.text=self.group.groupIndustrySubTypeName;
//    self.lbGroupTypeId.text=@"";
    self.lbGroupLvl.text=self.group.groupLvl;
//    self.lbGroupGrade.text=@"";
//    self.lbGroupAgencyType.text=@"";
//    self.lbJoinNetworkChannels.text=@"";
    self.lbSuperGroupId.text=self.group.groupSuperGroupId;
    if([self.group.groupSts isEqualToString:@"0"])
        self.lbGroupState.text=@"正常";
    else
        self.lbGroupState.text=@"未知";
    
    self.title=self.group.groupName;
    
    
#ifdef MANAGER_SY_VERSION
    self.lbCustomerManagerPhoneTitle.text=@"营销经理：";
    self.lbCustomerManagerTitle.text=@"营销经理电话：";
#endif

#if (defined MANAGER_SY_VERSION) || (defined MANAGER_CS_VERSION)
    self.lbCustomerManager.text=[self.groupDetails objectForKey:@"vip_mngr_name"];
    self.lbCustomerManagerPhone.text=[self.groupDetails objectForKey:@"vip_mngr_msisdn"];
#endif
    
#if (defined STANDARD_CS_VERSION) || (defined STANDARD_SY_VERSION)
    self.lbCustomerManager.hidden=YES;
    self.lbCustomerManagerPhone.hidden=YES;
    self.lbCustomerManagerPhoneTitle.hidden=YES;
    self.lbCustomerManagerTitle.hidden=YES;
#endif
    
//    //*****为长沙主管，客户经理新增 拜访类型  4G换卡 终端销售 流量套餐 其它字段
//#if (defined MANAGER_CS_VERSION) || (defined STANDARD_CS_VERSION)
//    
    self.dispGrounpNum.text= [NSString stringWithFormat:@"%d",self.group.groupNumber] ;
//#endif
//    
//    //*****不为长沙主管，客户经理新增 拜访类型  4G换卡 终端销售 流量套餐 其它字段
//#if (defined STANDARD_SY_VERSION) || (defined MANAGER_SY_VERSION)
//    self.dispGrounpNum.hidden=YES;
//    self.lbGrounpNum.hidden=YES;
//#endif

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
