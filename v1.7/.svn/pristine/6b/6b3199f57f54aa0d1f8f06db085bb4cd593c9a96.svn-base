//
//  MarketingCustomersViewController.h
//  CMCCMarketing
//
//  Created by talkweb on 14-9-3.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//
#import "Customer.h"
#import <UIKit/UIKit.h>
#import "User.h"
#import <MessageUI/MessageUI.h>
#import "MBProgressHUD.h"
@interface MarketingCustomersViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,MFMessageComposeViewControllerDelegate,MBProgressHUDDelegate,UIAlertViewDelegate>{

    __weak IBOutlet UITableView *recommendedPackageTableView;//流量，终端
    __weak IBOutlet UITableView *morePackagesTableView;//存费送费
    __weak IBOutlet UITableView *cunfeisongliTableView;//存费送礼
    
    __weak IBOutlet NSLayoutConstraint *recommendTableConstraintsHeight;
    __weak IBOutlet NSLayoutConstraint *topViewConstraintsHeight;
    
    __weak IBOutlet UILabel *lbCustomerName;
    __weak IBOutlet UILabel *lbCustomerTelephone;
    __weak IBOutlet UILabel *lbDgxsb;
    __weak IBOutlet UILabel *lb2ggllkh;
    __weak IBOutlet UILabel *lbZsll;
    __weak IBOutlet UILabel *lbDgllb;
    
    __weak IBOutlet UILabel *lblLlzl;//流量种类
    __weak IBOutlet UILabel *lblYhmc;//优惠名称
    
    
    __weak IBOutlet UIButton *flowPackageButton;
    __weak IBOutlet UIButton *phoneTerminalButton;
    __weak IBOutlet UIButton *btnCunfeisongli;
    
    __weak IBOutlet UIView *vwCFSLTips;
    __weak IBOutlet UIView *vwCFSFTips;

    __weak IBOutlet UIButton *btUserDetail;
    //新增的三个label用于新增字段
    
    __weak IBOutlet UILabel *lbNewChar9;
    __weak IBOutlet UILabel *lbNewChar10;
    __weak IBOutlet UILabel *lbNewChar11;
 
    
}
@property (weak, nonatomic) IBOutlet UISegmentedControl *markSegmentControl;

@property(nonatomic,assign)BOOL isGroup;
@property(nonatomic,strong)Customer* customer;
@property(nonatomic,strong)NSArray *groupUserList;
@property(nonatomic,strong)User *user;
@property(nonatomic,strong)Group *group;

@property(nonatomic,strong)NSDictionary* dicFlow;
@property(nonatomic,strong)NSDictionary* dicTerm;
@property(nonatomic,strong)NSDictionary* dicBind;

@end
