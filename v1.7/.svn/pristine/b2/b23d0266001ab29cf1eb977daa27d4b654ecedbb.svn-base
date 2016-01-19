//
//  RemindHandling.m
//  CMCCMarketing
//
//  Created by talkweb on 15-4-8.
//  Copyright (c) 2015年 talkweb. All rights reserved.
//

#import "RemindHandling.h"
#import "NetworkHandling.h"

@implementation RemindHandling

-(void)getRemindDataWithType:(RemaindType)remaindType{
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    
    
    NSString *url;
    switch (remaindType) {

        case RemaindTypeWithOtherRegress:
        {

            [bDict setObject:self.user.userMobile forKey:@"grp_svc_code"];
            [bDict setObject:[NSNumber numberWithInt:self.user.userEnterprise] forKey:@"enterprise"];

            url=@"diffuserback/remindList";
        }
            break;
        case RemaindTypeWithCustomerManager:
        {
            [bDict setObject:[NSNumber numberWithInt:self.user.userID] forKey:@"user_id"];
            [bDict setObject:self.user.userMobile forKey:@"mobile"];
            [bDict setObject:[NSNumber numberWithInt:self.user.userEnterprise] forKey:@"enterprise"];
                
//            url=@"grpuserlink/birthdayReminder";
#if (defined MANAGER_CS_VERSION) || (defined MANAGER_SY_VERSION)
            url=@"grpuserlink/leaderReminder";
#endif
            
            
#if (defined STANDARD_CS_VERSION) || (defined STANDARD_SY_VERSION)
            url=@"grpuserlink/birthdayReminder";
#endif
        }
            break;

        case RemaindTypeWithCustomerWarning:
        {
            [bDict setObject:self.user.userMobile forKey:@"mobile"];
            [bDict setObject:[NSNumber numberWithInt:self.user.userEnterprise] forKey:@"enterprise"];
                
            url=@"gprwarn/remindList";
        }
            break;
        case RemaindTypeWithVisitPlan:
        {
            [bDict setObject:[NSNumber numberWithInt:self.user.userLvl] forKey:@"user_lvl"];
            [bDict setObject:[NSNumber numberWithInt:self.user.userID] forKey:@"user_id"];
            [bDict setObject:self.user.userMobile forKey:@"user_msisdn"];
            [bDict setObject:[NSNumber numberWithInt:self.user.userEnterprise] forKey:@"enterprise"];
            
            url=@"visitplan/visitplanremind";
        }
            break;
            
        default:
            break;
    }
    
    [self loadRemindDataWithUrl:url withDict:bDict withType:remaindType];
}
-(void)loadRemindDataWithUrl:(NSString*)url withDict:(NSDictionary*)bDict withType:(RemaindType)remaindType{
    [NetworkHandling sendPackageWithUrl:url sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        NSArray *array;
        NSArray *remindTableArray;
        NSArray *remindWithGroupAddressTableArray;
        NSArray *remindWithLinkManTableArray;
        //加入客户管理提醒类型
        NSArray *remindChnlboosTableArray;
        NSArray *remindChnlAddTableArray;

        
        int count=0;
        
        switch (remaindType) {
            case RemaindTypeWithOtherRegress:
                array = [result objectForKey:@"remindUser"];
                count = [array count];
                break;
            case RemaindTypeWithCustomerManager:
                
                //#if (defined MANAGER_CS_VERSION) || (defined MANAGER_SY_VERSION)
#if  (defined MANAGER_SY_VERSION)
                //邵阳主管端客户管理通知角标
                
                remindTableArray =[result objectForKey:@"birthday"];
                remindWithGroupAddressTableArray=[result objectForKey:@"grp_add"];
                remindWithLinkManTableArray=[result objectForKey:@"linkman"];
                remindChnlboosTableArray=[result objectForKey:@"chnlboss"];
                remindChnlAddTableArray=[result objectForKey:@"chnl_add"];
                
                count = [remindTableArray count];
                count += [remindWithGroupAddressTableArray count];
                count += [remindWithLinkManTableArray count];
                count += [remindChnlboosTableArray count];
                count += [remindChnlAddTableArray count];
#endif
                
#if (defined MANAGER_CS_VERSION)
                //长沙主管端客户管理通知角标
                remindTableArray =[result objectForKey:@"birthday"];
                remindWithGroupAddressTableArray=[result objectForKey:@"grp_add"];
                remindWithLinkManTableArray=[result objectForKey:@"linkman"];
                count = [remindTableArray count];
                count += [remindWithGroupAddressTableArray count];
                count += [remindWithLinkManTableArray count];
                
#endif
                
                
#if (defined STANDARD_CS_VERSION) || (defined STANDARD_SY_VERSION)
                array =[result objectForKey:@"Response"];
                count = [array count];
#endif
                
//                array = [result objectForKey:@"Response"];
                break;
            case RemaindTypeWithCustomerWarning:
                array = [result objectForKey:@"remind"];
                count = [array count];
                break;
            case RemaindTypeWithVisitPlan:
                array = [result objectForKey:@"remind"];
                count = [array count];
                break;
            default:
                break;
        }
        
        [self.delegate remindHandlindDidFinished:count withError:error withType:remaindType];
    }];
}
@end
