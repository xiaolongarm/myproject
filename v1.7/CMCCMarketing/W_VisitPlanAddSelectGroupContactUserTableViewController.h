//
//  W_VisitPlanAddSelectGroupContactUserTableViewController.h
//  CMCCMarketing
//
//  Created by gmj on 14-11-20.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Group.h"

@class W_VisitPlanAddSelectGroupContactUserTableViewController;

@protocol VisitPlanAddSelectGroupContactUserTableViewControllerDelegate <NSObject>

-(void)visitPlanAddSelectGroupContactUserTableViewControllerDidFinished:(W_VisitPlanAddSelectGroupContactUserTableViewController*)controller;
//-(void)visitPlanAddSelectGroupContactUserTableViewControllerDidCanceled;
@end

@interface W_VisitPlanAddSelectGroupContactUserTableViewController : UITableViewController

@property(nonatomic,strong)NSArray *tableArray;
@property(nonatomic,strong)id<VisitPlanAddSelectGroupContactUserTableViewControllerDelegate> delegate;
@property(nonatomic,strong)Group *group;
//@property(nonatomic,strong)NSDictionary *selectUserDict;
@property(nonatomic,strong)NSMutableArray *selectedArray;
@end