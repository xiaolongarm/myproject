//
//  W_VisitPlanAddSelectCustomerManagerTableViewController.h
//  CMCCMarketing
//
//  Created by gmj on 15-1-13.
//  Copyright (c) 2015年 talkweb. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CustomerManager.h"

@class W_VisitPlanAddSelectCustomerManagerTableViewController;

@protocol W_VisitPlanAddSelectCustomerManagerTableViewControllerDelegate <NSObject>

-(void)w_VisitPlanAddSelectCustomerManagerTableViewControllerDidFinished:(W_VisitPlanAddSelectCustomerManagerTableViewController *)controller;

@end

@interface W_VisitPlanAddSelectCustomerManagerTableViewController : UITableViewController

@property(nonatomic,strong)NSArray *tableArray;
@property(nonatomic,strong)CustomerManager *selectCustomerManager;

@property(nonatomic,strong)id<W_VisitPlanAddSelectCustomerManagerTableViewControllerDelegate> delegate;

@end
