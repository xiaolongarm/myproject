//
//  ManagerBusinessProcessWebViewController.h
//  CMCCMarketing
//
//  Created by talkweb on 14-12-18.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ManagerBusinessProcessWebViewController : UIViewController{
    
//    __weak IBOutlet UIWebView *reportWebView;
}

@property (weak, nonatomic) IBOutlet UIWebView *reportWebView;
@property(nonatomic,strong)NSString *urlString;
@property(nonatomic,assign)BOOL isAutoSize;
//-(void)loadWebData:(NSString*)urlString;
@end
