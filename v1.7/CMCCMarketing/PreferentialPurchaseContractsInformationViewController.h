//
//  PreferentialPurchaseContractsInformationViewController.h
//  CMCCMarketing
//
//  Created by talkweb on 14-9-17.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PreferentialPurchaseContractsInformationViewController;
@protocol PreferentialPurchaseContractsInformationViewControllerDelegate <NSObject>
-(void)beginEdit;
-(void)endEdit;
-(void)selectDate:(id)sender;
@end
@interface PreferentialPurchaseContractsInformationViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *txtQuantity;
@property (weak, nonatomic) IBOutlet UITextField *txtStoredFee;
@property (weak, nonatomic) IBOutlet UITextField *txtGiftOfMonthFee;
@property (weak, nonatomic) IBOutlet UITextField *txtLowestMonthFee;
@property (weak, nonatomic) IBOutlet UITextField *txtReturnOfMonthFee;
@property (weak, nonatomic) IBOutlet UITextField *txtContractTerm;
//@property (weak, nonatomic) IBOutlet UITextField *txtStartDate;
//@property (weak, nonatomic) IBOutlet UITextField *txtEndDate;

@property (weak, nonatomic) IBOutlet UIButton *btStartDate;
@property (weak, nonatomic) IBOutlet UIButton *btEndDate;

@property (weak, nonatomic) IBOutlet UITextField *txtPostNumberOfMonth;
@property (weak, nonatomic) IBOutlet UITextField *txtMemo;

@property(nonatomic,strong)id<PreferentialPurchaseContractsInformationViewControllerDelegate> delegate;

@end
