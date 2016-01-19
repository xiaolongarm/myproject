//
//  RemindHandling.h
//  CMCCMarketing
//
//  Created by talkweb on 15-4-8.
//  Copyright (c) 2015年 talkweb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

typedef enum{
//    RemaindTypeWithMarketing,
//    RemaindTypeWithBusiness,
    RemaindTypeWithOtherRegress,
    RemaindTypeWithCustomerManager,
//    RemaindTypeWithMonthlyTasks,
//    RemaindTypeWithKnowledgeBase,
    RemaindTypeWithCustomerWarning,
//    RemaindTypeWithDataAcquisition,
    RemaindTypeWithVisitPlan,
}RemaindType;

@protocol RemindHandlingDelegate <NSObject>
-(void)remindHandlindDidFinished:(int)count withError:(NSError*)error withType:(RemaindType)remaindType;
@end

@interface RemindHandling : NSObject

-(void)getRemindDataWithType:(RemaindType)remaindType;
@property(nonatomic,strong)User *user;
@property(nonatomic,strong)id<RemindHandlingDelegate>delegate;

@end
