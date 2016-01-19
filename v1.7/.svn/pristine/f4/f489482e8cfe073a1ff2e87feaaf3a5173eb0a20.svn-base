//
//  ManagerWorkRecordViewController.h
//  CMCCMarketing
//
//  Created by gmj on 15-1-20.
//  Copyright (c) 2015年 talkweb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

#import "ManagerWorkRecordViewControllerCell.h"

@interface ManagerWorkRecordViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)User *user;
@property(nonatomic,strong)NSDictionary *selectedWorkRecord;
@property(nonatomic,strong)NSDate *selectedCellDate;
@property (strong,nonatomic) NSArray *tbList;
//@property (strong,nonatomic) NSMutableArray *keys;
//@property (strong,nonatomic) NSMutableDictionary *keyValues;

@property (weak, nonatomic) IBOutlet UITableView *tbView;

- (IBAction)bntNextWeekOnclick:(id)sender;
- (IBAction)btnPreWeekOnclick:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lblDate;

@end
