//
//  CustomersWarningWithGroupIndicatorsViewController.h
//  CMCCMarketing
//
//  Created by talkweb on 14-9-23.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface CustomersWarningWithGroupIndicatorsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{

    __weak IBOutlet UITableView *indicatorsTableView;
    
    __weak IBOutlet UILabel *lbCustomerManager;
    
    __weak IBOutlet UILabel *lbMonth;
    
    __weak IBOutlet UIButton *btProgressReply;
}
@property(nonatomic,strong)NSDictionary *groupDict;
//{
//    "grp_code" = 7311000182;
//    "grp_name" = "\U6e56\U5357\U7701\U91d1\U9f0e\U6d88\U9632\U5668\U6750\U6709\U9650\U516c\U53f8";
//    "threshold_falg" = true;
//    times =     (
//                 201408
//                 );
//}
@property(nonatomic,strong)User *user;
@property(nonatomic,assign)NSString *queryTime;

@end
