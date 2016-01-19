//
//  PreferentialPurchaseCustomerInformationViewController.h
//  CMCCMarketing
//
//  Created by talkweb on 14-9-17.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PreferentialPurchaseCustomerInformationViewController;
@protocol PreferentialPurchaseCustomerInformationViewControllerDelegate <NSObject>
-(void)goCamera;
-(void)deleteIDCard1;
-(void)deleteIDCard2;
-(void)selectGroup;

-(void)beginEdit;
-(void)endEdit;
@end

@interface PreferentialPurchaseCustomerInformationViewController : UIViewController{

}

@property (weak, nonatomic) IBOutlet UIImageView *imgIdCard1;
@property (weak, nonatomic) IBOutlet UIImageView *imgIdCard2;

@property(nonatomic,strong)id<PreferentialPurchaseCustomerInformationViewControllerDelegate> delegate;

//@property (weak, nonatomic) IBOutlet UITextField *txtGroupName;
@property (weak, nonatomic) IBOutlet UIButton *btGroupName;

@property (weak, nonatomic) IBOutlet UITextField *txtCustomerName;
@property (weak, nonatomic) IBOutlet UITextField *txtCustomerPhone;
@property (weak, nonatomic) IBOutlet UITextField *txtIDCard;
//@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
//@property (weak, nonatomic) IBOutlet UITextField *txtPasswordRetry;


@end
