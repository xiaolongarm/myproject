//
//  KnowledgesalesViewController.m
//  CMCCMarketing
//
//  Created by gmj on 15/5/18.
//  Copyright (c) 2015年 talkweb. All rights reserved.
//

#import "KnowledgesalesViewController.h"
#import "NetworkHandling.h"
#import "Reachability.h"
#import "MBProgressHUD.h"

@interface KnowledgesalesViewController ()<MBProgressHUDDelegate>

@end

@implementation KnowledgesalesViewController
@synthesize salesPay;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    NSLog(@"开始加载2015推广资费网页");
    
    NSString *baseurl=[NetworkHandling getBaseUrlString];
    NSString *stringurl=[baseurl stringByAppendingString:@"report/2015zifei.html"];
    // NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:fileNameArray ofType:nil]];
   // NSURL *url = [NSURL fileURLWithPath:stringurl];
     NSURL *url = [NSURL URLWithString:stringurl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    Reachability *reach= [Reachability reachabilityForInternetConnection];
    if ([reach currentReachabilityStatus] != NotReachable) {
        [salesPay loadRequest:request];

    }else
    {
        [self showErrorMessage:@"请连接网络"];
    }
    
}

-(void)showErrorMessage:(NSString *)title{
    
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.delegate = self;
    HUD.labelText = title;
    [HUD show:YES];
    [HUD hide:YES afterDelay:2];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
