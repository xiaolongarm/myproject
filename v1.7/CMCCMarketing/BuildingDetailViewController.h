//
//  BuildingDetailViewController.h
//  CMCCMarketing
//
//  Created by kevin on 15/8/24.
//  Copyright (c) 2015年 talkweb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
@interface BuildingDetailViewController : UIViewController
@property(nonatomic,strong)User *user;
@property(nonatomic,strong)NSDictionary *recipeDict;
@property (strong, nonatomic) IBOutlet UILabel *buildingName;
@property (strong, nonatomic) IBOutlet UILabel *buildingCity;
@property (strong, nonatomic) IBOutlet UILabel *buildingStreet;
@property (strong, nonatomic) IBOutlet UILabel *buildingDetail;
@property (strong, nonatomic) IBOutlet UILabel *marketType;
- (IBAction)takeCameral:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *cameralButton;

@property (strong, nonatomic) IBOutlet UIImageView *buildingPic1;
//- (IBAction)zoomPictuer:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *buildingPic2;
//- (IBAction)zoomPic2:(id)sender;




@end
