//
//  ManagerMonthlyTasksCreatorTableViewCell.h
//  CMCCMarketing
//
//  Created by talkweb on 15-1-12.
//  Copyright (c) 2015年 talkweb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ManagerMonthlyTasksCreatorTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *itemName;
@property (weak, nonatomic) IBOutlet UILabel *itemBeforeQuantity;
@property (weak, nonatomic) IBOutlet UILabel *itemUnit;
@property (weak, nonatomic) IBOutlet UITextField *itemQuantity;

@end
