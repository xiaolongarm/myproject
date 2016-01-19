//
//  VariableStore.h
//  CMCCMarketing
//
//  Created by talkweb on 14-12-8.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LocationDataAcquisition.h"

@interface VariableStore : NSObject

@property(nonatomic,strong)NSData* deviceToken;

+ (VariableStore *)sharedInstance;
@property(nonatomic,assign)BOOL isStopGPSReport;
@property(nonatomic,strong)LocationDataAcquisition *locationDataAcquisition;

@property(nonatomic,strong)NSString *city;
@property(nonatomic,assign)CLLocationCoordinate2D coord;

+ (NSString*)getCustomerManagerName;
+(UIColor *) hexStringToColor: (NSString *) stringToConvert;
@end
