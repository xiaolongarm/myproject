//
//  ContrantListTableViewController.h
//  CMCCMarketing
//
//  Created by kevin on 15/9/16.
//  Copyright (c) 2015年 talkweb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Group.h"

@interface ContrantListTableViewController : UITableViewController

@property(nonatomic,strong)Group *group;
@property(nonatomic,strong)NSString *grounpId;
@property(nonatomic,strong)NSMutableDictionary *rDcit;
@end
