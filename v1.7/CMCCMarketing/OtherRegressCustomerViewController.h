//
//  OtherRegressCustomerViewController.h
//  CMCCMarketing
//
//  Created by talkweb on 14-9-19.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import <MessageUI/MessageUI.h>

@interface OtherRegressCustomerViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{

    __weak IBOutlet UITableView *customerTableView;
    
    __weak IBOutlet UILabel *customerPhone;
    __weak IBOutlet UILabel *customerName;
    __weak IBOutlet UILabel *customerLvl;
    
}
@property(nonatomic,strong)NSDictionary *diffUserDict;
@property(nonatomic,strong)User *user;
@end
