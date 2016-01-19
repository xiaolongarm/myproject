//
//  FlowBusinessProcessViewController.h
//  CMCCMarketing
//
//  Created by talkweb on 14-9-16.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface FlowBusinessProcessViewController : UIViewController<UITextFieldDelegate,UIImagePickerControllerDelegate,UIAlertViewDelegate,UINavigationControllerDelegate>{
    __weak IBOutlet UILabel *lbFlowName;
    __weak IBOutlet UITextField *txtCustomerName;
    __weak IBOutlet UITextField *txtCustomerTel;
    __weak IBOutlet UITextField *txtCustomerIdCard;
    __weak IBOutlet UIImageView *imgIdCard1;
    __weak IBOutlet UIImageView *imgIdCard2;
    
}

@property(nonatomic,strong)NSString* flowName;
@property(nonatomic,strong)NSString* flowPrice;
@property(nonatomic,strong)NSString* flowDesc;
@property(nonatomic,strong)User *user;
@property(nonatomic,strong)NSString *customerTel;
//@property(nonatomic,strong)NSDictionary *syDict;
@property(nonatomic,assign)BOOL isShaoYang;
@property(nonatomic,assign)int busType;
@end
