//
//  GroupBroadbandViewController.h
//  CMCCMarketing
//
//  Created by talkweb on 14-9-15.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface GroupBroadbandViewController : UIViewController{

    __weak IBOutlet UIView *bodyView;
    __weak IBOutlet UIButton *renewalButton;
    __weak IBOutlet UIButton *createAccountButton;
}
@property(nonatomic,strong)User *user;

@end
