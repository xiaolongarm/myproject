//
//  ManagerBusinessProcessWebViewController.m
//  CMCCMarketing
//
//  Created by talkweb on 14-12-18.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import "ManagerBusinessProcessWebViewController.h"

@interface ManagerBusinessProcessWebViewController ()<UIWebViewDelegate>{
    UIActivityIndicatorView *activityView;
}

@end

@implementation ManagerBusinessProcessWebViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if(self.isAutoSize){
        [self.reportWebView setScalesPageToFit:YES];
        [self.reportWebView setAutoresizesSubviews:YES];
    }
    [self.reportWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]]];
  
        
//    [self.reportWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]]];
//    self.reportWebView.scalesPageToFit=YES;
//    self.reportWebView.autoresizesSubviews=YES;
//    [self.reportWebView setHidden:YES];
//    self.reportWebView.delegate = self;
//    
//    
//    activityView=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//    activityView.center=CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
//    [activityView startAnimating];
//    [self.view addSubview:activityView];
}
//#pragma mark - UIWebViewDelegate
//- (void)webViewDidFinishLoad:(UIWebView *)webView
//{
//    
//    //修改服务器页面的meta的值
//    NSString *meta = [NSString stringWithFormat:@"document.getElementsByName(\"viewport\")[0].content = \"width=%f height=%f, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no\"", webView.frame.size.width,webView.frame.size.height];
//    [webView stringByEvaluatingJavaScriptFromString:meta];
//    
//    [activityView removeFromSuperview];
//    activityView=nil;
//    self.reportWebView.hidden=NO;
//}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
