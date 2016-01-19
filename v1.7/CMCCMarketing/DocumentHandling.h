//
//  DocumentHandling.h
//  CMCCMarketing
//
//  Created by talkweb on 14-11-3.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Foundation/Foundation.h>

//@protocol DocumentHandlingDelegate <NSObject>
//-(void)documentHandlingDownloadDidFinished:(NSURL*)filePath;
////-(void)documentHandlingDownloadDidWriteDataState:(NSString*)downloadState;
//@end

@interface DocumentHandling : NSObject<NSURLSessionDownloadDelegate>{
    NSURL *savePath;
    UILabel *stateLabel;
}

@property (strong, nonatomic, readonly) NSURLSession *backgroundSession; // 后台会话
@property (strong, nonatomic) NSURLSessionDownloadTask *backgroundTask;  // 后台的下载任务
//@property(nonatomic,strong)id<DocumentHandlingDelegate>delegate;

-(void)downloadFileWithUrl:(NSString*)urlString fileRootPath:(NSString*)rootPath documetDirectory:(NSString*)docPath documentName:(NSString*)fileName progressLabel:(UILabel*)sLabel;
+(BOOL)getFileIsExistPath:(NSString*)rootPath documetDirectory:(NSString*)docPath documentName:(NSString*)fileName;
+(void)writeUser:(NSString*)userName withPass:(NSString*)password withFlag:(BOOL)state;
+(NSMutableDictionary*)readUser;
+(void)writeUserLocation:(NSString*)city withLatitude:(NSNumber*)latitude withLongitude:(NSNumber*)longitude;
@end
