//
//  W_VisitPlanSearchViewController.h
//  CMCCMarketing
//
//  Created by gmj on 14-12-12.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@class W_VisitPlanSearchViewController;

@protocol W_VisitPlanSearchViewControllerDelegate <NSObject>

-(void)W_VisitPlanSearchViewControllerDidFinished:(W_VisitPlanSearchViewController *)controller;

@end


@interface W_VisitPlanSearchViewController : UIViewController{
    
    __weak IBOutlet NSLayoutConstraint *lblGroupTitleConstraint;
    __weak IBOutlet NSLayoutConstraint *btnGroupConstraint;
    __weak IBOutlet NSLayoutConstraint *lblGroupConstraint;
}

@property(nonatomic,strong)User *user;
- (IBAction)btnStartDateOnClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnStartDate;
@property (weak, nonatomic) IBOutlet UILabel *lblStartDate;

- (IBAction)btnEndDateOnClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnEndDate;
@property (weak, nonatomic) IBOutlet UILabel *lblEndDate;


@property (weak, nonatomic) IBOutlet UILabel *lblGroupTitle;
@property (weak, nonatomic) IBOutlet UIButton *btnGroup;
- (IBAction)btnGroupOnClick:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lblGroup;

@property (weak, nonatomic) IBOutlet UILabel *lblCustomerManagerTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblCustomerManager;
@property (weak, nonatomic) IBOutlet UIButton *btnCustomerManager;
- (IBAction)btnCustomerManagerOnClick:(id)sender;



@property (strong,nonatomic) NSArray *visitplanlist;
@property (strong,nonatomic) NSMutableArray *keys;
@property (strong,nonatomic) NSMutableDictionary *keyValues;


@property(nonatomic,strong) id <W_VisitPlanSearchViewControllerDelegate> delegate;

@end
