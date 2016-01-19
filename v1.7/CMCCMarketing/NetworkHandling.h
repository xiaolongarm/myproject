//
//  NetworkHandling.h
//  CMCCMarketing
//
//  Created by talkweb on 14-9-10.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NetworkHandling : NSObject{

}

+ (void)getJsonWithUrl:(NSString*)postUrl sendBody:(NSDictionary*)bDict processHandler:(void (^)(NSDictionary *result, NSError *error))block;

+ (void)sendPackageWithUrl:(NSString*)postUrl sendBody:(NSDictionary*)bDict sendWithPostType:(int)postType processHandler:(void (^)(NSDictionary *result, NSError *error))block;

+ (void)sendPackageWithUrl:(NSString*)postUrl sendBody:(NSDictionary*)bDict processHandler:(void (^)(NSDictionary *result, NSError *error))block;
+(void)UploadsyntheticPictures:(UIImage*)img currentPicName:(NSString*)filename currentUser:(int)userId uploadType:(NSString*)uType completionHandler:(void(^)(NSURLResponse *response,                                                                                                                     NSData *data, NSError *error))block;
+(void)UploadsyntheticPictures:(UIImage*)img currentPicName:(NSString*)filename uploadType:(NSString*)uType completionHandler:(void(^)(NSURLResponse *response,                                                                                                                     NSData *data, NSError *error))block;

+(NSString*)GetCurrentNet;
+(NSString*)GetServerConnectState;
//+(NSString *)getBaseUrl;
//+ (void)sendLocation:(NSDictionary*)bDict processHandler:(void (^)(NSDictionary *result, NSError *error))block;
+(NSString *)getUpdateUrl;
+(NSString *)getBaseUrlString;
@end
