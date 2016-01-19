//
//  ChagangMonitorStaffListTableViewCell.h
//  CMCCMarketing
//
//  Created by talkweb on 14-12-22.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChagangMonitorStaffListTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIView *itemBodyView;
@property (weak, nonatomic) IBOutlet UIView *itemBodyLocusQueryView;

@property (weak, nonatomic) IBOutlet UILabel *itemName;
@property (weak, nonatomic) IBOutlet UIImageView *itemImageView;
@property (weak, nonatomic) IBOutlet UIImageView *itemStateImageView;

@property (weak, nonatomic) IBOutlet UIImageView *itemWarningImageView;
@property (strong, nonatomic) IBOutlet UILabel *holiday;


@property (weak, nonatomic) IBOutlet UIButton *itemLocusQueryButton;


@end
