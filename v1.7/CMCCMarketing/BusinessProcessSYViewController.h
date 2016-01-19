//
//  BusinessProcessSYViewController.h
//  CMCCMarketing
//
//  Created by talkweb on 15-5-11.
//  Copyright (c) 2015年 talkweb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface BusinessProcessSYViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableViewSever;
@property (weak, nonatomic) IBOutlet UIView *viewTitle;
@property(nonatomic,strong)User *user;
/**
 *  @brief  0. 4G套餐 1. 4g终端 2. 4g流量
 */
@property(nonatomic,assign)int busType;
@end
