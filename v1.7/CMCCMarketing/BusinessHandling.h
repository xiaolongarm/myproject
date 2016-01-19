//
//  BusinessHandling.h
//  CMCCMarketing
//
//  Created by talkweb on 14-10-11.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BusinessHandling : NSObject

//+(void)getFlowBizDataWithRecommend:(NSMutableArray*)recommendArray withMore:(NSMutableArray*)moreArray;
//+(void)getPhoneTerminalDataWithRecommend:(NSMutableArray*)recommendArray withMore:(NSMutableArray*)moreArray;

+(void)getFlowBizData:(void (^)(NSArray *recommendArray,NSArray *moreArray,NSArray *monthArray,NSArray *fourgArray,NSArray *halfyearArray,NSArray *yearArray,NSError *error))block;
+(void)getPhoneTerminalData:(void (^)(NSArray *recommendArray,NSArray *moreArray, NSError *error))block;
+(NSArray*)calculateWeekOfBeginDateAndEndDate:(NSDate*)date;
+(NSArray*)calculateWeekOfAllDate:(NSDate*)date;

+(UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size;
@end
