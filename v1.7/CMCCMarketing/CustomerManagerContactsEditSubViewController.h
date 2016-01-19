//
//  CustomerManagerContactsEditSubViewController.h
//  CMCCMarketing
//
//  Created by talkweb on 14-9-22.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomerManagerContactsEditSubViewController;
@protocol CustomerManagerContactsEditSubViewControllerDelegate <NSObject>
-(void)selectType:(id)sender;
-(void)selectOperators:(id)sender;
-(void)selectDate:(id)sender;
-(void)goCamera;
@end

@interface CustomerManagerContactsEditSubViewController : UIViewController<UITextFieldDelegate>

@property(nonatomic,strong)NSDictionary *contactsDict;
@property(nonatomic,assign)int listType;
@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UITextField *txtPhone;
@property (weak, nonatomic) IBOutlet UITextField *txtOtherPhone;
@property (weak, nonatomic) IBOutlet UITextField *txtOtherContact;
@property (weak, nonatomic) IBOutlet UITextField *txtDepart;
@property (weak, nonatomic) IBOutlet UITextField *txtGroup;
@property (weak, nonatomic) IBOutlet UITextField *txtJob;
//@property (weak, nonatomic) IBOutlet UITextField *txtBirthday;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle1;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle2;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle3;
@property (weak, nonatomic) IBOutlet UIImageView *image3;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle4;
@property (weak, nonatomic) IBOutlet UIImageView *image4;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle5;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle6;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle7;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle8;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle9;

@property (weak, nonatomic) IBOutlet UISwitch *swSex;
@property (weak, nonatomic) IBOutlet UISwitch *swIsDiffKey;
@property (weak, nonatomic) IBOutlet UISwitch *swIsFirst;

@property (weak, nonatomic) IBOutlet UIButton *btType;
@property (weak, nonatomic) IBOutlet UIButton *btOperators;
@property (weak, nonatomic) IBOutlet UIButton *btBirthday;

@property (weak, nonatomic) IBOutlet UIButton *bt1c2n;
@property (weak, nonatomic) IBOutlet UIButton *btMultipleNumber;
@property (weak, nonatomic) IBOutlet UIButton *btUnicom2n;
@property (weak, nonatomic) IBOutlet UIButton *btTeleCom2n;
@property (weak, nonatomic) IBOutlet UIButton *bt3n;

//@property (weak, nonatomic) IBOutlet UIImageView *bt3nImageView;
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UISwitch *swBirthdayRemind;


@property(nonatomic,strong)id<CustomerManagerContactsEditSubViewControllerDelegate> delegate;
-(void)setEditData;
@end
