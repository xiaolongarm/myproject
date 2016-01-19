//
//  MarketingViewController.h
//  CMCCMarketing
//
//  Created by talkweb on 14-9-3.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//
#import "MBProgressHUD.h"
#import <UIKit/UIKit.h>
#import "User.h"

@interface MarketingViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,MBProgressHUDDelegate>{
    
    __weak IBOutlet UIButton *groupCustomersQueryButton;
    __weak IBOutlet UIButton *individualCustomersQueryButton;
    
    __weak IBOutlet UIButton *thridButton;
    __weak IBOutlet UIView *individualQueryView;
    __weak IBOutlet UITableView *groupQueryTableView;
    
    __weak IBOutlet UITextField *txtQueryContent;
    
}

@property(nonatomic,strong)User* user;

@property(nonatomic,strong)NSDictionary* dicFlow;
@property(nonatomic,strong)NSDictionary* dicTerm;
@property(nonatomic,strong)NSDictionary* dicBind;


@end
