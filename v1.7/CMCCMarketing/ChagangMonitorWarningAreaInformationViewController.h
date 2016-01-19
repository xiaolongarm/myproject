//
//  ChagangMonitorWarningAreaInformationViewController.h
//  CMCCMarketing
//
//  Created by talkweb on 15-4-13.
//  Copyright (c) 2015年 talkweb. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChagangMonitorWarningAreaInformationViewControllerDelegate <NSObject>
-(void)chagangMonitorWarningAreaInformationViewControllerDidCancel:(NSString*)rowId;
@end

@interface ChagangMonitorWarningAreaInformationViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{

    __weak IBOutlet UILabel *lbUser;
}
@property (weak, nonatomic) IBOutlet UITableView *detailsTableView;

//@property(nonatomic,strong)NSArray *tableArray;
-(void)loadWarningInformation:(NSDictionary*)details;
@property(nonatomic,strong)id<ChagangMonitorWarningAreaInformationViewControllerDelegate>delegate;
@end
