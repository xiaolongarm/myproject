//
//  MarketingGroupDetailsViewController.m
//  CMCCMarketing
//
//  Created by talkweb on 14-10-10.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import "MarketingGroupDetailsViewController.h"

@interface MarketingGroupDetailsViewController ()

@end

@implementation MarketingGroupDetailsViewController

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
    
    self.title=self.group.groupName;
//    //*****为长沙主管，客户经理新增 拜访类型  4G换卡 终端销售 流量套餐 其它字段
//#if (defined MANAGER_CS_VERSION) || (defined STANDARD_CS_VERSION)
    
    self.dispGrounpNum.text= [NSString stringWithFormat:@"%d",self.group.groupNumber] ;
//#endif
//    
//    //*****不为长沙主管，客户经理新增 拜访类型  4G换卡 终端销售 流量套餐 其它字段
//#if (defined STANDARD_SY_VERSION) || (defined MANAGER_SY_VERSION)
//    self.dispGrounpNum.hidden=YES;
//    self.lbGrounpNum.hidden=YES;
//#endif
//
    
    lbGroupName.text=self.group.groupName;
    lbGroupName.adjustsFontSizeToFitWidth=YES;
    lbGroupId.text=self.group.groupId;
    lbGroupType.text=self.group.groupTypeName;
    lbGroupAddress.text=self.group.groupAddress;
    lbGroupAddress.adjustsFontSizeToFitWidth=YES;
    lbGroupCreateDocDate.text=self.group.groupCreateDocDate;
//    lbGroupOwnershipType.text=@"";
    lbGroupIndustryType.text=self.group.groupIndustryTypeName;
    lbGroupIndustrySubType.text=self.group.groupIndustrySubTypeName;
//    lbGroupClassId.text=@"";
    lbGroupGrade.text=self.group.groupLvl;
//    lbGroupLevel.text=self.group.groupLvl;
//    lbGroupAgency.text=@"";
//    lbGroupIntoTheChannel.text=@"";
    lbGroupParentId.text=self.group.groupSuperGroupId;
    lbGroupState.text=@"未知";
    if([self.group.groupSts isEqualToString:@"0"])
        lbGroupState.text=@"正常";
}

//{
//    "baidu_latitude" = "";
//    "baidu_longtitude" = "";
//    contactName = "\U67f3\U7434";
//    contactPhone = 13974821522;
//    "create_doc_date" = 20040601;
//    "didu_type" = 1;
//    flag = 1;
//    groupID = 7311000008;
//    groupName = "\U6e56\U5357\U516c\U8def\U7269\U8d28\U8bbe\U5907\U516c\U53f8";
//    "group_sts" = 0;
//    "grp_addr" = "\U6e56\U5357\U7701\U957f\U6c99\U5e02\U5f00\U798f\U533a\U516b\U4e00\U8def520\U53f7";
//    "grp_lvl" = A2;
//    "industry_sub_typ_name" = "\U6279\U53d1\U4e1a";
//    "industry_typ_name" = "\U6279\U53d1\U548c\U96f6\U552e\U4e1a";
//    latitude = "";
//    longtitude = "";
//    serviceCode = 3100000031066334;
//    "super_group_id" = "";
//}

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
