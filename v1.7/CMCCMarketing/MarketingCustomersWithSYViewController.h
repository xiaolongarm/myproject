//
//  MarketingCustomersWithSYViewController.h
//  CMCCMarketing
//
//  Created by talkweb on 15-5-5.
//  Copyright (c) 2015年 talkweb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "Customer.h"
#import <MessageUI/MessageUI.h>
@interface MarketingCustomersWithSYViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,MFMessageComposeViewControllerDelegate>

@property(nonatomic,assign)BOOL isGroup;
@property(nonatomic,strong)Customer* customer;
@property(nonatomic,strong)NSArray *groupUserList;
@property(nonatomic,strong)User *user;
@property(nonatomic,strong)Group *group;
@property (weak, nonatomic) IBOutlet UIView *viewTit;
@property (weak, nonatomic) IBOutlet UITableView *tableView4g;
@property (weak, nonatomic) IBOutlet UIButton *btnSever;
@property (weak, nonatomic) IBOutlet UIButton *btnMoble;
@property (weak, nonatomic) IBOutlet UIButton *btnFlow;
@property(nonatomic,strong)NSDictionary* dicFlow;
@property(nonatomic,strong)NSDictionary* dicTerm;
@property(nonatomic,strong)NSDictionary* dicBind;
@end
