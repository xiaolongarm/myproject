//
//  OtherRegressFeedbackController.h
//  CMCCMarketing
//
//  Created by gmj on 15-1-6.
//  Copyright (c) 2015年 talkweb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface OtherRegressFeedbackController: UIViewController{
    
}

@property(nonatomic,assign)NSInteger linkType;
@property(nonatomic,strong)User* user;
@property(nonatomic,strong)NSDictionary *diffUserDict;

@property (weak, nonatomic) IBOutlet UITextView *txtRemark;
@property (weak, nonatomic) IBOutlet UISwitch *switchIs_sensitive_user;
@property (weak, nonatomic) IBOutlet UILabel *lblAgain_link_date;
@property (weak, nonatomic) IBOutlet UIButton *btnAgain_link_date;
- (IBAction)btnAgain_link_dateOnClick:(id)sender;
- (IBAction)submitOnClick:(id)sender;
@end
