//
//  OtherRegressManagerContactTableViewController.h
//  CMCCMarketing
//
//  Created by talkweb on 15-1-13.
//  Copyright (c) 2015年 talkweb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "CustomerManager.h"
@interface OtherRegressManagerContactTableViewController : UITableViewController{
    
    __weak IBOutlet UILabel *lbPhone;
    __weak IBOutlet UILabel *lbName;
    __weak IBOutlet UILabel *lbIsHighUser;
    
}
@property(nonatomic,strong)User* user;
@property(nonatomic,strong)NSDictionary *diffUserDict;
@property(nonatomic,strong)CustomerManager *customerManager;
@end
