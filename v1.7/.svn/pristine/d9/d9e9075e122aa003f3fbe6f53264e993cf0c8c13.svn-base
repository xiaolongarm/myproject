//
//  W_VisitPlanAddSelectGroupContactUserViewController.h
//  CMCCMarketing
//
//  Created by talkweb on 15/7/2.
//  Copyright (c) 2015年 talkweb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Group.h"

@class W_VisitPlanAddSelectGroupContactUserViewController;

@protocol VisitPlanAddSelectGroupContactUserViewControllerDelegate <NSObject>

-(void)visitPlanAddSelectGroupContactUserViewControllerDidFinished:(W_VisitPlanAddSelectGroupContactUserViewController*)controller;
@end

@interface W_VisitPlanAddSelectGroupContactUserViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    
    __weak IBOutlet UITableView *tableview;
    
    __weak IBOutlet UILabel *lbUser1;
    __weak IBOutlet UILabel *lbUser2;
    __weak IBOutlet UILabel *lbUser3;
    __weak IBOutlet UIButton *btUser1;
    __weak IBOutlet UIButton *btUser2;
    __weak IBOutlet UIButton *btUser3;
    
    __weak IBOutlet UITextField *txtUser;
    __weak IBOutlet UITextField *txtPhone;
    
    __weak IBOutlet UIView *vwBottomBodyView;
    __weak IBOutlet NSLayoutConstraint *bottomViewConstraint;
}

@property(nonatomic,strong)NSArray *tableArray;
@property(nonatomic,strong)id<VisitPlanAddSelectGroupContactUserViewControllerDelegate> delegate;
@property(nonatomic,strong)Group *group;
@property(nonatomic,strong)NSMutableArray *selectedArray;

@property(nonatomic,assign) int selectType;

@end
