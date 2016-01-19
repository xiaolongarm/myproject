//
//  AppDelegate.h
//  CMCCMarketing
//
//  Created by talkweb on 14-9-1.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>{
    BMKMapManager* _mapManager;
    CLLocationManager *locationManager;
    
    BMKLocationService *bmklocService;
    BMKGeoCodeSearch *bmkgeocodeSearch;
    int bmklocationUpdatecount ;
}

@property (strong, nonatomic) UIWindow *window;
@property (copy) void (^backgroundSessionCompletionHandler)(); 

@end
