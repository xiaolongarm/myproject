//
//  CustomersWarningWithGroupViewController.h
//  CMCCMarketing
//
//  Created by talkweb on 14-9-23.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
@interface CustomersWarningWithGroupViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>{
    
    __weak IBOutlet UILabel *lbMonth;
    __weak IBOutlet UITableView *groupTableView;
    
    __weak IBOutlet UIView *vwTopBodyView;
    __weak IBOutlet UISearchBar *searchBar;
    
}
@property(nonatomic,strong)User* user;
@end
