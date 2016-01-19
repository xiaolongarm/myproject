//
//  DataAcquisitionActivityCostsViewController.h
//  CMCCMarketing
//
//  Created by talkweb on 14-9-28.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface DataAcquisitionActivityCostsViewController : UIViewController{
    
    __weak IBOutlet UIButton *btCustomer;
    __weak IBOutlet UITextField *txtProject;
    __weak IBOutlet UITextField *txtFeeType;
    __weak IBOutlet UITextField *txtBudget;
//    __weak IBOutlet UITextField *txtDatetime;
    __weak IBOutlet UITextView *txtContent;
    
    __weak IBOutlet UIButton *btDatetime;
    __weak IBOutlet UIImageView *imgPic;
}

@property(nonatomic,strong)User *user;
@end
