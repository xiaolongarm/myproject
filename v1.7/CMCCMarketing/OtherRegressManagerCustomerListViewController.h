//
//  OtherRegressManagerCustomerListViewController.h
//  CMCCMarketing
//
//  Created by talkweb on 15-1-13.
//  Copyright (c) 2015年 talkweb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomerManager.h"
#import "User.h"

@interface OtherRegressManagerCustomerListViewController : UIViewController{
    
    __weak IBOutlet UILabel *lbCustomerManagerName;
    __weak IBOutlet UILabel *lbCustomerManagerPhone;
    
    __weak IBOutlet UITableView *customerTableView;
    __weak IBOutlet UIButton *btNotRegress;
    __weak IBOutlet UIButton *btRegress;
    __weak IBOutlet UILabel *lbCustomerManagerNameTitle;
    
}

@property(nonatomic,strong)CustomerManager *customerManager;
@property(nonatomic,strong)User *user;
@end
