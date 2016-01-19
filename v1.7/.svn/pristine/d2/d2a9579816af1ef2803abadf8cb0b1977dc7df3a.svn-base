//
//  W_VisitPlanSignoutTableViewController.h
//  CMCCMarketing
//
//  Created by gmj on 14-11-27.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "User.h"
#import "BMapKit.h"

#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface W_VisitPlanSignoutTableViewController : UIViewController <BMKMapViewDelegate,BMKGeoCodeSearchDelegate>{
    
    __weak IBOutlet UIButton *signButton;
    __weak IBOutlet UIButton *refreshLocationButton;
}

@property(nonatomic,strong)User *user;
@property (strong,nonatomic)NSDictionary *dicSelectVisitPlanDetail;

@property (weak, nonatomic) IBOutlet UILabel *lblVisit_grp_name;
@property (weak, nonatomic) IBOutlet UILabel *lblLinkman;
@property (weak, nonatomic) IBOutlet UILabel *lblVip_mngr_name;
@property (weak, nonatomic) IBOutlet UILabel *lblVip_mngr_msisdn;
@property (weak, nonatomic) IBOutlet UILabel *lblVisit_grp_add;

@property (weak, nonatomic) IBOutlet BMKMapView *mapView;
@property (weak, nonatomic) IBOutlet UILabel *lblCurrentLocation;
@property (weak, nonatomic) IBOutlet UILabel *lblSignTime;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

- (IBAction)toVisitPlanDetailOnClick:(id)sender;
- (IBAction)refreshLocationOnClick:(id)sender;
- (IBAction)signOnClick:(id)sender;

@end
