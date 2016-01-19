//
//  CustomerManagerContactsDetailsTableViewCell.h
//  CMCCMarketing
//
//  Created by talkweb on 14-10-29.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomerManagerContactsDetailsTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *itemTitle;
@property (weak, nonatomic) IBOutlet UILabel *itemContent;
@property (weak, nonatomic) IBOutlet UIImageView *itemImage;
@property (weak, nonatomic) IBOutlet UITextView *itemMoreText;
@end
