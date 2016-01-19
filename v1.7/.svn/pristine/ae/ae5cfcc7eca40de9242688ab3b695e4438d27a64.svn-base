//
//  DataAcquisitionNetworkProblemsTableViewCell.h
//  CMCCMarketing
//
//  Created by talkweb on 14-9-28.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DataAcquisitionNetworkProblemsTableViewCellDeletate <NSObject>
-(void)selectGroup:(id)sender;
-(void)selectServerity:(id)sender;
-(void)selectDate:(id)sender;
@end

@interface DataAcquisitionNetworkProblemsTableViewCell : UITableViewCell<UITextFieldDelegate,UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *grounpName;
@property (weak, nonatomic) IBOutlet UITextField *grounpAddress;
@property (weak, nonatomic) IBOutlet UITextField *officePart;
@property (weak, nonatomic) IBOutlet UITextField *testName;
@property (weak, nonatomic) IBOutlet UITextField *testPhoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *customerName;
@property (weak, nonatomic) IBOutlet UITextField *customPhoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *whichBuilding;
@property (weak, nonatomic) IBOutlet UITextField *whichFloor;
@property (weak, nonatomic) IBOutlet UITextField *psrpName;
@property (weak, nonatomic) IBOutlet UITextField *sinrName;
@property (weak, nonatomic) IBOutlet UITextField *pciName;
@property (weak, nonatomic) IBOutlet UITextField *cellidName;
@property (weak, nonatomic) IBOutlet UITextField *downloadSpeed;
@property (weak, nonatomic) IBOutlet UITextField *arguementTalk;
@property (weak, nonatomic) IBOutlet UITextField *arguementNetwork;
@property (weak, nonatomic) IBOutlet UITextField *talkAndNetwork;



@property(nonatomic,strong)id<DataAcquisitionNetworkProblemsTableViewCellDeletate> delegate;

@end
