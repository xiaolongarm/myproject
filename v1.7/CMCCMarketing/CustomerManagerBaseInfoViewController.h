//
//  CustomerManagerBaseInfoViewController.h
//  CMCCMarketing
//
//  Created by talkweb on 14-9-22.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Group.h"
#import "Channels.h"
#import "CustomerManager.h"

#pragma mark -代理方法
//@class CustomerManagerBaseInfoViewController;
@protocol CustomerManagerBaseInfoViewControllerDelegate <NSObject>
@optional  
-(void)CustomerManagerBaseInforDidfinished:(NSMutableDictionary*)baseInfoDict;
@end


@interface CustomerManagerBaseInfoViewController : UIViewController{
    id<CustomerManagerBaseInfoViewControllerDelegate> _baseInfodelegate;
}
#pragma mark -代理方法
@property(nonatomic,strong)id<CustomerManagerBaseInfoViewControllerDelegate> baseInfodelegate;

@property (weak, nonatomic) IBOutlet UIScrollView *informationScrollView;
@property (weak, nonatomic) IBOutlet UILabel *lbGroupName;
@property (weak, nonatomic) IBOutlet UILabel *lbGroupNameTitle;

@property (weak, nonatomic) IBOutlet UILabel *lbGroupCode;
@property (weak, nonatomic) IBOutlet UILabel *lbGroupCodeTitle;

@property (weak, nonatomic) IBOutlet UILabel *lbGroupType;
@property (weak, nonatomic) IBOutlet UILabel *lbGroupTypeTitle;

@property (weak, nonatomic) IBOutlet UILabel *lbGroupAddress;
@property (weak, nonatomic) IBOutlet UILabel *lbGroupAddressTitle;

@property (weak, nonatomic) IBOutlet UILabel *lbCreateDocDatetime;
@property (weak, nonatomic) IBOutlet UILabel *lbCreateDocDatetimeTitle;
//@property (weak, nonatomic) IBOutlet UILabel *lbEnterpriseType;
@property (weak, nonatomic) IBOutlet UILabel *lbIndustryType;
@property (weak, nonatomic) IBOutlet UILabel *lbIndustryTypeTitle;

@property (weak, nonatomic) IBOutlet UILabel *lbIndustrySubType;
@property (weak, nonatomic) IBOutlet UILabel *lbIndustrySubTypeTitle;
//@property (weak, nonatomic) IBOutlet UILabel *lbGroupTypeId;
@property (weak, nonatomic) IBOutlet UILabel *lbGroupLvl;
@property (weak, nonatomic) IBOutlet UILabel *lbGroupLvlTitle;
//@property (weak, nonatomic) IBOutlet UILabel *lbGroupGrade;
//@property (weak, nonatomic) IBOutlet UILabel *lbGroupAgencyType;
//@property (weak, nonatomic) IBOutlet UILabel *lbJoinNetworkChannels;
@property (weak, nonatomic) IBOutlet UILabel *lbSuperGroupId;
@property (weak, nonatomic) IBOutlet UILabel *lbSuperGroupIdTitle;

@property (weak, nonatomic) IBOutlet UILabel *lbGroupState;
@property (weak, nonatomic) IBOutlet UILabel *lbGroupStateTitle;

@property (weak, nonatomic) IBOutlet UILabel *lbAreaState;
@property (weak, nonatomic) IBOutlet UILabel *lbAreaStateTitle;
/**
 *  @brief  主管添加属性 客户经理电话
 */
@property (weak, nonatomic) IBOutlet UILabel *lbCustomerManagerPhone;
@property (weak, nonatomic) IBOutlet UILabel *lbCustomerManagerPhoneTitle;
/**
 *  @brief  主管添加属性 客户经理名字
 */
@property (weak, nonatomic) IBOutlet UILabel *lbCustomerManagerName;
@property (weak, nonatomic) IBOutlet UILabel *lbCustomerManagerNameTitle;



//新增集团人数
@property (weak, nonatomic) IBOutlet UILabel *lbGrounpNum;
@property (weak, nonatomic) IBOutlet UILabel *dispGrounpNum;
//新增集团关键产品和非关键集团产品
@property (weak, nonatomic) IBOutlet UILabel *lbkeyProducteTitle;
@property (weak, nonatomic) IBOutlet UILabel *dispKeyProducte;
@property (weak, nonatomic) IBOutlet UILabel *lbnotKeyProducteTitle;
@property (weak, nonatomic) IBOutlet UILabel *dispNotKeyProducte;



@property(nonatomic,assign)int listType;
@property(nonatomic,strong)Group *group;
@property(nonatomic,strong)Channels *channels;
@property(nonatomic,strong)NSDictionary *littleDict;
@property(nonatomic,strong)CustomerManager *customerManager;
//合约信息按钮
- (IBAction)contrantButton:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *contrantButtonOutlet;

-(void)refreshViewData;
@end



