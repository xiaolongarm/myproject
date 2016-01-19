//
//  GroupBroadbandRecordViewController.h
//  CMCCMarketing
//
//  Created by talkweb on 14-9-19.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
@interface GroupBroadbandRecordViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    
    __weak IBOutlet UITableView *recordTableView;
    
    __weak IBOutlet UIButton *NotAcceptedOrderButton;
    __weak IBOutlet UIButton *AcceptedSuccessOrderButton;
    __weak IBOutlet UIButton *AcceptedFailureOrderButton;
}
@property(nonatomic,strong)User *user;
@end
