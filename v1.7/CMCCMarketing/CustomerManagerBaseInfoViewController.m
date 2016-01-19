//
//  CustomerManagerBaseInfoViewController.m
//  CMCCMarketing
//
//  Created by talkweb on 14-9-22.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import "CustomerManagerBaseInfoViewController.h"
#import "ContrantListTableViewController.h"

@interface CustomerManagerBaseInfoViewController ()

@end

@implementation CustomerManagerBaseInfoViewController

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
    self.contrantButtonOutlet.backgroundColor = [UIColor colorWithRed:102.0/255 green:188.0/255 blue:230.0/255 alpha:1];
    
    [self refreshViewData];
}
-(void)viewDidLayoutSubviews
{
    self.informationScrollView.contentSize = CGSizeMake(320, 1000);
}

-(void)refreshViewData{
//    BOOL bounces                      控制控件遇到边框是否反弹
//    BOOL alwaysBounceVertical   控制垂直方向遇到边框是否反弹
//    BOOL alwaysBounceHorizontal 控制水平方向遇到边框是否反弹
    self.informationScrollView .contentSize = CGSizeMake(320, 1000);
    self.informationScrollView.showsVerticalScrollIndicator=YES;
    
    //listTyp为使用判别为集团信息还是邵阳端渠道信息，长沙中小集团
    if (self.listType == 0) {
               self.dispGrounpNum.text= [NSString stringWithFormat:@"%d",self.group.groupNumber] ;
        
        self.lbGroupName.text=self.group.groupName;
        self.lbGroupName.adjustsFontSizeToFitWidth=YES;
        self.lbGroupCode.text=self.group.groupId;
        self.lbGroupType.text=self.group.groupTypeName;
        
        NSString *addressString = self.group.groupAddress;
        if(self.group.groupflag == 0)
            addressString = [addressString stringByAppendingString:@" (未审核)"];
        if(self.group.groupflag == 2)
            addressString = [addressString stringByAppendingString:@" (审核失败)"];
        
        self.lbGroupAddress.text=addressString;
        self.lbGroupAddress.numberOfLines = 2;
        self.lbGroupAddress.adjustsFontSizeToFitWidth=YES;
        
        NSDateFormatter *dateformatter =[[NSDateFormatter alloc] init];
        [dateformatter setDateFormat:@"yyyyMMdd"];
        NSDate *date =[dateformatter dateFromString:self.group.groupCreateDocDate];
        
        NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
        [dateFormatter1 setDateFormat:@"yyyy年MM月dd日"];
        
        self.lbCreateDocDatetime.text=[dateFormatter1 stringFromDate:date];
        self.lbIndustryType.text=self.group.groupIndustryTypeName;
        self.lbIndustrySubType.text=self.group.groupIndustrySubTypeName;
        self.lbGroupLvl.text=self.group.groupLvl;
        self.lbSuperGroupId.text=self.group.groupSuperGroupId;
        self.lbGroupState.text=@"未知";
        if([self.group.groupSts isEqualToString:@"0"])
            self.lbGroupState.text=@"正常";
        //
        self.lbkeyProducteTitle.text=@"集团关键产品:";
        NSString *Keystring =self.group.grpKeyProd;
        NSArray *array = [Keystring componentsSeparatedByString:@","];
        self.dispKeyProducte.numberOfLines = [array count];
        NSString *AppendString=[Keystring stringByReplacingOccurrencesOfString:@"," withString:@"\n"];
        self.dispKeyProducte.adjustsFontSizeToFitWidth=YES;
        self.dispKeyProducte.text=AppendString;
        //非关键产品
        self.lbnotKeyProducteTitle.text=@"集团非关键产品:";
        NSString *notKeystring =self.group.grpElseProd;
        NSArray *notarray = [notKeystring componentsSeparatedByString:@","];
        self.dispKeyProducte.numberOfLines = [notarray count];
        NSString *notAppendString=[notKeystring stringByReplacingOccurrencesOfString:@"," withString:@"\n"];
        self.dispNotKeyProducte.adjustsFontSizeToFitWidth=YES;
        self.dispNotKeyProducte.text=notAppendString;
#ifdef MANAGER_CS_VERSION
        self.lbCustomerManagerNameTitle.hidden=NO;
        self.lbCustomerManagerName.hidden=NO;
        self.lbCustomerManagerPhoneTitle.hidden=NO;
        self.lbCustomerManagerPhone.hidden=NO;
        
        self.lbCustomerManagerName.text=self.customerManager.vip_mngr_name;
        self.lbCustomerManagerPhone.text=self.customerManager.vip_mngr_msisdn;
#endif

    }
    else if (self.listType == 1) {
        self.lbGroupNameTitle.text = @"渠道名称:";
        self.lbGroupCodeTitle.text = @"渠道类型:";
        self.lbGroupTypeTitle.text = @"渠道编码:";
        self.lbGroupAddressTitle.text = @"区域经理名称:";
        self.lbCreateDocDatetimeTitle.text = @"区域经理手机号码:";
        self.lbIndustryTypeTitle.text = @"区域经理BOSS工号:";
        self.lbIndustrySubTypeTitle.text = @"所属乡镇营业部:";
        self.lbGroupLvlTitle.text = @"乡镇营业部经理姓名:";
        self.lbSuperGroupIdTitle.text = @"乡镇营业部经理手机:";
        self.lbGroupStateTitle.text = @"区县名称:";
        self.lbAreaStateTitle.text = @"区县编码:";
//        self.lbAreaStateTitle.text = @"a:";
        self.lbAreaStateTitle.hidden=NO;
        self.lbAreaState.hidden=NO;
        self.lbGroupName.text = self.channels.chnl_name;
        self.lbGroupCode.text = self.channels.chnl_type;
        self.lbGroupType.text = self.channels.vip_mngr_card;
        self.lbGroupAddress.text = self.channels.business_dept_mngr;
        self.lbCreateDocDatetime.text = self.channels.chnl_boss_msisdn;
        self.lbIndustryType.text = self.channels.chnl_boss_card;
        self.lbIndustrySubType.text = self.channels.grp_addr;
//        self.lbIndustrySubType.numberOfLines = 2;
        self.lbGroupLvl.text = self.channels.vip_mngr_name;
        self.lbSuperGroupId.text = self.channels.vip_mngr_msisdn;
        self.lbGroupState.text = self.channels.cnty_name;
        self.lbAreaState.text = self.channels.cnty_id;
        /**
         *  隐藏合约按钮
         */
        self.contrantButtonOutlet.hidden=YES;
    }
    else if (self.listType == 2){
        //中小集团显示标题
         self.lbGroupTypeTitle.text=@"集团状态:";
        self.lbGrounpNum.text=@"集团门牌号:";
        self.lbGroupAddressTitle.text=@"楼宇名称:";
        self.lbCreateDocDatetimeTitle.text=@"楼宇区县:";
        self.lbIndustryTypeTitle.text=@"楼宇街道:";
        self.lbIndustrySubTypeTitle.text=@"楼宇详细地址:";
        self.lbGroupLvlTitle.text=@"专业市场类别:";
        //中小集团显示数据
         self.lbGroupName.text =[self.littleDict objectForKey:@"grp_name"];
         self.lbGroupCode.text =[self.littleDict objectForKey:@"grp_code"];
        if([[self.littleDict objectForKey:@"state"] isEqualToString:@"0" ]){
            self.lbGroupType.text = @"未审核";}
        if([[self.littleDict objectForKey:@"state"] isEqualToString:@"1"]){
            self.lbGroupType.text =@" 通过审核";
        }
        if([[self.littleDict objectForKey:@"state"] isEqualToString:@"2"]){
        self.lbGroupType.text =@"审核失败";
        }
        self.dispGrounpNum.text=[self.littleDict objectForKey:@"grp_address"];
        self.lbGroupAddress.text=[self.littleDict objectForKey:@"market_name"];
        self.lbCreateDocDatetime.text=[self.littleDict objectForKey:@"b_cnty_name"];
        self.lbIndustryType.text=[self.littleDict objectForKey:@"b_street"];
        self.lbIndustrySubType.text=[self.littleDict objectForKey:@"grp_addr"];
        self.lbGroupLvl.text=[self.littleDict objectForKey:@"market_tpye"];
          //中小集团需要隐藏的部分
        self.lbSuperGroupIdTitle.hidden=YES;
        self.lbGroupStateTitle.hidden=YES;
        self.lbAreaStateTitle.hidden=YES;
         self.lbCustomerManagerPhoneTitle.hidden=YES;
         //self.dispKeyProducte.hidden=YES;
        self.lbCustomerManagerNameTitle.hidden=YES;
        self.lbCustomerManagerName.hidden=YES;
        self.lbCustomerManagerPhoneTitle.hidden=YES;
        self.lbCustomerManagerPhone.hidden=YES;
        /**
         *  隐藏合约按钮
         */
        self.contrantButtonOutlet.hidden=YES;
        
            }
//#if (defined STANDARD_CS_VERSION) || (defined STANDARD_SY_VERSION)
    //新增关键产品
   //#endif
    

    
#ifdef MANAGER_SY_VERSION
    self.lbCustomerManagerNameTitle.hidden=NO;
    self.lbCustomerManagerName.hidden=NO;
    self.lbCustomerManagerPhoneTitle.hidden=NO;
    self.lbCustomerManagerPhone.hidden=NO;
    
    self.lbCustomerManagerNameTitle.text=@"营销经理：";
    self.lbCustomerManagerPhoneTitle.text=@"营销经理电话号码：";
    if (self.listType == 1) {
        self.lbCustomerManagerNameTitle.hidden = YES;
        self.lbCustomerManagerPhoneTitle.hidden = YES;
    }
    
    self.lbCustomerManagerName.text=self.customerManager.vip_mngr_name;
    self.lbCustomerManagerPhone.text=self.customerManager.vip_mngr_msisdn;
#endif
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

- (IBAction)contrantButton:(id)sender {
    NSMutableDictionary *dcit=[[NSMutableDictionary alloc]init];
    [dcit setObject:self.group.groupId forKey:@"grp_code"];
//    [self.baseInfodelegate CustomerManagerBaseInforDidfinished:dcit];
    [_baseInfodelegate CustomerManagerBaseInforDidfinished:dcit];
}
@end
