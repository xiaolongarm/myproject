//
//  GroupCustomersTableViewCell.h
//  CMCCMarketing
//
//  Created by talkweb on 14-9-9.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GroupCustomersTableViewCell;
@protocol GroupCustomersTableViewCellDelegate <NSObject>
-(void)groupCustomersTableViewCellSelectButtonOnclick:(GroupCustomersTableViewCell*)controller;
@end

@interface GroupCustomersTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *itemSelected;
@property (weak, nonatomic) IBOutlet UILabel *itemName;
@property (weak, nonatomic) IBOutlet UILabel *itemTelephone;
@property (nonatomic,assign) int itemRow;
@property (nonatomic,strong) id<GroupCustomersTableViewCellDelegate> delegate;
@end
