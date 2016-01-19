//
//  CustomerManagerGroupAddressVerifyViewController.h
//  CMCCMarketing
//
//  Created by talkweb on 15-4-30.
//  Copyright (c) 2015年 talkweb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "BMapKit.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface CustomerManagerGroupAddressVerifyViewController : UIViewController<BMKMapViewDelegate>{
    
    __weak IBOutlet UITextView *txtVerifyContent;
    __weak IBOutlet UILabel *lbAddressTitle;
    __weak IBOutlet UILabel *lbAddress;
    
    __weak IBOutlet UISwitch *swVerify;
    
}

@property (weak, nonatomic) IBOutlet BMKMapView *mapview;
@property(nonatomic,strong)User* user;
@property(nonatomic,strong)NSDictionary *addrmsgDict;
@end
