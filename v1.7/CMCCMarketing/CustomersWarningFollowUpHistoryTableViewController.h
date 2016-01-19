//
//  CustomersWarningFollowUpHistoryTableViewController.h
//  CMCCMarketing
//
//  Created by talkweb on 14-9-24.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
@interface CustomersWarningFollowUpHistoryTableViewController : UITableViewController

@property(nonatomic,strong)User *user;
@property(nonatomic,strong)NSDictionary *groupDict;
@end
