//
//  OnlineTestResultViewController.h
//  CMCCMarketing
//
//  Created by Talkweb on 15/4/24.
//  Copyright (c) 2015年 talkweb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface OnlineTestResultViewController : UIViewController

@property(nonatomic,strong)User *user;
@property (nonatomic,strong) NSArray *testQuestionDetails;

@property (nonatomic,strong) NSDictionary *addPapersInfresult;
@property (weak, nonatomic) IBOutlet UILabel *descResult;
@property (weak, nonatomic) IBOutlet UIImageView *lvlResult;
@property (weak, nonatomic) IBOutlet UILabel *scoreResult;
@property (weak, nonatomic) IBOutlet UILabel *timeResult;

@property (weak, nonatomic) IBOutlet UIView *backgroundView;


@end
