//
//  CustomerManagerMapViewController.h
//  CMCCMarketing
//
//  Created by talkweb on 14-9-22.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"
#import "User.h"
#import "Group.h"
#import "Channels.h"
@interface CustomerManagerMapViewController : UIViewController<BMKMapViewDelegate,BMKGeoCodeSearchDelegate,UISearchBarDelegate,BMKPoiSearchDelegate>{
    
    __weak IBOutlet BMKMapView *mapview;
    __weak IBOutlet UILabel *lbSignLocation;
    __weak IBOutlet UILabel *lbGroupNameTitle;
    
}
@property(nonatomic,assign)int listType;
@property(nonatomic,strong)User* user;
@property(nonatomic,strong)Group *group;
@property(nonatomic,strong)Channels *channels;
@property(nonatomic,strong)NSDictionary *littleDict;
@property(nonatomic,assign)int addressType;
-(void)refreshUserLocaton;
-(void)forBackMap:(NSDictionary*)backDict;
@end
