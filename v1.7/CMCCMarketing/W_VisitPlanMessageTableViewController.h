//
//  W_VisitPlanMessageTableViewController.h
//  CMCCMarketing
//
//  Created by gmj on 14-12-3.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@protocol W_VisitPlanMessageTableViewControllerDelegate <NSObject>
-(void)w_visitPlanMessageTableViewControllerGoDetails:(int)vistplanId;
@end

@interface W_VisitPlanMessageTableViewController : UITableViewController

@property (strong,nonatomic) NSArray *tableList;
@property(nonatomic,strong)User *user;
@property(strong,nonatomic)NSDictionary *passDictData;
@property (strong, nonatomic) IBOutlet UITableView *tbView;

//@property (strong,nonatomic) NSArray *visitPlanList;//拜访数据
@property(nonatomic,strong)id<W_VisitPlanMessageTableViewControllerDelegate>delegate;

@end
