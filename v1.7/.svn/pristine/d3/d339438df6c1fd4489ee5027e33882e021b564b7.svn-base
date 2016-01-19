//
//  W_VisitPlanAddSelectAccompanyUserController.h
//  CMCCMarketing
//
//  Created by gmj on 14-11-20.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import <UIKit/UIKit.h>
@class W_VisitPlanAddSelectAccompanyUserController;

@protocol VisitPlanAddSelectAccompanyUserControllerDelegate <NSObject>

-(void)VisitPlanAddSelectAccompanyUserControllerDidFinished:(W_VisitPlanAddSelectAccompanyUserController *)controller;

@end

@interface W_VisitPlanAddSelectAccompanyUserController : UITableViewController

@property(nonatomic,strong)NSMutableArray *tableArray;
//@property(nonatomic,strong)NSDictionary *selectAccompanyUserDic;
@property(nonatomic,strong)NSMutableArray *selectAccompanyUserArr;
//用于记录手动输入联系人
@property(nonatomic,strong)NSMutableArray *recordArray;
@property(nonatomic,strong)id<VisitPlanAddSelectAccompanyUserControllerDelegate> delegate;

@end

