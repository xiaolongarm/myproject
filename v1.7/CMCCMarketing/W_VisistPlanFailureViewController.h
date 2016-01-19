//
//  W_VisistPlanFailureViewController.h
//  CMCCMarketing
//
//  Created by gmj on 14-11-27.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface W_VisistPlanFailureViewController : UIViewController <UITextViewDelegate>

@property(nonatomic,strong)User *user;

@property (strong,nonatomic)NSDictionary *dicSelectVisitPlanDetail;

@property (weak, nonatomic) IBOutlet UILabel *lblVisit_grp_name;
@property (weak, nonatomic) IBOutlet UILabel *lblLinkman;
@property (weak, nonatomic) IBOutlet UILabel *lblVip_mngr_name;
@property (weak, nonatomic) IBOutlet UILabel *lblVip_mngr_msisdn;
@property (weak, nonatomic) IBOutlet UILabel *lblVisit_grp_add;
@property (weak, nonatomic) IBOutlet UITextView *txtViewContent;

- (IBAction)toVisitPlanDetailOnClick:(id)sender;

@end
