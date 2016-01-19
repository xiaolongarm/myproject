//
//  CustomerManagerMessageTableViewController.h
//  CMCCMarketing
//
//  Created by talkweb on 14-9-22.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface CustomerManagerMessageTableViewController : UITableViewController

@property(nonatomic,strong)User* user;
/**
 *  从点击最新消息按钮过来所需的判断变量
 */
@property(nonatomic,strong)NSString *fromType;
@property(nonatomic,strong)NSMutableArray *passArray;
@property(nonatomic,assign)int listType;
@end
