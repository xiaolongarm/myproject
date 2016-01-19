//
//  FlowBusinessRecordTableViewCell.h
//  CMCCMarketing
//
//  Created by talkweb on 14-9-16.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FlowBusinessRecordTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *itemBusinessName;
@property (weak, nonatomic) IBOutlet UILabel *itemCustomerName;
@property (weak, nonatomic) IBOutlet UILabel *itemTelephone;
@property (weak, nonatomic) IBOutlet UILabel *itemDate;

@end
