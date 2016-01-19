//
//  PreferentialPurchaseSendBoxViewController.h
//  CMCCMarketing
//
//  Created by talkweb on 14-9-18.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface PreferentialPurchaseSendBoxViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{

    IBOutlet UITableView *sendBoxTableView;
}
@property(nonatomic,strong)User *user;
@end
