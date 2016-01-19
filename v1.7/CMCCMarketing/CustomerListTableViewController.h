//
//  CustomerListTableViewController.h
//  CMCCMarketing
//
//  Created by kevin on 15/9/22.
//  Copyright © 2015年 talkweb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface CustomerListTableViewController : UITableViewController
@property(nonatomic,strong)User *user;

@property(nonatomic,strong)NSString *recipeOldNum;
@property(nonatomic,strong)NSString *recipeNewNum;
@end
