//
//  SettingPasswordViewController.h
//  CMCCMarketing
//
//  Created by talkweb on 15-3-6.
//  Copyright (c) 2015年 talkweb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
@interface SettingPasswordViewController : UIViewController{
    
    __weak IBOutlet UITextField *txtPassword;
    __weak IBOutlet UITextField *txtNewPassword;
    __weak IBOutlet UITextField *txtNewPasswordRetry;
    
    __weak IBOutlet UILabel *lbOldPassError;
    __weak IBOutlet UILabel *lbNewPassRetryError;
    __weak IBOutlet UILabel *lbErrorMessage;
    
}
@property(nonatomic,strong)User* user;
@end
