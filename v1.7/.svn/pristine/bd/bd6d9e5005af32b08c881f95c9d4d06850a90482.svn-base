//
//  User.m
//  CMCCMarketing
//
//  Created by talkweb on 14-9-29.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import "User.h"



@implementation User

-(id)initWithDictionary:(NSDictionary*)userDict{
    self.userID=[[userDict objectForKey:@"userID"] intValue];
    self.userName=(NSNull*)[userDict objectForKey:@"userName"] != [NSNull null] ? [userDict objectForKey:@"userName"] : @"";
    self.userCode=(NSNull*)[userDict objectForKey:@"userCode"] != [NSNull null] ? [userDict objectForKey:@"userCode"] : @"";
    self.userSex=(NSNull*)[userDict objectForKey:@"sex"] != [NSNull null] ?[[userDict objectForKey:@"sex"] intValue]:0;
    self.userLvl=[[userDict objectForKey:@"userLvl"] intValue];
    self.userDeptDesc=(NSNull*)[userDict objectForKey:@"deptDesc"] != [NSNull null] ? [userDict objectForKey:@"deptDesc"] : @"";
    self.userEmail=(NSNull*)[userDict objectForKey:@"email"] != [NSNull null] ? [userDict objectForKey:@"email"] : @"";
    self.userEnterprise=[[userDict objectForKey:@"enterprise"] intValue];
    self.userImageUrl= (NSNull*)[userDict objectForKey:@"imageUrl"] != [NSNull null] ? [userDict objectForKey:@"imageUrl"] : @"";
    self.userLoginState=[[userDict objectForKey:@"isLogin"] intValue];
    self.userMobile=(NSNull*)[userDict objectForKey:@"mobile"] != [NSNull null] ? [userDict objectForKey:@"mobile"] : @"";
    self.userPassword=[userDict objectForKey:@"password"];
    //客户经理归宿县市id
    self.userCntyID=[userDict objectForKey:@"cnty_id"];
    
    self.gps_sta=[[userDict objectForKey:@"gps_sta"] boolValue];
    self.managerRole=[[userDict objectForKey:@"mngr_role"] intValue];

    
//    NSArray *array=[userDict objectForKey:@"groupInfo"];
//    NSMutableArray *tmpArray =[[NSMutableArray alloc] init];
//    for (NSDictionary *item in array) {
//        Group *g=[[Group alloc] initWithDictionary:item];
////        NSLog(@"group name : %@",g.groupName);
//        [tmpArray addObject:g];
//    }
//    self.groupInfo=tmpArray;
    
    
    
    //#ifdef MANAGER_VERSION
#if (defined MANAGER_CS_VERSION) || (defined MANAGER_SY_VERSION)
    
    NSArray *array=[userDict objectForKey:@"groupInfo"];
    NSMutableArray *tmpArray =[[NSMutableArray alloc] init];
    for (NSDictionary *item in array) {
        CustomerManager *c = [[CustomerManager alloc] initWithDictionary:item];
        [tmpArray addObject:c];
    }
    self.customerManagerInfo = tmpArray;
    
    NSArray *channelArray=[userDict objectForKey:@"chnlInfo"];
    NSMutableArray *tArray =[[NSMutableArray alloc] init];
    for (NSDictionary *item in channelArray) {
        ChannelsManager *c = [[ChannelsManager alloc] initWithDictionary:item];
        [tArray addObject:c];
    }
    self.channelManagerInfo = tArray;
    
#endif
    
    
    
    //#ifdef STANDARD_VERSION
#if (defined STANDARD_CS_VERSION) || (defined STANDARD_SY_VERSION)
    
    NSArray *array=[userDict objectForKey:@"groupInfo"];
    NSMutableArray *tmpArray =[[NSMutableArray alloc] init];
    for (NSDictionary *item in array) {
        Group *g=[[Group alloc] initWithDictionary:item];
        //        NSLog(@"group name : %@",g.groupName);
        [tmpArray addObject:g];
    }
    self.groupInfo=tmpArray;
    
    NSArray *channelArray=[userDict objectForKey:@"chnlInfo"];
    NSMutableArray *tArray =[[NSMutableArray alloc] init];
    for (NSDictionary *item in channelArray) {
        Channels *g=[[Channels alloc] initWithDictionary:item];
        [tArray addObject:g];
    }
    self.chnlInfo=tArray;
#endif
    
    return self;
}

//groupInfo



@end
