//
//  FlowBusinessViewController.h
//  CMCCMarketing
//
//  Created by talkweb on 14-9-15.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//
#import "User.h"
#import <UIKit/UIKit.h>

@interface FlowBusinessViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>{

    __weak IBOutlet UITableView *flowBusinessTableView;
    __weak IBOutlet UIButton *flowBusinessMonthlyButton;
    __weak IBOutlet UIButton *flowBusinessPackYearsButton;
    __weak IBOutlet UIButton *flowBusinessHalfOfYearButton;
    __weak IBOutlet UIButton *flowBusiness4GButton;
}
@property(nonatomic,strong)User *user;
@end
