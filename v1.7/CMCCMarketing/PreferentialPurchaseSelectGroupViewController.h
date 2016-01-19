//
//  PreferentialPurchaseSelectGroupViewController.h
//  CMCCMarketing
//
//  Created by talkweb on 14-10-16.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "Group.h"
#import "CustomerManager.h"
@class PreferentialPurchaseSelectGroupViewController;
@protocol PreferentialPurchaseSelectGroupViewControllerDelegate
-(void)preferentialPurchaseSelectGroupViewControllerDidCanceled;
-(void)preferentialPurchaseSelectGroupViewControllerDidFinished:(PreferentialPurchaseSelectGroupViewController*)controller;
@end

@interface PreferentialPurchaseSelectGroupViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    __weak IBOutlet UITableView *filterTableView;
}
@property(nonatomic,strong)id<PreferentialPurchaseSelectGroupViewControllerDelegate>delegate;
@property(nonatomic,strong)NSMutableArray *_filterArray;
@property(nonatomic,assign)int filterOfTimePeriod;
@property(nonatomic,strong)User *user;
@property(nonatomic,strong)Group *group;
@property(nonatomic,strong)CustomerManager *customerManager;

@property (weak, nonatomic) IBOutlet UILabel *lbTitle;

@end
