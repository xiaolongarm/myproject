//
//  ManagerWorkRecordSearchViewController.h
//  CMCCMarketing
//
//  Created by talkweb on 15-2-4.
//  Copyright (c) 2015年 talkweb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface ManagerWorkRecordSearchViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    
    __weak IBOutlet UILabel *lbDate;
    __weak IBOutlet UILabel *lbUser;
    
    __weak IBOutlet UITableView *tbView;
    __weak IBOutlet UIView *vwSelectUserBody;
}
@property(nonatomic,strong)User *user;
@end
