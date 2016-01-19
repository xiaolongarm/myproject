//
//  VisitPlanViewController.h
//  CMCCMarketing
//
//  Created by talkweb on 14-9-24.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface VisitPlanViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    
    __weak IBOutlet UITableView *visitPlanTableView;
    __weak IBOutlet UIButton *remindButton;
}
@property(nonatomic,strong)User *user;

@end
