//
//  MarketingGroupUserFilterViewController.h
//  CMCCMarketing
//
//  Created by talkweb on 14-10-9.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MarketingGroupUserFilterViewController;
@protocol MarketingGroupUserFilterViewControllerDelegate
-(void)marketingGroupUserFilterViewControllerDidCanceled;
-(void)marketingGroupUserFilterViewControllerDidFinished:(MarketingGroupUserFilterViewController*)controller;
@end

@interface MarketingGroupUserFilterViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    __weak IBOutlet UITableView *filterTableView;
    __weak IBOutlet UIImageView *marketingOfWeekImage;
    __weak IBOutlet UIImageView *marketingOfMonthImage;
}
@property(nonatomic,strong)id<MarketingGroupUserFilterViewControllerDelegate>delegate;
@property(nonatomic,strong)NSMutableArray *_filterArray;
@property(nonatomic,assign)int filterOfTimePeriod;
@end
