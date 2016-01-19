//
//  CustomerManagerContactsViewController.h
//  CMCCMarketing
//
//  Created by talkweb on 14-9-22.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@class CustomerManagerContactsViewController;
@protocol CustomerManagerContactsViewControllerDelegate <NSObject>
-(void)customerManagerContactsViewControllerDidfinished:(NSDictionary*)contactsDict;
@end

@interface CustomerManagerContactsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    
    __weak IBOutlet UITableView *contactsTableView;
}
@property(nonatomic,strong)id<CustomerManagerContactsViewControllerDelegate> delegate;

@property(nonatomic,strong)NSArray *userList;
-(void)refreshTableView;

@property(nonatomic,strong)User *user;
@property(nonatomic,assign)int listType;
@end
