//
//  ChannelsManager.m
//  CMCCMarketing
//
//  Created by talkweb on 15-5-18.
//  Copyright (c) 2015年 talkweb. All rights reserved.
//

#import "ChannelsManager.h"

@implementation ChannelsManager

-(id)initWithDictionary:(NSDictionary*)userDict{
    
    self.vip_mngr_msisdn = [userDict objectForKey:@"vip_mngr_msisdn"];
    self.vip_mngr_name = [userDict objectForKey:@"vip_mngr_name"];
    self.vip_mngr_user_id=[[userDict objectForKey:@"vip_mngr_user_id"] intValue];
    NSArray *array=[userDict objectForKey:@"list"];
    NSMutableArray *tmpArray =[[NSMutableArray alloc] init];
    for (NSDictionary *item in array) {
        Channels *g=[[Channels alloc] initWithDictionary:item];
        [tmpArray addObject:g];
    }
    self.channelList=tmpArray;
    
    return self;
}

@end
