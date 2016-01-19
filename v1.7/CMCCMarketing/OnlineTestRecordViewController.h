//
//  OnlineTestRecordViewController.h
//  CMCCMarketing
//
//  Created by Talkweb on 15/4/22.
//  Copyright (c) 2015年 talkweb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OnlineTestRecordViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *onlineTestTableView;
//@property(nonatomic,strong)User *user;
@property (nonatomic,strong) NSArray *recordList;
@end
