//
//  TaskNameViewController.h
//  CMCCMarketing
//
//  Created by gmj on 15/6/17.
//  Copyright (c) 2015年 talkweb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface TaskNameViewController : UITableViewController
@property(nonatomic,strong)NSDictionary *passDict;
@property(nonatomic,strong)NSDictionary *contactsDict;
@property(nonatomic,strong)User *user;
@end
