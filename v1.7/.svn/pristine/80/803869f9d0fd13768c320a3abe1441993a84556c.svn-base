//
//  CustomerManager.m
//  CMCCMarketing
//
//  Created by gmj on 15-1-13.
//  Copyright (c) 2015年 talkweb. All rights reserved.
//

#import "CustomerManager.h"

@implementation CustomerManager

-(id)initWithDictionary:(NSDictionary*)userDict{
    
    self.vip_mngr_msisdn = [userDict objectForKey:@"vip_mngr_msisdn"];
    self.vip_mngr_name = [userDict objectForKey:@"vip_mngr_name"];
    self.vip_mngr_user_id=[[userDict objectForKey:@"vip_mngr_user_id"] intValue];
    NSArray *array=[userDict objectForKey:@"list"];
    NSMutableArray *tmpArray =[[NSMutableArray alloc] init];
    for (NSDictionary *item in array) {
        Group *g=[[Group alloc] initWithDictionary:item];
//        NSLog(@"group name : %@",g.groupName);
        [tmpArray addObject:g];
    }
    self.groupList=tmpArray;
    
    return self;
}

@end
