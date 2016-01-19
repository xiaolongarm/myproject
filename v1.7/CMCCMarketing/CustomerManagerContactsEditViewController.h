//
//  CustomerManagerContactsEditViewController.h
//  CMCCMarketing
//
//  Created by talkweb on 14-9-22.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "Group.h"
#import "Channels.h"

@interface CustomerManagerContactsEditViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>{
    
//    __weak IBOutlet UIView *bodyView;
    __weak IBOutlet UIScrollView *bodyScrollView;
    NSString *kUTTypeImage;
    __weak IBOutlet NSLayoutConstraint *tableTopLayoutConstraint;
    
}
@property(nonatomic,strong)NSDictionary *contactDict;
-(void)setEditData;
@property(nonatomic,strong)User *user;
@property(nonatomic,strong)Group *group;
@property(nonatomic,strong)Channels *channels;
/**
 *  @brief  0.集团 1.渠道
 */
@property(nonatomic,assign)int listType;
@property(nonatomic,assign)BOOL isEdit;
@end
