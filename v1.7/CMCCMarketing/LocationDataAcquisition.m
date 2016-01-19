//
//  LocationDataAcquisition.m
//  CMCCMarketing
//
//  Created by talkweb on 14-12-25.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import "LocationDataAcquisition.h"
#import "NetworkHandling.h"
#import "VariableStore.h"

@implementation LocationDataAcquisition

-(void)startLocationDataAcquisition
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (locationMgr == nil)
        {
            locationMgr = [[CLLocationManager alloc] init];
            locationMgr.delegate = self;
            locationMgr.desiredAccuracy = kCLLocationAccuracyBest;
//            locationMgr.distanceFilter=100.0;
            locationMgr.distanceFilter=kCLDistanceFilterNone;
            lastDate=[NSDate date];
        }
        [locationMgr startUpdatingLocation];
    });

    [self startLocationSend];
}

-(void)stopLocationDataAcquisition{
    [locationMgr stopUpdatingLocation];
    
}

-(void)startLocationSend{
    if([VariableStore sharedInstance].isStopGPSReport){
//        NSLog(@"flag to stop update location...");
        [locationMgr stopUpdatingLocation];
        return;
    }
    
    UserLocation *userLocation=[self readSqlEntityWithFirst];
    if(!userLocation){
//        NSLog(@"null location data ,sleep now...");
        sleep(180);
        [self startLocationSend];
    }
    else
        [self sendLocation:userLocation];

}

-(void)sendLocation:(UserLocation*)userLocation{
    NSString *netstate=[NetworkHandling GetServerConnectState];
    if(!netstate)
        return;
    
    if(!userLocation)
        [self startLocationSend];
    
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    [bDict setValue:userLocation.userid forKey:@"userid"];
    [bDict setValue:userLocation.type forKey:@"type"];
    [bDict setValue:userLocation.time forKey:@"time"];
    [bDict setValue:userLocation.latitude forKey:@"lat"];
    [bDict setValue:userLocation.longitude forKey:@"lng"];
    [bDict setValue:[[UIDevice currentDevice].identifierForVendor UUIDString] forKey:@"DeviceID"];
    [NetworkHandling sendPackageWithUrl:@"HamstrerServlet/uploadgps" sendBody:bDict sendWithPostType:1 processHandler:^(NSDictionary *result, NSError *error) {
        BOOL flag=[[result objectForKey:@"ret_val"] boolValue];
        if(!error && flag){
//            NSLog(@"time:%@ send location %@ %@",userLocation.time,userLocation.latitude,userLocation.longitude);
            dispatch_async(dispatch_get_main_queue(), ^{
                BOOL f = [self deleteSqlEntity:userLocation];
                dispatch_async(dispatch_get_global_queue(0, 0), ^{
                    if(f) [self startLocationSend];
                });
            });
        }
        else{
            NSLog(@"time:%@ send fail, location %@ %@",userLocation.time,userLocation.latitude,userLocation.longitude);
            if(![VariableStore sharedInstance].isStopGPSReport) [self sendLocation:userLocation];
            else [locationMgr stopUpdatingLocation];
        }
    }];
}
#pragma mark - location Delegate
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"Location error!");
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
//    NSLog(@"location updatelications --");
    NSTimeInterval interval=[[NSDate date] timeIntervalSinceDate:lastDate];
    if(interval < 3*60){
//        NSLog(@"NSTimeInterval :%f",interval);
        return;
    }
    
    CLLocation* location = [locations lastObject];
    UserLocation *userLocation=[[UserLocation alloc] init];
    userLocation.userid=[NSNumber numberWithInt:self.user.userID];
    lastDate=[NSDate date];
    NSTimeInterval time = [lastDate timeIntervalSince1970]*1000;
    long long datetime = (long long)time;
    
    userLocation.time=[NSNumber numberWithLongLong:datetime];
    userLocation.type=[NSNumber numberWithInt:0];
    userLocation.latitude=[NSNumber numberWithDouble:location.coordinate.latitude];
    userLocation.longitude=[NSNumber numberWithDouble:location.coordinate.longitude];
//    NSLog(@"location updatelications ------- time:%@-------------------",userLocation.time);
    [self saveSqlEntity:userLocation];
}

-(void)saveSqlEntity:(UserLocation*)userLocation
{
    if(!sqlEntityHandling){
        sqlEntityHandling=[[SqlEntityHandling alloc] init];
    }
    
    NSManagedObject *object=[NSEntityDescription insertNewObjectForEntityForName:@"UserLocation" inManagedObjectContext:sqlEntityHandling.managedObjectContext];
    
    [object setValue:userLocation.userid forKey:@"userid"];
    [object setValue:userLocation.type forKey:@"type"];
    [object setValue:userLocation.time forKey:@"time"];
    [object setValue:userLocation.latitude forKey:@"latitude"];
    [object setValue:userLocation.longitude forKey:@"longitude"];
//    NSLog(@"saveSqlEntity ------- time:%@-------------------",userLocation.time);
    [sqlEntityHandling saveContext];
}

-(NSArray*)readSqlEntity
{
    if(!sqlEntityHandling){
        sqlEntityHandling=[[SqlEntityHandling alloc] init];
    }
    
    NSFetchRequest *fetch=[[NSFetchRequest alloc]init];
    NSEntityDescription *object=[NSEntityDescription entityForName:@"UserLocation" inManagedObjectContext:sqlEntityHandling.managedObjectContext];
    [fetch setEntity: object ];
    NSSortDescriptor *sort=[[NSSortDescriptor alloc]initWithKey:@"time" ascending:YES];
    NSLog(@"%@",sort);
    NSArray *sortarr=[[NSArray alloc]initWithObjects:sort, nil];
    [fetch setSortDescriptors:sortarr];
    NSError *error;
    NSArray *fetchresult=[sqlEntityHandling.managedObjectContext executeFetchRequest:fetch error:&error];
    return fetchresult;
}
-(UserLocation*)readSqlEntityWithFirst
{
    if(!sqlEntityHandling){
        sqlEntityHandling=[[SqlEntityHandling alloc] init];
    }
    
    NSFetchRequest *fetch=[[NSFetchRequest alloc]init];
    NSEntityDescription *object=[NSEntityDescription entityForName:@"UserLocation" inManagedObjectContext:sqlEntityHandling.managedObjectContext];
    [fetch setEntity: object ];
    NSSortDescriptor *sort=[[NSSortDescriptor alloc]initWithKey:@"time" ascending:YES];
//    NSLog(@"readSqlEntityWithFirst ------- sort:%@-----------------",sort);
    NSArray *sortarr=[[NSArray alloc]initWithObjects:sort, nil];
    [fetch setSortDescriptors:sortarr];
    NSError *error;
    NSArray *fetchresult=[sqlEntityHandling.managedObjectContext executeFetchRequest:fetch error:&error];
    return [fetchresult firstObject];
}
-(BOOL)updateSqlEntity:(UserLocation*)userLocation{
    if(!sqlEntityHandling){
        sqlEntityHandling=[[SqlEntityHandling alloc] init];
    }
    
    NSFetchRequest *fetch=[[NSFetchRequest alloc]init];
    NSEntityDescription *object=[NSEntityDescription entityForName:@"UserLocation" inManagedObjectContext:sqlEntityHandling.managedObjectContext];
    [fetch setEntity: object ];
    
    NSSortDescriptor *sort=[[NSSortDescriptor alloc]initWithKey:@"time" ascending:YES];
    NSLog(@"%@",sort);
    
    NSArray *sortarr=[[NSArray alloc]initWithObjects:sort, nil];
    [fetch setSortDescriptors:sortarr];
    
   fetch.predicate=[NSPredicate predicateWithFormat:@"time==%d",userLocation.time];
    
    NSError *error;
    NSArray *fetchresult=[sqlEntityHandling.managedObjectContext executeFetchRequest:fetch error:&error];
    
    NSManagedObject *o =[fetchresult firstObject];
    
    [o setValue:userLocation.userid forKey:@"userid"];
    [o setValue:userLocation.type forKey:@"type"];
    [o setValue:userLocation.latitude forKey:@"latitude"];
    [o setValue:userLocation.longitude forKey:@"longitude"];
    [sqlEntityHandling.managedObjectContext save:&error];
    
    if(error)
        return NO;
    return YES;

}
-(BOOL)deleteSqlEntity:(UserLocation*)userLocation{
    if(!sqlEntityHandling){
        sqlEntityHandling=[[SqlEntityHandling alloc] init];
    }
    NSError *error;
    [sqlEntityHandling.managedObjectContext deleteObject:(NSManagedObject*)userLocation];
    [sqlEntityHandling.managedObjectContext save:&error];
    
    if(error)
        return NO;
    return YES;
    
}

//    dispatch_async(dispatch_queue_create("VOICE_RECEIVE_QUEUE", NULL), ^{
//        dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        });
//    });
//
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//
//    });
//    dispatch_sync(dispatch_get_global_queue(0, 0), ^{
//
//    });
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        dispatch_async(dispatch_get_main_queue(), ^{
//
//        });
//    });

@end
