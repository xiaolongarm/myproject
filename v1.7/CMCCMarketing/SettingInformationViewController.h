//
//  SettingInformationViewController.h
//  CMCCMarketing
//
//  Created by talkweb on 14-9-4.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//
#import "User.h"
#import <UIKit/UIKit.h>

@protocol SettingInformationViewControllerDelegate <NSObject>
-(void)updatePersonImageDidFinished;
@end

@interface SettingInformationViewController : UIViewController{
    
    __weak IBOutlet UILabel *userName;
    __weak IBOutlet UILabel *userSex;
    __weak IBOutlet UILabel *userTelephone;
//    __weak IBOutlet UIImageView *userImage;
    
    __weak IBOutlet UIButton *btUserImage;
    __weak IBOutlet UILabel *userDept;
    __weak IBOutlet UILabel *userMail;
    
    __weak IBOutlet UISwitch *swGpsReport;
     BOOL hubFlag;
    
}

@property(nonatomic,strong)User* user;
@property(nonatomic,strong)id<SettingInformationViewControllerDelegate>delegate;
@end
