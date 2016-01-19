//
//  ChagangMonitorStaffListTableViewCell.m
//  CMCCMarketing
//
//  Created by talkweb on 14-12-22.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import "ChagangMonitorStaffListTableViewCell.h"

@implementation ChagangMonitorStaffListTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    if(selected){
//        self.backgroundColor = [UIColor blackColor];
        if(self.itemLocusQueryButton.tag )
            self.itemBodyLocusQueryView.hidden=NO;
        self.itemBodyView.backgroundColor=[UIColor blackColor];
    } else {
//        self.backgroundColor = [UIColor clearColor];
        if(self.itemLocusQueryButton.tag )
            self.itemBodyLocusQueryView.hidden=YES;
        self.itemBodyView.backgroundColor=[UIColor darkGrayColor];
    }
    
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}
//-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
//{
//    if(highlighted) {
//        self.backgroundColor = [UIColor blackColor];
//    } else {
//        self.backgroundColor = [UIColor clearColor];
//    }
//    [super setHighlighted:highlighted animated:animated];
//    
////    if( highlighted == YES )
////        self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lyric_mask"]];
////    else
////        self.backgroundView = nil;
////    
////    [super setHighlighted:highlighted animated:animated];
//}

@end
