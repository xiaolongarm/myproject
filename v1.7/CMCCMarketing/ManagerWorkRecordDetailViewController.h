//
//  ManagerWorkRecordDetailViewController.h
//  CMCCMarketing
//
//  Created by gmj on 15-2-2.
//  Copyright (c) 2015年 talkweb. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "User.h"

@interface ManagerWorkRecordDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>{
    
    __weak IBOutlet UILabel *lbDate;
    __weak IBOutlet UILabel *lbState;
//    __weak IBOutlet UILabel *lbContent;
    

    __weak IBOutlet UIImageView *imgDailyPic;
    
    __weak IBOutlet UILabel *lbSearchDate;
    
    __weak IBOutlet UIView *vwBottomBody;
    __weak IBOutlet UITableView *tbView;
    
    __weak IBOutlet UITextField *txtReply;
    
}
//增加显示图片
@property (strong, nonatomic) IBOutlet UIImageView *imgDaliyPic2;
@property (strong, nonatomic) IBOutlet UIImageView *imgDaliyPic3;
@property (strong, nonatomic) IBOutlet UITextView *txtContent;
@property (strong, nonatomic) IBOutlet UIView *contentView;


@property(nonatomic,strong)User *user;
@property(nonatomic,strong)NSDictionary *selectedWorkRecord;
@property(nonatomic,strong)NSDictionary *FromVisitlist;

@property(nonatomic,strong)NSDate *selectDate;
@property (strong, nonatomic) IBOutlet UIView *topView;
@property (strong, nonatomic) IBOutlet UIView *bottomView;
- (IBAction)onclickZoomOutPic:(id)sender;
- (IBAction)onclickZoomOutPic2:(id)sender;
- (IBAction)onclickZoomOutPic3:(id)sender;


@end
