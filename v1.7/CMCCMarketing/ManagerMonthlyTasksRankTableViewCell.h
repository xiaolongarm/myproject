//
//  ManagerMonthlyTasksRankTableViewCell.h
//  CMCCMarketing
//
//  Created by talkweb on 14-12-18.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ManagerMonthlyTasksRankTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *itemIndex;
@property (weak, nonatomic) IBOutlet UILabel *itemName;
@property (weak, nonatomic) IBOutlet UILabel *itemTotalNumber;
@property (weak, nonatomic) IBOutlet UILabel *itemPercentage;
@property (weak, nonatomic) IBOutlet UILabel *itemFinishedContent;
@property (weak, nonatomic) IBOutlet UIProgressView *itemProgressBar;

@end
