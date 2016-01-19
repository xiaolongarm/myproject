//
//  W_VisitPlanManageTableViewController.h
//  CMCCMarketing
//
//  Created by gmj on 14-11-25.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface W_VisitPlanManageTableViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (strong,nonatomic)NSArray *tableArray;
@property (strong, nonatomic) IBOutlet UITableView *tbView;
@property(nonatomic,strong)User *user;

@property (strong,nonatomic)NSDictionary *dicSelectVisitPlanDetail;
@property (weak, nonatomic) IBOutlet UILabel *lblVisit_grp_name;
@property (weak, nonatomic) IBOutlet UILabel *lblLinkman;
@property (weak, nonatomic) IBOutlet UILabel *lblVip_mngr_name;
@property (weak, nonatomic) IBOutlet UILabel *lblVip_mngr_msisdn;
@property (weak, nonatomic) IBOutlet UILabel *lblVisit_grp_add;

- (IBAction)toVisitPlanDetailOnClick:(id)sender;
- (IBAction)submitVisitPlan:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnEditVisitPlan;
- (IBAction)btnEditVisitPlanOnClick:(id)sender;
@end
