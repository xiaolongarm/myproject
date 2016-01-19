//
//  DocumentHandling.m
//  CMCCMarketing
//
//  Created by talkweb on 14-11-3.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import "DocumentHandling.h"
#define kBackgroundSessionID @"1010"
#define kBackgroundSession @"back session 1010"
#import "AppDelegate.h"

@implementation DocumentHandling

+(BOOL)getFileIsExistPath:(NSString*)rootPath documetDirectory:(NSString*)docPath documentName:(NSString*)fileName{

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,     NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSFileManager *fileManager=[NSFileManager defaultManager];
    
    NSString *rootDirectory=[documentsDirectory stringByAppendingPathComponent:rootPath];
    BOOL rootFlag= [fileManager fileExistsAtPath:rootDirectory];
    if(!rootFlag)
        return NO;
    
    NSString *docDirectory=[rootDirectory stringByAppendingPathComponent:docPath];
    BOOL docFlag=[fileManager fileExistsAtPath:docDirectory];
    if(!docFlag)
        return NO;
    
    NSString *fileDirectory=[docDirectory stringByAppendingPathComponent:fileName];
    BOOL fileFlag=[fileManager fileExistsAtPath:fileDirectory];
    if(!fileFlag)
        return NO;
    
    return YES;

}
-(void)downloadFileWithUrl:(NSString*)urlString fileRootPath:(NSString*)rootPath documetDirectory:(NSString*)docPath documentName:(NSString*)fileName progressLabel:(UILabel*)sLabel{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,     NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSFileManager *fileManager=[NSFileManager defaultManager];

    NSString *rootDirectory=[documentsDirectory stringByAppendingPathComponent:rootPath];
    BOOL rootFlag= [fileManager fileExistsAtPath:rootDirectory];
    NSError *error;
    if(!rootFlag)
        [fileManager createDirectoryAtPath:rootDirectory withIntermediateDirectories:YES attributes:nil error:&error];
    
    NSString *docDirectory=[rootDirectory stringByAppendingPathComponent:docPath];
    BOOL docFlag=[fileManager fileExistsAtPath:docDirectory];
    if(!docFlag)
        [fileManager createDirectoryAtPath:docDirectory withIntermediateDirectories:YES attributes:nil error:&error];
    
    [self backgroundDownload:urlString];
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,     NSUserDomainMask, YES);
//    NSString *documentsDirectory = [paths objectAtIndex:0];
//    documentsDirectory=[documentsDirectory stringByAppendingPathComponent:rootPath];
//    documentsDirectory=[documentsDirectory stringByAppendingPathComponent:docPath];
//    documentsDirectory=[documentsDirectory stringByAppendingPathComponent:fileName];
//    savePath=[NSURL URLWithString:documentsDirectory];
    
//    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *urls = [fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    NSURL *documentsDirectoryUrl = urls[0];
    documentsDirectoryUrl = [documentsDirectoryUrl URLByAppendingPathComponent:rootPath isDirectory:YES];
    documentsDirectoryUrl = [documentsDirectoryUrl URLByAppendingPathComponent:docPath isDirectory:YES];
    documentsDirectoryUrl = [documentsDirectoryUrl URLByAppendingPathComponent:fileName];
    savePath=documentsDirectoryUrl;
    stateLabel=sLabel;
}
- (void)backgroundDownload:(NSString *)urlString{
//    NSString *imageURLStr = @"http://farm3.staticflickr.com/2831/9823890176_82b4165653_b_d.jpg";
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    self.backgroundTask = [self.backgroundSession downloadTaskWithRequest:request];
    [self.backgroundTask resume];
}
/* 创建一个后台session单例 */
- (NSURLSession *)backgroundSession {
    static NSURLSession *backgroundSess = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration backgroundSessionConfiguration:kBackgroundSessionID];
        backgroundSess = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
        backgroundSess.sessionDescription = kBackgroundSession;
    });
    
    return backgroundSess;
}

-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location{
    //下载成功后，文件是保存在一个临时目录的，需要开发者自己考到放置该文件的目录
    NSLog(@"Download success");
//    NSURL *destination = [self createDirectoryForDownloadItemFromURL:location];
    //[savePath URLByAppendingPathComponent:[location lastPathComponent]]
    BOOL success = [self copyTempFileAtURL:location toDestination:savePath];
    
    if (success){
        dispatch_async(dispatch_get_main_queue(), ^{
//            stateLabel.hidden=YES;
            stateLabel.text=@"下载完成";
        });
    }

//    [self.delegate documentHandlingDownloadDidFinished:savePath];
}
//创建文件本地保存目录
//-(NSURL *)createDirectoryForDownloadItemFromURL:(NSURL *)location
//{
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    NSArray *urls = [fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
//    NSURL *documentsDirectory = urls[0];
//    return [documentsDirectory URLByAppendingPathComponent:[location lastPathComponent]];
//}
//把文件拷贝到指定路径
-(BOOL) copyTempFileAtURL:(NSURL *)location toDestination:(NSURL *)destination
{
    
    NSError *error;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtURL:destination error:NULL];
    [fileManager copyItemAtURL:location toURL:destination error:&error];
    if (error == nil) {
        return true;
    }else{
        NSLog(@"%@",error);
        return false;
    }
}
//-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes{
//    // 计算当前下载进度并更新视图
////    double downloadProgress = totalBytesWritten / (double)totalBytesExpectedToWrite;
////    [self setDownloadProgress:downloadProgress];
//    NSLog(@"update state download ...");
//}
///* 根据下载进度更新视图 */
//- (void)setDownloadProgress:(double)progress {
//    NSString *progressStr = [NSString stringWithFormat:@"%.1f", progress * 100];
//    progressStr = [progressStr stringByAppendingString:@"%"];
//    
//    dispatch_async(dispatch_get_main_queue(), ^{
//        self.downloadingProgressView.progress = progress;
//        self.currentProgress_label.text = progressStr;
//    });
//}
-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite{
    if(downloadTask == self.backgroundTask){
        NSLog(@"write data download ...");
        double downloadProgress = totalBytesWritten / (double)totalBytesExpectedToWrite;
        NSString *progressStr = [NSString stringWithFormat:@"%.1f %%", downloadProgress * 100];
        NSLog(@"download progress:%@",progressStr);
//        [self.delegate documentHandlingDownloadDidWriteDataState:progressStr];
        dispatch_async(dispatch_get_main_queue(), ^{
            stateLabel.hidden=NO;
            stateLabel.text=progressStr;
        });
    }
}

//- (void)URLSessionDidFinishEventsForBackgroundURLSession:(NSURLSession *)session {
//    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    if (appDelegate.backgroundSessionCompletionHandler) {
//        void (^completionHandler)() = appDelegate.backgroundSessionCompletionHandler;
//        appDelegate.backgroundSessionCompletionHandler = nil;
//        completionHandler();
//    }
//    NSLog(@"All tasks are finished");
//}

+(void)writeUser:(NSString*)userName withPass:(NSString*)password withFlag:(BOOL)state{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,     NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths firstObject];
    documentsDirectory = [documentsDirectory stringByAppendingPathComponent:@"user"];
    
    NSMutableDictionary *userDict = [self readUser];
    if(!userDict)
        userDict=[[NSMutableDictionary alloc] init];
    [userDict setObject:userName forKey:@"name"];
    [userDict setObject:password forKey:@"pass"];
    [userDict setObject:[NSNumber numberWithBool:state] forKey:@"isauto"];
    [userDict writeToFile:documentsDirectory atomically:YES];
}
+(void)writeUserLocation:(NSString*)city withLatitude:(NSNumber*)latitude withLongitude:(NSNumber*)longitude{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,     NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths firstObject];
    documentsDirectory = [documentsDirectory stringByAppendingPathComponent:@"user"];
    
    NSMutableDictionary *userDict = [self readUser];
    if(!userDict)
        userDict=[[NSMutableDictionary alloc] init];
    [userDict setObject:city forKey:@"city"];
    [userDict setObject:latitude forKey:@"latitude"];
    [userDict setObject:longitude forKey:@"longitude"];
    [userDict writeToFile:documentsDirectory atomically:YES];
}

+(NSMutableDictionary*)readUser{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,     NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths firstObject];
    documentsDirectory = [documentsDirectory stringByAppendingPathComponent:@"user"];
    NSMutableDictionary *userDict=[[NSMutableDictionary alloc] initWithContentsOfFile:documentsDirectory];
    return userDict;
}
@end
