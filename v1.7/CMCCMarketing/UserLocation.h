//
//  UserLocation.h
//  CMCCMarketing
//
//  Created by talkweb on 14-12-25.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserLocation : NSObject

@property (nonatomic,strong)NSNumber *userid;
@property (nonatomic,strong)NSNumber *type; //0:gps 1:基站
@property (nonatomic,strong)NSNumber *time;
@property (nonatomic,strong)NSNumber *latitude;
@property (nonatomic,strong)NSNumber *longitude;

@end
