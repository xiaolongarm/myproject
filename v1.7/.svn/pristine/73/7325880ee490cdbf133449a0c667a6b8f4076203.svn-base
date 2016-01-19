//
//  KnowledgeBaseDocumentReaderViewController.m
//  CMCCMarketing
//
//  Created by talkweb on 14-11-3.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import "KnowledgeBaseDocumentReaderViewController.h"

@interface KnowledgeBaseDocumentReaderViewController ()

@end

@implementation KnowledgeBaseDocumentReaderViewController

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
    self.title=self.fileName;
    [webView loadRequest:[NSURLRequest requestWithURL:self.filePath]];
}

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
