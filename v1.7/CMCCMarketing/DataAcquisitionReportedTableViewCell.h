//
//  DataAcquisitionReportedTableViewCell.h
//  CMCCMarketing
//
//  Created by talkweb on 14-9-28.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DataAcquisitionReportedTableViewCellDelegate <NSObject>
-(void)selectGroup:(id)sender;
@end

@interface DataAcquisitionReportedTableViewCell : UITableViewCell<UITextFieldDelegate,UITextViewDelegate>

//@property (weak, nonatomic) IBOutlet UITextField *itemGroupName;
@property (weak, nonatomic) IBOutlet UITextField *itemGroupStaffNumber;
@property (weak, nonatomic) IBOutlet UITextField *itemGroupNum;
@property (weak, nonatomic) IBOutlet UITextField *itemMarketShareWithCMCC;
@property (weak, nonatomic) IBOutlet UITextField *itemMarketShareWithTeleCom;
@property (weak, nonatomic) IBOutlet UITextField *itemInformationTech;
@property (weak, nonatomic) IBOutlet UITextField *itemWarnLVL;
@property (weak, nonatomic) IBOutlet UITextField *itemType;
@property (weak, nonatomic) IBOutlet UITextField *itemContactNameWithFirst;
@property (weak, nonatomic) IBOutlet UITextField *itemContactJobWithfirst;
@property (weak, nonatomic) IBOutlet UITextField *itemContactPhoneWithFirst;
@property (weak, nonatomic) IBOutlet UITextField *itemContactNameWithSecond;
@property (weak, nonatomic) IBOutlet UITextField *itemContactJobWithSecond;
@property (weak, nonatomic) IBOutlet UITextField *itemContactPhoneWithSecond;

@property (weak, nonatomic) IBOutlet UITextView *itemCompetition;

@property (weak, nonatomic) IBOutlet UITextField *itemGroupDemand;
@property (weak, nonatomic) IBOutlet UITextField *itemWeDealWith;
@property (weak, nonatomic) IBOutlet UITextField *itemFollowUpContent;

@property (weak, nonatomic) IBOutlet UISwitch *itemIsKeyPeople;

@property (weak, nonatomic) IBOutlet UIButton *itemPhotograghButton;
@property (weak, nonatomic) IBOutlet UIImageView *itemCompetitionPhoto;

@property(nonatomic,strong)id<DataAcquisitionReportedTableViewCellDelegate> delegate;
@end
