//
//  SettingMessageViewController.h
//  CMCCMarketing
//
//  Created by talkweb on 14-9-13.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingMessageViewController : UIViewController

@property (weak, nonatomic) IBOutlet UISwitch *swReceive;
@property (weak, nonatomic) IBOutlet UISwitch *swSound;
@property (weak, nonatomic) IBOutlet UISwitch *swShock;
@property (weak, nonatomic) IBOutlet UIButton *btReminderPeriod;

@end
