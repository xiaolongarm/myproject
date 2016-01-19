//
//  KnowledgeBaseWithBusinessDetailsViewController.h
//  CMCCMarketing
//
//  Created by talkweb on 14-11-1.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface KnowledgeBaseWithBusinessDetailsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    
    __weak IBOutlet UIWebView *webView;
    __weak IBOutlet UITableView *downloadTableView;
    __weak IBOutlet UISegmentedControl *segTitleController;
}

@property(nonatomic,strong)NSDictionary *detailsDict;
@property(nonatomic,strong)NSArray *detailsArray;
@property(nonatomic,strong)User *user;
@property(nonatomic,strong)NSDictionary *apiDict;
@property(nonatomic,strong)NSString *fromFlag;
@end
