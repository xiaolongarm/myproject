//
//  CustomerManagerContactsDetailsViewController.h
//  CMCCMarketing
//
//  Created by talkweb on 14-10-29.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "User.h"
#import "Group.h"
#import "Channels.h"
@protocol CustomerManagerContactsDetailsViewControllerDelegate <NSObject>
-(void)customerManagerContactsDetailsViewGoEdit:(NSDictionary*)contactDict;
@end

@interface CustomerManagerContactsDetailsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,MFMessageComposeViewControllerDelegate>{
    
    __weak IBOutlet UITableView *detailsTableView;
    
    __weak IBOutlet UIButton *btCallPhone;
    __weak IBOutlet UIButton *btSendMsg;
//    __weak IBOutlet NSLayoutConstraint *tableTopLayoutConstraint;
    __weak IBOutlet UIImageView *imgLine;
    
    __weak IBOutlet NSLayoutConstraint *tableLayoutConstraint;
}
@property(nonatomic,strong)NSDictionary *contactsDict;
@property(nonatomic,strong)User *user;
@property(nonatomic,strong)Group *group;
@property(nonatomic,strong)Channels *channels;
@property(nonatomic,assign)int listType;
@property(nonatomic,strong)id<CustomerManagerContactsDetailsViewControllerDelegate>delegate;

@end
