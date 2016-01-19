//
//  ManagerMonthlyTasksDetailsViewController.h
//  CMCCMarketing
//
//  Created by talkweb on 14-12-19.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ManagerMonthlyTasksDetailsViewController : UIViewController{
    
    __weak IBOutlet UILabel *lbDate;
    __weak IBOutlet UILabel *lbName;
    __weak IBOutlet UILabel *lbTaskCNT;
    __weak IBOutlet UILabel *lbRank;
    __weak IBOutlet UIProgressView *lbProgress;
    __weak IBOutlet UILabel *lbPercentage;
    __weak IBOutlet UILabel *lbFinishCNT;
    __weak IBOutlet UIView *calendarBodyView;
    
}
@property(nonatomic,strong)NSString *date;
@property(nonatomic,strong)NSDictionary *detailsDict;
@end
