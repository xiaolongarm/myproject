//
//  VerifyAddressViewController.h
//  CMCCMarketing
//
//  Created by kevin on 15/8/21.
//  Copyright (c) 2015年 talkweb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "BMapKit.h"
@interface VerifyAddressViewController : UIViewController<BMKMapViewDelegate,BMKGeoCodeSearchDelegate>
@property (strong, nonatomic) IBOutlet UILabel *companyName;
@property (strong, nonatomic) IBOutlet UILabel *companyAddr;
@property (strong, nonatomic) IBOutlet UIView *mapView;
@property (strong, nonatomic) IBOutlet UISwitch *passSwicth;

@property(nonatomic,strong)User* user;
@property(nonatomic,strong)NSDictionary *addrmsgDict;
@property (strong, nonatomic) IBOutlet UITextView *commit;
- (IBAction)PostDataButton:(id)sender;

@end
