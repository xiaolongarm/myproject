//
//  FlowBusinessRecordViewController.h
//  CMCCMarketing
//
//  Created by talkweb on 14-9-16.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
@interface FlowBusinessRecordViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>{
    
    __weak IBOutlet UITableView *recordTableView;
    __weak IBOutlet UIButton *NotAcceptedOrderButton;
    __weak IBOutlet UIButton *AcceptedSuccessOrderButton;
    __weak IBOutlet UIButton *AcceptedFailureOrderButton;
}
@property(nonatomic,strong)User* user;
@property(nonatomic,assign)BOOL isShaoYang;
@property(nonatomic,strong)NSString *bussType;
@property(nonatomic,strong)NSString *bussName;

@end
