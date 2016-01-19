//
//  CustomerManager.h
//  CMCCMarketing
//
//  Created by gmj on 15-1-13.
//  Copyright (c) 2015年 talkweb. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Group.h"

@interface CustomerManager : NSObject

@property(nonatomic,strong)NSString* vip_mngr_msisdn;
@property(nonatomic,strong)NSString* vip_mngr_name;
@property(nonatomic,assign)int vip_mngr_user_id;
@property(nonatomic,strong)NSArray* groupList;

-(id)initWithDictionary:(NSDictionary*)userDict;

@end
