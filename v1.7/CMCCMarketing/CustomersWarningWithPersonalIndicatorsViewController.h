//
//  CustomersWarningWithPersonalIndicatorsViewController.h
//  CMCCMarketing
//
//  Created by talkweb on 14-9-24.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface CustomersWarningWithPersonalIndicatorsViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>{
    
    __weak IBOutlet UITableView *indicatorsTableView;
    
    __weak IBOutlet UILabel *lbPhone;
    __weak IBOutlet UILabel *lbType;
    __weak IBOutlet UILabel *lbName;
    __weak IBOutlet UILabel *lbGroup;
    
    __weak IBOutlet UIButton *btProgressReply;
}
@property(nonatomic,strong)User *user;
@property(nonatomic,strong)NSDictionary *cuestomerDict;
@end
