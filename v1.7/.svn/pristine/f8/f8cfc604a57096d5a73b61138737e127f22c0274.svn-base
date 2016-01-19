//
//  SignMapViewController.h
//  CMCCMarketing
//
//  Created by talkweb on 14-9-4.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//
#import "User.h"
#import <UIKit/UIKit.h>
#import "BMapKit.h"

@interface SignMapViewController : UIViewController<BMKMapViewDelegate,BMKGeoCodeSearchDelegate>{

    
    __weak IBOutlet UIView *mapviewBody;
//    __weak IBOutlet BMKMapView *mapView;
    __weak IBOutlet UILabel *lbSignLocation;
    __weak IBOutlet UILabel *lbSignTime;
    
    BMKMapView *mapView;
    
    __weak IBOutlet UILabel *lbLocationTitle;
    __weak IBOutlet UILabel *lbTimeTitle;
    
}

@property(nonatomic,strong)User* user;
@property(nonatomic,assign)BOOL isSignIn;
@end
