//
//  ChagangMonitorStaffListTableViewController.h
//  CMCCMarketing
//
//  Created by talkweb on 14-12-22.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@class ChagangMonitorStaffListTableViewController;
@protocol ChagangMonitorStaffListTableViewControllerDelegate <NSObject>
-(void)chagangMonitorStaffListTableViewControllerDidSelected:(ChagangMonitorStaffListTableViewController*)controller;
-(void)chagangMonitorStaffListTableViewControllerDidLocusQuery:(ChagangMonitorStaffListTableViewController*)controller;
-(void)chagangMonitorStaffListTableViewControllerDidShowWarningDetails:(int)userId;
//-(void)chagangMonitorStaffListTableViewControllerDidRefreshAllData;
@end

@interface ChagangMonitorStaffListTableViewController : UITableViewController

@property(nonatomic,strong)NSArray *staffList;
@property(nonatomic,strong)id<ChagangMonitorStaffListTableViewControllerDelegate> delegate;
@property(nonatomic,strong)NSDictionary *selectDict;
@property(nonatomic,assign)CGRect cellFrame;

@property(nonatomic,strong)User *user;
@end
