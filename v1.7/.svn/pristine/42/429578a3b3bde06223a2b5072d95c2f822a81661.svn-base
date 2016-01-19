//
//  VisitPlanAddSelectGroupTableViewController.h
//  CMCCMarketing
//
//  Created by talkweb on 14-11-17.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Group.h"


@class VisitPlanAddSelectGroupTableViewController;
@protocol VisitPlanAddSelectGroupTableViewControllerDelegate <NSObject>
-(void)visitPlanAddSelectGroupTableViewControllerDidFinished:(VisitPlanAddSelectGroupTableViewController*)controller;
@end

@interface VisitPlanAddSelectGroupTableViewController : UITableViewController

@property(nonatomic,strong)NSArray *tableArray;
@property(nonatomic,strong)id<VisitPlanAddSelectGroupTableViewControllerDelegate> delegate;

@property(nonatomic,strong)Group *selectGroup;

@end
