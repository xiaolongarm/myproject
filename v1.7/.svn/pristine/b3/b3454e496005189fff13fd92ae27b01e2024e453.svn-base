//
//  SendBoxHandling.m
//  CMCCMarketing
//
//  Created by talkweb on 14-10-13.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import "SendBoxHandling.h"

@implementation SendBoxHandling

+(BOOL)setSendMessage:(NSDictionary*)data dataWithModule:(NSString*)moduleName{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,     NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath=[documentsDirectory stringByAppendingPathComponent:moduleName];
    
    NSFileManager *fileManager=[NSFileManager defaultManager];
    BOOL ff= [fileManager fileExistsAtPath:filePath];
    NSMutableArray *sendBoxArray;
    if(!ff){
        sendBoxArray=[[NSMutableArray alloc]init];
    }
    else{
        sendBoxArray=[NSMutableArray arrayWithContentsOfFile:filePath];
    }
//    [sendBoxArray removeAllObjects];
//    [sendBoxArray writeToFile:filePath atomically:YES];
    [sendBoxArray addObject:data];
    return [sendBoxArray writeToFile:filePath atomically:YES];
}
+(NSMutableArray*)getSendMessageWithModule:(NSString*)moduleName{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,     NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath=[documentsDirectory stringByAppendingPathComponent:moduleName];
    
    NSFileManager *fileManager=[NSFileManager defaultManager];
    BOOL ff= [fileManager fileExistsAtPath:filePath];
    if(!ff)
        return nil;
    NSMutableArray *tmpArray=[NSMutableArray arrayWithContentsOfFile:filePath];
    return tmpArray;
}
+(BOOL)refreshMessageWithModule:(NSString*)moduleName rewriteArray:(NSMutableArray*)array{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,     NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath=[documentsDirectory stringByAppendingPathComponent:moduleName];
    
    NSFileManager *fileManager=[NSFileManager defaultManager];
    BOOL ff= [fileManager fileExistsAtPath:filePath];
    if(!ff)
        return NO;
    return [array writeToFile:filePath atomically:YES];

}
+(NSString*)getUrlCode:(NSString*)string{
//    cStringUsingEncoding:NSUnicodeStringEncoding
//    const char* unicodeString=[string cStringUsingEncoding:NSUnicodeStringEncoding];
//    return [NSData dataWithBytes:unicodeString length:strlen(unicodeString)];
    
    return [string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}
+(NSString*)getUrlDecode:(NSString*)codeString{
    
    return [codeString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

@end
