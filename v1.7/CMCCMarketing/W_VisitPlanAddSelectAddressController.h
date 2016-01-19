//
//  W_VisitPlanAddSelectAddressController.h
//  CMCCMarketing
//
//  Created by gmj on 14-12-2.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

#import "BMapKit.h"
#import "User.h"
#import "BMKSearchComponent.h"

@protocol W_VisitPlanAddSelectAddressControllerDelegate <NSObject>
-(void)w_visitPlanAddSelectAddressControllerDidFinished:(CLLocationCoordinate2D)coord selectWithAddress:(NSString *)address;
@end

@interface W_VisitPlanAddSelectAddressController : UIViewController <BMKMapViewDelegate,BMKGeoCodeSearchDelegate,UISearchBarDelegate,BMKPoiSearchDelegate>{
    
    __weak IBOutlet UILabel *lbSelectAddress;
    __weak IBOutlet UIButton *touchRemarkButton;
    __weak IBOutlet UISearchBar *searchbar;
    
    __weak IBOutlet NSLayoutConstraint *searchbarLayoutConstraint;
}

//@property(nonatomic,strong)id vc;
@property(nonatomic,assign)int listType;
@property(nonatomic,strong)NSDictionary *rDict;
@property(nonatomic,strong)User *user;
@property(nonatomic,strong)Group *group;
@property(nonatomic,assign)BOOL layoutSearchBar;
@property (weak, nonatomic) IBOutlet BMKMapView *mapView;
@property(nonatomic,strong)id<W_VisitPlanAddSelectAddressControllerDelegate>delegate;

@end
