//
//  GroupBroadbandRenewalViewController.h
//  CMCCMarketing
//
//  Created by talkweb on 14-9-18.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
@class GroupBroadbandRenewalViewController;
@protocol GroupBroadbandRenewalViewControllerDelegate <NSObject>
-(void)groupBroadbandRenewalViewControllerDidFinished:(GroupBroadbandRenewalViewController*)controller;
@end

@interface GroupBroadbandRenewalViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    
    __weak IBOutlet UITableView *renewalTableView;
}
@property(nonatomic,strong)User *user;
@property(nonatomic,strong)id<GroupBroadbandRenewalViewControllerDelegate> delegate;
@property(nonatomic,strong)NSDictionary *selectRenewalDict;
@end
