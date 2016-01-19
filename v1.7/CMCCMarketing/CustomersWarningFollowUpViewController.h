//
//  CustomersWarningFollowUpViewController.h
//  CMCCMarketing
//
//  Created by talkweb on 14-9-24.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "Group.h"

@interface CustomersWarningFollowUpViewController : UIViewController<UITextFieldDelegate,UITextViewDelegate>{
    
    __weak IBOutlet UITextField *txtContactNames;
    __weak IBOutlet UITextField *txtContactPhone;
    __weak IBOutlet UITextView *txtFollowUpContent;
}
@property (weak, nonatomic) IBOutlet UILabel *lbCustomerName;
@property(nonatomic,strong)User *user;
@property(nonatomic,strong)Group *group;

@property(nonatomic,assign)BOOL isPersion;
@property(nonatomic,strong)NSDictionary *customerDict;

@end
