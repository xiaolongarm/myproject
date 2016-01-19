//
//  CustomerManagerContactsTableViewCell.h
//  CMCCMarketing
//
//  Created by talkweb on 14-9-22.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomerManagerContactsTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *itemName;
@property (weak, nonatomic) IBOutlet UIImageView *itemImageView;
@property (weak, nonatomic) IBOutlet UILabel *itemPhone;
@property (strong, nonatomic) IBOutlet UILabel *wheterCheck;

@end
