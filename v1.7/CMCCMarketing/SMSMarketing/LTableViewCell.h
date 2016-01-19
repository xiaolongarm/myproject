//
//  LTableViewCell.h
//  tableview
//
//  Created by mac on 14-9-8.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LTableViewCell : UITableViewCell{
    BOOL			m_checked;
    UIImageView*	m_checkImageView;
   
}
@property(nonatomic,strong)UILabel*       m_detailText;
- (void)setChecked:(BOOL)checked;
@end
