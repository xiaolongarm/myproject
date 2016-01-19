//
//  MainCollectionViewCell.h
//  CMCCMarketing
//
//  Created by talkweb on 15/7/6.
//  Copyright (c) 2015年 talkweb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *itemBadgeBackgroundView;
@property (weak, nonatomic) IBOutlet UILabel *itemBadge;
@property (weak, nonatomic) IBOutlet UILabel *itemTitle;
@property (weak, nonatomic) IBOutlet UIButton *itemButton;
/// 角标数字，主要保存推送过来的消息数
@property (assign,nonatomic) int badgeNumber;
@end
