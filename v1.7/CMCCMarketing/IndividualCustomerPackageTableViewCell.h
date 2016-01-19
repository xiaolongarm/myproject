//
//  IndividualCustomerPackageTableViewCell.h
//  CMCCMarketing
//
//  Created by talkweb on 14-9-11.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IndividualCustomerPackageTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *itemSelectedButton;
@property (weak, nonatomic) IBOutlet UILabel *itemName;
@property (weak, nonatomic) IBOutlet UILabel *itemDetails;
@property (strong,nonatomic)NSString* itemPrice;

@end
