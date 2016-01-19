//
//  BusinessHandling.m
//  CMCCMarketing
//
//  Created by talkweb on 14-10-11.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import "BusinessHandling.h"

@implementation BusinessHandling

+(void)getFlowBizData:(void (^)(NSArray *recommendArray,NSArray *moreArray,NSArray *monthArray,NSArray *fourgArray,NSArray *halfyearArray,NSArray *yearArray,NSError *error))block{

    NSString *path = [[NSBundle mainBundle]  pathForResource:@"recommend-flow" ofType:@"json"];
    //    NSLog(@"path:%@",path);
    NSData *jdata = [[NSData alloc] initWithContentsOfFile:path ];
    //    NSLog(@"length:%d",[jdata length]);
    NSError *error = nil;
    NSDictionary * adata = [NSJSONSerialization JSONObjectWithData:jdata options:NSJSONReadingAllowFragments error:&error];
    NSDictionary *recommendDict=[adata objectForKey:@"recommend"];
    NSArray *recommendArray=[recommendDict objectForKey:@"list"];
    //    NSString *recommendTitle=[recommendDict objectForKey:@"title"];
    
    NSMutableArray *moreArray=[[NSMutableArray alloc] init];
    
    NSDictionary *monthDict=[adata objectForKey:@"month"];
    NSArray *marray=[monthDict objectForKey:@"list"];
    for (NSObject *o in marray) {
        [moreArray addObject:o];
    }
    
    NSDictionary *fourgDict=[adata objectForKey:@"fourg"];
    NSArray *farray=[fourgDict objectForKey:@"list"];
    for (NSObject *o in farray) {
        [moreArray addObject:o];
    }
    NSDictionary *halfyearDict=[adata objectForKey:@"halfyear"];
    NSArray *harray=[halfyearDict objectForKey:@"list"];
    for (NSObject *o in harray) {
        [moreArray addObject:o];
    }
    NSDictionary *yearDict=[adata objectForKey:@"year"];
    NSArray *yarray=[yearDict objectForKey:@"list"];
    for (NSObject *o in yarray) {
        [moreArray addObject:o];
    }
    
    block(recommendArray,moreArray,marray,farray,harray,yarray,nil);
}
+(void)getPhoneTerminalData:(void (^)(NSArray *recommendArray,NSArray *moreArray, NSError *error))block{
    
    NSString *path = [[NSBundle mainBundle]  pathForResource:@"recommend-phone" ofType:@"json"];
    NSData *jdata = [[NSData alloc] initWithContentsOfFile:path ];
    NSError *error = nil;
    NSDictionary * adata = [NSJSONSerialization JSONObjectWithData:jdata options:NSJSONReadingAllowFragments error:&error];
    NSArray *recommendArray=[adata objectForKey:@"recommend"];
    NSArray *moreArray=[adata objectForKey:@"phone"];
    block(recommendArray,moreArray,nil);
}
+(NSArray*)calculateWeekOfBeginDateAndEndDate:(NSDate*)date{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDate *now = date;
    NSDateComponents *comps;
    comps = [calendar components:unitFlags fromDate:now];
    //NSInteger week = [comps week]; // 今年的第几周
    NSInteger weekday = [comps weekday]; // 星期几（注意，周日是“1”，周一是“2”。。。。）
    NSDateComponents *comps1 = [[NSDateComponents alloc] init];
    [comps1 setDay:(weekday-1)*-1 + 7];
    NSDate *sunday = [calendar dateByAddingComponents:comps1 toDate:now options:0];
    [comps1 setDay:(weekday-2)*-1];
    NSDate *monday = [calendar dateByAddingComponents:comps1 toDate:now options:0];
    NSMutableArray *array=[[NSMutableArray alloc] init];
    [array addObject:monday];
    [array addObject:sunday];
    return array;
}
+(NSArray*)calculateWeekOfAllDate:(NSDate*)date{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDate *now = date;
    NSDateComponents *comps;
    comps = [calendar components:unitFlags fromDate:now];
    //NSInteger week = [comps week]; // 今年的第几周
    NSInteger weekday = [comps weekday]; // 星期几（注意，周日是“1”，周一是“2”。。。。）
    
    NSDateComponents *comps1 = [[NSDateComponents alloc] init];
    [comps1 setDay:(weekday-1)*-1 + 7];
    NSDate *sunday = [calendar dateByAddingComponents:comps1 toDate:now options:0];
    
    [comps1 setDay:(weekday-2)*-1];
    NSDate *monday = [calendar dateByAddingComponents:comps1 toDate:now options:0];
    
    [comps1 setDay:(weekday-3)*-1];
    NSDate *Tuesday = [calendar dateByAddingComponents:comps1 toDate:now options:0];
    
    [comps1 setDay:(weekday-4)*-1];
    NSDate *Wednesday = [calendar dateByAddingComponents:comps1 toDate:now options:0]; [comps1 setDay:(weekday-2)*-1];
    [comps1 setDay:(weekday-5)*-1];
    NSDate *Thursday = [calendar dateByAddingComponents:comps1 toDate:now options:0]; [comps1 setDay:(weekday-2)*-1];
    [comps1 setDay:(weekday-6)*-1];
    NSDate *Friday = [calendar dateByAddingComponents:comps1 toDate:now options:0]; [comps1 setDay:(weekday-2)*-1];
    [comps1 setDay:(weekday-7)*-1];
    NSDate *Saturday = [calendar dateByAddingComponents:comps1 toDate:now options:0]; [comps1 setDay:(weekday-2)*-1];

    
    NSMutableArray *array=[[NSMutableArray alloc] init];
    
    [array addObject:monday];
    
     [array addObject:Tuesday];
     [array addObject:Wednesday];
     [array addObject:Thursday];
    [array addObject:Friday];
     [array addObject:Saturday];
    [array addObject:sunday];
    return array;
}

+ (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}
@end
