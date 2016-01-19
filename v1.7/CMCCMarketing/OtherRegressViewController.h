//
//  OtherRegressViewController.h
//  CMCCMarketing
//
//  Created by talkweb on 14-9-19.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
@interface OtherRegressViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>{

    __weak IBOutlet UITableView *otherRegressTableView;
    __weak IBOutlet UIButton *remindButton;
    
    __weak IBOutlet UILabel *lbPendingContactTitle;
    __weak IBOutlet UILabel *lbPendingContactNumber;
    __weak IBOutlet UILabel *lbDate;
    __weak IBOutlet UILabel *lbNullLabel;
    __weak IBOutlet UIButton *pendingContactButton;
    __weak IBOutlet UIButton *contactedButton;
    
    __weak IBOutlet UISearchBar *searchBar;
    __weak IBOutlet UIView *searchBodyView;
    
}

@property(nonatomic,strong)User *user;

@end
