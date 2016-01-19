//
//  DataAcquisitionNetworkProblemsTableViewController.h
//  CMCCMarketing
//
//  Created by talkweb on 14-9-28.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "Group.h"

@interface DataAcquisitionNetworkProblemsTableViewController : UITableViewController

@property(nonatomic,strong)User *user;
@property (strong,nonatomic) NSString *visit_id;

@end
