//
//  PreferentialPurchaseViewController.h
//  CMCCMarketing
//
//  Created by talkweb on 14-9-15.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface PreferentialPurchaseViewController : UIViewController{
    
    __weak IBOutlet UIView *bodyView;
    
    __weak IBOutlet UIButton *customerInformationButton;
    __weak IBOutlet UIButton *contractsInformationButton;
    __weak IBOutlet UIButton *phoneInformationButton;
    
    __weak IBOutlet UIButton *recordButton;
    __weak IBOutlet UIButton *sendBoxButton;
    
    __weak IBOutlet UIButton *contractPhoneButton;
    __weak IBOutlet UIButton *barePhoneButton;
    
}
@property(nonatomic,strong)User *user;
@property(nonatomic,assign)BOOL isSelected;
//@property(nonatomic,strong)NSDictionary *selectedItem;

@property(nonatomic,strong)NSString *selectedCustomerPhone;
@property(nonatomic,strong)Group *selectedCustomerGroup;

@property(nonatomic,strong)NSString* terminalName;
@property(nonatomic,strong)NSString* terminalPrice;
@property(nonatomic,strong)NSString* terminalDesc;
@property(nonatomic,strong)NSString* groupName;

@end
