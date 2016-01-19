//
//  SettingViewController.h
//  CMCCMarketing
//
//  Created by talkweb on 14-9-4.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//
#import "User.h"
#import <UIKit/UIKit.h>


@protocol SettingViewControllerDelegate <NSObject>
-(void)settingViewControllerUpdatePersonImageDidFinished;
@end

@interface SettingViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    
    __weak IBOutlet UITableView *tableview;
}
@property(nonatomic,strong)User* user;
@property(nonatomic,assign)BOOL goInformation;
//@property(nonatomic,strong)SettingInformationViewController *settingInformationViewController;
@property(nonatomic,strong)id<SettingViewControllerDelegate>delegate;
@end
