//
//  DataAq4GTermialTableViewCell.h
//  CMCCMarketing
//
//  Created by kevin on 15/7/7.
//  Copyright (c) 2015年 talkweb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DataAq4GTermialTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *customPhoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *termialType;
@property (weak, nonatomic) IBOutlet UITextField *termialClassify;
@property (weak, nonatomic) IBOutlet UITextField *keyAmount;
@property (weak, nonatomic) IBOutlet UIButton *dealTimeButton;

@end
