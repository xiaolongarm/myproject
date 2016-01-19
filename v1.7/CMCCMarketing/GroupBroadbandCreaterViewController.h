//
//  GroupBroadbandCreaterViewController.h
//  CMCCMarketing
//
//  Created by talkweb on 14-9-18.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GroupBroadbandCreaterViewController;
@protocol GroupBroadbandCreaterViewControllerDelegate <NSObject>
-(void)selectGroup;
-(void)selectDate:(id)sender;
-(void)beginEdit;
-(void)endEdit;
@end

@interface GroupBroadbandCreaterViewController : UIViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIButton *btGroupName;
@property (weak, nonatomic) IBOutlet UITextField *txtGroupId;
@property (weak, nonatomic) IBOutlet UITextField *txtGroupNo;

@property (weak, nonatomic) IBOutlet UITextField *txtBroadband;
@property (weak, nonatomic) IBOutlet UITextField *txtContract;
@property (weak, nonatomic) IBOutlet UIButton *btStartDate;
@property (weak, nonatomic) IBOutlet UIButton *btEndDate;
@property (weak, nonatomic) IBOutlet UITextField *txtFee;

@property (weak, nonatomic) IBOutlet UIButton *btDataVideo;
@property (weak, nonatomic) IBOutlet UIButton *btInternet;
@property (weak, nonatomic) IBOutlet UIButton *btWLan;
@property (weak, nonatomic) IBOutlet UIButton *btFDDI;

@property(nonatomic,strong)id<GroupBroadbandCreaterViewControllerDelegate> delegate;
@property(nonatomic,assign)int speciaLinePro;
@property(nonatomic,strong)NSString *speciaLineProText;

-(void)setBroadbandType:(int)type;

@end
