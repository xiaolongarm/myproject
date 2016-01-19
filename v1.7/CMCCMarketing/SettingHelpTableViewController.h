//
//  SettingHelpTableViewController.h
//  CMCCMarketing
//
//  Created by talkweb on 15-3-9.
//  Copyright (c) 2015年 talkweb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface SettingHelpTableViewController : UITableViewController
@property (nonatomic, strong) UITableViewCell *prototypeCell;

@property(nonatomic,strong)User* user;
@end
