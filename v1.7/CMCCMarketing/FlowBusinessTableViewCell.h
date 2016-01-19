//
//  FlowBusinessTableViewCell.h
//  CMCCMarketing
//
//  Created by talkweb on 14-9-15.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FlowBusinessTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *itemName;
@property (weak, nonatomic) IBOutlet UILabel *itemFee;
@property (weak, nonatomic) IBOutlet UILabel *itemMemo;
@property (weak, nonatomic) IBOutlet UIButton *itemSelected;

@end
