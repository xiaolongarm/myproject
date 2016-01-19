//
//  WorkRecordDetailViewController.h
//  CMCCMarketing
//
//  Created by gmj on 15-1-27.
//  Copyright (c) 2015年 talkweb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface WorkRecordDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    
    
    __weak IBOutlet UITableView *tbView;
    __weak IBOutlet UIImageView *imgUpload1;
    __weak IBOutlet UIImageView *imgUpload2;
    __weak IBOutlet UIImageView *imgUpload3;
    __weak IBOutlet UIButton *btEdit;
    __weak IBOutlet UIButton *btDelete;
}

@property(nonatomic,strong)NSDictionary *selectedWorkRecord;
@property(nonatomic,strong)NSString *recipeDateString;
@property(nonatomic,strong)NSDictionary *recipeListDict;
//@property(nonatomic,strong)UIImage *uploadImage;
@property (weak, nonatomic) IBOutlet UILabel *lblDate;
@property (weak, nonatomic) IBOutlet UILabel *lblState;
@property (weak, nonatomic) IBOutlet UITextView *txtViewContent;
@property(nonatomic,strong)User *user;
@property(nonatomic,assign)int whereFrom;
- (IBAction)deleWorkRecordOnClick:(id)sender;
@end
