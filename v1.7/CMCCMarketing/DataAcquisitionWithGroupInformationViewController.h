//
//  DataAcquisitionWithGroupInformationViewController.h
//  CMCCMarketing
//
//  Created by talkweb on 15-2-27.
//  Copyright (c) 2015年 talkweb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "JMFormDelegate.h"


@interface DataAcquisitionWithGroupInformationViewController : UIViewController<JMFormDelegate,JMKeyboardFormDelegate>

@property(nonatomic,strong)User *user;
@end
