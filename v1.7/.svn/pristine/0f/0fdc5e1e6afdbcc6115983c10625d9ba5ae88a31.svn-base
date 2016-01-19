//
//  W_VisitPlanAddViewController.h
//  CMCCMarketing
//
//  Created by gmj on 14-11-19.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "PlaceholderTextView.h"

@interface W_VisitPlanAddViewController : UIViewController
//增加拜访类型
@property (weak, nonatomic) IBOutlet UILabel *lbVisitType;
@property (weak, nonatomic) IBOutlet UILabel *disp_visittype;

- (IBAction)selectVisitType:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *visitTypeButton;

@property (weak, nonatomic) IBOutlet UILabel *lblUserNameTitle;
@property (weak, nonatomic) IBOutlet UIButton *btnUserName;
- (IBAction)btnUserNameOnClick:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *lbUserName;
@property (weak, nonatomic) IBOutlet UIButton *btAccompanyUser;
@property (weak, nonatomic) IBOutlet UILabel *lbAccompanyUser;
@property (weak, nonatomic) IBOutlet UILabel *lbGroup;
@property (weak, nonatomic) IBOutlet UIButton *btGroup;
@property (weak, nonatomic) IBOutlet UIButton *btContactUser;
@property (weak, nonatomic) IBOutlet UILabel *lbContactUser;
@property (weak, nonatomic) IBOutlet UILabel *lbContactAddress;
@property (weak, nonatomic) IBOutlet UIButton *btContactAddress;
@property (weak, nonatomic) IBOutlet UIButton *btStartTime;
@property (weak, nonatomic) IBOutlet UILabel *lbStartTime;
@property (weak, nonatomic) IBOutlet UIButton *btEndTime;
@property (weak, nonatomic) IBOutlet UILabel *lbEndTime;

@property (weak, nonatomic) IBOutlet PlaceholderTextView *txtContent;

@property (weak, nonatomic) IBOutlet UIButton *btnRemindOne;
@property (weak, nonatomic) IBOutlet UIButton *btnRemindTwo;
@property (weak, nonatomic) IBOutlet UIButton *btnRemindThree;
@property (weak, nonatomic) IBOutlet UIButton *btnRemindFour;

@property(nonatomic,strong)User *user;
@property(nonatomic,strong)NSDictionary *selectVisitAddressDic;//拜访地址


- (IBAction)selectGroupOnclick:(id)sender;
- (IBAction)selectGroupContactUserOnclick:(id)sender;
- (IBAction)selectAccompanyUserOnclick:(id)sender;
- (IBAction)selectAddressOnclick:(id)sender;
- (IBAction)selectStartTimeOnclick:(id)sender;
- (IBAction)selectEndTimeOnclick:(id)sender;


- (IBAction)btnRemindOneOnClick:(id)sender;
- (IBAction)btnRemindTwoOnClick:(id)sender;
- (IBAction)btnRemindThreeOnClick:(id)sender;
- (IBAction)btnRemindFourOnClick:(id)sender;


//编辑模式，设置拜访拜访数据
@property (strong,nonatomic)NSDictionary *dicSelectVisitPlanDetail;//编辑模式，传递拜访详细数据
//-(void)setVisitPlanData:(NSDictionary *)dicVisitPlan;

@end
