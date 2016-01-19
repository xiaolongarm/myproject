//
//  PreferentialPurchaseContractsRecordViewController.h
//  CMCCMarketing
//
//  Created by talkweb on 14-9-18.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface PreferentialPurchaseContractsRecordViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>{
    __weak IBOutlet UIView *cellTitleView;
    __weak IBOutlet UITableView *contractsRecordTableView;
    
    __weak IBOutlet UIButton *NotAcceptedOrderButton;
    __weak IBOutlet UIButton *AcceptedSuccessOrderButton;
    __weak IBOutlet UIButton *AcceptedFailureOrderButton;
}
@property(nonatomic,strong)User* user;
@property(nonatomic,strong)NSString* type; //0 合约机 1 裸机
@end
