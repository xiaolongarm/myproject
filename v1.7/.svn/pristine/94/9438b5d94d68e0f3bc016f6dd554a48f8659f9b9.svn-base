//
//  Channels.m
//  CMCCMarketing
//
//  Created by talkweb on 15-5-12.
//  Copyright (c) 2015年 talkweb. All rights reserved.
//

#import "Channels.h"

@implementation Channels

-(id)initWithDictionary:(NSDictionary*)userDict{
    self.baidu_latitude=[[userDict objectForKey:@"baidu_latitude"] doubleValue];
    self.baidu_longtitude=[[userDict objectForKey:@"baidu_longtitude"] doubleValue];
    self.business_dept=[self filterNullType:[userDict objectForKey:@"business_dept"]];
    self.business_dept_mngr=[self filterNullType:[userDict objectForKey:@"business_dept_mngr"]];
    self.business_dept_msisdn=[self filterNullType:[userDict objectForKey:@"business_dept_msisdn"]];
    self.chnl_boss_card=[self filterNullType:[userDict objectForKey:@"chnl_boss_card"]];
    self.chnl_boss_msisdn=[self filterNullType:[userDict objectForKey:@"chnl_boss_msisdn"]];
    self.chnl_boss_name=[self filterNullType:[userDict objectForKey:@"chnl_boss_name"]];
    self.chnl_code=[self filterNullType:[userDict objectForKey:@"chnl_code"]];
    self.chnl_name=[self filterNullType:[userDict objectForKey:@"chnl_name"]];
    self.chnl_type=[self filterNullType:[userDict objectForKey:@"chnl_type"]];
    self.cnty_id=[self filterNullType:[userDict objectForKey:@"cnty_id"]];
    self.cnty_name=[self filterNullType:[userDict objectForKey:@"cnty_name"]];
    self.didu_type=[[userDict objectForKey:@"didu_type"] intValue];
    self.flag=[[userDict objectForKey:@"flag"] intValue];
    self.grp_addr=[self filterNullType:[userDict objectForKey:@"grp_addr"]];
    self.latitude=[[userDict objectForKey:@"latitude"] doubleValue];
    self.longtitude=[[userDict objectForKey:@"longtitude"] doubleValue];
    self.vip_mngr_card=[self filterNullType:[userDict objectForKey:@"vip_mngr_card"]];
    self.vip_mngr_msisdn=[self filterNullType:[userDict objectForKey:@"vip_mngr_msisdn"]];
    self.vip_mngr_name=[self filterNullType:[userDict objectForKey:@"vip_mngr_name"]];
    
    return self;
}
-(id)filterNullType:(id)object{
    if(!object || object == [NSNull null] || ((NSString*)object).length == 0)
        return @"-";
    return object;
}
@end
