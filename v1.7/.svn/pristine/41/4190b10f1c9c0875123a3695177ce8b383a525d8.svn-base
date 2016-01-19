//
//  LocationDataAcquisition.h
//  CMCCMarketing
//
//  Created by talkweb on 14-12-25.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>  
#import "SqlEntityHandling.h"
#import <CoreData/CoreData.h>
#import "UserLocation.h"
#import "User.h"

@interface LocationDataAcquisition : NSObject<CLLocationManagerDelegate>{
    CLLocationManager* locationMgr;
    SqlEntityHandling *sqlEntityHandling;
    NSDate *lastDate;
}

-(void)startLocationDataAcquisition;
-(void)stopLocationDataAcquisition;

@property(nonatomic,strong)User *user;
//@property(nonatomic,assign)BOOL isStart;

-(void)saveSqlEntity:(UserLocation*)userLocation;
-(NSArray*)readSqlEntity;
-(UserLocation*)readSqlEntityWithFirst;
-(BOOL)updateSqlEntity:(UserLocation*)userLocation;
-(BOOL)deleteSqlEntity:(UserLocation*)userLocation;
//-(void)startLocationSend;

@end
