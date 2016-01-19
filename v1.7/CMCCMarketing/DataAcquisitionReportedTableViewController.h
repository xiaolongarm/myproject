//
//  DataAcquisitionReportedTableViewController.h
//  CMCCMarketing
//
//  Created by talkweb on 14-9-28.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface DataAcquisitionReportedTableViewController : UITableViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property(nonatomic,strong)User *user;
@end
