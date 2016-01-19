//
//  VisitPlanAddSelectGroupContactUserTableViewController.h
//  CMCCMarketing
//
//  Created by talkweb on 14-11-17.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Group.h"

@class VisitPlanAddSelectGroupContactUserTableViewController;

@protocol VisitPlanAddSelectGroupContactUserTableViewControllerDelegate <NSObject>
-(void)visitPlanAddSelectGroupContactUserTableViewControllerDidFinished:(VisitPlanAddSelectGroupContactUserTableViewController*)controller;
@end

@interface VisitPlanAddSelectGroupContactUserTableViewController : UITableViewController

@property(nonatomic,strong)NSArray *tableArray;
@property(nonatomic,strong)id<VisitPlanAddSelectGroupContactUserTableViewControllerDelegate> delegate;
@property(nonatomic,strong)Group *group;
@property(nonatomic,strong)NSDictionary *selectUserDict;
@end
