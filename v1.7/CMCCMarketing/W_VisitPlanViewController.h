//
//  W_VisitPlanViewController.h
//  CMCCMarketing
//
//  Created by gmj on 14-11-19.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface W_VisitPlanViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *btnVisitPlanAll;
@property (weak, nonatomic) IBOutlet UIButton *btnVisitPlanWill;
@property (weak, nonatomic) IBOutlet UIButton *btnVisitPlanDone;
@property (weak, nonatomic) IBOutlet UIButton *btnVisitPlanWaitCheck;

@property (weak, nonatomic) IBOutlet UITableView *visitPlanTableView;
@property (weak, nonatomic) IBOutlet UIButton *remindButton;

@property (strong,nonatomic) NSArray *visitplanlist;
@property (strong,nonatomic) NSMutableArray *keys;
@property (strong,nonatomic) NSMutableDictionary *keyValues;
@property (strong,nonatomic) NSString *compKey;

@property(nonatomic,strong)User *user;
- (IBAction)searchVisitPlan:(id)sender;

- (IBAction)addVisitPlan:(id)sender;

- (IBAction)visitPlanAllOnClick:(id)sender;
- (IBAction)visitPlanWillOnClick:(id)sender;
- (IBAction)visitPlanDoneOnClick:(id)sender;
- (IBAction)visitPlanWaitCheckOnClick:(id)sender;
- (IBAction)remindButtonOnClick:(id)sender;

@end
