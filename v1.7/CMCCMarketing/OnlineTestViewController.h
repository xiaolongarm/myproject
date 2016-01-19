//
//  OnlineTestViewController.h
//  CMCCMarketing
//
//  Created by Talkweb on 15/4/21.
//  Copyright (c) 2015年 talkweb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface OnlineTestViewController : UIViewController


@property (weak, nonatomic) IBOutlet UIButton *btnTestRecord;
@property (weak, nonatomic) IBOutlet UIButton *btnMyDoWrong;
@property (weak, nonatomic) IBOutlet UIButton *btnTestNoti;
@property (weak, nonatomic) IBOutlet UIButton *btnStartTest;
@property (weak, nonatomic) IBOutlet UIImageView *imageDisableStart;
@property (weak, nonatomic) IBOutlet UILabel *labelTest;
@property (weak, nonatomic) IBOutlet UILabel *labelTime;

@property(nonatomic,strong)User *user;

- (IBAction)testRecordOnClick:(id)sender;
- (IBAction)myDoWrongOnClick:(id)sender;
- (IBAction)testNotiOnClick:(id)sender;
- (IBAction)startTestOnClick:(id)sender;



@end
