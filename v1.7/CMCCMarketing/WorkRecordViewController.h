//
//  WorkRecordViewController.h
//  CMCCMarketing
//
//  Created by gmj on 15-1-26.
//  Copyright (c) 2015年 talkweb. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "User.h"

@interface WorkRecordViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>{

    __weak IBOutlet UIButton *btAdd;
}

@property(nonatomic,strong)User *user;

@property (strong,nonatomic) NSArray *tbList;
@property (strong,nonatomic) NSMutableArray *keys;
@property (strong,nonatomic) NSMutableDictionary *keyValues;

@property (weak, nonatomic) IBOutlet UITableView *tbView;
@property(nonatomic,strong)NSDictionary *selectedWorkRecord;
//@property(nonatomic,strong)UIImage *selectedCellImage;
@end
