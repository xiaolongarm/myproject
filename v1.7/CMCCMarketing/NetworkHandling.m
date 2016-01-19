//
//  NetworkHandling.m
//  CMCCMarketing
//
//  Created by talkweb on 14-9-10.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//
//#import "AFHTTPSessionManager.h"
#import "NetworkHandling.h"
#import "Base64codeFunc.h"
#import "Reachability.h"
#import "BusinessHandling.h"


@implementation NetworkHandling
    //192.168.31.112 192.168.31.100
    //192.168.146.167

//    NSString*const BaseURLString=@"http://192.168.146.167:8080/kite/";
//http://appbox.talkyun.com/kite/HamstrerServlet/
//NSString*const BaseURLString=@"http://appbox.talkyun.com/kite/";

//http://111.22.14.166:8080
//211.138.233.31 端口80
// 211.138.233.31
///111.22.14.166
//211.138.233.31:80 邵阳
//111.22.14.166:8080 长沙
//appbox.talkyun.com
//    NSString*const BaseURLString = @"http://192.168.146.167:8080/kite/HamstrerServlet/v1_4/";
//    NSString*const jsonFileURLString = @"http://192.168.146.166:8888/kite/";//精准营销JSON文件地址
    NSString* const md5Key=@"k3N8t1";

//http://192.168.146.167:8080/kite/dimjson

//    NSString*const gpsReportUrlString = @"http://192.168.146.167:8080/kite/HamstrerServlet/uploadGPS";
//NSString*const gpsReportUrlString = @"http://192.168.31.62:8080/kite/HamstrerServlet/";
//http://192.168.31.62:8080/kite/uploadGPS

//    NSString*const serverPingIp = @"192.168.146.167";
//    static MBProgressHUD* HUD;
//static bool flag;
//    NSString*const UploadUrlString = [BaseURLString stringByAppendingString:@"http://192.168.146.167:8080/kite/iosupload"];


//+(NSString *)getBaseUrl{
//    return @"http://192.168.146.167:8080/";
//}

+(NSString *)getBaseUrlString{
    NSString *serverAddress = [[NSUserDefaults standardUserDefaults] stringForKey:@"server_ip"];
    NSString *serverPort=[[NSUserDefaults standardUserDefaults] stringForKey:@"server_port"];
    
    if([serverPort length])
        serverAddress=[NSString stringWithFormat:@"%@:%@",serverAddress,serverPort];
    
    NSString *baseUrl=@"http://";
    baseUrl=[baseUrl stringByAppendingString:serverAddress];
    baseUrl=[baseUrl stringByAppendingString:@"/kite/"];
    return baseUrl;
}
+(NSString *)getUpdateUrl{
//    return @"http://192.168.146.167:8080/kite/iosupdate/";
//    return [[self getBaseUrlString] stringByAppendingString:@"iosupdate/"];
    return @"https://mpc.mtalkweb.com/marketing/";
}



+ (void)sendPackageWithUrl:(NSString*)postUrl sendBody:(NSDictionary*)bDict processHandler:(void (^)(NSDictionary *result, NSError *error))block{
    [self sendPackageWithUrl:postUrl sendBody:bDict sendWithPostType:-1 processHandler:^(NSDictionary *result, NSError *error) {
        block(result,error);
    }];
}


+ (void)sendPackageWithUrl:(NSString*)postUrl sendBody:(NSDictionary*)bDict sendWithPostType:(int)postType processHandler:(void (^)(NSDictionary *result, NSError *error))block{
    NSString *ts=[NetworkHandling getTimestamp];
    NSMutableDictionary *param1=[[NSMutableDictionary alloc] init];
    NSMutableDictionary *param2=[[NSMutableDictionary alloc] init];
    NSMutableDictionary *headDict=[NetworkHandling getHead];
    
    [headDict setValue:ts forKey:@"ts"];
    
    NSMutableDictionary *bMD5Dict=[[NSMutableDictionary alloc] init];
    [bMD5Dict setValue:bDict forKey:@"b"];
    
    if ([NSJSONSerialization isValidJSONObject:bMD5Dict])
    {
        NSError *error;
        
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:bMD5Dict options:kNilOptions error:&error];
        
        if(error && block){
            block(nil,error);
            return;
        }
        
        NSString *js =[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        js=[js stringByAppendingString:md5Key];
        js=[js stringByAppendingString:ts];
        NSString *md5String=[Base64codeFunc md5:js];
        md5String=[md5String substringFromIndex:8];
        md5String=[md5String substringToIndex:16];
        [headDict setValue:md5String forKey:@"tkon"];
    }
    
    [param1 setValue:headDict forKey:@"head"];
    [param2 setValue:bDict forKey:@"b"];
    
    NSString *paramEncString;
    NSString *param1String;
    NSString *param2String;
    
    if ([NSJSONSerialization isValidJSONObject:param1])
    {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:param1 options:kNilOptions error:&error];
        if(error && block){
            block(nil,error);
            return;
        }
        param1String =[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
    if ([NSJSONSerialization isValidJSONObject:param2])
    {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:param2 options:kNilOptions error:&error];
        if(error && block){
            block(nil,error);
            return;
        }
        param2String =[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
    param1String=[param1String substringToIndex:[param1String length]-1];
    param2String=[param2String substringFromIndex:1];
    param1String=[param1String stringByAppendingString:@","];
    param1String=[param1String stringByAppendingString:param2String];
    NSLog(@"param string:%@",param1String);
    
    paramEncString=__BASE64(param1String);
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:nil delegateQueue:nil];
    
    
    NSString *postUrl2=@"";

#if (defined STANDARD_SY_VERSION) || (defined MANAGER_SY_VERSION)
    //更新接口版本到V1_5 修改时间20150610
    postUrl2=@"HamstrerServlet/shaoyang/v1_2/";
#endif
    
#if (defined STANDARD_CS_VERSION) || (defined MANAGER_CS_VERSION)
    //更新接口版本到V1_5 修改时间20150814
    //postUrl2=@"HamstrerServlet/changsha/v1_4/";
    postUrl2=@"HamstrerServlet/changsha/v1_8/";
#endif
    
    if(postType == -1)
        postUrl2=[postUrl2 stringByAppendingString:postUrl];
    else
        postUrl2=postUrl;
    
    NSURL *url = [NSURL URLWithString:[[self getBaseUrlString] stringByAppendingString:postUrl2]];
    NSLog(@"Post data:%@",url);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setHTTPMethod:@"POST"];
    NSData *postData=[paramEncString dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:postData];
    
    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSString *dataString=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSString *txt=__TEXT(dataString);
        
        NSError *er = nil;
        NSDictionary *JSONDict =
        [NSJSONSerialization JSONObjectWithData: [txt dataUsingEncoding:NSUTF8StringEncoding]
                                        options: NSJSONReadingMutableContainers
                                          error: &er];
        
        if(er && block){
            block(nil,er);
        }
        if(!er && block){
            block(JSONDict,nil);
        }
        
    }];
    
    [postDataTask resume];

}

+ (void)getJsonWithUrl:(NSString*)postUrl sendBody:(NSDictionary*)bDict processHandler:(void (^)(NSDictionary *result, NSError *error))block{
    
    NSString *ts=[NetworkHandling getTimestamp];
    NSMutableDictionary *param1=[[NSMutableDictionary alloc] init];
    NSMutableDictionary *param2=[[NSMutableDictionary alloc] init];
    NSMutableDictionary *headDict=[NetworkHandling getHead];
    
    [headDict setValue:ts forKey:@"ts"];
    
    NSMutableDictionary *bMD5Dict=[[NSMutableDictionary alloc] init];
    [bMD5Dict setValue:bDict forKey:@"b"];
    
    if ([NSJSONSerialization isValidJSONObject:bMD5Dict])
    {
        NSError *error;
        
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:bMD5Dict options:kNilOptions error:&error];
        
        if(error && block){
            block(nil,error);
            return;
        }
        
        NSString *js =[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        js=[js stringByAppendingString:md5Key];
        js=[js stringByAppendingString:ts];
        NSString *md5String=[Base64codeFunc md5:js];
        md5String=[md5String substringFromIndex:8];
        md5String=[md5String substringToIndex:16];
        [headDict setValue:md5String forKey:@"tkon"];
    }
    
    [param1 setValue:headDict forKey:@"head"];
    [param2 setValue:bDict forKey:@"b"];
    
    NSString *paramEncString;
    NSString *param1String;
    NSString *param2String;
    
    if ([NSJSONSerialization isValidJSONObject:param1])
    {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:param1 options:kNilOptions error:&error];
        if(error && block){
            block(nil,error);
            return;
        }
        param1String =[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
    if ([NSJSONSerialization isValidJSONObject:param2])
    {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:param2 options:kNilOptions error:&error];
        if(error && block){
            block(nil,error);
            return;
        }
        param2String =[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
    param1String=[param1String substringToIndex:[param1String length]-1];
    param2String=[param2String substringFromIndex:1];
    param1String=[param1String stringByAppendingString:@","];
    param1String=[param1String stringByAppendingString:param2String];
    NSLog(@"param string:%@",param1String);
    
    paramEncString=__BASE64(param1String);
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:nil delegateQueue:nil];
    //dimjson
    NSURL *url = [NSURL URLWithString:[[[self getBaseUrlString] stringByAppendingString:@""] stringByAppendingString:postUrl]];
    NSLog(@"Post data:%@",url);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setHTTPMethod:@"POST"];
    NSData *postData=[paramEncString dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:postData];
    
    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSString *dataString=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//        NSString *txt=__TEXT(dataString);
        
        NSError *er = nil;
        NSDictionary *JSONDict =
        [NSJSONSerialization JSONObjectWithData: [dataString dataUsingEncoding:NSUTF8StringEncoding]
                                        options: NSJSONReadingMutableContainers
                                          error: &er];
        
        if(er && block){
            block(nil,er);
        }
        if(!er && block){
            block(JSONDict,nil);
        }
        
    }];
    
    [postDataTask resume];
}

+(NSMutableDictionary*)getHead{
    NSMutableDictionary *headDict=[[NSMutableDictionary alloc] init];
    [headDict setValue:@"ios" forKey:@"OS"];
    [headDict setValue:@"7.0" forKey:@"ver"];
    [headDict setValue:@"sxmes" forKey:@"clientNam"];
    [headDict setValue:@"22.13456" forKey:@"pos"];
    [headDict setValue:@"v4" forKey:@"clientVer"];
    [headDict setValue:@"" forKey:@"ts"];
    [headDict setValue:@"ddd" forKey:@"tkon"];
    return headDict;
}

+(NSString*)getTimestamp{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    return [dateFormatter stringFromDate:[NSDate date]];
}

+(void)UploadsyntheticPictures:(UIImage*)imgData currentPicName:(NSString*)filename currentUser:(int)userId uploadType:(NSString*)uType completionHandler:(void(^)(NSURLResponse *response,                                                                                                                     NSData *data, NSError *error))block{

    CGFloat w=imgData.size.width/3;
    CGFloat h=imgData.size.height/3;
    UIImage *img=[BusinessHandling scaleToSize:imgData size:CGSizeMake(w,h)];
    
    NSData *fData=UIImageJPEGRepresentation(img, 1.0);
//    NSString *urlString=UploadUrlString;  chnlboss
    NSString *urlString=[[self getBaseUrlString] stringByAppendingString:@"iosupload"];
    NSString *paramString=[NSString stringWithFormat:@"?userID=%d&type=%@",userId,uType];
    if([uType isEqualToString:@"personInfo"])
        paramString=[NSString stringWithFormat:@"?userID=%d&type=%@&imageID=%@",userId,uType,filename];
    if([uType isEqualToString:@"visitplan"])
        paramString=[NSString stringWithFormat:@"?type=visitplan/%d/",userId];
    if([uType isEqualToString:@"bussdisc"])
        paramString=[NSString stringWithFormat:@"?type=bussdisc/%d/",userId];
    if([uType isEqualToString:@"chnlboss"]){
//        paramString=[NSString stringWithFormat:@"?type=chnlboss/%@/",filename];
        paramString=[NSString stringWithFormat:@"?type=chnlboss/"];
        filename=[filename stringByAppendingString:@".jpg"];
    }
    urlString=[urlString stringByAppendingString:paramString];
    NSLog(@"url:%@",urlString);
    NSLog(@"load picture name is:%@",filename);
    NSURL*connection=[[NSURL alloc] initWithString:urlString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:connection];
    [request setHTTPMethod:@"POST"];
    NSString *boundary = @"--";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    NSMutableData *body = [NSMutableData data];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    NSString *posiString=[NSString stringWithFormat:@"Content-Disposition: form-data; name='upload'; filename=%@\r\n",filename];
    [body appendData:[posiString dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[NSData dataWithData:fData]];//mageData就是照片数据
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:body];
//    [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response,
                                                                                     NSData *data,
                                                                                     NSError *error){
        block(response,data,error);
    }];
    

}
+(void)UploadsyntheticPictures:(UIImage*)imgData currentPicName:(NSString*)filename uploadType:(NSString*)uType completionHandler:(void(^)(NSURLResponse *response,                                                                                                                     NSData *data, NSError *error))block{
    CGFloat w=imgData.size.width/3;
    CGFloat h=imgData.size.height/3;
    UIImage *img=[BusinessHandling scaleToSize:imgData size:CGSizeMake(w,h)];
    NSData *fData=UIImageJPEGRepresentation(img, 1.0);
    //    NSString *urlString=UploadUrlString;
    NSString *urlString=[[self getBaseUrlString] stringByAppendingString:@"iosupload"];
    if([uType isEqualToString:@"linkuserPC"]){
        NSString *paramString=[NSString stringWithFormat:@"?type=%@&imageID=%@",uType,filename];
        urlString = [urlString stringByAppendingString:paramString];
    }
    else
        urlString=[urlString stringByAppendingString:uType];

    NSLog(@"url:%@",urlString);
    NSLog(@"load picture name is:%@",filename);
    NSURL*connection=[[NSURL alloc] initWithString:urlString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:connection];
    [request setHTTPMethod:@"POST"];
    NSString *boundary = @"--";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    NSMutableData *body = [NSMutableData data];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    NSString *posiString=[NSString stringWithFormat:@"Content-Disposition: form-data; name='upload'; filename=%@\r\n",filename];
    [body appendData:[posiString dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[NSData dataWithData:fData]];//mageData就是照片数据
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:body];
    //    [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response,
                                                                                     NSData *data,
                                                                                     NSError *error){
        block(response,data,error);
    }];
    
    
}

+(NSString*)GetCurrentNet
{
    NSString* result;
     NSString *serverAddress = [[NSUserDefaults standardUserDefaults] stringForKey:@"server_ip"];
    Reachability *r = [Reachability reachabilityWithHostName:serverAddress];
    
//    struct sockaddr_in address;
//    memset(&address, 0, sizeof(address));
//    address.sin_len = sizeof(address);
//    address.sin_family = AF_INET;
//    address.sin_port = htonl(IP_PORT);
//    address.sin_addr.s_addr = htons(inet_addr(IP_Address));
    
//    Reachability *r = [Reachability reachabilityWithAddress:[self getBaseUrlString]];
    
    switch ([r currentReachabilityStatus]) {
        case NotReachable:// 没有网络连接
            result=nil;
            break;
        case ReachableViaWWAN:// 使用3G网络
            result=@"3g";
            break;
        case ReachableViaWiFi:// 使用WiFi网络
            result=@"wifi";
            break;
    }
    return result;
}
+(NSString*)GetServerConnectState
{
    NSString* result;
    Reachability *r = [Reachability reachabilityWithHostName:[[NSUserDefaults standardUserDefaults] stringForKey:@"server_ip"]];
    switch ([r currentReachabilityStatus]) {
        case NotReachable:// 没有网络连接
            result=nil;
            break;
        case ReachableViaWWAN:// 使用3G网络
            result=@"3g";
            break;
        case ReachableViaWiFi:// 使用WiFi网络
            result=@"wifi";
            break;
    }
    return result;
}
//+ (void)sendLocation:(NSDictionary*)bDict processHandler:(void (^)(NSDictionary *result, NSError *error))block{
////    NSString *ts=[NetworkHandling getTimestamp];
////    NSMutableDictionary *param1=[[NSMutableDictionary alloc] init];
////    NSMutableDictionary *param2=[[NSMutableDictionary alloc] init];
////    NSMutableDictionary *headDict=[NetworkHandling getHead];
//    
////    [headDict setValue:ts forKey:@"ts"];
//    
////    NSMutableDictionary *bMD5Dict=[[NSMutableDictionary alloc] init];
////    [bMD5Dict setValue:bDict forKey:@"b"];
//    
////    if ([NSJSONSerialization isValidJSONObject:bMD5Dict])
////    {
////        NSError *error;
////        
//////        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:bMD5Dict options:kNilOptions error:&error];
////        
//////        if(error && block){
//////            block(nil,error);
//////            return;
//////        }
////        
//////        NSString *js =[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
////        
//////        js=[js stringByAppendingString:md5Key];
//////        js=[js stringByAppendingString:ts];
//////        NSString *md5String=[Base64codeFunc md5:js];
//////        md5String=[md5String substringFromIndex:8];
//////        md5String=[md5String substringToIndex:16];
//////        [headDict setValue:md5String forKey:@"tkon"];
////        [headDict setValue:@"" forKey:@"tkon"];
////    }
//    
////    [param1 setValue:headDict forKey:@"head"];
////    [param2 setValue:bDict forKey:@"p"];
//    
//    NSString *paramEncString;
////    NSString *param1String;
//    NSString *param2String;
//    
////    if ([NSJSONSerialization isValidJSONObject:param1])
////    {
////        NSError *error;
////        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:param1 options:kNilOptions error:&error];
////        if(error && block){
////            block(nil,error);
////            return;
////        }
////        param1String =[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
////        
////    }
//    
//    if ([NSJSONSerialization isValidJSONObject:bDict])
//    {
//        NSError *error;
//        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:bDict options:kNilOptions error:&error];
//        if(error && block){
//            block(nil,error);
//            return;
//        }
//        param2String =[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//        
//    }
//    
////    param1String=[param1String substringToIndex:[param1String length]-1];
////    param2String=[param2String substringFromIndex:1];
////    param1String=[param1String stringByAppendingString:@","];
////    param1String=[param1String stringByAppendingString:param2String];
////    NSLog(@"param string:%@",param2String);
//    
////    paramEncString=__BASE64(param1String);
//    
//    paramEncString=[NSString stringWithFormat:@"p=%@",param2String];
//    NSLog(@"param string:%@",paramEncString);
//
////    NSString *newGpsReportUrlString=[gpsReportUrlString stringByAppendingFormat:@"?%@",paramEncString];
////    newGpsReportUrlString=[newGpsReportUrlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    
//    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
//    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:nil delegateQueue:nil];
//    NSURL *url = [NSURL URLWithString:gpsReportUrlString];
////    NSURL *url = [NSURL URLWithString:newGpsReportUrlString];
//    
////    NSURL *url = [NSURL URLWithString:[BaseURLString stringByAppendingString:postUrl]];
//    NSLog(@"Post data:%@",url);
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
//                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
//                                                       timeoutInterval:60.0];
//    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
//    [request setHTTPMethod:@"POST"];
////    NSData *postData=[paramEncString dataUsingEncoding:NSUTF8StringEncoding];
//    NSData *postData=[@"p=test" dataUsingEncoding:NSUTF8StringEncoding];
//    [request setHTTPBody:postData];
//    
////    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    
//    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//        NSString *dataString=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//        NSString *txt=__TEXT(dataString);
//        
//        NSError *er = nil;
//        NSDictionary *JSONDict =
//        [NSJSONSerialization JSONObjectWithData: [txt dataUsingEncoding:NSUTF8StringEncoding]
//                                        options: NSJSONReadingMutableContainers
//                                          error: &er];
//        
//        if(er && block){
//            block(nil,er);
//        }
//        if(!er && block){
//            block(JSONDict,nil);
//        }
//        
//    }];
//    
//    [postDataTask resume];
//}
@end
