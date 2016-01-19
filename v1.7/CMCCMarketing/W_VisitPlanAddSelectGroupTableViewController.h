//
//  W_VisitPlanAddSelectGroupTableViewController.h
//  CMCCMarketing
//
//  Created by gmj on 14-11-19.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Group.h"
#import "User.h"
#import "CustomerManager.h"

@class W_VisitPlanAddSelectGroupTableViewController;

@protocol VisitPlanAddSelectGroupTableViewControllerDelegate <NSObject>

-(void)visitPlanAddSelectGroupTableViewControllerDidFinished:(W_VisitPlanAddSelectGroupTableViewController *)controller;
-(void)visitPlanAddSelectLittleGroupTableViewControllerDidFinished:(NSDictionary *)dcit;
@end

@interface W_VisitPlanAddSelectGroupTableViewController : UITableViewController

@property(nonatomic,strong)NSArray *tableArray;
@property(nonatomic,strong)Group *selectGroup;
@property(nonatomic,strong)NSDictionary *selectDict;
@property(nonatomic,strong)User *user;
@property(nonatomic,strong)NSArray *hadVisitedTableArray;
@property(nonatomic,assign)int listType;
@property(nonatomic,strong)CustomerManager *selectedCustomerManager;
@property(nonatomic,strong)id<VisitPlanAddSelectGroupTableViewControllerDelegate> delegate;

@end
