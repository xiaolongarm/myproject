//
//  KnowledgeBaseDocumentReaderViewController.h
//  CMCCMarketing
//
//  Created by talkweb on 14-11-3.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KnowledgeBaseDocumentReaderViewController : UIViewController{
    
    __weak IBOutlet UIWebView *webView;
}
@property(nonatomic,strong)NSURL *filePath;
@property(nonatomic,strong)NSString* fileName;
@end
