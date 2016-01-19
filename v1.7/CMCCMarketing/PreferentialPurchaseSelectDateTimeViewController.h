//
//  PreferentialPurchaseSelectDateTimeViewController.h
//  CMCCMarketing
//
//  Created by talkweb on 14-10-23.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PreferentialPurchaseSelectDateTimeViewController;
@protocol PreferentialPurchaseSelectDateTimeViewControllerDelegate <NSObject>
-(void)preferentialPurchaseSelectDateTimeViewControllerDidFinished:(PreferentialPurchaseSelectDateTimeViewController*)controller;
-(void)preferentialPurchaseSelectDateTimeViewControllerDidCancel;
@end

@interface PreferentialPurchaseSelectDateTimeViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIDatePicker *datetimePicker;
@property (nonatomic,assign) NSInteger modeDateAndTime;
@property(nonatomic,strong)id<PreferentialPurchaseSelectDateTimeViewControllerDelegate> delegate;

@end
