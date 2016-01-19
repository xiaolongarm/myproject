//
//  OtherRegressCustomerDetailsTableViewController.h
//  CMCCMarketing
//
//  Created by talkweb on 14-9-19.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "CustomerManager.h"

@interface OtherRegressCustomerDetailsTableViewController : UITableViewController

//@property(nonatomic,strong)NSDictionary *customerDetials;
@property(nonatomic,strong)User* user;
@property(nonatomic,strong)NSDictionary *diffUserDict;
@property(nonatomic,assign)BOOL isManager;

@property(nonatomic,strong)CustomerManager *customerManager;
@property(nonatomic,assign)BOOL isNotRegress;
@end
