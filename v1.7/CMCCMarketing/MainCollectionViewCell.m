//
//  MainCollectionViewCell.m
//  CMCCMarketing
//
//  Created by talkweb on 15/7/6.
//  Copyright (c) 2015年 talkweb. All rights reserved.
//

#import "MainCollectionViewCell.h"

@implementation MainCollectionViewCell

-(void)awakeFromNib{
    [self.itemButton addTarget:self action:@selector(clearBadge) forControlEvents:UIControlEventTouchUpInside];
}
-(void)clearBadge{
    self.badgeNumber=0;
}

@end
